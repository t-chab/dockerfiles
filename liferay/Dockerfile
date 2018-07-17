FROM tomcat:8.5-jre8-alpine

ENV LFR_URL_ROOT="https://sourceforge.net/projects/lportal/files/Liferay%20Portal/"

ENV LFR_VERSION="7.1.0-ga1"
ENV LFR_EDITION="liferay-ce-portal"
ENV LFR_EDITION_TIMESTAMP="20180703012531655"
ENV LFR_BUNDLE="${LFR_EDITION}-${LFR_VERSION}-${LFR_EDITION_TIMESTAMP}.war"
ENV LFR_DEPS="${LFR_EDITION}-dependencies-${LFR_VERSION}-${LFR_EDITION_TIMESTAMP}.zip"
ENV LFR_OSGI_DEPS="${LFR_EDITION}-osgi-${LFR_VERSION}-${LFR_EDITION_TIMESTAMP}.zip"
ENV LFR_OTHER_DEPS="${LFR_EDITION}-other-dependencies-${LFR_VERSION}-${LFR_EDITION_TIMESTAMP}.zip"
ENV LFR_HOME="/opt/liferay"
ENV LFR_DEPLOY="${LFR_HOME}/deploy"

ENV CATALINA_OPTS="${CATALINA_OPTS} -Dfile.encoding=UTF8 \
    -Djava.net.preferIPv4Stack=true \
    -Dorg.apache.catalina.loader.WebappClassLoader.ENABLE_CLEAR_REFERENCES=false \
    -Duser.timezone=Europe/Paris \
    -Xmx768m \
    -XX:MaxMetaspaceSize=128m"
ENV TC_EXT="${CATALINA_HOME}/lib/ext"
ENV TC_COMMON_LOADER='\"\${catalina.base}\/lib\",\"\${catalina.base}\/lib\/*.jar\",\"\${catalina.home}\/lib\",\"\${catalina.home}\/lib\/*.jar\",\"\${catalina.home}\/lib\/ext\/global\",\"\${catalina.home}\/lib\/ext\/global\/*.jar\",\"\${catalina.home}\/lib\/ext\",\"\${catalina.home}\/lib\/ext\/*.jar\",\"\${catalina.home}\/lib\/ext\",\"\${catalina.home}\/lib\/ext\/*.jar\"'

COPY "${LFR_BUNDLE}" "${LFR_HOME}"/
COPY "${LFR_DEPS}" "${LFR_HOME}"/
COPY "${LFR_OSGI_DEPS}" "${LFR_HOME}"/
COPY "${LFR_OTHER_DEPS}" "${LFR_HOME}"/

RUN mkdir -p "${TC_EXT}/global" "${CATALINA_HOME}/conf/Catalina/localhost" \
    && rm -r ${CATALINA_HOME}/webapps/* \
    && mkdir -p "${CATALINA_HOME}/webapps/ROOT" \
    && mv "${LFR_HOME}/${LFR_BUNDLE}" "${CATALINA_HOME}/webapps/ROOT.war" \
    && unzip "${CATALINA_HOME}/webapps/ROOT.war" -d "${CATALINA_HOME}/webapps/ROOT" \
    && unzip "${LFR_HOME}/${LFR_DEPS}" -d "${LFR_HOME}" \
    && cd "${LFR_HOME}/${LFR_EDITION}-dependencies-${LFR_VERSION}" \
    && mv * "${TC_EXT}/" \
    && unzip "${LFR_HOME}/${LFR_OTHER_DEPS}" -d "${LFR_HOME}" \
    && cd "${LFR_HOME}/${LFR_EDITION}-other-dependencies-${LFR_VERSION}" \
    && mv * "${TC_EXT}/" \
    && unzip "${LFR_HOME}/${LFR_OSGI_DEPS}" -d "${LFR_HOME}" \
    && mv "${LFR_HOME}/${LFR_EDITION}-${LFR_VERSION}/osgi" "${LFR_HOME}/osgi" \
    && cp "${LFR_HOME}/osgi/core/com.liferay.osgi.service.tracker.collections.jar" "${TC_EXT}" \
    && echo '<Context path="" crossContext="true"></Context>' > "${CATALINA_HOME}/conf/Catalina/localhost/ROOT.xml" \
    && echo 'grant { permission java.security.AllPermission; };' > "${CATALINA_HOME}/conf/catalina.policy" \
    && sed -i "s/\(common\.loader=\).*\$/\1${TC_COMMON_LOADER}/" "${CATALINA_HOME}/conf/catalina.properties" \
    && echo "liferay.home=${LFR_HOME}" > "${CATALINA_HOME}/webapps/ROOT/WEB-INF/classes/portal-ext.properties" \
    && rm -r "${CATALINA_HOME}"/webapps/ROOT.war ${LFR_HOME}/${LFR_EDITION}*

EXPOSE 8080
