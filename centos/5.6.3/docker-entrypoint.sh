#!/bin/bash
ES_HOME=/usr/local/elasticsearch
CMD="$ES_HOME/bin/elasticsearch"
DEFAULT_ES_USER=search

if [ `id -u` = 0 ]; then
  for path in \
  	/usr/local/elasticsearch/config \
		/usr/local/elasticsearch/data \
		/usr/local/elasticsearch/logs \
	; do
		#chown -R  search:search "$path"
	done
  #su -c "$CMD" $DEFAULT_ES_USER
  $CMD
  echo "Running as non-root..."
else
  $CMD
fi
