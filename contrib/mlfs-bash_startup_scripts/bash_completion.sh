for script in /etc/bash_completion.d/*.sh ; do
	if [ -r $script ] ; then
		. $script
	fi
done
