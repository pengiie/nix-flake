{ lib, ... }@inputs: rec {
  # rgb color type
  rgb = r: g: b: { inherit r g b; };

  # parses a hex string into rgb
  parseHex = hexStr: let
    hexToDec = hex: let
      hexToDecMap = {
        "0" = 0;
        "1" = 1;
        "2" = 2;
        "3" = 3;
        "4" = 4;
        "5" = 5;
        "6" = 6;
        "7" = 7;
        "8" = 8;
        "9" = 9;
        "a" = 10;
        "b" = 11;
        "c" = 12;
        "d" = 13;
        "e" = 14;
        "f" = 15;
      };

      math = import ./math.nix inputs;
      base16To10 = exponent: scalar: scalar * math.pow 16 exponent;
      
      decimals = builtins.map (ch: hexToDecMap."${ch}") (lib.strings.stringToCharacters (lib.strings.toLower hex));
      decimalsAscending = lib.lists.reverseList decimals;
      decimalsPowered = lib.lists.imap0 base16To10 decimalsAscending;
    in lib.lists.foldl builtins.add 0 decimalsPowered;

    hex = lib.strings.removePrefix "#" hexStr;
    r = hexToDec (builtins.substring 0 2 hex);
    g = hexToDec (builtins.substring 2 2 hex);
    b = hexToDec (builtins.substring 4 2 hex);
  in rgb r g b;
  
  hexToRgba = hexStr: alpha: let 
    rgb = parseHex hexStr;
  in "rgba(${builtins.toString rgb.r}, ${builtins.toString rgb.g}, ${builtins.toString rgb.b}, ${builtins.toString alpha})";
  
  # converts the channel into a 2 wide hex string
  hexChannel = c: let
    str = "0${lib.trivial.toHexString c}";
    len = builtins.stringLength str;
  in builtins.substring (len - 2) 2 str;

  # converts hex to rgb
  hexToRgb = { r, g, b }: "#${hexChannel r}${hexChannel g}${hexChannel b}";

  # Color functions

  # shade with the percieved luminance ratio on rgb, i feel like im making things up
  shadeLRgb = { r, g, b }: v: let 
    p = v - 1; 
    lr = (p * 0.2126) + 1.0;
    lg = (p * 0.7152) + 1.0;
    lb = (p * 0.0722) + 1.0;
  in (rgb (builtins.ceil (r * lr)) (builtins.ceil (g * lg)) (builtins.ceil (b * lb)));
  shadeLHex = hexStr: v: hexToRgb (shadeLRgb (parseHex hexStr) v);

  # shade with the value being a multiplier
  shadeRgb = { r, g, b }: v: rgb (builtins.ceil (r * v)) (builtins.ceil (g * v)) (builtins.ceil (b * v));
  shadeHex = hexStr: v: hexToRgb (shadeRgb (parseHex hexStr) v);
}
