{ config, ... }: {
  networking.firewall.enable = true;

  networking.firewall.allowedTCPPorts = [ 
    # HTTP Ports
    80 
    443
    25565
  ] ++ config.host.extraAllowedTCPPorts;
}
