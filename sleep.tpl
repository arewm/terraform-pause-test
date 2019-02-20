#!/bin/bash
 echo "Sleep time:  ${sleep_time}"
 echo "Sleep count: ${sleep_count}"

 count=0
 until [ "$count" == "${sleep_count}" ]; do
    sleep ${sleep_time}
    echo "Woke up after $(( count++ +1 )) ${sleep_time}s nap(s)."
 done