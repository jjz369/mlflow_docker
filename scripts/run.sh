#!/bin/sh

mlflow models serve -m "$ARTIFACT_STORE" -p $SERVER_PORT -h $SERVER_HOST --no-conda