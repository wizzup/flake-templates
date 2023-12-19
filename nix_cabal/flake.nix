{
  description = "hello-cabal";
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
    drv = pkgs.haskellPackages.callCabal2nix "hello" ./. {};
    hsPcks = with pkgs.haskellPackages; [
      cabal-install
      haskell-language-server
      hpack
    ];
    dev = drv.env.overrideAttrs (attr: {
      buildInputs = attr.buildInputs
                 ++ hsPcks
                 ++ [pkgs.helix];
    shellHook = ''
        source ${pkgs.cabal-install}/share/bash-completion/completions/cabal 
      '';
    });
  in
    {
      formatter.${system} = pkgs.alejandra;
      packages.${system}.default = drv;
      devShells.${system}.default = dev;
    });
}
