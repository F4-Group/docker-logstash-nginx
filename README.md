# Logstash

based on cactusbone/logstash

configured to accept gelf input and output to elasticsearch
port 9200 must be exported using -p so browsers can access it
expect /var/log on the host to be binded using data volume on /var/host_logs

also configure your /etc/nginx/nginx.conf file with

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

to send nginx logs to logstash

be careful, since port 12201 is using udp, you cannot use the svendowideit/ambassador image in front.

Ports

* 12201/udp (gelf udp input)
* 9200 (embedded elasticsearch)

run it using

    docker run -d -p 12201:12201/udp -p 9201:9200 -v /var/logs:/var/host_logs:ro cactusbone/logstash-nginx