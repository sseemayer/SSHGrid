SSHGrid
=======

SSHGrid is a poor-man's grid computing implementation that was designed 
for minimal software requirements on the compute nodes. It can be used
to turn e.g. CIP pool machines into compute nodes during low-usage hours.

Requirements
------------

Requirements for the master (i.e. your machine)
* `perl`
* `bash`
* `ssh`, `scp`
* no root access!

Requirements for the compute nodes
* A common filesystem shared between them
* You can SSH into them via public key authentication
* `bash`

Running it
----------

Download the current version, extract and run in a commandline:

	$ cd SSHGrid/
	$ . dev.sh
	$ sshgrid-do

Installation
------------

Currently, no installation method is provided, but that will change.

Documentation
-------------

Check the [SSHGrid wiki](https://github.com/sseemayer/SSHGrid/wiki) for more information or see SSHGrids manpages:

	$ sshgrid-do --man

Contributing
------------

Want to contribute? Great! Fork me on github at https://github.com/sseemayer/SSHGrid


