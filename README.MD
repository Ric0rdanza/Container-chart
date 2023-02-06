# Deploying this chart to GKE

A demo of this deployment is at `34.78.68.26`, set your hosts with hostname `my.container.local` to this IP address. Use `https://my.container.local` to access the website.

This README.MD is a guide to deploy this chart to GKE. The repository is at https://github.com/Ric0rdanza/Container-chart.

## Prerequisites

1. Install `cert-manager` in the Cluster

2. Trust `ca.crt` in your operating system

### Docker Settings

1. Create three docker hub repositories for the three images, `auth`, `main`, and `nginx`.
2. Build and push the images to the repositories. If you are using a ARM64 machine, you have to use buildx with specified architecture to build the images.
3. Update the `values.yaml` file with the new image names.
4. Update the `deployment.yaml` file with the new image names.

### Helm Chart Settings
1. Use command `helm dependency update containerization/` to update the dependencies.
2. Use command `helm package containerization/` to package the chart.
3. Use command `helm repo index . --url https://ric0rdanza.github.io/Container-chart/` to update the index file.
4. `git commit` and `git push` the changes.
5. The chart will be available at https://ric0rdanza.github.io/Container-chart/

## Installing the Chart

Use `helm install --repo https://ric0rdanza.github.io/Container-chart/ <chart-name> containerization` to install the chart.

## Uninstalling the Chart

Use `helm uninstall <chart-name>` to uninstall the chart.

## Configuration

1. Because the in-cluster IP address in this chart is statically set, you must reset all the IP addresses to fit in the range of the cluster. in both the `values.yaml` and `networkpolicy.yaml` files.
2. To scale up or down the number of replicas, change the `replicaCount` in the `values.yaml` file. Then use command `helm upgrade -i --repo https://ric0rdanza.github.io/Container-chart/ <chart-name> containerization` to upgrade the chart. The default is set to 1, and Autoscaling is implemented.
3. If only change images, use command `kubectl set image deployment/<deployment-name> <container-name>=<image-name>` to update the image. `kubectl rollout restart deployment/<deployment-name>` also works because the image pull policy is set to `Always`.

## Network Policy
1. For pods running database, auth and main, only allow traffic within pods pools, deny all other traffic.
2. For pods running nginx, allow all traffic from inside and outside the cluster.
## Horizontal Pod Autoscaler
1. Default replica count is 1, and the maximum is 3.
2. The CPU utilization is set to 80% in three sub charts, database, auth and main. The CPU utilization set to 20% in main chart.


