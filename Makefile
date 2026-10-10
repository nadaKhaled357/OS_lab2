DIR = dir
MAL_DIR = malicious_dir
INTERVAL = 5

run: setup
	./antivirusd.sh $(DIR) $(MAL_DIR) $(INTERVAL)

restore: setup
	./restore.sh $(DIR) $(MAL_DIR)

setup:
	mkdir -p $(MAL_DIR)
