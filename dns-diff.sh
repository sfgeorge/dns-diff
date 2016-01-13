#!/bin/bash

set -o errexit
set -o nounset

# Usage:   ./dns-diff.sh <list-of-nameservers.txt> <list-of-dig-queries.txt>

nameservers_list=$1
query_list=$2



create_directory() {
  echo Creating directory "$1" ...
  mkdir -p "$1"
}


while read -r nameserver || [[ -n "$nameserver" ]]; do
  index=1
  dir="dns-diff-results/ns_$nameserver"
  create_directory "$dir"

  while read -r query || [[ -n "$query" ]]; do
    output_file="$dir/query_$index.txt"
    command="dig $nameserver $query"
    echo "echo $command > $output_file"
    echo "$command" > "$output_file"
    echo >> "$output_file"
    $command >> "$output_file"

    index=$(( $index + 1 ))

  done < "$query_list"

  echo

done < "$nameservers_list"

echo 'Done!  Compare results with:  diff -r dns-diff-results/<directory 1> dns-diff-results/<directory N>'

