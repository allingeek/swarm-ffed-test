#!/bin/sh


OPTS=''
validate() {
  echo Testing Docker configuration.
  docker $OPTS info
  if [ $? -eq 0 ]; then
    echo Docker environment set.
    return 0
  fi

  OPTS='-H tcp://localhost:2376'
  docker $OPTS info
  if [ $? -eq 0 ]; then
    echo Using localhost:2376
    return 0
  fi

  OPTS='-H unix:///var/run/docker.sock'
  docker $OPTS info
  if [ $? -eq 0 ]; then
    echo Using docker.sock
    return 0
  fi

  echo Docker unavailable.
  return 1
}

test() {
  docker $OPTS run \
    -d --name manager \
    --restart always \
    --net host \
    -v "$(pwd)"/slash-$1-list.txt:/tmp/cluster.txt \
    swarm:latest \
      manage -H tcp://0.0.0.0:3376 \
      --strategy spread \
      file:///tmp/cluster.txt
}

health() {
  docker -H tcp://localhost:3376 info | grep Status | sort | uniq -c
}

stop() {
  docker $OPTS stop manager
}

clean() {
  docker $OPTS rm -vf manager
}

