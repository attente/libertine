#!/bin/bash

echo "Creating the base container… "

libertine_container_manager create -t chroot

echo "Updating the container… "
libertine_container_manager update

echo "Installing packages in the container… "
libertine_container_manager install-package -p gedit
libertine_container_manager install-package -p libreoffice
libertine_container_manager install-package -p chromium
libertine_container_manager install-package -p xchat-gnome
libertine_container_manager install-package -p gimp
