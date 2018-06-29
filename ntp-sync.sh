#!/bin/bash
echo "Sync date NS1"
ntpdate -u horalegal.inm.gov.co
echo "Sync date NS2"
rsh root@ns2 "ntpdate -u horalegal.inm.gov.co"
echo "Sync date NS3"
rsh root@ns3 "ntpdate -u horalegal.inm.gov.co"
echo "Sync date NS4"
rsh root@ns4 "ntpdate -u horalegal.inm.gov.co"
