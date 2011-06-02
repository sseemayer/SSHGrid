#!/bin/bash

# hello_world.sh - SSHGrid test for asynchronous job processing
echo -e "start\t0\t`pwd`\t`hostname`\t`date`" >> result_echos; sleep 10s; echo -e "stop\t0\t`pwd`\t`hostname`\t`date`" >> result_echos
echo -e "start\t1\t`pwd`\t`hostname`\t`date`" >> result_echos; sleep 10s; echo -e "stop\t1\t`pwd`\t`hostname`\t`date`" >> result_echos
echo -e "start\t2\t`pwd`\t`hostname`\t`date`" >> result_echos; sleep 10s; echo -e "stop\t2\t`pwd`\t`hostname`\t`date`" >> result_echos
echo -e "start\t3\t`pwd`\t`hostname`\t`date`" >> result_echos; sleep 10s; echo -e "stop\t3\t`pwd`\t`hostname`\t`date`" >> result_echos
echo -e "start\t4\t`pwd`\t`hostname`\t`date`" >> result_echos; sleep 10s; echo -e "stop\t4\t`pwd`\t`hostname`\t`date`" >> result_echos
echo -e "start\t5\t`pwd`\t`hostname`\t`date`" >> result_echos; sleep 10s; echo -e "stop\t5\t`pwd`\t`hostname`\t`date`" >> result_echos
echo -e "start\t6\t`pwd`\t`hostname`\t`date`" >> result_echos; sleep 10s; echo -e "stop\t6\t`pwd`\t`hostname`\t`date`" >> result_echos
echo -e "start\t7\t`pwd`\t`hostname`\t`date`" >> result_echos; sleep 10s; echo -e "stop\t7\t`pwd`\t`hostname`\t`date`" >> result_echos
echo -e "start\t8\t`pwd`\t`hostname`\t`date`" >> result_echos; sleep 10s; echo -e "stop\t8\t`pwd`\t`hostname`\t`date`" >> result_echos
echo -e "start\t9\t`pwd`\t`hostname`\t`date`" >> result_echos; sleep 10s; echo -e "stop\t9\t`pwd`\t`hostname`\t`date`" >> result_echos
