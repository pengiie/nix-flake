{ config, ... }: {
  networking.firewall.enable = true;

  networking.firewall.allowedTCPPorts = [ 
    # HTTP Ports
    80 
    443
  ] ++ config.host.extraAllowedTCPPorts;
}
