PID=./tmp/pids/puma_dev.pid
PUMA_PID=`cat $PID`

action=$1

case $action in
start)
    bundle exec puma -C config/puma.rb
    echo '--start [OK]'
    ;;
stop)
    pumactl -p $PUMA_PID stop
    echo '--stop [OK]'
    ;;
restart)
    pumactl -p $PUMA_PID restart
    echo '--restart [OK]'
    ;;
upgrade)
    pumactl -p $PUMA_PID phased-restart
    echo '--upgrade [OK]'
    ;;
esac
