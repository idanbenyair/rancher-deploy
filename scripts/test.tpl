#!/bin/bash
sudo apt-get update -y
sudo apt install docker.io -y
sudo usermod -aG docker ubuntu
