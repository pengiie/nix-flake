{ pkgs, ... }: {
  services.nginx = {
    enable = true;
    virtualHosts."pengie.dev" = {
      addSSL = true;
      enableACME = true;
      root = "/var/www/webby";
    };
  };

  security.acme = {
    acceptTerms = true;
    certs = {
      "pengie.dev".email = "nathan@pengie.dev";
    };
  };
}
