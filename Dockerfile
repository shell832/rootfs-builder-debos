FROM docker.io/godebos/debos

RUN apt update && apt install -y zerofree jq
