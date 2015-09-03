# Zen Writer #

## Running specs ##

1. Start an instance of ElasticSearch. (Installation instructions can be found under "Dependencies".)

```bash
$ elasticsearch --config=/usr/local/opt/elasticsearch/config/elasticsearch.yml
```

2. Run `guard`, which will watch for changes within the `/specs` directory and run any updated tests. Hitting "Enter" on the command line will execute all specs.

```
$ guard
```

## Dependencies ##

### ElasticSearch ###

> Credit to [SitePoint](http://www.sitepoint.com/full-text-search-rails-elasticsearch/) for these easy-to-follow installation directions.

#### Ubuntu ####
Go to [elasticsearch.org/download](//elasticsearch.org/download) and download the DEB file. Once the file is local, type:
```bash
$ sudo dpkg -i elasticsearch-[version].deb
```

#### Mac OSX ####
If you’re on a Mac, Homebrew makes it easy:
```
$ brew install elasticsearch
```

#### Validate Installation ####
Open this url: [http://localhost:9200](http://localhost:9200) and you’ll see ElasticSearch respond like so:

```json
{
  "status" : 200,
  "name" : "Anvil",
  "version" : {
    "number" : "1.2.1",
    "build_hash" : "6c95b759f9e7ef0f8e17f77d850da43ce8a4b364",
    "build_timestamp" : "2014-06-03T15:02:52Z",
    "build_snapshot" : false,
    "lucene_version" : "4.8"
  },
  "tagline" : "You Know, for Search"
}
```

## Style Guide ##

https://github.com/bbatsov/ruby-style-guide