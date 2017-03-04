#!/bin/sh

CMD=`which xmlstarlet`

if [ ! -f $CMD ]; then
  (>&2 echo "xmlstarlet was not found. You can install it with 'sudo apt-get install xmlstarlet' from universe.")
fi;

# Parse arguments
while [ $# -gt 1 ]
do
key="$1"

case $key in
    -proxyServer)
    PROXYSERVER="$2"
    shift
    ;;
    -proxyOverride)
    PROXYOVERRIDE="$2"
    shift
    ;;
    -out)
    OUT="$2"
    shift
    ;;
    -unattend)
    UNATTEND="$2"
    shift
    ;;
    *)
      (>&2 echo "unknown option: $key")
      exit -1;
    ;;
esac
shift
done

if [ ! -f "$UNATTEND" ]; then
      (>&2 echo "option -unattend: file not found")
      exit 1;
fi;

if [ -z "${OUT+x}" ]; then
      (>&2 echo "option -out: must be specified")
      exit 1;
fi;

if [ -n "$PROXYSERVER" ] || [ -n "$PROXYOVERRIDE" ]; then

  (>&2 echo "option -proxyServer and -proxyOverride are not implemented")
  exit 1;

else

  $CMD edit -N ms=urn:schemas-microsoft-com:unattend \
    --delete "/ms:unattend/ms:settings/ms:component[@name='Microsoft-Windows-IE-ClientNetworkProtocolImplementation']" \
    $UNATTEND > $OUT
fi;
