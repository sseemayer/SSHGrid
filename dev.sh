#!/bin/bash

# sshgrid-dev - Convenient access to bin/ and lib/

# determine directory that this script is located in
SELF="${BASH_SOURCE[0]}";
if ([ -h "${SELF}" ]) then
	  while([ -h "${SELF}" ]) do SELF=`readlink "${SELF}"`; done
fi
pushd . > /dev/null
cd `dirname ${SELF}` > /dev/null
SELF=`pwd`;
popd  > /dev/null

export PATH="$PATH:$SELF/bin"
export PERL5LIB="$PERL5LIB:$SELF/lib"
