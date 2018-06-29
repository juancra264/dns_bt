NAMED_CONF_PATH="/etc/bind/named.conf.bt.zones"
BIND_DB_PATH="/etc/bind/master"
SERIAL_NO_COUNT=`date +%Y%m%d01`
NS1="ns1.btlatam.com.co"
NS2="ns2.btlatam.com.co"
NS3="ns3.btlatam.com.co"
NS4="ns4.btlatam.com.co"
ADMIN_EMAIL="dc\.ar.bt.com"
ZONE_DB_FILE=""
domainname=""
ipmainadd=""
ipwebadd=""
serial_no=1
echo -n "Enter domain name : "
read domainname
ZONE_DB_FILE="$BIND_DB_PATH/db.$domainname"
echo -n "Enter IP Address for main domain record : "
read ipmainadd
echo -n "Enter IP Address for www  record : "
read ipwebadd

if grep \"$domainname\" $NAMED_CONF_PATH > /dev/null ; then
	echo "Domain $domainname is already present, please check it up"
	exit 1
fi

if which ipcalc > /dev/null ; then

	ipcalc -ms $ipmainadd > /dev/null
	if ! [ $? -eq 0 ] ; then
		echo "Ip Main Address is wrong, please try again"
		exit 2
	fi


	ipcalc -ms $ipwebadd > /dev/null
	if ! [ $? -eq 0 ] ; then
		echo "Ip WEB Address is wrong, please try again"
		exit 2
	fi
fi


echo "zone 	\"$domainname\" {" >> $NAMED_CONF_PATH
echo "		type master;" >> $NAMED_CONF_PATH
echo "		file \"$ZONE_DB_FILE\";" >> $NAMED_CONF_PATH
echo "};" >> $NAMED_CONF_PATH
echo " " >> $NAMED_CONF_PATH


echo '$ORIGIN' $domainname. >> $ZONE_DB_FILE
echo '$TTL 43200' >> $ZONE_DB_FILE
echo "$domainname.	IN	SOA	$NS1.	$ADMIN_EMAIL.	(" >> $ZONE_DB_FILE
echo "			$SERIAL_NO_COUNT ; serial" >> $ZONE_DB_FILE
echo "			10800	; refresh" >> $ZONE_DB_FILE
echo "			3600	; retry" >> $ZONE_DB_FILE
echo "			604800	; expire" >> $ZONE_DB_FILE
echo "			38400	; TTL" >> $ZONE_DB_FILE
echo "			)"	>> $ZONE_DB_FILE
echo "@				IN	NS	$NS1." >> $ZONE_DB_FILE
echo "@				IN	NS	$NS2." >> $ZONE_DB_FILE
echo "@				IN	NS	$NS3." >> $ZONE_DB_FILE
echo "@				IN	NS	$NS4." >> $ZONE_DB_FILE
echo "@				IN	A	$ipmainadd" >> $ZONE_DB_FILE
echo "www				IN	A	$ipwebadd" >> $ZONE_DB_FILE

echo "$domainname ($ipmainadd) Added succesfully."
/etc/init.d/bind9 restart
named-checkzone $domainname $BIND_DB_PATH/db.$domainname

