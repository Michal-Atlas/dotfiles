{ pkgs, lib, ... }:
{
  enable = true;
  systemd.enable = true;
  wrapperFeatures = { gtk = true; base = true; };
  config = {
    gaps = {
      inner = 5;
      outer = 5;
    };
    input = {
      "type:keyboard" = {
        xkb_layout = "us,cz";
        xkb_variant = ",ucw";
        xkb_options = "grp:caps_switch,grp_led,lv3:ralt_switch,compose:rctrl-altgr";
        xkb_numlock = "enabled";
      };
      "1739:32382:DELL0740:00_06CB:7E7E_Touchpad" = {
        dwt = "enabled";
        tap = "enabled";
        natural_scroll = "enabled";
        middle_emulation = "enabled";
      };
    };
    output = {
      "*" = {
        bg = "${
                                         builtins.fetchurl {
                                           url = "https://ift.tt/2UDuBqa";
                                           sha256 = "sha256:1nj5kj4dcxnzazf46dczfvcj8svhv1lhfa8rxn0q418s3j1w5dcb";
                                         }
                                       } fill";
      };
      "HDMI-A-1".position = "1920,0";
      "DP-1".position = "0,0";
    };
    menu = "${pkgs.bemenu}/bin/bemenu-run -c -M200 --fn 'Fira Code 15' -B2 -l10";
    modifier = "Mod4";
    startup = [
      { command = "${pkgs.autotiling}"; }
    ];
    terminal = "${pkgs.foot}/bin/footclient";
  };
}
