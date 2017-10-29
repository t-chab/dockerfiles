# Description

Dockerfile to create Ubuntu based container, with latest Java and Google Chrome installed.

# Quirks

Chrome must be launched with *no-sandbox* option, otherwise it will fail.

```
google-chrome-stable --no-sandbox
```
