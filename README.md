# Logstash

This repository contains **Dockerfile** for [Logstash](http://logstash.net/).

It is configured with :

* input: gelf, log4j, nginx logfile
* output: elasticsearch

Expect /var/log on the host to be binded using data volume on /var/host_logs

### Dependencies

* [cactusbone/logstash](https://index.docker.io/u/cactusbone/logstash/)

### Configuration

Configure your /etc/nginx/nginx.conf file to send nginx logs to logstash :

    ##
    # Logging Settings
    ##
    log_format logstash_json '{ "@timestamp": "$time_iso8601", '
                     '"@fields": { '
                     '"remote_addr": "$remote_addr", '
                     '"remote_user": "$remote_user", '
                     '"body_bytes_sent": "$body_bytes_sent", '
                     '"request_time": "$request_time", '
                     '"status": "$status", '
                     '"request": "$request", '
                     '"request_method": "$request_method", '
                     '"http_referrer": "$http_referer", '
                     '"http_user_agent": "$http_user_agent" } }';
    access_log /var/log/nginx/access.log logstash_json;
    error_log /var/log/nginx/error.log;

### Exposed ports

* 12201/udp (gelf udp input)
* 9200 (embedded elasticsearch)
* 9500 (log4j server)

Be careful, since port 12201 is using udp, you cannot use the svendowideit/ambassador image in front.

### Usage

    docker run -d -p 12201:12201/udp -p 9201:9200 -v /var/logs:/var/host_logs:ro cactusbone/logstash-nginx