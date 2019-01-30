#!/bin/bash
FLUME_CONF_DIR=/opt/flume/conf
FLUME_LOG_DIR=/opt/flume/data/output

CONF_FILE=${FLUME_CONF_DIR}/flume.conf
/opt/flume/bin/flume-ng agent -c ${FLUME_CONF_DIR} -f $CONF_FILE -n org_agent -DpropertiesImplementation=org.apache.flume.node.EnvVarResolverProperties -Dflume.root.logger=INFO,console -Dorg.apache.flume.log.rawdata=true