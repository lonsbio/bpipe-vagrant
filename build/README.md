build
======

Once built inside your VM, copy your build archive here (e.g. bpipe.tar.gz)

	cp build/bpipe.tar.gz .
	tar -xvzf bpipe.tar.gz

Copy to your target system, and then use source (or .) with the load\_bpipe.bash script and bpipe location. Note: assumes an environment with module, and loads java accordingly. 

	source load\_bpipe.bash bpipe

Test with

	which bpipe


