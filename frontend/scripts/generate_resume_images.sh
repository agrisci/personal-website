#! /bin/bash

is_docker_container=false

# Check if running inside a Docker container
if [ -f "/.dockerenv" ] || [ -n "$DOCKER_CONTAINER" ] || [ -n "$KUBERNETES_SERVICE_HOST" ]; then
    is_docker_container=true
fi


# Check if os-release file exists
if [ -f "/etc/os-release" ]; then
    source /etc/os-release

    # Check for linux distro type
    if [[ "$ID" == "debian" || "$ID_LIKE" == *"debian"* ]]; then
        # Check if poppler-utils binary exists otherwise install it
        if ! dpkg -l | grep -q "poppler-utils"; then
            echo "Installing poppler-utils..."
            if [ "$is_docker_container" = true ]; then
                apt-get update
                apt-get install -y poppler-utils
            else
                sudo apt-get update
                sudo apt-get install -y poppler-utils
            fi
        else
            echo "poppler-utils is already installed."
        fi
    elif [[ "$ID" == "fedora" || "$ID_LIKE" == *"fedora"* ]]; then
        # Check if poppler-utils binary exists otherwise install it
        if ! rpm -q poppler-utils > /dev/null; then
            echo "Installing poppler-utils..."
            if [ "$is_docker_container" = true ]; then
                dnf install -y poppler-utils
            else
                sudo dnf install -y poppler-utils
            fi
        else
            echo "poppler-utils is already installed."
        fi
    else
        echo "Failed to determine the linux distribution."
        exit 1
    fi
else
    echo "Failed to find the os-release file."
    exit 1
fi

# Generate png images based on the resume.pdf
cd public/
pdftocairo resume.pdf -png -scale-to 800
mv resume-1.png resume-small-1.png
mv resume-2.png resume-small-2.png
pdftocairo resume.pdf -png -scale-to 1200
mv resume-1.png resume-medium-1.png
mv resume-2.png resume-medium-2.png
pdftocairo resume.pdf -png
mv resume-1.png resume-large-1.png
mv resume-2.png resume-large-2.png