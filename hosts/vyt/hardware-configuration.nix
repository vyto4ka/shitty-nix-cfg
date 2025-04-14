# Автоматически сгенерированная аппаратная конфигурация.
{ config, lib, ... }:
{
  imports = [ ];

  fileSystems."/" =
    { device = "/dev/sda2";
      fsType = "ext4";
    };

  swapDevices = [ ];
}
