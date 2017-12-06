#!/bin/bash
ES_HOME=/usr/share/elasticsearch
CMD="$ES_HOME/bin/elasticsearch"
DEFAULT_ES_USER=elasticsearch

export J2SDKDIR=/usr/lib/jvm/oracle_jdk8
export J2REDIR=/usr/lib/jvm/oracle_jdk8/jre
export PATH=$PATH:/usr/lib/jvm/oracle_jdk8/bin:/usr/lib/jvm/oracle_jdk8/db/bin:/usr/lib/jvm/oracle_jdk8/jre/bin
export JAVA_HOME=/usr/lib/jvm/oracle_jdk8
export DERBY_HOME=/usr/lib/jvm/oracle_jdk8/db

if [ `id -u` = 0 ]; then
  for path in \
		/usr/share/elasticsearch/data \
		/usr/share/elasticsearch/logs \
	; do
		chown -R  elasticsearch:elasticsearch "$path"
	done
  su -c "$CMD" $DEFAULT_ES_USER
  echo "Running as non-root..."
else
  $CMD
fi
