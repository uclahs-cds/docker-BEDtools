ARG MINIFORGE_VERSION=23.1.0-1
FROM condaforge/mambaforge:${MINIFORGE_VERSION} AS builder

# Use mamba to install tools and dependencies into /usr/local
ARG BEDTOOLS_VERSION=2.31.0
RUN mamba create -qy -p /usr/local \
    -c bioconda \
    -c conda-forge \
    bedtools==${BEDTOOLS_VERSION}

# Deploy the target tools into a base image
FROM ubuntu:20.04
COPY --from=builder /usr/local /usr/local

# Add a new user/group called bldocker
RUN groupadd -g 500001 bldocker && \
    useradd -r -u 500001 -g bldocker bldocker

# Change the default user to bldocker from root
USER bldocker

LABEL maintainer="Sorel Fitz-Gibbon <sfitzgibbon@mednet.ucla.edu>" \
org.opencontainers.image.source=https://github.com/uclahs-cds/docker-BEDtools
