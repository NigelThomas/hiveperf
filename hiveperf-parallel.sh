tdir=test-`date +"%Y%m%d%H%M"`
mkdir $tdir
cd $tdir

for p in `seq -w 1 $1`
do
    export CONTAINER_NAME=hiveperf$p
    echo "starting $CONTAINER_NAME"
    ./hiveperf.sh
done

echo "hiveperf-parallel with $1 containers started at `date` logging to $tdir"

# stats every 15 secs for 20 minutes with timestamp and wide format
vmstat -t -w 15 80 | tee vmstat.logging


