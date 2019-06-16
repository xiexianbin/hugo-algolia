package main

import (
	"fmt"
	"io/ioutil"
	"log"
	"os"

	"github.com/algolia/algoliasearch-client-go/algoliasearch"
	"gopkg.in/yaml.v2"
)

type Config struct {
	AppId     string `yaml:"app_id"`
	AdminKey  string `yaml:"admin_key"`
	IndexName string `yaml:"index_name"`
	IndexFile string `yaml:"index_file"`
}

func Sync2Algolia() {
	client := algoliasearch.NewClient(cfg.AppId, cfg.AdminKey)
	index := client.InitIndex(cfg.IndexName)

	content, _ := ioutil.ReadFile(cfg.IndexFile)

	var objects []algoliasearch.Object
	if err := yaml.Unmarshal(content, &objects); err != nil {
		fmt.Println(err)
		return
	}

	res, err := index.AddObjects(objects)
	if err != nil {
		fmt.Println("Sync to algolia failed:", err)
	} else {
		fmt.Println("Task id:", res.TaskID)
		fmt.Println("Object IDs:", res.ObjectIDs)
		fmt.Println("Sync to algolia Success.")
	}
}

var cfg Config

func main() {
	if len(os.Args) < 2 {
		println("Usage: ./hugo-algolia <ConfigFile>\n")
		return
	}

	_cfg, err := ioutil.ReadFile(os.Args[1])
	if err != nil {
		log.Println("Read config file failed:", err)
		return
	}

	err = yaml.Unmarshal(_cfg, &cfg)
	if err != nil {
		log.Println("Unmarshal config failed:", err)
		return
	} else {
		Sync2Algolia()
	}
}
