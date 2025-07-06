{ ... }: {
  # 6.12 kernel doesn't work with virtbox without this.
  # https://github.com/NixOS/nixpkgs/issues/363887#issuecomment-2536693220
  boot.kernelParams = [ "kvm.enable_virt_at_load=0" ];

  programs.virt-manager.enable = true;
  users.groups.libvirtd.members = ["nathan"];
  virtualisation = {
    libvirtd.enable = true;
    virtualbox = {
        host.enable = true;
    };
    spiceUSBRedirection.enable = true;
  };

}
