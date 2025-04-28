{ config, pkgs, lib, ... }:

{
  disko.devices = {
    disk = {
      sda = {
        device = "/dev/sda";
        content = {
          type   = "table";
          format = "gpt";
          partitions = [
            {
              name      = "ESP";
              start     = "1MiB";
              end       = "512MiB";
              bootable  = true;         # нужно для BIOS-MBR/BIOS-GRUB
              content = {
                type        = "filesystem";
                format      = "vfat";
                mountpoint  = "/boot";
                mountOptions = [ "umask=0077" ];
              };
            }
            {
              name      = "root";
              start     = "512MiB";
              end       = "100%";
              content = {
                type       = "filesystem";
                format     = "ext4";
                mountpoint = "/";
              };
            }
          ];
        };
      };
    };
  };
}
