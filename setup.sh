#!/bin/bash

# Function to print graphical echo line
function printLine() {
  echo "--------------------------------------------------------"
}

# Check if directories exist and override them
printLine
echo "Checking if directories already exist..."
if [ -d "iobroker" ]; then
  echo "Directory 'iobroker' already exists. Overriding..."
  rm -rf iobroker
fi
if [ -d "grafana" ]; then
  echo "Directory 'grafana' already exists. Overriding..."
  rm -rf grafana
fi
if [ -d "influx" ]; then
  echo "Directory 'influx' already exists. Overriding..."
  rm -rf influx
fi

# Create directories and files
printLine
echo "Creating directories and files..."
sleep 1
mkdir iobroker
echo "FROM iobroker:latest" > iobroker/dockerfile

sleep 1
mkdir grafana
echo "FROM grafana/grafana:latest" > grafana/dockerfile

sleep 1
mkdir influx
echo "FROM influxdb:1.8%" > influx/dockerfile

# Create docker-compose.yaml file
printLine
echo "Creating docker-compose.yaml file..."
sleep 1
cat <<EOF > docker-compose.yaml
version: "3"
services:
  grafana:
    build: ./grafana
    image: localbuild/grafana:latest
    container_name: grafana
    restart: unless-stopped
    ports:
      - "3000:3000"
    volumes: 
      - grafanaData:/var/lib/grafana
    networks:
      - edge
  influxdb:
    build: ./influx
    image: localbuild/influxdb:latest
    container_name: influxdb
    restart: unless-stopped
    environment:
      INFLUXDB_DB: <DB-NAME>
      INFLUXDB_HTTP_AUTH_ENABLED: "true"
      INFLUXDB_ADMIN_USER: <USER>
      INFLUXDB_ADMIN_PASSWORD: <PASSWORD>
      INFLUXDB_USER: <USER>
      INFLUXDB_USER_PASSWORD: <PASSWORD>
    ports:
      - "8082:8082"
      - "8086:8086"
      - "8089:8089"
    volumes:
      - influxData:/var/lib/influxdb
    networks: 
      - edge
  iobroker:
    image: iobroker/iobroker:latest
    container_name: iobroker
    restart: unless-stopped
    ports:
      - "8081:8081"
      #MQTT
      #- "1883:1883"
      - "1886:1886"
      #NoteRed
      #- "1880:1880"
      #Home-automation
      #- "1882:1882"
    volumes:
      - iobrokerData:/opt/iobroker
    networks:
      - edge

#Create internal link network for Containers
networks:
  edge:

#Create Volumes for persistent Storage
volumes:
  grafanaData:
  influxData:
  iobrokerData:
EOF

echo "Done!"
echo ""
echo "Steps to run the containers:"
echo "1. Replace <DB-NAME>, <USER>, and <PASSWORD> in docker-compose.yaml with appropriate values."
echo "2. Run 'docker-compose up -d' to start the containers in detached mode."
printLine

