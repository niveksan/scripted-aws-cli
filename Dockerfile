FROM amazon/aws-cli:2.17.45

# ENV LABEL_MAINTAINER="niveksan" \
#     LABEL_IMAGE_NAME="niveksan/scripted-aws-cli" \
#     LABEL_DESCRIPTION="Docker amazon/aws-cli image using crond as default entrypoint." \
#     LABEL_LICENSE="GPL-3.0"

# install bash (for script)
RUN apk add --no-cache \
  bash

# copy scripted-aws-cli script to crond daily folder
COPY scripted-aws-cli.sh /

# copy entrypoint to usr bin
COPY entrypoint.sh /

# give execution permission to scripts
RUN chmod +x /entrypoint.sh && \
    chmod +x /scripted-aws-cli.sh

RUN echo "0 */12 * * * /scripted-aws-cli.sh" > /etc/crontabs/root

ENTRYPOINT ["/entrypoint.sh"]

# docker build --network=host --no-cache -t scripted-aws-cli:arm .