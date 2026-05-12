{{- define "couple-games.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end }}

{{- define "couple-games.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end }}

{{- define "couple-games.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end }}

{{- define "couple-games.labels" -}}
helm.sh/chart: {{ include "couple-games.chart" . }}
{{ include "couple-games.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{- define "couple-games.selectorLabels" -}}
app.kubernetes.io/name: {{ include "couple-games.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{- define "couple-games.mysqlPvcName" -}}
{{- printf "%s-mysql" (include "couple-games.fullname" .) -}}
{{- end }}

{{- define "couple-games.appdataPvcName" -}}
{{- printf "%s-appdata" (include "couple-games.fullname" .) -}}
{{- end }}

{{- define "couple-games.configMapName" -}}
{{- printf "%s-app-config" (include "couple-games.fullname" .) -}}
{{- end }}

{{- define "couple-games.redisHost" -}}
{{- if .Values.redis.host -}}
{{- .Values.redis.host -}}
{{- else -}}
{{- printf "%s-%s" .Values.redis.bitnami.releaseName .Values.redis.bitnami.primaryServiceSuffix -}}
{{- end -}}
{{- end }}

{{- define "couple-games.redisUrl" -}}
{{- $host := include "couple-games.redisHost" . -}}
{{- $port := .Values.redis.port | toString -}}
{{- if .Values.redis.password -}}
redis://:{{ .Values.redis.password }}@{{ $host }}:{{ $port }}
{{- else -}}
redis://{{ $host }}:{{ $port }}
{{- end -}}
{{- end }}

{{- define "couple-games.mysqlSelectorLabels" -}}
app: db
{{ include "couple-games.selectorLabels" . }}
{{- end }}

{{- define "couple-games.backendSelectorLabels" -}}
app: backend
{{ include "couple-games.selectorLabels" . }}
{{- end }}

{{- define "couple-games.clientSelectorLabels" -}}
app: client
{{ include "couple-games.selectorLabels" . }}
{{- end }}
