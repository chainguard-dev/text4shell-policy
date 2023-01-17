# Text4Shell Demo
This demo shows how you can use Sigstore to validate your signed SBOMs against text4shell policies in Kubernetes or on the command line

## Option 1: Check if your remote OCI image is affected using cue with cosign 2.0
```
cosign verify-attestation --policy policy/text4shell.cue --type https://cyclonedx.org/bom --certificate-identity-regexp=.* --certificate-oidc-issuer-regexp=.* ghcr.io/chainguard-dev/text4shell-policy:main
```

## Option 2: Check using Enforce for Kubernetes with image built from this repo
```
chainctl policies create --group $DEMO_GROUP -f policy/text4shell-policy.yaml
kubectl label ns default policy.sigstore.dev/include=true --overwrite
kubectl run text4shell --image=ghcr.io/chainguard-dev/text4shell-policy:main
```
![text4shell diagnostic](https://user-images.githubusercontent.com/9351962/196332575-2ac25720-0262-4768-8854-615fb6f3c686.png)

### Clean Up
```
kubectl delete pod text4shell --grace-period=0
chainctl policy delete -y $(chainctl policy list -o json | jq -r '[.items[] | select(.name == "vuln-cve-2022-42889-text4shell")][0].id')
kubectl label ns default policy.sigstore.dev/include-
```
