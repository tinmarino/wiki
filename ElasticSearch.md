## Tuto

* __Init:__ `sudo systemctl start elasticsearch.service`
* __Test:__ `curl GET "localhost:9200"`
* __Test:__ `curl -X GET "http://localhost:9200/?pretty"`
* __Read clusters:__ `curl -XGET 'http://localhost:9200/_cluster/state?pretty'`


* __Note:__ Remember to be root to explore directories: toherwise, they appears void


### Querying

[Querry syntax](https://www.elastic.co/guide/en/elasticsearch/reference/7.5/query-dsl-query-string-query.html#query-string-syntax)

curl -X POST localhost:9200/twitter/_search?q=username:eriky

* `~1` for accept syntax errors
curl -X POST http://localhost:9200/twitter/_search?q=Elastcsearch~1&pretty

* __All:__ `POST /_all/_search`
* `GET /_all/_search?q=city:paprola `: All indices with city paprola
* __indices:__ `POST /index1,index2,index3/_search`
* `POST /school*,-schools_gov /_search` : starting with school without schools_gov

### Config (in /etc/elasticsearch)

* elasticsearch.yml for configuring Elasticsearch
* jvm.options for configuring Elasticsearch JVM settings
* log4j2.properties for configuring Elasticsearch logging


### Fix master_not_discovered_exception

* Purge and reinstall WITHOUT config

### Fix discovery startup error

```text
avril 20 17:37:07 tourny elasticsearch[10763]: ERROR: [1] bootstrap checks failed
avril 20 17:37:07 tourny elasticsearch[10763]: [1]: the default discovery settings are unsuitable for production use; at least one of [discovery.seed_hosts, discovery.se
```

* `sudoedit /etc/elasticsearch/elasticsearch.yml`
```text
node.data : true
network.host : 0.0.0.0
discovery.seed_hosts : []
cluster.initial_master_nodes : []
```
