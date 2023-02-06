export CUSTOM_IMAGE_NAME=your_custom_image_name
export CUSTOM_IMAGE_TAG=your_custom_image_tag
export BASE_IMAGE_NAME=your_base_image_name
export BASE_IMAGE_TAG=your_base_image_tag
export SGX_MEM_SIZE=memory_size_of_sgx_in_custom_image
export SGX_LOG_LEVEL=log_level_of_sgx_in_custom_image
export ENABLE_DCAP_ATTESTATION=true

if [[ "$SGX_MEM_SIZE" == "memory_size_of_sgx_in_custom_image" ]] || [[ "$SGX_LOG_LEVEL" == "log_level_of_sgx_in_custom_image" ]]
then
    echo "Please specific SGX_MEM_SIZE and SGX_LOG_LEVEL."
else
    sudo docker build \
        --build-arg BASE_IMAGE_NAME=${BASE_IMAGE_NAME} \
        --build-arg BASE_IMAGE_TAG=${BASE_IMAGE_TAG} \
        --build-arg SGX_MEM_SIZE=${SGX_MEM_SIZE} \
        --build-arg SGX_LOG_LEVEL=${SGX_LOG_LEVEL} \
        --build-arg ENABLE_DCAP_ATTESTATION=${ENABLE_DCAP_ATTESTATION} \
        -t ${CUSTOM_IMAGE_NAME}:${CUSTOM_IMAGE_TAG} \
        -f ./Dockerfile .
fi
