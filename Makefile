# Author: Rory Olsen, LabJack Corporation
# Date: 2020-07-03
# License: MIT

# https://tech.davis-hansson.com/p/make/
SHELL := bash
.ONESHELL:
.SHELLFLAGS := -eu -o pipefail -c
.DELETE_ON_ERROR:
MAKEFLAGS += --warn-undefined-variables
MAKEFLAGS += --no-builtin-rules

ifeq ($(origin .RECIPEPREFIX), undefined)
  $(error This Make does not support .RECIPEPREFIX. Please use GNU Make 4.0 or later)
endif
.RECIPEPREFIX = >

# Default - top level rule is what gets ran when you run just `make`
build: out/labjack-ljm
.PHONY: build

clean:
> rm -rf out
.PHONY: clean

out/labjack-ljm:
> mkdir -p $(@D)
> image_id="labjack/ljm:$$(cat VERSION)"
> docker build --tag="$${image_id}" ubuntu_18
> echo "$${image_id}" > out/labjack-ljm


# Test / example
out/example:
> mkdir -p $(@D)
> image_id="labjack/ljm:$$(cat VERSION)"
> docker build -t ljm-example example
> echo "$${image_id}" > out/example

test: out/example
> docker run --rm \
    -v /run/udev:/run/udev:ro \
    -v /dev/bus/usb:/dev/bus/usb \
    --privileged \
    --network=host \
    ljm-example
.PHONY: test


# Publish
publish:
> image_id="labjack/ljm:$$(cat VERSION)"
> docker push $${image_id}
.PHONY: publish
