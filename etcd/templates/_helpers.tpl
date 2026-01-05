{{/*
Expand the name of the chart.
*/}}
{{- define "etcd.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "etcd.fullname" -}}
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
{{- define "etcd.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "etcd.labels" -}}
helm.sh/chart: {{ include "etcd.chart" . }}
{{ include "etcd.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "etcd.selectorLabels" -}}
app.kubernetes.io/name: {{ include "etcd.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "etcd.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "etcd.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Return the proper image name
*/}}
{{- define "etcd.image" -}}
{{- $tag := .Values.image.tag | default .Chart.AppVersion -}}
{{- printf "%s/%s:%s" .Values.image.registry .Values.image.repository $tag }}
{{- end }}

{{/*
Return the protocol for client connections (http or https)
*/}}
{{- define "etcd.clientProtocol" -}}
{{- if .Values.tls.enabled -}}
https
{{- else -}}
http
{{- end -}}
{{- end }}

{{/*
Return the protocol for peer connections (http or https)
*/}}
{{- define "etcd.peerProtocol" -}}
{{- if .Values.tls.enabled -}}
https
{{- else -}}
http
{{- end -}}
{{- end }}

{{/*
Generate the initial cluster string for etcd
Example output: etcd-0=http://etcd-0.etcd-headless:2380,etcd-1=http://etcd-1.etcd-headless:2380,etcd-2=http://etcd-2.etcd-headless:2380
*/}}
{{- define "etcd.initialCluster" -}}
{{- $fullname := include "etcd.fullname" . -}}
{{- $protocol := include "etcd.peerProtocol" . -}}
{{- $replicaCount := int .Values.replicaCount -}}
{{- $peers := list -}}
{{- range $i := until $replicaCount -}}
{{- $peers = append $peers (printf "%s-%d=%s://%s-%d.%s-headless:2380" $fullname $i $protocol $fullname $i $fullname) -}}
{{- end -}}
{{- join "," $peers -}}
{{- end }}

{{/*
Generate client URL for a specific pod
*/}}
{{- define "etcd.clientUrl" -}}
{{- $protocol := include "etcd.clientProtocol" . -}}
{{- $fullname := include "etcd.fullname" . -}}
{{- printf "%s://$(ETCD_NAME).%s-headless:2379" $protocol $fullname -}}
{{- end }}

{{/*
Generate peer URL for a specific pod
*/}}
{{- define "etcd.peerUrl" -}}
{{- $protocol := include "etcd.peerProtocol" . -}}
{{- $fullname := include "etcd.fullname" . -}}
{{- printf "%s://$(ETCD_NAME).%s-headless:2380" $protocol $fullname -}}
{{- end }}

{{/*
Generate all client endpoints for the cluster
*/}}
{{- define "etcd.clientEndpoints" -}}
{{- $fullname := include "etcd.fullname" . -}}
{{- $protocol := include "etcd.clientProtocol" . -}}
{{- $replicaCount := int .Values.replicaCount -}}
{{- $endpoints := list -}}
{{- range $i := until $replicaCount -}}
{{- $endpoints = append $endpoints (printf "%s://%s-%d.%s-headless:2379" $protocol $fullname $i $fullname) -}}
{{- end -}}
{{- join "," $endpoints -}}
{{- end }}
