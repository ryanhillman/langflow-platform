{{- define "langflow-platform.name" -}}
langflow-platform
{{- end -}}

{{- define "langflow-platform.fullname" -}}
{{ include "langflow-platform.name" . }}
{{- end -}}
