{{/*
Expand the name of the chart.
*/}}
{{- define "searxng.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "searxng.fullname" -}}
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
{{- define "searxng.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "searxng.labels" -}}
helm.sh/chart: {{ include "searxng.chart" . }}
{{ include "searxng.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "searxng.selectorLabels" -}}
app.kubernetes.io/name: {{ include "searxng.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "searxng.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "searxng.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Return the proper image name
*/}}
{{- define "searxng.image" -}}
{{- $tag := .Values.image.tag | default .Chart.AppVersion -}}
{{- printf "%s:%s" .Values.image.repository $tag }}
{{- end }}

{{/*
Generate secret key for SearXNG
*/}}
{{- define "searxng.secretKey" -}}
{{- if .Values.secret.create }}
{{- .Values.secret.secretKey }}
{{- else }}
{{- .Values.secret.secretKey }}
{{- end }}
{{- end }}

{{/*
Get secret name for SearXNG
*/}}
{{- define "searxng.secretName" -}}
{{- if .Values.secret.create }}
{{- printf "%s-secret" (include "searxng.fullname" .) }}
{{- else }}
{{- .Values.secret.existingSecret }}
{{- end }}
{{- end }}

{{/*
Valkey connection URL
*/}}
{{- define "searxng.valkeyUrl" -}}
{{- if .Values.valkey.enabled }}
{{- printf "valkey://%s-valkey:6379/0" (include "searxng.fullname" .) }}
{{- else }}
{{- printf "false" }}
{{- end }}
{{- end }}

{{/*
Merge default SearXNG config with extra config from values
Returns the merged YAML as a string
*/}}
{{- define "searxng.mergedConfig" -}}
{{- $defaultConfig := dict
  "general" (dict
    "debug" false
    "instance_name" .Values.config.general.instance_name
    "enable_metrics" .Values.config.general.enable_metrics
  )
  "brand" (dict
    "new_issue_url" "https://github.com/searxng/searxng/issues/new"
    "docs_url" "https://docs.searxng.org/"
    "public_instances" "https://searx.space"
    "wiki_url" "https://github.com/searxng/searxng/wiki"
  )
  "search" (dict
    "safe_search" .Values.config.search.safe_search
    "autocomplete" .Values.config.search.autocomplete
    "ban_time_on_fail" .Values.config.search.ban_time_on_fail
    "max_ban_time_on_fail" .Values.config.search.max_ban_time_on_fail
    "formats" (list "html")
  )
  "server" (dict
    "port" 8080
    "bind_address" "0.0.0.0"
    "base_url" .Values.config.server.base_url
    "limiter" .Values.valkey.enabled
    "public_instance" .Values.config.server.public_instance
    "image_proxy" .Values.config.server.image_proxy
    "method" .Values.config.server.method
  )
  "valkey" (dict
    "url" (include "searxng.valkeyUrl" .)
  )
  "ui" (dict
    "default_theme" .Values.config.ui.default_theme
    "center_alignment" .Values.config.ui.center_alignment
    "infinite_scroll" .Values.config.ui.infinite_scroll
    "query_in_title" .Values.config.ui.query_in_title
    "default_locale" .Values.config.ui.default_locale
  )
  "outgoing" (dict
    "request_timeout" 3.0
    "useragent_suffix" ""
    "pool_connections" 100
    "pool_maxsize" 20
    "enable_http2" true
  )
  "doi_resolvers" (dict
    "oadoi.org" "https://oadoi.org/"
    "doi.org" "https://doi.org/"
  )
  "default_doi_resolver" "oadoi.org"
  "engines" (list
    (dict
      "name" "duckduckgo"
      "engine" "duckduckgo"
      "shortcut" "ddg"
      "disabled" (index .Values.config.engines 0 | default dict).disabled | default false
    )
    (dict
      "name" "google"
      "engine" "google"
      "shortcut" "go"
      "disabled" (index .Values.config.engines 1 | default dict).disabled | default false
    )
    (dict
      "name" "wikipedia"
      "engine" "wikipedia"
      "shortcut" "wp"
      "display_type" (list "infobox")
      "disabled" (index .Values.config.engines 2 | default dict).disabled | default false
    )
    (dict
      "name" "github"
      "engine" "github"
      "shortcut" "gh"
      "disabled" (index .Values.config.engines 3 | default dict).disabled | default false
    )
    (dict
      "name" "stackoverflow"
      "engine" "stackexchange"
      "shortcut" "st"
      "api_site" "stackoverflow"
      "categories" (list "it" "q&a")
      "disabled" (index .Values.config.engines 4 | default dict).disabled | default false
    )
  )
}}
{{- /* Add open_metrics if defined */ -}}
{{- if .Values.config.general.open_metrics }}
{{- $_ := set $defaultConfig.general "open_metrics" .Values.config.general.open_metrics }}
{{- end }}
{{- /* Merge with extra config */ -}}
{{- $merged := mergeOverwrite $defaultConfig .Values.extraConfig }}
{{- $merged | toYaml }}
{{- end }}

