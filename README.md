# Lab 2 - Simple Antivirus

## Files

- `antivirusd.sh` monitors `dir` and moves suspicious files to `malicious_dir`.
- `restore.sh` lets you restore or permanently delete quarantined files.
- `Makefile` creates `malicious_dir` and runs the scripts.
- `dir` is the folder being monitored.
- `malicious_dir` stores suspicious files.

The scripts work with files directly inside `dir`; they do not scan subfolders.

## Requirements

Ubuntu and Bash. Make is needed to use the Makefile. Install it with:

```bash
sudo apt update
sudo apt install make
```

## Setup

Open a terminal in the project folder and run:

```bash
chmod +x antivirusd.sh restore.sh
mkdir -p dir
make setup
```

## Run the antivirus

Start the daemon with:

```bash
make run
```

It checks for changes every 5 seconds. Press `Ctrl+C` to stop it.

## Restore or delete files

Stop the daemon first, then run:

```bash
make restore
```

Choose a file by its number. Enter `1` to restore it, `2` to permanently delete it, or `3` to leave it in quarantine. Enter `q` to quit.

## Detection rules

In `antivirusd.sh`, the `extensions` variable contains `exe`, `bat`, `vbs`, `scr`, and `ps1`. The `keywords` variable contains `virus`, `trojan`, `malware`, `worm`, and `ransomware`.

The script checks filenames for the listed extensions and file contents for the listed keywords.
