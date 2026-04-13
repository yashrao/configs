{
  description = "A simple NixOS Flake";

  inputs = {
    # NixOS official package source, using the nixos-25.11 branch here
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      # The `follows` keyword in inputs is used for inheritance.
      # Here, `inputs.nixpkgs` of home-manager is kept consistent with
      # the `inputs.nixpkgs` of the current flake,
      # to avoid problems caused by different versions of nixpkgs.
      inputs.nixpkgs.follows = "nixpkgs";
    };

    kimi-cli = {
      url = "github:MoonshotAI/kimi-cli";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ethereum = {
      url = "github:nix-community/ethereum.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    neovim-nightly = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, kimi-cli, nix-vscode-extensions, ethereum, plasma-manager, neovim-nightly, ... }@inputs: let
     username = "yash";
  in {
    nixosConfigurations.based-department = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        # Import the previous configuration.nix we used,
        # so the old configuration file still takes effect
        ./hardware-configuration.nix 
        ./configuration.nix
        # make home-manager as a module of nixos
        # so that home-manager configuration will be deployed automatically when executing `nixos-rebuild switch`
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;

          home-manager.sharedModules = [ plasma-manager.homeModules.plasma-manager ];
          home-manager.users.${username} = import ./home.nix;

          # Optionally, use home-manager.extraSpecialArgs to pass arguments to home.nix
          home-manager.extraSpecialArgs = {
            inherit kimi-cli;
            inherit nix-vscode-extensions;
            inherit ethereum;
	    inherit neovim-nightly;
          };
        }
      ];
    };
  };
}
