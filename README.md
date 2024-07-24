# Postgres

Database container image with required initial data already in it.

## Commit local working image

```bash
docker commit -a "Victor Smolinski" \
-m "6579a23 (HEAD -> develop, gitlab/develop)" \
postgres registry.gitlab.com/kloudnuk/postgres:0.0.1 
```

### Publish new image commit

```bash
docker push registry.gitlab.com/kloudnuk/postgres:0.0.1-test
```