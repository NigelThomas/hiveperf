for p in `seq -w 1 $1`
do
    export CONTAINER_NAME=hiveperf$p
    echo "starting $CONTAINER_NAME"
    ./hiveperf.sh
    sleep 30
done
