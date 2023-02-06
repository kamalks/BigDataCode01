status_8_scala_e2e=1

LOCAL_IP=$LOCAL_IP
DB_PATH=$1

if [ $status_8_scala_e2e -ne 0 ]; then
  cd /ppml/trusted-big-data-ml
./clean.sh
/graphene/Tools/argv_serializer bash -c "/opt/jdk8/bin/java \
    -cp '/ppml/trusted-big-data-ml/work/spark-3.1.2/conf/:/ppml/trusted-big-data-ml/work/spark-3.1.2/jars/*:/ppml/trusted-big-data-ml/work/spark-3.1.2/examples/jars/spark-example-sql-e2e.jar' \
    -Xmx2g \
    org.apache.spark.deploy.SparkSubmit \
    --master 'local[4]' \
    --conf spark.driver.host=$LOCAL_IP \
    --conf spark.driver.memory=8g \
    --executor-memory 8g \
    --class test.SqlExample \
    /ppml/trusted-big-data-ml/work/spark-3.1.2/examples/jars/spark-example-sql-e2e.jar \
    $DB_PATH" > /ppml/trusted-big-data-ml/secured-argvs
./init.sh
SGX=1 ./pal_loader bash 2>&1 | tee spark-example-sql-e2e-sgx.log
fi
status_8_scala_e2e=$(echo $?)

echo "#### example.8 Excepted result(e2e): INFO this is result2 count: XXX"
echo "---- example.8 Actual result: "
cat spark-example-sql-e2e-sgx.log | egrep -a 'INFO this is result2 count:'
