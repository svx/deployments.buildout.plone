.PHONY: lucky

PATH := .:$(PATH)

lucky:
	./.imfeelinglucky.sh

install_crontab:
	./bin/fab install_crontab

install_logrotate:
	./bin/fab install_logrotate

# ./bin/munin-install is generated by buildout at the moment
install_munin:
	./bin/munin-install.py

install_files: install_crontab install_logrotate install_munin

buildout:
	./bin/buildout -Nt 2

#update:
#	svn up
#	./bin/mr.developer update ''

#diff:
#	svn diff
#	./bin/mr.developer status ''
