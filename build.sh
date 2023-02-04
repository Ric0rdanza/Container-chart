docker buildx build --platform linux/amd64,linux/arm64 --push -t odonataprime/auth:gke backend/auth/

docker buildx build --platform linux/amd64,linux/arm64 --push -t odonataprime/shortener:gke backend/main/

docker buildx build --platform linux/amd64,linux/arm64 --push -t odonataprime/server:gke server



helm dependency update containerization/

helm package containerization/

helm repo index . --url https://ric0rdanza.github.io/Container-chart/