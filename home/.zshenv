[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env" || true

export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/library"

setopt -w0U
setopt auto_continue
setopt no_hup
setopt pipe_fail

GUIX_PROFILE="/home/michal-atlas/.guix-profile"
. "$GUIX_PROFILE/etc/profile"