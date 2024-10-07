{ fetchFromGitHub
, rustPlatform
, cmake
, fontconfig
, obs-studio
, pkg-config
}:

rustPlatform.buildRustPackage rec {
  pname = "obs-livesplit-one";
  version = "0.4.1";

  src = fetchFromGitHub {
    owner = "LiveSplit";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-4Ar4ChSl226BVFyAnqpWDLxsZF63bxl++sWD+6aENW8=";
  };

  cargoLock = {
    lockFile = ./Cargo.lock;
    outputHashes = {
      "livesplit-auto-splitting-0.1.0" = "sha256-g+cuGr1TXQTuUPAKGF7R0OJ/wC0yPndkMkVQ6hjJQZ8=";
      "simdutf8-0.1.4" = "sha256-Ld6gINjASxtkoRkq3AkUo5BfKSZti+vf92X6BSk5F4c=";
    };
  };

  nativeBuildInputs = [ cmake pkg-config ];
  buildInputs = [ fontconfig obs-studio ];

  postInstall = ''
    mkdir $out/lib/obs-plugins/
    mv $out/lib/libobs_livesplit_one.so $out/lib/obs-plugins/obs-livesplit-one.so
  '';
}
