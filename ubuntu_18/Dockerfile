FROM ubuntu:18.04

RUN apt-get update
RUN apt-get install -y wget python3-pip libusb-1.0-0-dev udev

RUN wget https://files.labjack.com/installers/LJM/Linux/x64/minimal/beta/labjack_ljm_minimal_2020_03_30_x86_64_beta.tar.gz
RUN tar zxf ./labjack_ljm_minimal_2020_03_30_x86_64_beta.tar.gz
RUN ./labjack_ljm_minimal_2020_03_30_x86_64/labjack_ljm_installer.run -- --no-restart-device-rules

RUN pip3 install --no-cache-dir labjack-ljm==1.21.0
