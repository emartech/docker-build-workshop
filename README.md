# DOCKER BULDKIT WORKSHOP

## PREFLIGHT
### Useful commands
```
docker system df
TYPE                TOTAL               ACTIVE              SIZE                RECLAIMABLE
Images              10                  0                   467.4MB             467.4MB (100%)
Containers          0                   0                   0B                  0B
Local Volumes       0                   0                   0B                  0B
Build Cache         42                  0                   113.5MB             113.5MB
```

```
docker diff mycontainer
A /tmp/addedfile
D /tmp/deletedfile
C /tmp/changedfile
```

```
docker history node:alpine
IMAGE               CREATED             CREATED BY                                      SIZE
25969f50f21d        7 days ago          /bin/sh -c #(nop)  CMD ["node"]                 0B
<missing>           7 days ago          /bin/sh -c apk add --no-cache --virtual .bui…   5.1MB
<missing>           7 days ago          /bin/sh -c #(nop)  ENV YARN_VERSION=1.13.0      0B
<missing>           7 days ago          /bin/sh -c addgroup -g 1000 node     && addu…   64.6MB
<missing>           7 days ago          /bin/sh -c #(nop)  ENV NODE_VERSION=11.10.0     0B
<missing>           3 weeks ago         /bin/sh -c #(nop)  CMD ["/bin/sh"]              0B
<missing>           3 weeks ago         /bin/sh -c #(nop) ADD file:2a1fc9351afe35698…   5.53MB
```

```
docker builder|image|volume|system prune
```
---
## Step 1: Basic best practices
```
time docker build --build-arg NPM_TOKEN=$NPM_TOKEN -t build-workshop/reference .
```

## Step 2: Choose your base image wisely
```
time docker build \
  --build-arg NPM_TOKEN=$NPM_TOKEN \
  -f Dockerfile-alpine \
  -t build-workshop/alpine .
```

## Step 3: Multistage build
```
time docker build \
  --build-arg NPM_TOKEN=$NPM_TOKEN \
  -f Dockerfile-multistage \
  -t build-workshop/multistage .
```

## Step 4: BuildKit
With docker build:
```
time docker build \
  --no-cache \
  --build-arg NPM_TOKEN=$NPM_TOKEN \
  -f Dockerfile-multistage \
  -t build-workshop/multistage .
```
With BuildKit:
```
DOCKER_BUILDKIT=1 docker build \
  --no-cache \
  --build-arg NPM_TOKEN=$NPM_TOKEN \
  -f Dockerfile-multistage \
  -t build-workshop/multistage .
```

## Step 5: Experimental
Add to `require` in `composer.json`:
```
"laravel/framework": "5.7.24",
```
With build `ARG`:
```
DOCKER_BUILDKIT=1 docker build \
--build-arg NPM_TOKEN=$NPM_TOKEN \
-f Dockerfile-experimental \
-t build-workshop/experimental .
```
With secret:
```
DOCKER_BUILDKIT=1 docker build \
--secret id=npmrc,src=.npmrc.secret \
-f Dockerfile-experimental \
-t build-workshop/experimental .
```
With SSH:
```
DOCKER_BUILDKIT=1 docker build \
--ssh github=/Users/<your_username>/.ssh/id_rsa \
--secret id=npmrc,src=.npmrc.secret \
-f Dockerfile-experimental \
-t build-workshop/experimental .
```