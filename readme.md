# crash-checker

A daemon to notify discord webhooks when the
[crashspace](https://blog.crashspace.org/) opens.

## usage

Get a [Discord webhook URL](https://support.discord.com/hc/en-us/articles/228383668-Intro-to-Webhooks)
for your channel.

### Run with Docker:

```sh
docker run -d
  --name checker
  -e "DISCORD_URL=<webhook url>"
  xanderstrike/crash-checker
```

### Run with Kubernetes:

Update and apply [deployment.yml](deployment.yml).

Enjoy.
