#!/bin/bash
cd /root/tmf/helm
rm -rf apig-api-uportal-0.1.0.tgz
helm package apig-api-uportal
rm -rf /root/helm/helm-chart/apig-api-uportal-*.tgz
cd /root/helm/helm-chart/
git checkout gh-pages
mv /root/tmf/helm/apig-api-uportal-*.tgz .
rm -rf index.yaml
helm repo index --url https://zhaoyf23.github.io/helm-chart/ --merge index.yaml .
git add --all . && git commit -m "automatic commit" && git push
helm repo update
helm fetch helmchart/apig-api-uportal
