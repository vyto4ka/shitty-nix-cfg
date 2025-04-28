{ config, pkgs, lib, ... }:

{
  disko.devices = {
    disk = {
      sda = {
        device = "/dev/sda";
        content = {
          type    = "table";
          format  = "gpt";
           partitions = {
             ESP = {
               size = "512MiB";
               content = {
                 type       = "filesystem";
                 format     = "vfat";
                 mountpoint = "/boot";
                 mountOptions = [ "umask=0077" ];
               };
             };
             root = {
               size = "100%";
               content = {
                 type       = "filesystem";
                 format     = "ext4";
                 mountpoint = "/";
               };
             };
           };
        };
      };
    };
  };
}
