## Run Locally

Clone the project

```bash
  git clone https://github.wdf.sap.corp/cis-backup/ccloud-script-miscellaneous.git
```

Go to the project directory

```bash
  cd my-project
```

Script to set up a Docker environment for ioBroker, Grafana, and InfluxDB



## Shalom4Sun

### - Script to set up a Docker environment for ioBroker, Grafana, and InfluxDB


This is a shell script that automates the setup of a Docker environment for ioBroker, Grafana, and InfluxDB. The script creates the following directories and files:

- iobroker: a directory that contains a Dockerfile <br>FROM iobroker:latest<br><br>
- grafana: a directory that contains a Dockerfile <br>FROM grafana/grafana:latest<br><br>
- influx: a directory that contains a Dockerfile  <br>FROM influxdb:1.8%<br><br>
- docker-compose.yaml: a file that defines the Docker containers for ioBroker, Grafana, and InfluxDB<br><br>
### The script checks if the directories already exist and overrides them if they do. It then creates the directories and files, and creates the docker-compose.yaml file with the appropriate configuration.

### Usage
## To use the script, follow these steps:

- Clone or download this repository to your local machine.<br>
- Open a terminal window and navigate to the directory where the repository is located.<br>
- Run the shell script by entering the following command: ./setup.sh<br>
- Replace <DB-NAME>, <USER>, and <PASSWORD> in the docker-compose.yaml file with appropriate values.<br>
- Run the Docker containers in detached mode by entering the following command: docker-compose up -d<br>
- Note that the script adds some delay between the different steps to avoid any issues that may arise if the different steps execute too quickly.<br>





