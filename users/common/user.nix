{ lib, ... }: 
let
  inherit (lib) mkOption types;
in {
  options.user = {
    name = mkOption {
      type = types.str;
      default = "nathan";
      description = "The user's name.";
    };
    email = mkOption {
      type = types.str;
      default = "nathan@pengie.dev";
      description = "The user's email.";
    };
  };
}
