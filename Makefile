#############################
# Global vars
#############################
PROJECT_NAME := $(shell basename $(shell pwd))
PROJECT_VER  ?= $(shell git describe --tags --always --dirty | sed -e '/^v/s/^v\(.*\)$$/\1/g') # Strip leading 'v' if found
# Last released version (not dirty)
PROJECT_VER_TAGGED  := $(shell git describe --tags --always --abbrev=0 | sed -e '/^v/s/^v\(.*\)$$/\1/g') # Strip leading 'v' if found

SRCDIR       ?= .
GO            = go

# The root module (from go.mod)
PROJECT_MODULE  ?= $(shell $(GO) list -m)

#############################
# Targets
#############################
all: build

# Humans running make:
build: check-version clean lint test cover-report compile

# Build command for CI tooling
build-ci: check-version clean lint test compile-only

# All clean commands
clean: cover-clean compile-clean release-clean

include build/compile.mk
include build/deps.mk
include build/docker.mk
include build/document.mk
include build/generate.mk
include build/lint.mk
include build/release.mk
include build/test.mk
include build/util.mk


.PHONY: all build build-ci clean
