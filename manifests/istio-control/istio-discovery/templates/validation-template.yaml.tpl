{{ define "validatingwebhookconfiguration.yaml.tpl" }}
{{- if .Values.global.istiod.enabled }}
apiVersion: admissionregistration.k8s.io/v1beta1
kind: ValidatingWebhookConfiguration
metadata:
  name: istiod-{{ .Release.Namespace }}
  namespace: {{ .Release.Namespace }}
  labels:
    app: istiod
    release: {{ .Release.Name }}
    istio: istiod
webhooks:
  - name: validation.istio.io
    clientConfig:
      service:
        name: istio-pilot{{ .Values.version }}
        namespace: {{ .Release.Namespace }}
        path: "/validate"
        port: 443
      caBundle: ""
    rules:
      - operations:
        - CREATE
        - UPDATE
        apiGroups:
        - config.istio.io
        - rbac.istio.io
        - security.istio.io
        - authentication.istio.io
        - networking.istio.io
        apiVersions:
        - "*"
        resources:
        - "*"
    failurePolicy: Fail
    sideEffects: None
{{- else }}
apiVersion: admissionregistration.k8s.io/v1beta1
kind: ValidatingWebhookConfiguration
metadata:
  name: istiod-{{ .Release.Namespace }}
  namespace: {{ .Release.Namespace }}
  labels:
    app: istiod
    release: {{ .Release.Name }}
    istio: istiod
webhooks:
{{- end }}
---
{{ end }}
