# Install the repro case
#
# Assumes we are running in a docker container (eg sqlstream/minimal:release) as root (no need for sudo)
# Remember to create the Hive table first

. /etc/sqlstream/environment

H=/home/sqlstream/hiveperf

for f in core-site.xml hdfs-site.xml svc_sqlstream_guavus.keytab
do
    cp $H/credentials/$f /home/sqlstream
done

cp $H/credentials/krb5.conf /etc

mkdir -p /home/sqlstream/edr-out
chown -R sqlstream:sqlstream /home/sqlstream

# make sure the test KDC server is known to us
cat $H/credentials/testhosts >>/etc/hosts

$SQLSTREAM_HOME/bin/sqllineClient --run=$H/setup.sql

echo Use $H/startPumps.sql to start the pumps

