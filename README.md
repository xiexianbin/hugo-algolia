hugo-algolia
--

a tools sync hugo json index to algolia.

## how to build

```
go build hugo-algolia.go
```

## how to config

create a `algolia.yaml` file, like:

```
---
app_id: "<app id>"
admin_key: "<admin key>"
index_name: "<index name>"
index_file: "./public/algolia.json"
```

note:

- app_id: app id
- admin_key: admin key
- index_name: index name
- index_file: json file path


## how to use

```
./hugo-algolia algolia.yaml
```
