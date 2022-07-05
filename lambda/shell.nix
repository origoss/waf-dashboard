let
  pkgs = import (fetchTarball {
        url = https://github.com/nixos/nixpkgs/archive/689b76bcf36055afdeb2e9852f5ecdd2bf483f87.tar.gz;
        sha256 = "08d38db4707jdm3gws82y6bynh6k8qal4s1cms9zqd9cdwcmylyj";
      }) {};
in pkgs.mkShell {
  buildInputs = [
    pkgs.go
    pkgs.jq
    pkgs.awscli2
  ];
  AWS_ACCESS_KEY_ID = builtins.readFile ../aws-access-key-id;
  AWS_SECRET_ACCESS_KEY = builtins.readFile ../aws-secret-access-key;
  AWS_DEFAULT_REGION = "eu-central-1";
}
