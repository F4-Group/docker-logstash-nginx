FROM cactusbone/logstash
MAINTAINER F4 <dev@f4-group.com>

ADD logstash.conf /opt/logstash.conf
#allows file logs to work
RUN touch .sincedb

EXPOSE 9500