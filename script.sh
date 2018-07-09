#!/bin/bash
ssh -v -t -o StrictHostKeyChecking=no -i /home/admin/mini_cert admin@192.168.10.1 "./tc_script.sh $1 $2 $3 $4 $5 $6"
#expect "password for admin: "
#send "superadmin"
