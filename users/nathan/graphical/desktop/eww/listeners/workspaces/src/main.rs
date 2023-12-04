use std::process::Command;

use clap::Parser;
use hyprland::{event_listener::EventListener, shared::HyprDataActive};
use serde::{Deserialize, Serialize};

#[derive(Parser, Debug)]
struct Args {
    monitor: String
}

fn main() {
    let args = Args::parse();
    
    let mut event_listener = EventListener::new();

    let monitor = args.monitor.clone();
    event_listener.add_active_window_change_handler(move |_| {
        print_workspace_info(&monitor);
    });

    let monitor = args.monitor.clone();
    event_listener.add_workspace_change_handler(move |_| {
        print_workspace_info(&monitor);
    });

    let monitor = args.monitor.clone();
    event_listener.add_workspace_moved_handler(move |_| {
        print_workspace_info(&monitor);
    });

    let monitor = args.monitor.clone();
    event_listener.add_active_monitor_change_handler(move |_| {
        print_workspace_info(&monitor);
    });

    // Startup print
    print_workspace_info(&args.monitor);

    event_listener.start_listener().unwrap();
}

#[derive(Debug, Serialize, Deserialize)]
struct Workspace {
    id: u32,
    name: String,
    monitor: String,
    is_active: bool,
}

// This code is not a reflection of my coding skills, i simply dont care if its pretty
fn print_workspace_info(monitor: &String) {
    let workspaces = Command::new("hyprctl")
        .arg("workspaces")
        .output()
        .expect("failed to execute process")
        .stdout;

    let parsed_workspaces = {
        let workspaces_string = String::from_utf8(workspaces).unwrap();
        let split = workspaces_string.split("on monitor");
        let mut parsed_workspaces = Vec::new();
        let mut last_workspace_name = String::new();
        for (i, workspace) in split.enumerate() {
            let mut workspace = workspace.trim();
            if workspace.len() > 0 && workspace.contains("monitorID") {
                let mut lines = workspace.lines();
                let id = i as u32; // Workspaces start from 1.
                let monitor_name = lines.next().unwrap().trim().strip_suffix(":").unwrap().to_string();
                parsed_workspaces.push(Workspace {
                    id,
                    monitor: monitor_name,
                    name: last_workspace_name.clone(),
                    is_active: false,
                });

                // Find last set of () and use that as the name
                while workspace.find("(").is_some() {
                    let b = workspace.find("(").unwrap();
                    workspace = &workspace[b+1..];
                }
                let e = workspace.find(")");

                if e.is_none() {
                    continue;
                }

                let name = workspace[0..e.unwrap()].to_string();
                last_workspace_name = name;
            } else if workspace.len() > 0 {
                // Find last set of () and use that as the name
                while workspace.find("(").is_some() {
                    let b = workspace.find("(").unwrap();
                    workspace = &workspace[b+1..];
                }
                let e = workspace.find(")").unwrap();
                let name = workspace[0..e].to_string();
                last_workspace_name = name;
            }
        }
        parsed_workspaces
    };

    let active_workspace = hyprland::data::Workspace::get_active().unwrap();

    let monitor_workspaces = parsed_workspaces.into_iter().filter(|w| w.monitor == *monitor).map(|mut w| {
        w.is_active = w.id == active_workspace.id as u32;
        w
    }).collect::<Vec<_>>();

    let json = serde_json::to_string(&monitor_workspaces).unwrap();
    
    println!("{}", json);
}
