#! /bin/bash

source env.vars

rm -rf ../cluster/base/cluster-settings.yaml
envsubst < ../tmpl/cluster-settings.yaml > ../cluster/base/cluster-settings.yaml