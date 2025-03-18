{{/*
Expand the name of the chart.
*/}}
{{- define "shipy.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "shipy.fullname" -}}
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
{{- define "shipy.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "shipy.labels" -}}
helm.sh/chart: {{ include "shipy.chart" . }}
app.kubernetes.io/name: {{ include "shipy.name" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Web App Selector labels
*/}}
{{- define "shipy.webapp.selectorLabels" -}}
app.kubernetes.io/name: {{ .Release.Name | cat "webapp-" | nospace }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/version: {{ .Values.webapp.image.tag | default .Chart.AppVersion | quote }}
{{- end }}

{{/*
customerapi Selector labels
*/}}
{{- define "shipy.customerapi.selectorLabels" -}}
app.kubernetes.io/name: {{ .Release.Name | cat "customerapi-" | nospace }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/version: {{ .Values.webapp.image.tag | default .Chart.AppVersion | quote }}
{{- end }}

{{/*
shipapi Selector labels
*/}}
{{- define "shipy.shipapi.selectorLabels" -}}
app.kubernetes.io/name: {{ .Release.Name | cat "shipapi-" | nospace }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/version: {{ .Values.webapp.image.tag | default .Chart.AppVersion | quote }}
{{- end }}

{{/*
workshopapi Selector labels
*/}}
{{- define "shipy.workshopapi.selectorLabels" -}}
app.kubernetes.io/name: {{ .Release.Name | cat "workshopapi-" | nospace }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/version: {{ .Values.webapp.image.tag | default .Chart.AppVersion | quote }}
{{- end }}

{{/*
workshopeventhandler Selector labels
*/}}
{{- define "shipy.workshopeventhandler.selectorLabels" -}}
app.kubernetes.io/name: {{ .Release.Name | cat "workshopeventhandler-" | nospace }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/version: {{ .Values.webapp.image.tag | default .Chart.AppVersion | quote }}
{{- end }}

{{/*
eventlogservice Selector labels
*/}}
{{- define "shipy.eventlogservice.selectorLabels" -}}
app.kubernetes.io/name: {{ .Release.Name | cat "eventlogservice-" | nospace }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/version: {{ .Values.webapp.image.tag | default .Chart.AppVersion | quote }}
{{- end }}

{{/*
invoiceservice Selector labels
*/}}
{{- define "shipy.invoiceservice.selectorLabels" -}}
app.kubernetes.io/name: {{ .Release.Name | cat "invoiceservice-" | nospace }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/version: {{ .Values.webapp.image.tag | default .Chart.AppVersion | quote }}
{{- end }}

{{/*
notificationservice Selector labels
*/}}
{{- define "shipy.notificationservice.selectorLabels" -}}
app.kubernetes.io/name: {{ .Release.Name | cat "notificationservice-" | nospace }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/version: {{ .Values.webapp.image.tag | default .Chart.AppVersion | quote }}
{{- end }}

{{ define "render-value" }}
  {{- if kindIs "string" .value }}
    {{- tpl .value .context }}
  {{- else }}
    {{- tpl (.value | toYaml) .context }}     
  {{- end }}
{{- end }}