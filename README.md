# linux-chmod-scheduler

Automate changing file permissions for specified directories on a Linux system. This script runs every 60 seconds, applying `chmod -R 777` to all paths listed in a configuration file.

---

## Project Structure

```
linux-chmod-scheduler
├── src
│   └── run_chmod.sh         # Main script
├── config
│   └── paths.conf           # List of directories to chmod
└── README.md                # Documentation
```

---

## Quick Start

### 1. Clone and Run Directly from GitHub

You can run the script directly without manually downloading files:

```bash
git clone <repository-url>
cd linux-chmod-scheduler
chmod +x src/run_chmod.sh
bash src/run_chmod.sh
```

Or, run directly using `curl` and `bash` (replace `<raw-url>` with the raw GitHub URL):

```bash
curl -sL <raw-url-to-run_chmod.sh> | bash
```

> **Note:**  
> For configuration, you still need to create and edit `config/paths.conf` with your target directories.

---

## Configure Target Directories

Edit `config/paths.conf` and add each directory you want to update, one per line:

```
/DATA
/var/lib/pterodactyl
/var/lib/pufferpanel
/etc/pterodactyl
```

---

## Run Automatically at Startup

### Option 1: Using systemd (Recommended)

1. **Create a service file**  
   Replace `/absolute/path/to/linux-chmod-scheduler/src/run_chmod.sh` with your actual path.

   ```ini
   # /etc/systemd/system/chmod-scheduler.service
   [Unit]
   Description=Run chmod scheduler script

   [Service]
   Type=simple
   ExecStart=/absolute/path/to/linux-chmod-scheduler/src/run_chmod.sh
   Restart=always

   [Install]
   WantedBy=multi-user.target
   ```

2. **Enable and start the service**

   ```bash
   sudo systemctl enable chmod-scheduler
   sudo systemctl start chmod-scheduler
   ```

### Option 2: Using Cron

Add this line to your crontab (`crontab -e`) to run the script every minute:

```
* * * * * /bin/bash /absolute/path/to/linux-chmod-scheduler/src/run_chmod.sh
```

---

## Modifying Directories

To change which directories are affected, edit `config/paths.conf`. Each directory should be on its own line.

---

## Security Warning

> **Warning:**  
> `chmod -R 777` gives all users full access to files and folders. This can be a major security risk. Only use on directories where this is safe and intended.

---

## Troubleshooting

- Ensure the script has execute permissions:  
  `chmod +x src/run_chmod.sh`
- Run as root if you need permission to change system directories.
- Check logs with `journalctl -u chmod-scheduler` if using systemd.