## Deployment

Note: Kubernetes must be setup and running before performing the following the steps. Documentations for setup of k8s can be found at docs/setup-k8s.

Get the manifest files of both FogLAMP Manage and FogLAMP from https://github.com/nerdapplabs/k8s.git

Following commands will create resources mentioned in yaml file of fogman and foglamp

### FogLAMP

Create persistent volume
> sudo kubectl apply -f foglamp-pvc.yaml

Create network services
> sudo kubectl apply -f foglamp-service.yaml

Create FogLAMP resources
> sudo kubectl apply -f foglamp.yaml

### FogLAMP Manage

Create secrets
> sudo kubectl apply -f fogman-secret.yaml

Create persistent volume
> sudo kubectl apply -f fogman-pvc.yaml

Create network services
> sudo kubectl apply -f fogman-service.yaml

Create FogLAMP Manage resources
> sudo kubectl apply -f fogman.yaml


## Checking deployments

- Get all deployments
  > sudo kubectl get deployments

    Sample Output:
    ```
    ubuntu@ip:~$ sudo kubectl get deployments
    NAME                 READY   UP-TO-DATE   AVAILABLE   AGE
    foglamp-deployment   1/1     1            1           22h
    fogman-deployment    1/1     1            1           22h
    ubuntu@ip:~$ 
    ```

- Get all pods
  > sudo kubectl get pods

    Sample Output:
    ```
    ubuntu@ip:~$ sudo kubectl get pods
    NAME                                  READY   STATUS    RESTARTS   AGE
    foglamp-deployment-596997d767-fkdnt   1/1     Running   0          22h
    fogman-deployment-5bc5f795b8-cmf8t    2/2     Running   0          22h
    ubuntu@ip:~$ 
    ```

- Get all services
  > sudo kubectl get services

    Sample Output:
    ```
    ubuntu@ip:~$ sudo kubectl get services
    NAME             TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)                                        AGE
    kubernetes       ClusterIP   10.43.0.1       <none>        443/TCP                                        32d
    foglamp          NodePort    10.43.9.55      <none>        8081:31924/TCP,1995:31770/TCP,80:31217/TCP     22h
    foglamp-manage   NodePort    10.43.212.235   <none>        5000:31294/TCP,5001:31749/TCP,5002:30197/TCP   22h
    ubuntu@ip:~$ 
    ```

- Get all persistent volumes
  > sudo kubectl get pv

    Sample Output:
    ```
    ubuntu@ip:~$ sudo kubectl get pv
    NAME                                       CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS        CLAIM                         STORAGECLASS   REASON   AGE
    pvc-32518fec-f8d3-4745-9b28-d240375afbb6   10Gi       RWO            Delete           Terminating   default/foglamp-data          local-path              29d
    pvc-78414feb-6bf8-4570-8666-69a7009285fa   10Gi       RWO            Delete           Bound         portainer/portainer           local-path              21d
    pvc-bdb5b2b9-d8fc-43e2-9953-db733f988439   10Gi       RWO            Delete           Bound         default/foglamp-manage-db     local-path              22h
    pvc-7aaf17bf-3a68-44d1-b3da-15fd81203b64   10Gi       RWO            Delete           Bound         default/foglamp-manage-data   local-path              22h
    ubuntu@ip:~$ 
    ```







