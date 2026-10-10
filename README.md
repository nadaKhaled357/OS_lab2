# Lab 2 - Simple Antivirus

A shell antivirus daemon that monitors a directory and quarantines malicious files, plus a tool to restore or permanently delete the quarantined files.

## Folder hierarchy

```
9038-lab2/
├── antivirusd.sh
├── restore.sh
├── Makefile
├── README.md
├── dir/
└── malicious_dir/
```

## Files

- `antivirusd.sh` monitors `dir` and, when it changes, copies malicious files to `malicious_dir` and deletes them from `dir`.
- `restore.sh` lets you restore or permanently delete quarantined files.
- `Makefile` creates `malicious_dir` and runs the scripts.
- `dir` is the folder being monitored. It is created in the Setup step.
- `malicious_dir` stores the quarantined files. It is created automatically.

While the daemon runs it also creates `directory-info.last` and `directory-info.new` in the project folder. They store the snapshots of `dir` used to detect changes.

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

To test it, open a second terminal in the project folder and add files to `dir`:

```bash
echo "hello" > dir/ok.txt
echo "x" > dir/bad.exe
echo "this is a trojan" > dir/note.txt
```

The daemon prints `<file> is malicious and it is DELETED` for the last two files and moves them to `malicious_dir`.

## Restore or delete files

Stop the daemon first, then run:

```bash
make restore
```

Choose a file by its number. Enter `1` to restore it, `2` to permanently delete it, or `3` to leave it in quarantine. Enter `q` to quit. If `malicious_dir` is empty, the tool prints `No malicious files to review.`

## Detection rules

The lists are defined at the top of `antivirusd.sh`:

```bash
extensions="exe|bat|vbs|scr|ps1"
keywords="virus|trojan|malware|worm|ransomware"
```

A file is malicious if its name ends with one of the extensions, or if its content contains one of the keywords. Both checks ignore upper and lower case.
