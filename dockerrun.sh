#!/bin/bash
#
# start a development container, load all slab files from the current project

HERE=$(cd `dirname $0`; pwd)
BASE_IMAGE=sqlstream/streamlab-git-dev
CONTAINER_NAME=hiveperf

: ${LOAD_SLAB_FILES:=}


. $HERE/dockercommon.sh

