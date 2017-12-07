#FROM openjdk:8-jre-alpine
FROM primetoninc/jdk:1.8

# ensure elasticsearch user exists
RUN groupadd -r search && adduser -r -g search search

# https://artifacts.elastic.co/GPG-KEY-elasticsearch
ENV GPG_KEY 46095ACC8548582C1A2699A9D27D666CD88E42B4

WORKDIR /usr/local/elasticsearch
ENV PATH /usr/local/elasticsearch/bin:$PATH

ENV ELASTICSEARCH_VERSION 5.6.3

COPY elasticsearch-5.6.3.tar.gz ./elasticsearch.tar.gz
COPY node-v8.9.2-linux-x64.tar.xz ./node-v8.9.2-linux-x64.tar.xz
ENV ELASTICSEARCH_TARBALL="https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-5.6.3.tar.gz" \
	ELASTICSEARCH_TARBALL_ASC="https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-5.6.3.tar.gz.asc" \
	ELASTICSEARCH_TARBALL_SHA1="d5e4b61038f2cc3ec7ae5cbecf3406c7ecc7a1c4"

RUN set -ex; \
	#wget -O elasticsearch.tar.gz "$ELASTICSEARCH_TARBALL"; \
	tar -xf elasticsearch.tar.gz --strip-components=1; \
	rm elasticsearch.tar.gz; \
	\
	\
	mkdir -p ./plugins; \
	for path in \
		./data \
		./logs \
		./config \
		./config/scripts \
	; do \
		mkdir -p "$path"; \
		#chown -R search:search "$path"; \
	done; \
	\
# we shouldn't need much RAM to test --version (default is 2gb, which gets Jenkins in trouble sometimes)
	#export ES_JAVA_OPTS='-Xms128m -Xmx512m'; \
	if [ "${ELASTICSEARCH_VERSION%%.*}" -gt 1 ]; then \
		elasticsearch --version; \
	else \
# elasticsearch 1.x doesn't support --version
# but in 5.x, "-v" is verbose (and "-V" is --version)
		elasticsearch -v; \
	fi

COPY config ./config

VOLUME /elasticsearch/data

COPY docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh

EXPOSE 9200 9300
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["elasticsearch"]
