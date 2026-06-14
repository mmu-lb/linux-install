#!/bin/bash

source /usr/local/etc/ydb_env_set
export ydb_routines=". $ydb_routines"
cd "$1"
exec bash
