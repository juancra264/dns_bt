#!/usr/bin/python
#-----------------------------------------------------------------------------
# Descripcion: Prueba de una registro DNS despues de un cambio
# Autor: JCRAMIREZ
# Fecha Modificacion: 02 Oct 2017
# Version 0.1
#
# Prerequisitos de instalacion:
#     sudo yum -y install python-pip
#-----------------------------------------------------------------------------

#*****************************************************************************
# Library Load
#*****************************************************************************
import os
import sys
import datetime
import argparse
import subprocess


#****************************************************************************
# Global Variable
#****************************************************************************



#****************************************************************************
# Funtions
#****************************************************************************


def check_dns(dns_server, domain, type):
    cmd = "dig @" + dns_server + " " + domain + " " + type + " +short"
    out = subprocess.Popen(cmd,
                           stdout=subprocess.PIPE,
                           shell=True).stdout.read().rstrip()
    print("   {0} ->\t{1}\n".format(dns_server, out))

def main():
    global VERBOSE_MODE
    parser = argparse.ArgumentParser(description="Analiza los archivos "
                                                 " zonas DNS y valida "
                                                 "con el whois la "
                                                 "delegacion")
    parser.add_argument('-r', '--register', action='store', type=str,
                        help="Registro a Validar FQDN")
    parser.add_argument('-t', '--type', action='store', type=str,
                        help="Tipo de registro(A, MX, NS, TXT, etc)")
    args = parser.parse_args()
    now = datetime.datetime.now()
    now_strg = "%.2i-%.2i-%.2i %.2i:%.2i" % (now.year, now.month, now.day,
                                             now.hour, now.minute)
    print("\n******************************************************\n")
    print(" PRUEBAS DE DNS \n")
    print("  Fecha y Hora: {0}\n".format(now_strg))
    print("  Registro: {0}\tTipo: {1}\n\n".format(args.register, args.type))
    print("  Servidores DNS BT LATAM COLOMBIA\n")
    check_dns("ns1.btlatam.com.co", args.register, args.type)
    check_dns("ns2.btlatam.com.co", args.register, args.type)
    check_dns("ns3.btlatam.com.co", args.register, args.type)
    check_dns("ns4.btlatam.com.co", args.register, args.type)
    print("  Servidores INTERNET\n")
    check_dns("4.2.2.2", args.register, args.type)
    check_dns("8.8.8.8", args.register, args.type)
    check_dns("8.8.4.4", args.register, args.type)
    #check_dns("02sht.ru", args.register, args.type)
    #check_dns("ns1.telecomnet.ru", args.register, args.type)
    #check_dns("tsinet.ru", args.register, args.type)
    #check_dns("194.226.42.100", args.register, args.type)
    #check_dns("ip217-113-245-80.crelcom.ru", args.register, args.type)
    #check_dns("ip229.net18.stalcom.net", args.register, args.type)
    #check_dns("ns2.lancronix.ru", args.register, args.type)
    #check_dns("80.252.24.3", args.register, args.type)
    #check_dns("85-95-177-140.saransk.ru", args.register, args.type)
    #check_dns("static-1-68.podolsknet.ru", args.register, args.type)
    print("******************************************************")


#****************************************************************************
# MAIN process
#****************************************************************************
if __name__ == '__main__':
    try:
        main()
    except KeyboardInterrupt:
        try:
            print("Keyboard Interrupt")
            sys.exit(0)
        except SystemExit:
            os._exit(0)
    #finally:
    #    try:
    #        sys.exit(0)
    #    except SystemExit:
    #        os._exit(0)

