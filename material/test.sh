#!/bin/sh

. ./harness.sh
validate

# gather data for $1
phase() {
  echo Starting phase $1
  date
  TS=$(date +%s)
  echo $(date +%s) Starting phase $1 >> event.log
  nstat > $1-before-nstat-$TS.log
  ss -s > $1-before-ss-s-$TS.log
  netstat -i > $1-before-netstat-i-$TS.log
  ip -s link > $1-before-ip-s-link-$TS.log
  test $1
  echo Soaking at /$1...
  echo $(date +%s) Soaking phase $1 >> event.log
  sleep 300

  echo Gathering network deltas and cluster health.
  date
  TS=$(date +%s)
  health > $1-final-health-$TS.log
  nstat > $1-after-nstat-$TS.log
  ss -s > $1-after-ss-s-$TS.log
  netstat -i > $1-after-netstat-i-$TS.log
  ip -s link > $1-after-ip-s-link-$TS.log
  echo $(date +%s) Cleaning up phase $1 >> event.log
  clean

  echo Calming down from /$1...
  sleep 300
}

ST=$(date +%s)
phase 24
phase 23
phase 22
phase 21
phase 20
phase 19
phase 18
phase 17
ET=$(date +%s)
tar -czf ffed-$ST-$ET.tar.gz *.log
