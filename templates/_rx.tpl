{{/* Remove all matches of a regular expression from a string */}}
{{- define "rx.removeAll" }}
  {{- if not (and (kindIs "slice" .) (eq 2 (len .))) }}
    {{- fail "Usage: rx.removeAll REGEX STRING" }}
  {{- end }}
  {{- $regex := first . }}
  {{- $string := last . }}
  {{- mustRegexReplaceAll $regex $string "" }}
{{- end }}

{{/* Trim a regex prefix from a string */}}
{{- define "rx.trimPrefix" -}}
  {{- if not (and (kindIs "slice" .) (eq 2 (len .))) }}
    {{- fail "Usage: rx.trimPrefix REGEX STRING" }}
  {{- end }}
  {{- $regex := first . }}
  {{- $string := last . }}
  {{- mustRegexReplaceAll (printf "^(?:%s)" (trimPrefix "^" $regex)) $string "" }}
{{- end -}}

{{/* Trim a regex suffix from a string */}}
{{- define "rx.trimSuffix" -}}
  {{- if not (and (kindIs "slice" .) (eq 2 (len .))) }}
    {{- fail "Usage: rx.trimSuffix REGEX STRING" }}
  {{- end }}
  {{- $regex := first . }}
  {{- $string := last . }}
  {{- mustRegexReplaceAll (printf "(?:%s)$" (trimSuffix "$" $regex)) $string "" }}
{{- end -}}
