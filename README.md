SSHGrid
=======

SSHGrid is a poor-man's grid computing implementation that was designed for minimal software requirements on the compute nodes. It can be used to turn e.g. CIP pool machines into compute nodes during low-usage hours.

Some other select features are:

* Basic management tools (`sshgrid-do`, `sshgrid-status`, `sshgrid-kill`)
* Support for synchronization via barriers
* Can manage compute nodes over multiple filesystems
* Coordination via nothing but SSH

Requirements
------------

Requirements for the master (i.e. your machine):

* `perl`, `bash`, `ssh`, `scp`
* no root access!

Requirements for the compute nodes:

* There is a "master" node that all compute nodes can SSH into
* You can SSH into the compute nodes via public key authentication
* `bash`

Running it
----------

SSHGrid can be run without prior installation using the `dev.sh` shell script that will set up your shell correctly. 
Just download the current version, extract and run in a commandline:

	$ cd SSHGrid/
	$ . dev.sh
	$ sshgrid-do

Installation
------------

If you are a lucky Arch Linux user with root privileges, you can check out [SSHGrid on AUR](http://aur.archlinux.org/packages.php?ID=49616).

For any other linux distribution, if you have root priviliges on your current system, you can install SSHGrid via the tarball. Installation is currently 
provided by [Module::Build](http://search.cpan.org/perldoc?Module::Build) - after downloading and extraction, run:

	$ perl Build.PL
	$ ./Build
	$ sudo ./Build install

Documentation
-------------

Check the [SSHGrid wiki](https://github.com/sseemayer/SSHGrid/wiki) for more information or see SSHGrids manpages:

	$ sshgrid-do --man

Contributing
------------

Want to contribute? Great! Fork me on github at https://github.com/sseemayer/SSHGrid


