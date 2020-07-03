# LabJack LJM Docker Image

Provides an image with [LJM](https://labjack.com/ljm) and [LJM-Python](https://labjack.com/support/software/examples/ljm/python).

LJM supports [T-series](https://labjack.com/support/datasheets/t-series) LabJack devices.

See here for the full list of [T-series software options](https://labjack.com/support/datasheets/t-series/software-options).


## Prerequisites

Linux is currently the only supported OS due to the `docker run` requirements for accessing the network and/or USB device layer. See [Run](#run) below.


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


## Example Dockerfile

Example usage:

```
FROM labjack/ljm:1.2100
WORKDIR /app
ADD . /app # Adds list_connections.py
CMD ["python3", "list_connections.py"]
```

See [example](example).


## Project Life Cycle

Build: `make`

Clean: `make clean`

Test: `make test`
 - Currently this just runs a [ListAll](https://labjack.com/support/software/api/ljm/function-reference/ljmlistall) command and displays the number of connections found.


### Publishing a new version

 - `ubuntu_18/Dockerfile`: Replace the LJM installer and LJM-Python URLs
 - `ubuntu_18/Dockerfile`: Replace the LJM installer paths. The URL path may be different.
 - Update `VERSION`, which serves as the tag that will be published
 - `example/Dockerfile`: Update `FROM` line with the tag you just put in `VERSION`
 - `make clean`, `make`, and `make test`
 - `docker login`, as needed
 - Publish: `make publish`
