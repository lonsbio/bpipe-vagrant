#!/bin/bash
if [ $# != 1 ]; then
	echo "

** No effect when called directly, use source load_bpipe <bpipe_directory> **

Usage: load_bpipe <bpipe directory>

* Java module loaded
* BPIPE_HOME will be set to <bpipe directory>, appended to PATH and exported
* All other arguments ignored
* 'which bpipe' to test
"
	exit 1
fi


module load java && BPIPE_HOME=`readlink -f $1` &&  export BPIPE_HOME && PATH=$BPIPE_HOME/bin:$PATH && export PATH
