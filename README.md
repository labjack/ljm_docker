# LabJack LJM Docker Image

Provides an image with [LJM](https://labjack.com/ljm) and [LJM-Python](https://labjack.com/support/software/examples/ljm/python).

LJM supports [T-series](https://labjack.com/support/datasheets/t-series) LabJack devices.

See here for the full list of [T-series software options](https://labjack.com/support/datasheets/t-series/software-options).


## Sudo

Sudo may be required for the following commands.


## Prerequisites

Linux is currently the only supported OS due to the `docker run` requirements needed to access the network and/or USB device layer. See [Run](#run) below.


## Project Life Cycle

Build: `make`

Clean: `make clean`

Test: `make test`
 - Currently this just runs a [ListAll](https://labjack.com/support/software/api/ljm/function-reference/ljmlistall) command and displays the number of connections found.


### Updating

 - Replace the URLs in `ubuntu_18/Dockerfile`
 - Update `VERSION`, which serves as the tag that will be published
 - Update `FROM` line with the tag you just put in `VERSION`
 - `make clean`, `make`, and `make test`
 - `docker login`, as needed
 - Publish: `make publish`


## Run

LJM needs permissions to access the host network or the host USB layer.

To run with Ethernet/WiFi access, you need `--network=host`. For example:

```
sudo docker run --network=host labjack/ljm
```

USB access requires udev and the USB device bus shared, and also needs `--privileged`. For example:

```
docker run \
    -v /run/udev:/run/udev:ro \
    -v /dev/bus/usb:/dev/bus/usb \
    --privileged \
    labjack/ljm
```

To run interactively with both USB and network access, for example:

```
docker run --rm -it \
    -v /run/udev:/run/udev:ro \
    -v /dev/bus/usb:/dev/bus/usb \
    --privileged \
    --network=host \
    labjack/ljm
```