#!/bin/zsh
cv="bitcoin-0.20.0" #current version/version, to use
dd="/data/blockchain/" #datadir
cf="/data/blockchain/.cookie" #rpccoockiefile

function usage()
{
    echo "BitCoinDaemonManagment -- Script, to manage bitcoind"
    echo ""
    echo "./bcdm.sh"
    echo "\t-h\t--help display this text"
    echo "\t-start\tstarts bitcoind"
    echo "\t-stop\tstops bitcoind"
    echo "\t-wo\treturns current height or error"
    echo "\t-bla\treturns metric-bla"
    echo "\t-cmd=xyz\tpasses command. default=help"
    echo "\t-bu=folder\tsaves metric to folder default=./stats"
    echo ""
}

function startbcd()
{

#echo "befehl:"
echo "current version/bin-dir used: $cv"
echo "starting bitcoind..."
#/home/bitcoind/bitcoin-0.17.1/bin/bitcoind -datadir=$dd -daemon #-rescan
#/home/bitcoind/bitcoin-0.19.0.1/bin/bitcoind -datadir=$dd -daemon #-rescan
#/home/bitcoind/bitcoin-0.19.1/bin/bitcoind -datadir=$dd -daemon -blocknotify="/home/bitcoind/newblock.sh -bh=%s" #-rescan

/home/bitcoind/$cv/bin/bitcoind -datadir=$dd -daemon -server -txindex -zmqpubrawblock=tcp://127.0.0.1:28332 -zmqpubrawtx=tcp://127.0.0.1:28333 -blocknotify="/home/bitcoind/newblock.sh -bh=%s" #-rescan
}


function savemetric()
{
d=$(date +"%Y%m%d-%s")
echo "saving metrics: $d"
mkdir -p ./stats/$d
cmd getpeerinfo > ./stats/$d/getpeerinfo
cmd getnettotals > ./stats/$d/getnettotals
cmd listbanned > ./stats/$d/listbanned
cmd uptime > ./stats/$d/uptime
}


function stopbcd()
{
echo "current version/bin-dir used: $cv"
savemetric
echo "stoping bitcoind..."
~/$cv/bin/bitcoin-cli -datadir=$dd -rpccookiefile=$cf stop

}



function wo()
{
#convert to regex!
blocks=$(~/$cv/bin/bitcoin-cli -datadir=$dd -rpccookiefile=$cf -getinfo | grep blocks )
echo $blocks[-7,-2]
}

#!/bin/zsh
cv="bitcoin-0.20.0" #current version
dd="/data/blockchain/" #datadir
cf="/data/blockchain/.cookie" #rpccoockiefile

function usage()
{
    echo "BitCoinDaemonManagment -- Script, to manage bitcoind"
    echo ""
    echo "./bcdm.sh"
    echo "\t-h\t--help display this text"
    echo "\t-start\tstarts bitcoind"
    echo "\t-stop\tstops bitcoind"
    echo "\t-wo\treturns current height or error"
    echo "\t-bla\treturns metric-bla"
    echo "\t-cmd=xyz\tpasses command. default=help"
    echo "\t-bu=folder\tsaves metric to folder default=./stats"
    echo ""
}

function startbcd()
{

#echo "befehl:"
echo "current version/bin-dir used: $cv"
echo "starting bitcoind..."
#/home/bitcoind/bitcoin-0.17.1/bin/bitcoind -datadir=$dd -daemon #-rescan
#/home/bitcoind/bitcoin-0.19.0.1/bin/bitcoind -datadir=$dd -daemon #-rescan
#/home/bitcoind/bitcoin-0.19.1/bin/bitcoind -datadir=$dd -daemon -blocknotify="/home/bitcoind/newblock.sh -bh=%s" #-rescan

/home/bitcoind/$cv/bin/bitcoind -datadir=$dd -daemon -server -txindex -zmqpubrawblock=tcp://127.0.0.1:28332 -zmqpubrawtx=tcp://127.0.0.1:28333 -blocknotify="/home/bitcoind/newblock.sh -bh=%s" #-rescan
}


function savemetric()
{
d=$(date +"%Y%m%d-%s")
echo "saving metrics: $d"
mkdir -p ./stats/$d
cmd getpeerinfo > ./stats/$d/getpeerinfo
cmd getnettotals > ./stats/$d/getnettotals
cmd listbanned > ./stats/$d/listbanned
cmd uptime > ./stats/$d/uptime
}


function stopbcd()
{
echo "current version/bin-dir used: $cv"
savemetric
echo "stoping bitcoind..."
~/$cv/bin/bitcoin-cli -datadir=$dd -rpccookiefile=$cf stop

}



function wo()
{
#convert to regex!
blocks=$(~/$cv/bin/bitcoin-cli -datadir=$dd -rpccookiefile=$cf -getinfo | grep blocks )
echo $blocks[-7,-2]
}



function bla()
{
bla=$(~/$cv/bin/bitcoin-cli -datadir=$dd -rpccookiefile=$cf -getinfo)
echo "$bla"
}


function cmd()
{
command=$1
if [[ $command == "" ]]; then 
  command="help"
fi
bla=$(~/$cv/bin/bitcoin-cli -datadir=$dd -rpccookiefile=$cf $command)
echo "$bla"
}

if [[ "$1" == "" ]]; then
  usage
  exit
fi

while [ "$1" != "" ]; do
    PARAM=`echo $1 | awk -F= '{print $1}'`
    VALUE=`echo $1 | awk -F= '{print $2}'`
    case $PARAM in
        -h | --help | h | help)
            usage
            exit
            ;;
        -start | start)
            startbcd
            ;;
        -stop | stop)
            stopbcd
            ;;
        -wo | wo)
            wo
            ;;
        -bla | bla)
            bla
            ;;
        -bu | bu)
            savemetric
            ;;
        -cmd | cmd)
            echo "val:"
            cmd $VALUE
            ;;
        *)
            echo "ERROR: unknown parameter \"$PARAM\""
            usage
            exit 1
            ;;
    esac
    shift
done


#Todo:
#	-parametrify folders, endpoints, and common startingoptions


function bla()
{
bla=$(~/$cv/bin/bitcoin-cli -datadir=$dd -rpccookiefile=$cf -getinfo)
echo "$bla"
}


function cmd()
{
command=$1
if [[ $command == "" ]]; then 
  command="help"
fi
bla=$(~/$cv/bin/bitcoin-cli -datadir=$dd -rpccookiefile=$cf $command)
echo "$bla"
}

if [[ "$1" == "" ]]; then
  usage
  exit
fi

while [ "$1" != "" ]; do
    PARAM=`echo $1 | awk -F= '{print $1}'`
    VALUE=`echo $1 | awk -F= '{print $2}'`
    case $PARAM in
        -h | --help | h | help)
            usage
            exit
            ;;
        -start | start)
            startbcd
            ;;
        -stop | stop)
            stopbcd
            ;;
        -wo | wo)
            wo
            ;;
        -bla | bla)
            bla
            ;;
        -bu | bu)
            savemetric
            ;;
        -cmd | cmd)
            echo "val:"
            cmd $VALUE
            ;;
        *)
            echo "ERROR: unknown parameter \"$PARAM\""
            usage
            exit 1
            ;;
    esac
    shift
done


#Todo:
#	- parametrify folders, endpoints, and common startingoptions
# - add ncurses and stuff
# - much more
# - do some ai.(mark_plagiats="RGB",retranslate(l=commonpython),take_care_off=["refractors","comments","tests"]) on everything
# - locale
