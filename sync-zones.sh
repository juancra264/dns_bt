#!/bin/bash
echo "***********************************"
echo "Reseting BIND NS1"
echo "***********************************"
/etc/init.d/bind9 restart
echo "***********************************"
echo "Reseting BIND NS2"
echo "***********************************"
rsync -azvp /etc/bind root@ns2:/etc
rsh root@ns2 "/etc/init.d/bind9 restart"
echo "***********************************"
echo "Reseting BIND NS3"
echo "***********************************"
rsync -azvp /etc/bind root@ns3:/etc
rsh root@ns3 "/etc/init.d/bind9 restart"
echo "***********************************"
echo "Reseting BIND NS4"
echo "***********************************"
rsync -azvp /etc/bind root@ns4:/etc
rsh root@ns4 "systemctl restart bind9"
echo "************  DONE  ***************"
