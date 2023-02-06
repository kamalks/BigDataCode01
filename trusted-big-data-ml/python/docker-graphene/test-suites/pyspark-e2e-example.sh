#!/bin/bash
status_8_local_spark_customer_profile=1
SPARK_LOCAL_IP=$LOCAL_IP
DB_PATH=/ppml/trusted-big-data-ml/work/data/sqlite_example/100w.db

# attention to SPARK_LOCAL_IP env change into targeted ip
if [ $status_8_local_spark_customer_profile -ne 0 ]; then
echo "example.8 local spark, Custom profile"
cd /ppml/trusted-big-data-ml
./clean.sh
/graphene/Tools/argv_serializer bash -c "export TF_MKL_ALLOC_MAX_BYTES=10737418240 && export SPARK_LOCAL_IP=$SPARK_LOCAL_IP && /opt/jdk8/bin/java \
  -cp '/ppml/trusted-big-data-ml/work/spark-3.1.2/conf/:/ppml/trusted-big-data-ml/work/spark-3.1.2/jars/*' \
  -Xmx1g \
  org.apache.spark.deploy.SparkSubmit \
    --master 'local[4]' \
    --conf spark.driver.memory=2g \
    --properties-file /ppml/trusted-big-data-ml/work/bigdl-$BIGDL_VERSION/conf/spark-bigdl.conf \
    --executor-memory 2g \
    --conf spark.python.use.daemon=false \
    --conf spark.python.worker.reuse=false \
    /ppml/trusted-big-data-ml/work/examples/customer_profile.py \
    --db_path $DB_PATH" > /ppml/trusted-big-data-ml/secured-argvs
./init.sh
SGX=1 ./pal_loader bash 2>&1 | tee customer_profile-sgx.log
status_8_local_spark_customer_profile=$(echo $?)
fi

echo "#### example.8 Excepted result(e2e): INFO this is result2 count: XXX"
echo "---- example.8 Actual result: "
cat customer_profile-sgx.log | egrep -a 'INFO this is result2 count:'
