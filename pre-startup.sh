#!/bin/bash
#
# Do any preproject setup needed before loading the StreamLab projects
#
# Assume we are running in the project directory

mkdir -p $SQLSTREAM_HOME/classes/net/sf/farrago/dynamic/

echo ... Creating the clean_edrs interface stream

sqllineClient --run=$(which clean_edrs.sql)

echo ... done

$SQLSTREAM_HOME/bin/sqllineClient --run=setup.sql

echo Use $H/startPumps.sql to start the pumps



