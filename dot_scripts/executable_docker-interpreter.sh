#!/usr/bin/env bash

IMAGE_NAME="openinterpreter"

# build image if missing
if [[ -z "$(docker images -q $IMAGE_NAME 2>/dev/null)" ]]; then
  cat <<EOF > Dockerfile
FROM python:3.11-slim
RUN pip install --no-cache-dir open-interpreter
ENTRYPOINT ["interpreter"]
EOF
  docker build -t $IMAGE_NAME .
  rm Dockerfile
fi

# run interpreter once, forward all script arguments
docker run --rm \
  -v "$(pwd)":/workspace \
  -v "$HOME/ai-space":/ai-space \
  -w /workspace \
  $IMAGE_NAME \
  "$@"

