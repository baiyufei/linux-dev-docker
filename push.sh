#!/bin/bash

sudo docker login
sudo docker build -t baiyufei/dev:1.0 .
sudo docker push baiyufei/dev:1.0
