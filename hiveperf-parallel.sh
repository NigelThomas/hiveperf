tdir=test-`date +"%Y.%m.%d-%H.%M"`
mkdir $tdir

for p in `seq -w 1 $1`
do
    export CONTAINER_NAME=hiveperf$p
    echo "starting $CONTAINER_NAME"
    ./hiveperf.sh
done
cd $tdir

echo "hiveperf-parallel with $1 containers started at `date` logging to $tdir" | tee > summary.txt

# stats every 15 secs for 20 minutes with timestamp and wide format
vmstat -t -w 15 80 | tee vmstat.log

for p in `seq -w 1 $1`
do
    export CONTAINER_NAME=hiveperf$p
    # collect trace log and stream stats
    docker cp ${CONTAINER_NAME}:/var/log/sqlstream/Trace.log.0 ${CONTAINER_NAME}.trace.log

    # some analyis on the logs
    # .. extract flushes in the format "rows HH:MM:SS"
    grep flushing ${CONTAINER_NAME}.trace.log | \
         sed -e "s/.*flushing //" -e "s/ rows.*INFO \[/ /" -e "s/]: com.*//" | \
         awk '{printf "%s %05d\n",$4,$1}' | cut -c1-11 > ${CONTAINER_NAME}.flush.log

    docker cp ${CONTAINER_NAME}:/home/sqlstream/monitor/edr_minute_count-${CONTAINER_NAME}.csv .
done


cd ..
pwd

echo Test $tdir completed at `date` | tee >>summary.txt


