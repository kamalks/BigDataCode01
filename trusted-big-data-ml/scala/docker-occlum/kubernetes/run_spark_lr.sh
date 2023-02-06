#!/bin/bash

${SPARK_HOME}/bin/spark-submit \
    --master k8s://https://${kubernetes_master_url}:6443 \
    --deploy-mode cluster \
    --name spark-LogisticRegressionExample \
    --class org.apache.spark.examples.ml.LogisticRegressionExample \
    --conf spark.executor.instances=1 \
    --conf spark.rpc.netty.dispatcher.numThreads=32 \
    --conf spark.kubernetes.container.image=intelanalytics/bigdl-ppml-trusted-big-data-ml-scala-occlum:2.3.0-SNAPSHOT \
    --conf spark.kubernetes.authenticate.driver.serviceAccountName=spark \
    --conf spark.kubernetes.executor.podNamePrefix="sparklr" \
    --conf spark.kubernetes.executor.deleteOnTermination=false \
    --conf spark.kubernetes.driver.podTemplateFile=./driver.yaml \
    --conf spark.kubernetes.executor.podTemplateFile=./executor.yaml \
    --conf spark.kubernetes.sgx.log.level=off \
    --executor-memory 1024m \
    --executor-cores 6 \
    --conf spark.kubernetes.driverEnv.SGX_DRIVER_JVM_MEM_SIZE="2G" \
    --conf spark.executorEnv.SGX_EXECUTOR_JVM_MEM_SIZE="1G" \
    --jars local:/opt/spark/examples/jars/scopt_2.12-3.7.1.jar \
    local:/opt/spark/examples/jars/spark-examples_2.12-3.1.3.jar \
    --regParam 0.3 --elasticNetParam 0.8 \
    /opt/spark/data/mllib/sample_libsvm_data.txt

