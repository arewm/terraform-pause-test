echo "Sleep time:  ${sleep_time}"
echo "Sleep count: ${sleep_count}"

count = 0
until [ $count -eq ${sleep_time} ]; do
    sleep ${sleep_time}
    echo "Woke up after a ${sleep_time}s nap."
done