{
  description = "Nix flake templates collection";

  outputs = { self }: {
    templates = {
      haskell_cabal = {
        path = ./nix_cabal;
        description = "A Haskell app using cabal (with tools)";
      };
      python = {
        path = ./python;
        description = "Python with devshell";
      };
    };
  };
}
