## Automated Django app deployment on DigitalOcean droplet

This project automates Django deployments on a DigitalOcean droplet using GitHub Actions. It sets up Python dependencies, manages a uWSGI service with systemd, and utilizes Nginx for web serving. Automated GitHub Actions using self hosted runner for updates and maintenance of the application.

## Server Setup:

### Setting up self-hosted GitHub runner:
- Repository settings > Actions > Runners > New self-hosted runner.
- Follow the instructions given there.
- Install and start the service for the same.([Reference](https://docs.github.com/en/actions/hosting-your-own-runners/managing-self-hosted-runners/configuring-the-self-hosted-runner-application-as-a-service))
- Run the `actions/checkout` action once to setup your repository on the server.

### Setting up Python environment:
- Installing dependencies: ```sudo apt install -y python3 python3-pip python3-venv nginx```
- Create python virtual environment: ```python3 -m venv venv``` this is located in home directory of user.
- Installing project dependencies: ```pip install -r requirements.txt```

### Setting up `django-app.service`:
- Created a `systemd` service named `django-app.service`.
- Located at `/etc/systemd/systemd/`
- ```ini
    [Unit]
    Description=uWSGI instance for django-app
    After=network.target

    [Service]
    User=<user>
    Group=<group>
    WorkingDirectory=path/to/working/directory
    Environment="PATH=path/to/environment"
    ExecStart=path/to/uwsgi --socket path/to/socket --module path/to/<app_name>.wsgi
    ExecReload=/bin/kill -s HUP $MAINPID
    ExecStop=/bin/kill -s TERM $MAINPID
    ExecStopPost=/bin/rm -f path/to/socket

    [Install]
    WantedBy=multi-user.target
    ```
- This manages the `uWSGI` instance for the django app.
- The `server-restart.sh` script checks for the instance and starts/restarts it accordingly.

Now whenever code is pushed to the repository GitHub actions does checkout in the directory and runs the `server-restart.sh` script.
