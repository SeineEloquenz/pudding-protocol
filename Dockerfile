FROM debian:bookworm-slim

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y -q \
    build-essential \
    git \
    curl \
    iftop

RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
ENV PATH="/root/.cargo/bin:${PATH}"
RUN cargo --help

COPY . /usr/app
WORKDIR /usr/app

RUN chmod +x prepare_and_build.sh
RUN chmod +x run_evaluation.sh

RUN ./prepare_and_build.sh

CMD [ "./run_evaluation.sh" ]
