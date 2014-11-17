fluent-plugin-better-timestamp
==============================

fluentd plugin to store timestamp with millisecond to elasticsearch

### fluent-plugin-elasticsearch
fluentd uses unixtime as 'time' and fluent-plugin-elasticsearch inserts the 'time' to elasticsearch as @timestamp. Therefore, it's not easy to store more detailed time data like millisec. But fluentd-plugin-elasticsearch provides another way to store timestamp to elasticsearch. if record has '@timestamp', that will be  stored in elasticsearh.

### fluent-plugin-better-timestamp
this plugin works as a filter that creates '@timestamp' with proper format from 'time' and one more field which have 'msec' data

## install
```
gem install fluent-plugin-better-timestamp
```

### configuration
'better-timestamp' plugin has only 3 config parameters

 * tag
 * msec_key - specifies the key name for msec (default:  msec)
 * timestamp_key - specifies the key name for output (default: @timestamp)

### example

```
<source>
  type tail
  format
  format /^(?<time>\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}).(?<msec>\d{3}) .....
  ...
  tag log
</source>
<match log>
  type better_timestamp
  tag log.with_msec
</match>
<match tag log.with_msec>
  type elasticsearch
  ...
</match
```



