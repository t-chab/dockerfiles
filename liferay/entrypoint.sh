#!/usr/bin/env sh

# Setup datasource in ROOT.xml
cat <<'EOF' > "${CATALINA_HOME}"/conf/Catalina/localhost/ROOT.xml
<Context crossContext="true" path="">
    <Resource name="jdbc/LiferayPool" auth="Container"
        type="javax.sql.DataSource" 
        driverClassName="org.postgresql.Driver"
        url="jdbc:postgresql://postgres/liferay"
        username="liferay" password="liferay"
        maxActive="200" maxIdle="50" minIdle="50" 
        initialSize="50" maxWait="10000" />
</Context>
EOF

if [ ! -d "${LFR_HOME}"/jackrabbit ]
then
    echo "No existing Liferay data found, setup first startup ..."
    cp -r "${LFR_BIN}/osgi" "${LFR_HOME}"
    cat <<'EOF' > "${CATALINA_HOME}/webapps/ROOT/WEB-INF/classes/portal-ext.properties"
admin.email.from.name=Test Test
jdbc.default.jndi.name=jdbc/LiferayPool
liferay.home=/data
EOF
fi

rm -rf "${LFR_BIN}"

catalina.sh run
