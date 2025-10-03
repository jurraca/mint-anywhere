## README

<img width="256" height="256" alt="mint-anywhere" src="https://github.com/user-attachments/assets/092f0a2c-9e79-4f24-ad59-b05f1a879895" />


*Status*: untested, custom CDK branch, needs security review.

Deploy a Cashu mint with [CDK](https://github.com/cashubtc/cdk) and [nixos-anywhere](https://github.com/nix-community/nixos-anywhere).

- Step 1: have a machine with SSH access. This can be a VPS, a local machine, anything.
- Step 2: configure your settings
- Step 3: deploy

### Quickstart

If you're familiar with `nix-bitcoin` or NixOS configuration, then adding a Cashu mint to your configuration should look reasonably familiar:

```nix
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
```

### Under the hood

nixos-anywhere leverages `kexec` to turn any machine into a NixOS machine, which means you can then modify and deploy it from the comfort of your desktop reliably.
With existing projects like `nix-bitcoin`, you can deploy a Bitcoin and Lightning node with your own configuration easily, and combine them with other Nix deploys.
With `mint-anywhere`, you can leverage both of these to deploy a Cashu mint built with CDK.


TODO: example configurations, step by step guide.
