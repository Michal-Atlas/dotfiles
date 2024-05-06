.PHONY: system home

all: system home

CONFIG_FILE ::= config.scm
COMMON_FLAGS += --verbosity=3 -M4
SYSTEM_FLAGS += --on-error=backtrace

guix ::= ./pre-inst-env guix

system:
	sudo OP="system" --preserve-env=GUILE_LOAD_PATH --preserve-env=LOCK_FILE $(guix) system reconfigure $(CONFIG_FILE) $(COMMON_FLAGS) $(SYSTEM_FLAGS)

build-system:
	OP="system" $(guix) system build -r "$@" $(CONFIG_FILE) $(COMMON_FLAGS) $(SYSTEM_FLAGS)

home:
	OP="home" $(guix) home reconfigure $(CONFIG_FILE) $(COMMON_FLAGS) $(HOME_FLAGS)

build-home:
	OP="home" $(guix) home build $(CONFIG_FILE) $(COMMON_FLAGS) $(HOME_FLAGS)

pull:
	guix time-machine -C channels.scm -- describe -f channels > "${LOCK_FILE}"
