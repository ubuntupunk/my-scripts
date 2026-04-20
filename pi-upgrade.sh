#!/bin/bash

# Copyright (c) 2024 @ubuntupunk. All rights reserved.
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation.

echo ""
echo "Updating/Upgrading Raspbian"
apt-get -y update
apt-get -y upgrade
apt-get -y dist-upgrade
apt-get -y install rpi-update
rpi-update
echo "Updating/Upgrading completed"
echo ""
