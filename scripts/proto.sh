#!/bin/bash
set -e

cd "$(dirname "$0")/.."
readonly service="$1"

if [[ -z "$service" ]]; then
    echo "Usage: $0 <output_directory>"
    exit 1
fi

if [[ "$service" == "api" ]]; then
    proto_path="api/v1"
elif [[ "$service" == "lww" ]]; then
    proto_path="api/internal"
else
    echo "Unknown service: $service"
    exit 1
fi

mkdir -p "internal/common/genproto/$service"
protoc \
    --go_out="internal/common/genproto/$service" \
    --go_opt=paths=source_relative \
    --go-grpc_out="internal/common/genproto/$service" \
    --go-grpc_opt=paths=source_relative \
    --proto_path="$proto_path" \
    "$proto_path/$service.proto"
