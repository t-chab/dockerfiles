# Build

Build with

```sh
docker build -t liferay-tomcat .
```

# Run

Run with

```sh
docker run -p 8080:8080 --rm --name lfr-tomcat -it $(docker images |grep liferay-tomcat |awk '{ print $3}')
```
