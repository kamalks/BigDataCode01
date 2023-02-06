sudo docker rm -f bigdl-ppml-trusted-big-data-ml-scala-occlum-customer

# Run new command in container
sudo docker run -it \
	--net=host \
	--name=bigdl-ppml-trusted-big-data-ml-scala-occlum-customer \
	--cpuset-cpus 10-14 \
	--device=/dev/sgx/enclave \
	--device=/dev/sgx/provision \
	-v /var/run/aesmd:/var/run/aesmd \
	-v data:/opt/occlum_spark/data \
	-e SGX_MEM_SIZE=24GB \
	-e SGX_THREAD=512 \
	-e SGX_HEAP=512MB \
	-e SGX_KERNEL_HEAP=1GB \
        -e ATTESTATION=false \
	-e PCCS_URL=https://PCCS_IP:PCCS_PORT \
	-e ATTESTATION_URL=ESHM_IP:EHSM_PORT \
        -e APP_ID=your_app_id \
        -e API_KEY=your_api_key \
        -e CHALLENGE=cHBtbAo= \
        -e REPORT_DATA=ppml \
	-e SGX_LOG_LEVEL=off \
	intelanalytics/bigdl-ppml-trusted-big-data-ml-scala-occlum-production:2.3.0-build \
	bash /opt/run_spark_on_occlum_glibc.sh $1
