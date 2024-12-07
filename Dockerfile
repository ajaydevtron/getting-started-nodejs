# Base image
FROM node
ENV TINI_VERSION v0.18.0
RUN arch=$(arch | sed s/aarch64/arm64/ | sed s/x86_64/amd64/) && \
    wget https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini-${arch} -O /tini && \
    chmod +x /tini

# Install `script` for session recording
RUN apt-get update && apt-get install -y bsdutils && apt-get clean

# Add the shell wrapper script
COPY shell-wrapper.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/shell-wrapper.sh

# Set Tini as the init system
ENTRYPOINT ["/tini", "--"]

# Copy application files and install dependencies
COPY /. .
RUN npm install

# Use the shell wrapper script as the default command
CMD ["/usr/local/bin/shell-wrapper.sh"]
