FROM cactusbone/logstash
MAINTAINER F4 <dev@f4-group.com>

ADD logstash.conf /opt/logstash.conf

#elasticsearch
EXPOSE 9200

#gelf udp
EXPOSE 12201/udp
CMD java -jar /opt/logstash.jar agent -f /opt/logstash.conf -- web
