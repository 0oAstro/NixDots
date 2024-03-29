# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = ["ehci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" "sr_mod"];
  boot.initrd.kernelModules = ["i915"];
  boot.kernelModules = ["kvm-intel"];
  boot.extraModulePackages = [];

  powerManagement.cpuFreqGovernor = "performance";

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/7a280a05-6d6a-4085-9037-9a277037fa69";
    fsType = "btrfs";
    options = ["subvol=nixos" "noatime" "space_cache=v2" "compress=zstd" "autodefrag"];
  };

  fileSystems."/home" = {
    device = "/dev/disk/by-uuid/7a280a05-6d6a-4085-9037-9a277037fa69";
    fsType = "btrfs";
    options = ["subvol=home" "compress=zstd" "autodefrag" "noatime" "space_cache=v2"];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/B04C-7A33";
    fsType = "vfat";
  };

  swapDevices = [
    {device = "/dev/disk/by-uuid/f25c14b1-02b2-4bcd-8aa2-035a34838d14";}
  ];

  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
