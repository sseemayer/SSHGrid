#!/bin/bash

# long_barriers.sh - LONG Barrier crossing sample 
echo -e "start\tA   0\t`pwd`\t`hostname`\t`date`" >> result_echos; sleep 5; echo -e "stop\tA   0\t`pwd`\t`hostname`\t`date`" >> result_echos
echo -e "start\tA   1\t`pwd`\t`hostname`\t`date`" >> result_echos; sleep 5; echo -e "stop\tA   1\t`pwd`\t`hostname`\t`date`" >> result_echos
echo -e "start\tA   2\t`pwd`\t`hostname`\t`date`" >> result_echos; sleep 5; echo -e "stop\tA   2\t`pwd`\t`hostname`\t`date`" >> result_echos
echo -e "start\tA   3\t`pwd`\t`hostname`\t`date`" >> result_echos; sleep 5; echo -e "stop\tA   3\t`pwd`\t`hostname`\t`date`" >> result_echos
echo -e "start\tA   4\t`pwd`\t`hostname`\t`date`" >> result_echos; sleep 5; echo -e "stop\tA   4\t`pwd`\t`hostname`\t`date`" >> result_echos
echo -e "start\tA   5\t`pwd`\t`hostname`\t`date`" >> result_echos; sleep 30; echo -e "stop\tA   5\t`pwd`\t`hostname`\t`date`" >> result_echos
#%B A first barrier
echo -e "start\t B  0\t`pwd`\t`hostname`\t`date`" >> result_echos; sleep 5; echo -e "stop\t B  0\t`pwd`\t`hostname`\t`date`" >> result_echos
echo -e "start\t B  1\t`pwd`\t`hostname`\t`date`" >> result_echos; sleep 5; echo -e "stop\t B  1\t`pwd`\t`hostname`\t`date`" >> result_echos
echo -e "start\t B  2\t`pwd`\t`hostname`\t`date`" >> result_echos; sleep 5; echo -e "stop\t B  2\t`pwd`\t`hostname`\t`date`" >> result_echos
echo -e "start\t B  3\t`pwd`\t`hostname`\t`date`" >> result_echos; sleep 5; echo -e "stop\t B  3\t`pwd`\t`hostname`\t`date`" >> result_echos
echo -e "start\t B  4\t`pwd`\t`hostname`\t`date`" >> result_echos; sleep 5; echo -e "stop\t B  4\t`pwd`\t`hostname`\t`date`" >> result_echos
echo -e "start\t B  5\t`pwd`\t`hostname`\t`date`" >> result_echos; sleep 50; echo -e "stop\t B  5\t`pwd`\t`hostname`\t`date`" >> result_echos
#%B Another barrier
echo -e "start\t  C 0\t`pwd`\t`hostname`\t`date`" >> result_echos; sleep 5; echo -e "stop\t  C 0\t`pwd`\t`hostname`\t`date`" >> result_echos
echo -e "start\t  C 1\t`pwd`\t`hostname`\t`date`" >> result_echos; sleep 5; echo -e "stop\t  C 1\t`pwd`\t`hostname`\t`date`" >> result_echos
echo -e "start\t  C 2\t`pwd`\t`hostname`\t`date`" >> result_echos; sleep 70; echo -e "stop\t  C 2\t`pwd`\t`hostname`\t`date`" >> result_echos
echo -e "start\t  C 3\t`pwd`\t`hostname`\t`date`" >> result_echos; sleep 5; echo -e "stop\t  C 3\t`pwd`\t`hostname`\t`date`" >> result_echos
echo -e "start\t  C 4\t`pwd`\t`hostname`\t`date`" >> result_echos; sleep 5; echo -e "stop\t  C 4\t`pwd`\t`hostname`\t`date`" >> result_echos
echo -e "start\t  C 5\t`pwd`\t`hostname`\t`date`" >> result_echos; sleep 5; echo -e "stop\t  C 5\t`pwd`\t`hostname`\t`date`" >> result_echos
