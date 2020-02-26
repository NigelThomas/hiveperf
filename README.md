# LOAD to Hive performance test

## Unpack the tarball

Unpack `hiveperf.tgz` into `/home/sqlstream`. This will create a folder tree starting at `/home/sqlstream/hiveperf`.

## Hive Sink Table

The target Hive table is created in the Hive schema `hiveperf` with the name `hive_edr_data`. The SQL is in `hive_edr_hiveperf.sql` and needs to be copied to the Hive cluster.

The docker instance does not attempt to manage the remote Hive table; you shoud manually remove data from the table before test runs by connecting to 

## Install s-Server schema and credentials

The SQLstream end of the data flow is created using the install script:

```
. /home/sqlstream/hiveperf/install.sh
```

## SQLstream schema

The SQLstream end of the data flow is created in the `"hiveperf"` schema using `sqllineClient --run=/home/sqlstream/hiveperf/setup.sql` 
(this is included in install.sh).

## Source Data

The data comes from Verizon; A small number of sample CSV files are included here in the edr subdirectory, i.e. `/home/sqlstream/hiveperf/edr`. The 
foreign stream is `"edr_data_fs"`. Data is pumped into a native stream `"edr_data"`.

To support long running tests the source foreign stream uses the `STATIC_FILES` and `REPEAT` options: 
```
        "STATIC_FILES" 'true',
        "REPEAT" '100'
```
The test data amounts to 600k rows; so the full cycle counts to 60M rows.

## Sink

A foreign stream "`edr_data_fs"` is created. This references the `HIVE_SERVER` server. Column names have been lower-cased and normalized to match the Hive table.

* Local files go to `/home/sqlstream/edr-out` on the docker container

## Credentials

Credentials are mounted from `$HOME/credentials` on the host to `/home/sqlstream/credentials`. These __credentials are not included in this repository__ (for obvious reasons) but can be obtained from nigel.thomas@guavus.com on request.

If the credentials are stored elsewhere on the host, set the environment variable 
The following files are copied to /home/sqlstream by `install.sh`

* `core-site.xml`
* `hdfs-site.xml`
* `svc_sqlstream_guavus.keytab` - this should have 600 permissions (o:rw) and be owned by sqlstream
* `krb5.conf` - should be moved to /etc/krb5.conf

* `testhosts` - an entry to add into the /etc/hosts on the SQLstream host server or docker instance - assuming that the target KDC server is as specified
* `orctest.lic` - a license file

These files are not included in the git repository, but they are included in the tarball.

## Starting and stopping the data flow

```
$SQLSTREAM_HOME/bin/sqllineClient --run=startPumps.sql

$SQLSTREAM_HOME/bin/sqllineClient --run=stopPumps.sql
```

