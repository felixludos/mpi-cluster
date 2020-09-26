#!/bin/sh

export FOUNDATION_RUN_MODE="cluster"

export FOUNDATION_SAVE_DIR="/home/fleeb/trained_nets/"
export FOUNDATION_DATA_DIR="/home/fleeb/local_data/"
export FOUNDATION_TESTING="0"

export JOB_REGISTRY_PATH="/home/fleeb/registry.txt"

export RESTART_AFTER="10"

export IMG_TO_STR="1"


echo "-- starting job --"

{}

echo "-- job complete --"
