function batchsum
	for f in $argv
		set nf (shasum $f | cut -d' ' -f1).(echo $f | sed "s/.*\.\(.*\)/\1/g")
		if [ $f != $nf ]
			mv $f $nf
		end
	end
end
