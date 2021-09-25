FROM ruby

RUN apt-get update && apt-get install -y cron && apt-get clean && rm -rf /var/lib/apt/lists/*

COPY main.rb .
RUN chmod +x main.rb

COPY run.sh .
RUN chmod +x run.sh

COPY example-crontab .
RUN chmod 0644 /example-crontab && crontab /example-crontab

ENTRYPOINT ["./run.sh"]
