FROM blcdsdockerregistry/bl-base:1.0.0 AS builder

# Use conda to install tools and dependencies into /usr/local
ARG BEDTOOLS_VERSION=2.29.2
RUN conda create -qy -p /usr/local \
    -c bioconda \
    -c conda-forge \
    bedtools==${BEDTOOLS_VERSION}

# Deploy the target tools into a base image
FROM ubuntu:20.04
COPY --from=builder /usr/local /usr/local

LABEL maintainer="Helena Winata <hwinata@mednet.ucla.edu>"

