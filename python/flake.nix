{
  description = "python-shell";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };
  nixConfig.bash-prompt-suffix = "🔨";
  outputs = {
    self,
    nixpkgs,
  }: (let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
    dev = pkgs.mkShell {
      packages = [
        pkgs.helix
        
        (pkgs.python3.withPackages (python-pkgs: [
          python-pkgs.python-lsp-server

          python-pkgs.requests
        ]))
      ];
    };
  in {
    formatter.${system} = pkgs.alejandra;
    devShells.${system}.default = dev;
  });
}
