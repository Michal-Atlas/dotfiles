function pull
	ln -f (readlink $argv) $argv
end