
## Debugging commands

- List all the images downloaded 
    > sudo crictl image ls

- Describe commands with verbose output 
    > sudo kubectl describe pods fogman-pod
    
    > sudo kubectl describe nodes my-node

- Get a shell to the running container
    > sudo kubectl exec --stdin --tty foglamp-pod -- /bin/bash

- Dry run the changes of a yaml file
    > sudo kubectl apply -f fogman.yaml --dry-run=client

- Get commands with basic output
    > sudo kubectl get service

    > sudo kubectl get nodes -o wide
    
    > sudo kubectl get pods -o wide

- Dump pod container logs (stdout, multi-container case)
    > sudo kubectl logs fogman-pod -c fogman

- Delete pod
    > sudo kubectl delete pod fogman-pod

Reference:

- https://kubernetes.io/docs/tasks/debug/debug-application/