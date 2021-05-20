#!/bin/sh

ls -a ${ARTIFACT_STORE}

mlflow models serve -m "$ARTIFACT_STORE" -p $SERVER_PORT -h $SERVER_HOST --no-conda