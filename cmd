

# alpine
DOCKER_BUILDKIT=1 docker build \
--build-arg NPM_TOKEN=$NPM_TOKEN \
-f Dockerfile-alpine \
-t build-workshop/alpine .

# multistage
DOCKER_BUILDKIT=1 docker build \
--build-arg NPM_TOKEN=$NPM_TOKEN \
-f Dockerfile-multistage \
-t build-workshop/multistage .


# experimental
DOCKER_BUILDKIT=1 docker build \
--build-arg NPM_TOKEN=$NPM_TOKEN \
--ssh github=/Users/iben/.ssh/id_rsa \
--secret id=npmrc,src=.npmrc.secret \
-f Dockerfile-experimental \
-t build-workshop/experimental .