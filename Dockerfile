FROM public.ecr.aws/docker/library/python:3.9-slim-bookworm

ARG KUBECTL_VERSION=1.22.12

# Instalar herramientas
RUN apt-get update && apt-get install -y --no-install-recommends curl \
    && rm -rf /var/lib/apt/lists/* \
    && pip install --no-cache-dir awscli \
    && curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash \
    && curl -LO https://storage.googleapis.com/kubernetes-release/release/v${KUBECTL_VERSION}/bin/linux/amd64/kubectl \
    && chmod +x ./kubectl && mv ./kubectl /usr/local/bin/kubectl

COPY deploy.sh /usr/local/bin/deploy

CMD ["deploy"]
