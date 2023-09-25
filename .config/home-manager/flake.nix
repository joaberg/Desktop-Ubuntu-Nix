{
  description = "Home Manager configuration";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland.url = "github:hyprwm/Hyprland";
   
  };

  outputs = { self, nixpkgs, home-manager, hyprland, ... }:
    let
      system = "x86_64-linux";
  	  pkgs = import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
        };
      };
      
      	
    in {
      homeConfigurations."joakim" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        modules = [ 
        	./home.nix 
			    hyprland.homeManagerModules.default
			    {wayland.windowManager.hyprland.enable = true;}
                   

        ];

        # Optionally use extraSpecialArgs
        # to pass through arguments to home.nix
        
      };




      
      
    };
}
