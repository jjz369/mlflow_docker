FROM python:3.8

ARG RUN_ID=af13de24a09848e68306348515a12271
ARG EXP_ID=0
ARG MODEL_NAME=model

ENV SERVER_PORT 5000
ENV SERVER_HOST 0.0.0.0

ENV MLFLOW_HOME /opt/mlflow
ENV FILE_STORE ${MLFLOW_HOME}/fileStore 
ENV ARTIFACT_STORE ${MLFLOW_HOME}/artifactStore
ENV SCRIPT_STORE ${MLFLOW_HOME}/scripts

RUN mkdir -p ${MLFLOW_HOME} && \
    mkdir -p ${ARTIFACT_STORE} && \
    mkdir -p ${FILE_STORE} && \
    mkdir -p ${SCRIPT_STORE}

RUN pip install mlflow==1.14.1 && \
    pip install pandas==1.2.3 && \
    pip install scikit-learn==0.24.2

COPY scripts/run.sh ${SCRIPT_STORE}/run.sh 
COPY mlruns/$EXP_ID/$RUN_ID/artifacts/$MODEL_NAME/* ${ARTIFACT_STORE}

EXPOSE ${SERVER_PORT}/tcp 

VOLUME ["${SCRIPT_STORE}", "${ARTIFACT_STORE}", "${FILE_STORE}"]

WORKDIR ${MLFLOW_HOME}

RUN chmod +x ${SCRIPT_STORE}/run.sh

ENTRYPOINT ["./scripts/run.sh"]
