#!/bin/bash

# Check if an argument is provided
if [ $# -eq 0 ]; then
    echo "No arguments provided. Please provide an argument."
    exit 1
fi

# Assign the input argument to a variable
input=$1

# Execute commands based on the input argument
case $input in
    local)
        echo "Running the app locally..."
        docker build -t eval-app:latest .
	    docker run -d -p 3000:3000 -p 5000:5000 -v ~/.aws:/root/.aws eval-app
        ;;
    deploy)
        echo "Deploying the app. This might take a few minutes..."
        copilot app init eval-genai-app && copilot env init --name test --profile default --default-config && copilot env deploy --name test &&  copilot deploy
        ;;
    *)
        echo "Invalid argument. Please use build, local or deploy."
        exit 1
        ;;
esac