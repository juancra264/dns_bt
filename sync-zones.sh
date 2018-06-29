#!/bin/bash
echo "Reseting BIND NS1"
/etc/init.d/bind9 restart
echo "Reseting BIND NS2"
rsync -azvp /etc/bind root@ns2:/etc
rsh root@ns2 "/etc/init.d/bind9 restart"
echo "Reseting BIND NS3"
rsync -azvp /etc/bind root@ns3:/etc
rsh root@ns3 "/etc/init.d/bind9 restart"
echo "Reseting BIND NS4"
rsync -azvp /etc/bind root@ns4:/etc
rsh root@ns4 "/etc/init.d/bind9 restart"