MIX := $(shell which mix 2>/dev/null || which ./mix)
SUBMODULES = build_utils
SUBTARGETS = $(patsubst %,%/.git,$(SUBMODULES))

UTILS_PATH := build_utils
TEMPLATES_PATH := .

# Name of the service
SERVICE_NAME := pathfinder
# Service image default tag
SERVICE_IMAGE_TAG ?= $(shell git rev-parse HEAD)
# The tag for service image to be pushed with
SERVICE_IMAGE_PUSH_TAG ?= $(SERVICE_IMAGE_TAG)

# Base image for the service
BASE_IMAGE_NAME := service-erlang
BASE_IMAGE_TAG := da0ab769f01b650b389d18fc85e7418e727cbe96

BUILD_IMAGE_TAG := 4f0eb2312d1fcf9c6df23cfe440a6913d819845d

CALL_W_CONTAINER := all submodules compile test start release clean distclean dialyze

.PHONY: $(CALL_W_CONTAINER)

all: compile

-include $(UTILS_PATH)/make_lib/utils_container.mk
-include $(UTILS_PATH)/make_lib/utils_image.mk

$(SUBTARGETS): %/.git: %
	git submodule update --init $<
	touch $@

submodules: $(SUBTARGETS)

mix-hex:
	$(MIX) local.hex --force

mix-rebar:
	$(MIX) local.rebar --force

mix-deps: mix-hex mix-rebar
	$(MIX) do deps.get, deps.compile

compile: submodules mix-deps
	$(MIX) compile

start: submodules
	$(MIX) run

release: submodules distclean
	MIX_ENV=prod $(MIX) release

clean:
	$(MIX) clean

distclean:
	$(MIX) clean -a
	rm -rf _build

test: submodules
	$(MIX) do ecto.migrate, test

dialyze: submodules
	$(MIX) dialyzer
