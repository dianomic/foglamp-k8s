# Setup FogLAMP Manage and FogLAMP in Kubernetes

Documentation for setting up FogLAMP Manage and FogLAMP in the Kubernetes environment.

- [Kubernetes setup](./setup-k8s/README.md)
- [FogLAMP Manage and FogLAMP setup in Kubernetes](./setup-k8s-foglamp-fogman/README.md)
- [Debugging](./debugging-k8s-foglamp-fogman/README.md)


## TODO tasks

- [X] Setup Kubernetes with insecure docker registry
- [X] Use secrets for storing passwords
- [X] Use persistent volumes
- [X] Setup multi-node cluster
- [X] Check FogLAMP with postgres in Kubernetes environment
- [X] Check networking setup with NodePort/LoadBalancer(Local Machine).
- [ ] Check external Cloud Control Managers(CCM) for aws/gcp etc.
- [ ] Setup of Kubernetes with Dockerfile/s


## Known Issues
Following issues will occur if running default k3s installation on ec2 instances.
- FogLAMP Manage login failing because authentication page opens on port 5002 whereas 5002 is in Kubernetes environment is mapped to different port.
- Not able to directly expose 5000, 5001 and 5002 ports of FogLAMP Manage, instead we have to use internally assigned ports for accessing GUI.