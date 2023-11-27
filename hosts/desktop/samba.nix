{ ... }: {
  services.samba = {
    enable = true;
    openFirewall = true;
    securityType = "user";
    shares = {
      dev = {
        comment = "Development";
        path = "/home/nathan/dev";
        browseable = "yes";
        "read only" = "no";
        "guest ok" = "no";
      };
    };
  };
}
