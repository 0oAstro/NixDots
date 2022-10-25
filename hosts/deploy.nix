inputs: {
  nodes = with inputs.deploy-rs.lib.x86_64-linux; {
    nu = {
      hostname = "nu";
      profiles.system = {
        user = "root";
        path = activate.nixos inputs.self.nixosConfigurations.nu;
      };
    };
  };
}
