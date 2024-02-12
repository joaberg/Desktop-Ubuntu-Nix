{
  description = "Home Manager configuration of joakim";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland.url = "github:hyprwm/Hyprland";

    #Plugin:
     hycov={
      url = "github:DreamMaoMao/hycov";
      inputs.hyprland.follows = "hyprland";
    };
   
  };

  outputs = { self, nixpkgs, home-manager, hyprland, hycov, ... }:
    let
      system = "x86_64-linux";
  	  pkgs = import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
        };
      };
      #pkgs = nixpkgs.legacyPackages.${system};
      
      	
    in {
      homeConfigurations."joakim" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        modules = [ 
        	./home.nix 
			    hyprland.homeManagerModules.default
			    {
            wayland.windowManager.hyprland.enable = true;
            wayland.windowManager.hyprland.plugins = [hycov.packages.${pkgs.system}.hycov];
              }
                   

        ];

        # Optionally use extraSpecialArgs
        # to pass through arguments to home.nix
        
      };




      
      
    };
}
