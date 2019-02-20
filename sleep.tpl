#!/bin/bash
 echo "Sleep time:  ${sleep_time}"
 echo "Sleep count: ${sleep_count}"

 count=0
 until [ "$count" == "${sleep_count}" ]; do
     sleep ${sleep_time}
     echo "Woke up after a ${sleep_time}s nap for the $(( count++ )) time."
 done