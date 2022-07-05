let
  pkgs = import (fetchTarball {
        url = https://github.com/nixos/nixpkgs/archive/689b76bcf36055afdeb2e9852f5ecdd2bf483f87.tar.gz;
        sha256 = "08d38db4707jdm3gws82y6bynh6k8qal4s1cms9zqd9cdwcmylyj";
      }) {};
  app-name = "aws-lambda";
  bin = pkgs.buildGoModule {
    name = app-name;
    src = builtins.filterSource
      (path: type: type == "regular" &&
                   builtins.elem (builtins.baseNameOf path)
                     ["main.go" "go.mod" "go.sum"])
      ./.;
    vendorSha256 = "sha256-u1D9WT41zcHPZxzsZTvUTY8Va6Joua/57+1uESr86ps=";
    CGO_ENABLED = 0;
  };
in pkgs.runCommand "zipped-aws-lambda"
  { buildInputs = [
      pkgs.zip
    ];
  } ''
      mkdir -p $out
      cd ${bin}/bin
      zip $out/main.zip ${app-name}
    ''
