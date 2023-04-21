#!/bin/bash

# Function to print graphical echo line
function printLine() {
  echo "--------------------------------------------------------"
}

# Change current working directory to /tmp/
cd /tmp/

# Remove directories and files created by the main script
printLine
echo "Removing directories and files..."
sleep 1
rm -rf iobroker
rm -rf grafana
rm -rf influx
rm -f docker-compose.yaml

echo "Done!"
printLine
