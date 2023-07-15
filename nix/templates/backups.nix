{ pkgs, ... }: {
  systemd =
    let
      make-btrfs-timer = label: period: {
        "btrfs-autosnap-${label}" = {
          wantedBy = [ "timers.target" ];
          timerConfig = {
            OnCalendar = period;
            Persistent = true;
            Unit = "btrfs-autosnap-${label}.service";
          };
        };
      };
      make-btrfs-service = label: path: retention: {
        "btrfs-autosnap-${label}" = {
          script = ''
            ${pkgs.sbcl.withPackages (ps: with ps; [
              clingon local-time pkgs.btrfs-progs
            ])}/bin/sbcl \
                --script ${../../scripts/btrfs-autosnap.lisp} \
                --label '${label}' \
                --path '${path}' \
                --retention '${builtins.toString retention}'
          '';
          serviceConfig = { Type = "oneshot"; };
        };
      };
    in
    {
      timers =
        (make-btrfs-timer "frequent" "*:0/15") //
        (make-btrfs-timer "hourly" "hourly") //
        (make-btrfs-timer "daily" "daily") //
        (make-btrfs-timer "weekly" "weekly") //
        (make-btrfs-timer "monthly" "monthly");
      services =
        (make-btrfs-service "frequent" "/home/" 4) //
        (make-btrfs-service "hourly" "/home/" 26) //
        (make-btrfs-service "daily" "/home/" 4) //
        (make-btrfs-service "weekly" "/home/" 5) //
        (make-btrfs-service "monthly" "/home/" 12);
    };
}
