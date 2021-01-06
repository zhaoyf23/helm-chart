#!/bin/bash
cd /root/tmf/helm
rm -rf global-config-0.1.0.tgz
helm package global-config
rm -rf /root/helm/helm-chart/global-config-*.tgz
cd /root/helm/helm-chart/
git checkout gh-pages
mv /root/tmf/helm/global-config-*.tgz .
rm -rf index.yaml
helm repo index --url https://zhaoyf23.github.io/helm-chart/ --merge index.yaml .
git add --all . && git commit -m "automatic commit" && git push
helm repo update
helm fetch helmchart/global-config
