#!/bin/bash

function chart_pack() {
# Go into helm chart directory.
    cd /root/tmf/helm
# check if $@ directory exists, return if not exists
    if [ ! -d $@ ]; then
        echo "warning: "$@ not exists, continue for scanning other directory...
        return;
    fi
# Delete old chart
    rm -rf $@-*.tgz
# Packages a chart into a versioned chart archive file.
    helm package $@
# Go into helm chart archive file directory, delete old cart archive file.
    cd /root/helm/helm-chart && rm -rf $@-*.tgz
# Git checkout branch of chart repository.
    git checkout gh-pages
    mv /root/tmf/helm/$@-*.tgz .
}

function chart_commit() {
# Go into helm chart directory.
    cd /root/tmf/helm
# check if $@ directory exists, return if not exists
    if [ ! -d $@ ]; then
        echo "warning: "$@ not exists, continue for scanning other directory...
        return;
    fi
# Go into helm chart archive file directory, delete old index.yaml file.
    cd /root/helm/helm-chart && rm -rf index.yaml
# Read the current directory and generate an index file based on the charts found.
    helm repo index --url https://zhaoyf23.github.io/helm-chart/ --merge index.yaml .
# Commit current directory to branch of chart repository.
    git add --all . && git commit -m "automatic commit for $@ by build.sh at `date`" && git push
}

for arg in $*
do
  chart_pack $arg
  chart_commit $arg
done
helm repo update
echo "Complete!"