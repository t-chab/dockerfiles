FROM tomcat:8.5-jre8-alpine

ENV LFR_VERSION="7.0-sp7"
ENV LFR_EDITION="liferay-dxp-digital-enterprise"
ENV LFR_BUNDLE="${LFR_EDITION}-${LFR_VERSION}.war"
ENV LFR_DEPS="${LFR_EDITION}-dependencies-${LFR_VERSION}.zip"
ENV LFR_OSGI_DEPS="${LFR_EDITION}-osgi-${LFR_VERSION}.zip"
ENV LFR_BIN="/opt/liferay"
ENV LFR_HOME="/data"
ENV LFR_DEPLOY="${LFR_HOME}/deploy"

ENV CATALINA_OPTS="${CATALINA_OPTS} -Dfile.encoding=UTF8 \
    -Djava.net.preferIPv4Stack=true \
    -Dorg.apache.catalina.loader.WebappClassLoader.ENABLE_CLEAR_REFERENCES=false \
    -Duser.timezone=GMT \
    -Xmx1024m \
    -XX:MaxMetaspaceSize=384m"
ENV TC_EXT="${CATALINA_HOME}/lib/ext"
ENV TC_COMMON_LOADER='\"\${catalina.base}\/lib\",\"\${catalina.base}\/lib\/*.jar\",\"\${catalina.home}\/lib\",\"\${catalina.home}\/lib\/*.jar\",\"\${catalina.home}\/lib\/ext\/global\",\"\${catalina.home}\/lib\/ext\/global\/*.jar\",\"\${catalina.home}\/lib\/ext\",\"\${catalina.home}\/lib\/ext\/*.jar\",\"\${catalina.home}\/lib\/ext\",\"\${catalina.home}\/lib\/ext\/*.jar\"'

COPY entrypoint.sh /
COPY "${LFR_BUNDLE}" "${LFR_BIN}"/
COPY "${LFR_DEPS}" "${LFR_BIN}"/
COPY "${LFR_OSGI_DEPS}" "${LFR_BIN}"/

RUN mkdir -p "${TC_EXT}/global" && apk --no-cache --update add openjdk8

# Other Liferay dependencies
ADD https://repo1.maven.org/maven2/javax/activation/activation/1.1/activation-1.1.jar "${TC_EXT}/activation.jar"
ADD https://repo1.maven.org/maven2/javax/ccpp/ccpp/1.0/ccpp-1.0.jar "${TC_EXT}/ccpp.jar"
ADD https://repo1.maven.org/maven2/javax/transaction/jta/1.1/jta-1.1.jar "${TC_EXT}/jta.jar"
ADD https://repo1.maven.org/maven2/com/beetstra/jutf7/jutf7/1.0.0/jutf7-1.0.0.jar "${TC_EXT}/jutf7.jar"
ADD https://repo1.maven.org/maven2/javax/mail/mail/1.4/mail-1.4.jar "${TC_EXT}/mail.jar"
ADD https://repo1.maven.org/maven2/org/eclipse/persistence/javax.persistence/2.1.1/javax.persistence-2.1.1.jar "${TC_EXT}/persistence.jar"
ADD https://repo1.maven.org/maven2/org/postgresql/postgresql/42.0.0/postgresql-42.0.0.jar "${TC_EXT}/postgresql.jar"
ADD https://repository.jboss.org/maven2/javax/jms/jms/1.1/jms-1.1.jar "${TC_EXT}/jms.jar"
ADD support-tomcat.jar "${TC_EXT}/support-tomcat.jar"

RUN mkdir -p "${CATALINA_HOME}/conf/Catalina/localhost" \
    && rm -r ${CATALINA_HOME}/webapps/* \
    && mkdir -p "${CATALINA_HOME}/webapps/ROOT" \
    && mv "${LFR_BIN}/${LFR_BUNDLE}" "${CATALINA_HOME}/webapps/ROOT.war" \
    && unzip "${CATALINA_HOME}/webapps/ROOT.war" -d "${CATALINA_HOME}/webapps/ROOT" \
    && unzip "${LFR_BIN}/${LFR_DEPS}" -d "${LFR_BIN}" \
    && cd "${LFR_BIN}/${LFR_EDITION}-dependencies-${LFR_VERSION}" \
    && mv * "${TC_EXT}/" \
    && unzip "${LFR_BIN}/${LFR_OSGI_DEPS}" -d "${LFR_BIN}" \
    && mv "${LFR_BIN}/${LFR_EDITION}-${LFR_VERSION}/osgi" "${LFR_BIN}/osgi" \
    && cp "${LFR_BIN}/osgi/core/com.liferay.osgi.service.tracker.collections.jar" "${TC_EXT}" \
    && echo '<Context path="" crossContext="true"></Context>' > "${CATALINA_HOME}/conf/Catalina/localhost/ROOT.xml" \
    && echo 'grant { permission java.security.AllPermission; };' > "${CATALINA_HOME}/conf/catalina.policy" \
    && sed -i "s/\(common\.loader=\).*\$/\1${TC_COMMON_LOADER}/" "${CATALINA_HOME}/conf/catalina.properties" \
    && rm -r "${CATALINA_HOME}"/webapps/ROOT.war ${LFR_BIN}/${LFR_EDITION}-dependencies* ${LFR_BIN}/${LFR_EDITION}-osgi-*.zip

VOLUME ["/data"]

EXPOSE 8080

ENTRYPOINT [ "/entrypoint.sh" ]
