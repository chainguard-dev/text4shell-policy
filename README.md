# Text4Shell Demo
This demo shows how you can use Sigstore to validate your signed SBOMs against text4shell policies in Kubernetes or on the command line

## Option 1: Check if your remote OCI image is affected using cue
cosign verify-attestation --policy policy/text4shell.cue --type https://cyclonedx.org/schema ghcr.io/chainguard-dev/text4shell-policy:main@sha256:98b9a03b479ea567b2fbed8ffb0d46bb908425c9ea66f162bd026ce2ea1c403f

## Option 2: Check your SBOM against with a local cue
cosign verify-attestation --type https://cyclonedx.org/schema ghcr.io/chainguard-dev/text4shell-policy:main@sha256:98b9a03b479ea567b2fbed8ffb0d46bb908425c9ea66f162bd026ce2ea1c403f | jq -r .payload | base64 -d | jq > sbom.json
cue vet policy/text4shell.cue sbom.json

## Option 3: Check using Enforce for Kubernetes with image built from this repo
chainctl policies create --group $DEMO_GROUP -f policy/text4shell-policy.yaml
kubectl label ns default policy.sigstore.dev/include=true --overwrite
kubectl run text4shell --image=ghcr.io/chainguard-dev/text4shell-policy:main@sha256:98b9a03b479ea567b2fbed8ffb0d46bb908425c9ea66f162bd026ce2ea1c403f

### Clean Up
kubectl delete pod text4shell --grace-period=0
chainctl policy delete -y $(chainctl policy list -o json | jq -r '[.items[] | select(.name == "vuln-cve-2022-42889-text4shell")][0].id')
kubectl label ns default policy.sigstore.dev/include-

