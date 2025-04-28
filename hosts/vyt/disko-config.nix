{ config, pkgs, lib, … }:

{
  disko.devices = {
    sda = {
      device = "/dev/sda";
      content = {
        type       = "table";
        format     = "gpt";
        partitions = [
          {
            name      = "ESP";
            start     = "1MiB";
            end       = "512MiB";
            content = {
              type       = "filesystem";
              format     = "vfat";
              mountpoint = "/boot";
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
}
