#!/bin/bash
#
# Do any preproject setup needed before loading the StreamLab projects
#
# Assume we are running in the project directory

mkdir -p $SQLSTREAM_HOME/classes/net/sf/farrago/dynamic/

echo ... installing the SQLstream schema 

$SQLSTREAM_HOME/bin/sqllineClient --run=setup.sql

echo Use $H/startPumps.sql to start the pumps



