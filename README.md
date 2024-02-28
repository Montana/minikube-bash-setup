# minikube-bash-setup
So I don't have to manually set it up on new instances or VM's. 

## Usage

Run after you've ran `minikube.sh`: 

```bash
kubectl port-forward deployment/nginx-deployment 8080:80
```
To try out the `nginx` deployment deployment file. 
