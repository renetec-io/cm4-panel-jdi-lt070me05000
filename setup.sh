#!/usr/bin/bash

DRV_VERSION=0.0.1

sudo mkdir -p /usr/src/cm4-panel-jdi-lt070me05000-${DRV_VERSION}

sudo cp -r $(pwd)/* /usr/src/cm4-panel-jdi-lt070me05000-${DRV_VERSION}

sudo dkms add -m cm4-panel-jdi-lt070me05000 -v ${DRV_VERSION}
sudo dkms build -m cm4-panel-jdi-lt070me05000 -v ${DRV_VERSION}
sudo dkms install -m cm4-panel-jdi-lt070me05000 -v ${DRV_VERSION}
