{{/*
Expand the name of the chart.
*/}}
{{- define "apig-api-uportal.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "apig-api-uportal.fullname" -}}
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
{{- define "apig-api-uportal.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "apig-api-uportal.labels" -}}
helm.sh/chart: {{ include "apig-api-uportal.chart" . }}
{{ include "apig-api-uportal.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "apig-api-uportal.selectorLabels" -}}
app.kubernetes.io/name: {{ include "apig-api-uportal.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
zcm-app: {{ include "apig-api-uportal.name" . }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "apig-api-uportal.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "apig-api-uportal.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}