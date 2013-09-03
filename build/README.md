build
======

Once built inside your VM, copy your build archive here (e.g. bpipe.tar.gz)

	cp build/bpipe.tar.gz /vagrant/build/

Copy to your target system and extract:

	tar -xvzf bpipe.tar.gz

Use source (or .) with the load\_bpipe.bash script and bpipe location. Note: assumes an environment with module, and loads java accordingly. 

	source load\_bpipe.bash bpipe

Test with

	which bpipe


