run: setup
	./antivirusd.sh dir malicious_dir 5

restore: setup
	./restore.sh dir malicious_dir

setup:
	mkdir -p malicious_dir
