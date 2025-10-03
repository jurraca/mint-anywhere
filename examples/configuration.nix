{ config, pkgs, lib, ... }: {
  imports = [
    # <nix-bitcoin/modules/presets/secure-node.nix>

    # FIXME: The hardened kernel profile improves security but
    # decreases performance by ~50%.
    # Turn it off when not needed.
    # <nix-bitcoin/modules/presets/hardened.nix>

    # FIXME: Uncomment next line to import your hardware configuration. If so,
    # add the hardware configuration file to the same directory as this file.
    # ./hardware-configuration.nix
  ];
  # FIXME: Enable modules by uncommenting their respective line. Disable
  # modules by commenting out their respective line.


  nix-bitcoin.generateSecrets = true;

  ### BITCOIND
  # Bitcoind is enabled by default via secure-node.nix.
  services.bitcoind = {
    dataDir = "/var/lib/bitcoin";
    txindex = true;
    i2p = true;
    extraConfig = ''
      v2transport=1
    '';
  };

  networking.firewall.allowedTCPPorts = [
    config.services.bitcoind.rpc.port
    config.services.clightning-rest.port
  ];

  ### CLIGHTNING
  # Enable clightning, a Lightning Network implementation in C.
  services.clightning = {
    enable = true;
    extraConfig = ''
      log-level=debug
    '';
  };

  services.clightning-rest = {
    enable = true;
    lndconnect = {
      enable = true;
      onion = true;
    };
  };

  ### Cashu Mint via CDK
  services.cdk-mintd = {
    enable = true;
    settings = {
      lightning = {
        backend = "cln";
        maxMint = 10000;
        maxMelt = 10000;
      };
      mintInfo = {
        enable = true;
        name = "Bank of Cyberspace";
        motd = "hack the planet!!!";
        # description = "";
        # iconURL = "...";
        # pubkey = "";
      };
    };
  };

  networking.hostName = "cyberspace-bank";
  time.timeZone = "UTC";

  services.openssh.enable = true;

  # FIXME: add your SSH key
  users.users.root = {
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3N..."
    ];
  };

  # FIXME: Uncomment this to allow the operator user to run
  # commands as root with `sudo` or `doas`
  users.users.operator.extraGroups = [ "wheel" ];

  # FIXME: add packages you need in your system
  environment.systemPackages = with pkgs; [
    nvim
    ripgrep
    tmux
  ];

  environment.shellAliases = {
    ll = "ls -al";
    ta = "tmux a -t";
    tls = "tmux ls";
    ss = "systemctl status";
  };

  # FIXME: Add custom options (like boot options, output of
  # nixos-generate-config, etc.):

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "21.05"; # Did you read the comment?

  # The nix-bitcoin release version that your config is compatible with.
  # When upgrading to a backwards-incompatible release, nix-bitcoin will display an
  # an error and provide hints for migrating your config to the new release.
  nix-bitcoin.configVersion = "0.0.70";
}
