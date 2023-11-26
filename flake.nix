{
  description = "k8s-dev-stack";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      with pkgs;
      {
        devShells.default = mkShell {
          packages = [
            age
            ansible
            ansible-lint
            cilium-cli
            cloudflared
            direnv
            git
            go
            go-task
            gotestsum
            jq
            kubectl
            kubernetes-helm
            kustomize
            neovim
            neofetch
            sops
            stern
            terraform
            yamllint
            yq
          
            
            (python3.withPackages (p: with p; [
              jinja2
              kubernetes
              mkdocs-material
              netaddr
              rich
            ]))
          ];
        };
      }
    );
}