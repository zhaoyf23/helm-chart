#!/bin/bash

# Define dynamic parameters for local path and remote chart repository.
helm_path=/root/tmf/helm-chart
chart_path=/root/helm/helm-chart
chart_repo=https://zhaoyf23.github.io/helm-chart/

function check() {
# Go into helm chart directory.
    cd $helm_path
# check if $@ directory exists, return if not exists.
    if [ ! -d $@ ]; then
        echo "warning: "$@ not exists, continue for scanning other directory...
        exit;
    fi
# Delete old chart
    rm -rf $@-*.tgz
}

function source_commit() {
# Go into helm chart directory.
    cd $helm_path
# Git checkout main branch.
    git checkout main
# Commit current directory to main branch.
    git add --all . && git commit -m "automatic commit for $@ by build.sh at `date`" && git push
}

function chart_pack() {
# Go into helm chart directory.
    cd $helm_path
# Packages a chart into a versioned chart archive file.
    helm package $@
# Go into helm chart archive file directory, delete old cart archive file.
    cd $chart_path && rm -rf $@-*.tgz
# Git checkout branch of chart repository.
    git checkout gh-pages
    mv $helm_path/$@-*.tgz .
}

function chart_commit() {
# Go into helm chart archive file directory, delete old index.yaml file.
    cd $chart_path && rm -rf index.yaml
# Read the current directory and generate an index file based on the charts found.
    helm repo index --url $chart_repo --merge index.yaml .
# Commit current directory to branch of chart repository.
    git add --all . && git commit -m "automatic commit for $@ by build.sh at `date`" && git push
}

for arg in $*
do
    check $arg
    source_commit $arg
    chart_pack $arg
    chart_commit $arg
done
    helm repo update
    echo "Complete!"
