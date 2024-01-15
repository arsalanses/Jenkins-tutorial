ARG JENKINS_VERSION=lts-slim
FROM jenkins/jenkins:$JENKINS_VERSION

##### Install jenkins plugins

RUN jenkins-plugin-cli --plugins \
  configuration-as-code \
  workflow-aggregator \
  job-dsl \
  pipeline-model-definition \
  docker-plugin \
  docker-commons \
  docker-workflow \
  git \
  git-parameter \
  github \
  junit \
  generic-webhook-trigger \
  ansible \
  credentials \
  credentials-binding \
  rebuild \
  run-condition \
  ssh \
  publish-over-ssh \
  http_request \
  s3 \
  config-file-provider \
  ansicolor \
  join \
  ws-cleanup \
  ssh-steps \
  codedeploy \
  ssh-credentials \
  matrix-auth \
  durable-task \
  remote-file

USER root

##### Install docker client

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y apt-transport-https \
  ca-certificates curl \
  gnupg gnupg2 \
  software-properties-common \
  lsb-release \
  apt-utils

RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -

RUN add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y docker-ce-cli

##### Install ansible

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y python3-pip

RUN pip install --break-system-packages wheel && pip install --break-system-packages ansible

##### ansible collection install

USER jenkins

COPY ansible.yaml /tmp/ansible.yaml

RUN ansible-galaxy collection install -r /tmp/ansible.yaml
