FROM node:slim
WORKDIR /usr/local/elasticsearch-head

COPY phantomjs-2.1.1-linux-x86_64.tar.bz2 ./phantomjs-2.1.1-linux-x86_64.tar.bz2

RUN apt-get update && \
    apt-get install -y git node-gyp bzip2 && \
    bunzip2 phantomjs-2.1.1-linux-x86_64.tar.bz2
    
ENV PATH /usr/local/elasticsearch-head/phantomjs-2.1.1-linux-x86_64/bin:$PATH
RUN export PATH

RUN apt-get autoremove -y && \
    apt-get clean all && \
    rm -rf /var/lib/apt/lists/* && \
    npm install -g grunt grunt-cli && \
    git clone git://github.com/mobz/elasticsearch-head.git

RUN cd elasticsearch-head && \
    npm install && \
    sed -i 's/port: 9100,/hostname: "0.0.0.0", port: 9100,/g' Gruntfile.js && \
    sed -i 's/http://localhost:9200,/http://47.97.17.78:19200,/g' _site/app.js

EXPOSE 9100

CMD ["grunt", "server"]