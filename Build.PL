
use Module::Build;
my $build = Module::Build->new(
	module_name	=> 'SSHGrid',
	license		=> 'gpl',

	share_files	=> {
		'share/SSHGrid/node-bin/sshgrid-worker'			=> 'share/SSHGrid/node-bin/sshgrid-worker',
		'share/SSHGrid/examples/command_files/hello_world.sh'	=> 'share/SSHGrid/examples/command_files/hello_world.sh',
	},

	install_path	=> {
		share => '/usr/share',
	},
);
$build->add_build_element('share');
$build->create_build_script;
