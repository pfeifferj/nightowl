FROM crystallang/crystal:latest

RUN apt-get update && apt-get install -y \
    git \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY shard.yml shard.lock ./

RUN shards install

COPY . .

RUN crystal build number_station.cr --release

EXPOSE 3000

CMD ["./number_station"]
