# Install the repro case
#
# Assumes we are running in a docker container (eg sqlstream/minimal:release) as root (no need for sudo)
# Remember to create the Hive table first

. /etc/sqlstream/environment

H=/home/sqlstream/hiveperf

# assume credentials are mounted at /home/sqlstream/credentials
CRED=/home/sqlstream/credentials

for f in core-site.xml hdfs-site.xml svc_sqlstream_guavus.keytab
do
    cp $CRED/$f /home/sqlstream
done

cp $CRED/krb5.conf /etc

mkdir -p /home/sqlstream/edr-out
chown -R sqlstream:sqlstream /home/sqlstream

# make sure the test KDC server is known to us
cat $CRED/testhosts >>/etc/hosts

