FROM mhart/alpine-node:6.4

RUN apk add --no-cache git

RUN apk add --no-cache cmake make gcc g++ bash

RUN git clone https://github.com/WebAssembly/binaryen.git

WORKDIR /binaryen

RUN git checkout version_11

RUN cmake . && make

ENV PATH=${PATH}:/binaryen/bin

#Currently we need a beta version of node

WORKDIR /

RUN apk add --no-cache python linux-headers openssl

RUN git clone https://github.com/nodejs/node.git

WORKDIR /node

RUN git checkout v7.x-staging

RUN ./configure && make

RUN make install

# END BETA NODE

ADD app /app

WORKDIR /app

CMD ["run.sh", "add"]
