{{/*
Expand the name of the chart.
*/}}
{{- define "custc-service-core-r92.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "custc-service-core-r92.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "custc-service-core-r92.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "custc-service-core-r92.labels" -}}
helm.sh/chart: {{ include "custc-service-core-r92.chart" . }}
{{ include "custc-service-core-r92.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "custc-service-core-r92.selectorLabels" -}}
app.kubernetes.io/name: {{ include "custc-service-core-r92.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
zcm-app: {{ include "custc-service-core-r92.name" . }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "custc-service-core-r92.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "custc-service-core-r92.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}