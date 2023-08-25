# jenkins-stack-docker

![LinkedIn Follow](https://shields.io/badge/style-arsalanse-black?logo=linkedin&label=LinkedIn&link=https://www.linkedin.com/in/arsalanse)

### Get started:

Change traefik hosts

```bash
chmod 600 acme.json
docker network create web
docker compose up -d
```

### No valid crumb
- manage > configureSecurity > CSRF Protection > Enable proxy compatibility
