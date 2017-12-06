#!/bin/bash
ES_HOME=/usr/local/elasticsearch
CMD="$ES_HOME/bin/elasticsearch"
DEFAULT_ES_USER=elasticsearch

if [ `id -u` = 0 ]; then
  for path in \
		/usr/local/elasticsearch/data \
		/usr/local/elasticsearch/logs \
	; do
		chown -R  elasticsearch:elasticsearch "$path"
	done
  su -c "$CMD" $DEFAULT_ES_USER
  echo "Running as non-root..."
else
  $CMD
fi
