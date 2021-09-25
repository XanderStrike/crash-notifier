# crash-checker

A daemon to notify discord webhooks when the
[crashspace](https://blog.crashspace.org/) opens.

![image](https://user-images.githubusercontent.com/1565303/134781532-d422190d-6288-4372-bc80-bcf901230545.png)

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
