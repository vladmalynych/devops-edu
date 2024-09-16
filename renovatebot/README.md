# RenovateBot - ArgoCD applications update

### Install renovate bot
1. Create GH token
2. Configure helm values
3.  Install helm
```commandline
helm install renovatebot  --namespace renovatebot --create-namespace --values helm/values.yaml renovate/renovate
```
