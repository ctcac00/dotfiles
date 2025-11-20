{
  description = "Macbook Air M4 Setup";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    mac-app-util.url = "github:hraban/mac-app-util";
    nix-homebrew.url = "github:zhaofengli/nix-homebrew";

    # Optional: Declarative tap management
    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };
    dbt-labs = {
      url = "github:dbt-labs/dbt-cli";
      flake = false;
    };
  };

  outputs = inputs @ {
    self,
    nix-darwin,
    nixpkgs,
    mac-app-util,
    nix-homebrew,
    homebrew-core,
    homebrew-cask,
    dbt-labs,
  }: let
    configuration = {pkgs, ...}: {
      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      environment.systemPackages = [
        pkgs.vim
        pkgs.neovim
        pkgs.tmux
        pkgs.zoxide
        pkgs.kitty
        pkgs.iterm2
        pkgs.alacritty
        pkgs.stow
        pkgs.bat
        pkgs.atuin
        pkgs.rustup
        pkgs.nodejs_22
        pkgs.go
        pkgs.python313
        pkgs.python313Packages.pip
        pkgs.fzf
        pkgs.fd
        pkgs.lazygit
        pkgs.lazydocker
        pkgs.lua
        pkgs.btop
        pkgs.awscli2
        pkgs.google-cloud-sdk
        pkgs.eza
        pkgs.fastfetch
        pkgs.openssh
        pkgs.yazi
        pkgs.aerospace
        pkgs.gemini-cli
        pkgs.vscode
        pkgs.postman
        pkgs.httpie
        pkgs.curlie
        pkgs.docker-compose
        pkgs.dbeaver-bin
        pkgs.stats
        pkgs.maccy
        pkgs.telegram-desktop
        pkgs.skhd
        pkgs.ripgrep
        pkgs.k3d
        pkgs.k9s
        pkgs.ncdu
        pkgs.gh
        pkgs.exiftool
        pkgs.qemu
        pkgs.mongosh
        pkgs.mongodb-compass
        pkgs.raycast
        pkgs.hidden-bar
        pkgs.pipx
        pkgs.uv
        pkgs.claude-code
        pkgs.nmap
        pkgs.jankyborders
      ];

      homebrew = {
        enable = true;
        taps = [
          "homebrew/command-not-found"
        ];
        brews = [
          "superfile"
          "helm"
          "dbt"
        ];
        casks = [
          "docker-desktop"
          "garmin-express"
          "vlc"
          "gimp"
          "spotmenu"
          "spotify"
          "vnc-viewer"
        ];
        masApps = {
          "Xcode" = 497799835;
          "Wireguard" = 1451685025;
        };
        onActivation.autoUpdate = true;
        global.autoUpdate = true;
      };

      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";
      nixpkgs.config.allowUnfree = true;
      # Enable alternative shell support in nix-darwin.
      # programs.fish.enable = true;

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 6;

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";
      nix.extraOptions = ''
        extra-platforms = x86_64-darwin aarch64-darwin
      '';

      security.pam.services.sudo_local.touchIdAuth = true;
      security.pam.services.sudo_local.reattach = true;

      system.primaryUser = "carlos";
      system.defaults = {
        dock = {
          autohide = true;
          orientation = "bottom";
          showhidden = true;
          mineffect = "genie";
          launchanim = true;
          show-process-indicators = true;
          tilesize = 48;
          static-only = true;
          mru-spaces = false;
          show-recents = false;
        };
        finder = {
          AppleShowAllExtensions = true;
          FXEnableExtensionChangeWarning = false;
          CreateDesktop = false; # disable desktop icons
          FXPreferredViewStyle = "clmv";
          ShowPathbar = true;
          ShowStatusBar = true;
          FXDefaultSearchScope = "SCcf";
          _FXShowPosixPathInTitle = true;
        };
        trackpad = {
          Clicking = true;
          TrackpadThreeFingerDrag = true;
          Dragging = true;
        };
        loginwindow = {
          GuestEnabled = false;
          DisableConsoleAccess = true;
        };
        SoftwareUpdate.AutomaticallyInstallMacOSUpdates = true;
        NSGlobalDomain = {
          AppleInterfaceStyle = "Dark"; # set dark mode
          AppleKeyboardUIMode = 3;
          ApplePressAndHoldEnabled = false;
          NSAutomaticCapitalizationEnabled = false;
          NSAutomaticDashSubstitutionEnabled = false;
          NSAutomaticPeriodSubstitutionEnabled = false;
          NSAutomaticQuoteSubstitutionEnabled = false;
          NSAutomaticSpellingCorrectionEnabled = false;
          NSNavPanelExpandedStateForSaveMode = true;
          NSNavPanelExpandedStateForSaveMode2 = true;
          _HIHideMenuBar = false;
          KeyRepeat = 2;
        };
        screencapture.location = "~/Pictures/Screenshots";
        screensaver.askForPasswordDelay = 10;

        CustomUserPreferences = {
          # Settings of plist in /Users/${vars.user}/Library/Preferences/
          "com.apple.finder" = {
            # Set home directory as startup window
            NewWindowTargetPath = "file:///Users/carlos/";
            NewWindowTarget = "PfHm";
            # Multi-file tab view
            FinderSpawnTab = true;
          };
          "com.apple.desktopservices" = {
            # Disable creating .DS_Store files in network an USB volumes
            DSDontWriteNetworkStores = true;
            DSDontWriteUSBStores = true;
          };
          # Privacy
          "com.apple.AdLib".allowApplePersonalizedAdvertising = false;
          "com.apple.CoreBrightness" = {
            CBBlueReductionEnabled = 1;
            CBBlueReductionMode = 2;
          };
        };
      };

      fonts.packages = with pkgs; [maple-mono.NF-unhinted];
    };
  in {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#m4air
    darwinConfigurations."m4air" = nix-darwin.lib.darwinSystem {
      modules = [
        configuration
        mac-app-util.darwinModules.default
        nix-homebrew.darwinModules.nix-homebrew
        {
          nix-homebrew = {
            # Install Homebrew under the default prefix
            enable = true;

            # Apple Silicon Only: Also install Homebrew under the default Intel prefix for Rosetta 2
            enableRosetta = true;

            # User owning the Homebrew prefix
            user = "carlos";

            # Optional: Declarative tap management
            taps = {
              "homebrew/homebrew-core" = homebrew-core;
              "homebrew/homebrew-cask" = homebrew-cask;
              "dbt-labs/dbt-cli" = dbt-labs;
            };

            # Optional: Enable fully-declarative tap management
            #
            # With mutableTaps disabled, taps can no longer be added imperatively with `brew tap`.
            mutableTaps = true;
          };
        }
        # Optional: Align homebrew taps config with nix-homebrew
        ({config, ...}: {
          homebrew.taps = builtins.attrNames config.nix-homebrew.taps;
        })
      ];
    };
  };
}
