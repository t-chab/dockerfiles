FROM alpine:3.10

ENV ANTENNAS_HOME /opt/antennas
ENV ANTENNAS_USER antennas
ENV ANTENNAS_GROUP antennas
ENV ANTENNAS_UID=5000
ENV ANTENNAS_GID=5000

RUN apk add --no-cache --update yarn nodejs git \
    && rm -rf /var/cache/apk/* \
    && mkdir -p ${ANTENNAS_HOME} \
    && git clone "https://github.com/TheJF/antennas.git" ${ANTENNAS_HOME} \
    && cd ${ANTENNAS_HOME} \
    && wget -O tvh.patch "https://github.com/TheJF/antennas/commit/085b996eb944b50d5e3ab33d5f7224a16cc3908f.patch" \
    && git apply tvh.patch \
    && yarn install \
    && addgroup -g ${ANTENNAS_GID} ${ANTENNAS_USER} \
    && adduser -S -s /sbin/nologin -u ${ANTENNAS_UID} -h "${ANTENNAS_HOME}" -G ${ANTENNAS_GROUP} ${ANTENNAS_USER} \
    && chown -R ${ANTENNAS_UID}:${ANTENNAS_GID} "${ANTENNAS_HOME}" \
    && chown -R ${ANTENNAS_UID}.${ANTENNAS_GID} "${ANTENNAS_HOME}"

WORKDIR ${ANTENNAS_HOME}

EXPOSE 5004

USER ${ANTENNAS_USER}
ENTRYPOINT ["/usr/bin/node", "index.js"]
