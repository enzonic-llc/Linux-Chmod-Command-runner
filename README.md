# Linux Chmod Scheduler

A simple script to automate `chmod` permissions for specified directories on a Linux system. It runs periodically to apply **`chmod -R 777`** to all paths listed in a configuration file.

-----

## 📂 Project Structure

```
linux-chmod-scheduler/
├── src/
│   └── run_chmod.sh         # Main script
└── README.md              # Documentation
```

-----

## 🚀 Quick Start

1.  **Clone the Repository**

    ```bash
    git clone https://github.com/enzonic-llc/linux-chmod-scheduler
    cd linux-chmod-scheduler
    ```

2.  **Make the Script Executable**

    ```bash
    chmod +x src/run_chmod.sh
    ```

3.  **Run the Script Manually**
    To test it, run the script once:

    ```bash
    bash src/run_chmod.sh
    ```

## 🤖 Running Automatically at Startup

Choose one of the following methods to run the script automatically.

### Using `systemd` (Recommended)

1.  **Create a `systemd` Service File**
    Open a new service file using a text editor:

    ```bash
    sudo nano /etc/systemd/system/chmod-scheduler.service
    ```

    Paste the following configuration. **Remember to replace** *`/absolute/path/to/linux-chmod-scheduler`* with the actual path where you cloned the repository.

    ```ini
    [Unit]
    Description=Run chmod scheduler script to manage directory permissions

    [Service]
    Type=simple
    ExecStart=/bin/bash /linux-chmod-scheduler/src/run_chmod.sh
    Restart=always

    [Install]
    WantedBy=multi-user.target
    ```

2.  **Enable and Start the Service**

    ```bash
    sudo systemctl daemon-reload
    sudo systemctl enable chmod-scheduler.service
    sudo systemctl start chmod-scheduler.service
    ```

3.  **Check the Service Status**

    ```bash
    sudo systemctl status chmod-scheduler.service
    ```

### Using `cron`

1.  **Edit Your Crontab**
    Open the crontab editor for the current user:

    ```bash
    crontab -e
    ```

2.  **Add the Cron Job**
    Add the following line at the end of the file. This example runs the script every minute. **Remember to replace** *`/absolute/path/to/linux-chmod-scheduler`* with your actual path.

    ```
    * * * * * /bin/bash /absolute/path/to/linux-chmod-scheduler/src/run_chmod.sh
    ```

-----

## ⚠️ Security Warning

> **Warning:** Using **`chmod -R 777`** grants read, write, and execute permissions to *everyone* (owner, group, and others). This is a **major security risk** on most systems. Only use this script if you fully understand the implications and are operating in a controlled environment where such open permissions are required and safe.

-----

## 🛠️ Troubleshooting

  * **Script Won't Run**

      * Ensure the script is executable: `chmod +x src/run_chmod.sh`
      * If you're modifying system directories, you may need to run the script with `sudo`: `sudo bash src/run_chmod.sh`

  * **`systemd` Service Issues**

      * View recent logs for your service to find errors: `journalctl -u chmod-scheduler`

  * **`cron` Job Not Working**

      * Ensure your crontab was saved correctly.
      * Check system logs for cron activity: `grep CRON /var/log/syslog` (log location may vary by distribution).

  * **Need More Help?**

      * For any other questions or issues, feel free to **open an issue** on the project's GitHub repository.
