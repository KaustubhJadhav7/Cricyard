#!/bin/bash

# Run dependency_validator and capture the output
output=$(flutter pub run dependency_validator 2>&1)

# Extract the list of potentially unused dependencies
unused_dependencies=$(echo "$output" | grep "These packages may be unused" -A 100 | tail -n +2 | grep -o '^\s*[*]\s\+\S*' | awk '{print $2}')

# Loop through each unused dependency and remove it
for package in $unused_dependencies
do
    echo "Removing $package..."
    dart pub remove $package
done
