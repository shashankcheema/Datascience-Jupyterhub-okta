# Use UBI 8 as the base image
FROM registry.access.redhat.com/ubi8/ubi

# Set the working directory
WORKDIR /srv/jupyterhub

# Install necessary dependencies
RUN dnf update -y && \
    dnf install -y python3 python3-pip && \
    dnf clean all

# Install JupyterHub and other required packages
RUN pip3 install jupyterhub jupyterhub-oktaauthenticator

# Install Apache Spark
RUN curl -O https://downloads.apache.org/spark/spark-<version>/spark-<version>-bin-hadoop<version>.tgz \
    && tar -xzf spark-<version>-bin-hadoop<version>.tgz \
    && mv spark-<version>-bin-hadoop<version> /opt/spark \
    && rm spark-<version>-bin-hadoop<version>.tgz

# Set environment variables for Spark
ENV SPARK_HOME=/opt/spark
ENV PATH=$SPARK_HOME/bin:$PATH
ENV PYTHONPATH=$SPARK_HOME/python:$SPARK_HOME/python/lib/py4j-<py4j_version>-src.zip:$PYTHONPATH

# Copy the JupyterHub configuration file and Okta configuration to the container
COPY jupyterhub_config.py .

# Copy the Spark configuration file to the container
COPY spark-defaults.conf $SPARK_HOME/conf/spark-defaults.conf

# Copy the OktaAuthenticator file to the container
COPY okta_auth.py .

# Expose the necessary ports
EXPOSE 8000

# Start JupyterHub
CMD ["jupyterhub", "-f", "jupyterhub_config.py"]
