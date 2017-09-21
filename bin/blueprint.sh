#! /bin/bash

SLUG=$1
uuid=$(ruby -rpuuid -e "puts PUUID::UUIDSlug.slug2uuid '$SLUG'")
curl "https://zuul.everydayhero.io/peter/api/v1/blueprints/$uuid" | jq .
