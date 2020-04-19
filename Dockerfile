FROM openjdk:11-jdk-slim

LABEL maintainer="niranjan.nanda2011@gmail.com"

# ENV arguments
## ZK_NODE_COUNT --> The no. of nodes (default: 1)
## ZK_TICK_TIME --> An entry on zoo.cfg file for key "tickTime" (default: 2000)
## ZK_INIT_LIMIT --> An entry on zoo.cfg file for key "initLimit" (default: 10)
## ZK_SYNC_LIMIT --> An entry on zoo.cfg file for key "syncLimit" (default: 5)
## ZK_AUTOPURGE_SNAP_RETAIN_COUNT --> An entry on zoo.cfg file for key "autopurge.snapRetainCount" (default: 5)
## ZK_AUTOPURGE_PURGE_INTERVAL --> An entry on zoo.cfg file for key "autopurge.purgeInterval" (unit in hours; default: 1)
## ZK_4LW_CMD_WHITELIST --> An entry on zoo.cfg file for key "4lw.commands.whitelist" (default: *)
## ZK_MAX_CLIENT_CNXNS --> An entry on zoo.cfg file for key "maxClientCnxns" (default: 60)
## ZK_MIN_HEAP --> Min. JVM Heap size (default: 2GB)
## ZK_MAX_HEAP --> Max. JVM Heap size (default: 2GB)
ENV ZK_NODE_COUNT=1 \
    ZK_TICK_TIME=2000 \
    ZK_INIT_LIMIT=10 \
    ZK_SYNC_LIMIT=5 \
    ZK_AUTOPURGE_SNAP_RETAIN_COUNT=5 \
    ZK_AUTOPURGE_PURGE_INTERVAL=1 \
    ZK_4LW_CMD_WHITELIST=* \
    ZK_MAX_CLIENT_CNXNS=60 \
    ZK_STANDALONE_ENABLED=false \
    ZK_ADMIN_SERVER_ENABLED=false \
    ZK_MIN_HEAP=2g \
    ZK_MAX_HEAP=2g

EXPOSE 2181 2888 3888

COPY apache-zookeeper-3.5.5-bin.tar.gz /
COPY docker-entrypoint.sh /

# Initial setup actions
RUN cd / && tar -xf apache-zookeeper-3.5.5-bin.tar.gz \
    && mv apache-zookeeper-3.5.5-bin zk-3.5.5 \ 
    && rm -f apache-zookeeper-3.5.5-bin.tar.gz \
    && cd \
    && chmod u+x /docker-entrypoint.sh

ENTRYPOINT [ "/docker-entrypoint.sh" ]