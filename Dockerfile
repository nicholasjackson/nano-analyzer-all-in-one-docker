FROM node:24

RUN apt-get update \
    && apt-get install -y --no-install-recommends python3 python3-pip \
    && rm -rf /var/lib/apt/lists/*

RUN curl -fsSL https://bob.ibm.com/download/bobshell.sh | bash -s -- --pm npm

ARG CACHEBUST=1

WORKDIR /tools/nano-analyzer

RUN git clone --branch f-bob --depth 1 https://github.com/nicholasjackson/nano-analyzer.git .

WORKDIR /juice-shop

RUN git clone https://github.com/juice-shop/juice-shop.git --depth 1 . \
    && npm install -g typescript \
    && npm install \
    && npm run build:server

EXPOSE 3000

CMD ["npm", "start"]
