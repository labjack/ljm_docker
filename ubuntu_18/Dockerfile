FROM ubuntu:18.04

RUN apt-get update
RUN apt-get install -y wget python3-pip libusb-1.0-0-dev udev

RUN wget https://labjack.com/sites/default/files/software/labjack_ljm_minimal_2019_04_10_x86_64.tar.gz

RUN tar zxf ./labjack_ljm_minimal_2019_04_10_x86_64.tar.gz

RUN ./labjack_ljm_minimal_2019_04_10_x86_64/labjack_ljm_installer.run -- --no-restart-device-rules

RUN pip3 install --no-cache-dir https://labjack.com/sites/default/files/software/Python_LJM_2019_04_03.zip

# LJM ports
# EXPOSE 502
# EXPOSE 52362

# CMD ["python3", "app.py"]

# 1.2000