{
  network.description = "git content counter";

  gitter =
    { config, pkgs, ... }:
    let
      tgtpkgs = pkgs // {
        gitcount = pkgs.callPackage ./gitcount.nix {};
      };
    in
    { networking.firewall.enable = false;
      services.openssh = {
          enable = true;
          # permitRootLogin = "yes";
      };

      # The remote service shouldn't take long.  Set a pre-scheduled
      # shutdown to ensure that the VM doesn't continue running (limit
      # cost) and to cause termination if the service gets hung.
      environment.extraInit = "shutdown -P +10";

      # The service will be a captive SSH login, so it will not have a
      # profile.  Specify the set of packages needed to perform the
      # service.
      environment.systemPackages = with tgtpkgs; [gitcount git coreutils];

      # Now create a captive SSH login that will run the service when
      # connected to.  There will also be a root login available..
      users.users = {
        gitcounter = {
          createHome = true;
          description = "Checkout and run wc on a git repo";
          home = "/home/gitcounter";
          shell = tgtpkgs.gitcount;  # captive to this executable
          openssh = {
          #   authorizedKeys.keys = "public-access-key";
          # OR:
            authorizedKeys.keyFiles = [ /home/kquick/.ssh/authorized_keys ];
          };
        };
      };

      # Make sure the captive executable is an allowed shell
      environment.shells = [ tgtpkgs.gitcount ];
    };

}
