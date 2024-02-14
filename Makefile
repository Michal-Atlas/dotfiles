.PHONY: system home

CONFIG_FILE="config.scm"
COMMON_FLAGS="--verbosity=3 -M4"
SYSTEM_FLAGS="--on-error=backtrace"

system: builds/system
	sudo OP="system" --preserve-env=GUILE_LOAD_PATH guix system reconfigure ${CONFIG_FILE}

builds/system:
	OP="system" guix system build -r "$@" ${CONFIG_FILE}

home: builds/home
	OP="home" guix home reconfigure ${CONFIG_FILE}

builds/home:
	OP="home" guix home build ${CONFIG_FILE}

pull:
	guix time-machine -C channels.scm -- describe -f channels > "$LOCK_FILE"
