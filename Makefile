MIX := MIX_HOME=$(shell pwd)/.mix $(shell which mix 2>/dev/null || which ./mix)
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
BASE_IMAGE_TAG := 54a794b4875ad79f90dba0a7708190b3b37d584f

BUILD_IMAGE_NAME := build-erlang
BUILD_IMAGE_TAG := 12beabfb5b6968c7566fa3d872ad1b3e8d612f46

CALL_W_CONTAINER := all submodules mix_deps compile test start release clean distclean dialyze

.PHONY: $(CALL_W_CONTAINER)

all: compile

-include $(UTILS_PATH)/make_lib/utils_container.mk
-include $(UTILS_PATH)/make_lib/utils_image.mk

$(SUBTARGETS): %/.git: %
	git submodule update --init $<
	touch $@

submodules: $(SUBTARGETS)

mix_hex:
	$(MIX) local.hex --force

mix_rebar:
	$(MIX) local.rebar rebar3 $(shell which rebar3) --force

mix_support: mix_hex mix_rebar

mix_deps: mix_support
	$(MIX) do deps.get, deps.compile

compile: submodules
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
	MIX_ENV=test $(MIX) do ecto.migrate, test

dialyze: submodules
	$(MIX) dialyzer
