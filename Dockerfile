FROM amazon/aws-cli:2.18.8

# ENV LABEL_MAINTAINER="niveksan" \
#     LABEL_IMAGE_NAME="niveksan/scripted-aws-cli" \
#     LABEL_DESCRIPTION="Docker amazon/aws-cli image using crond as default entrypoint." \
#     LABEL_LICENSE="GPL-3.0"

# install bash (for script)
RUN yum clean all \
    && yum update -y \
    && yum install -y bash \
                      cronie

# copy scripted-aws-cli script to crond daily folder
COPY scripted-aws-cli.sh /

# copy entrypoint to usr bin
COPY entrypoint.sh /

# give execution permission to scripts
RUN chmod +x /entrypoint.sh && \
    chmod +x /scripted-aws-cli.sh

RUN echo "0 */12 * * * bash /scripted-aws-cli.sh" | crontab

ENTRYPOINT ["/entrypoint.sh"]

# create image locally:
# docker build --network=host --no-cache -t scripted-aws-cli:arm .