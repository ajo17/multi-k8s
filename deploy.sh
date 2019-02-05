docker build -t arunjose/multi-docker-frontend:latest -t arunjose/multi-docker-frontend:$SHA ./client/Dockerfile ./client
docker build -t arunjose/multi-docker-backend:latest -t arunjose/multi-docker-backend:$SHA ./server/Dockerfile ./server
docker build -t arunjose/multi-docker-worker:latest -t arunjose/multi-docker-worker:$SHA ./worker/Dockerfile ./worker
docker push arunjose/multi-docker-frontend:latest
docker push arunjose/multi-docker-backend:latest
docker push arunjose/multi-docker-worker:latest
docker push arunjose/multi-docker-frontend:$SHA
docker push arunjose/multi-docker-backend:$SHA
docker push arunjose/multi-docker-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/backend-deployment backend=backend-arunjose/multi-docker-backend:$SHA
kubectl set image deployments/frontend-deployment frontend=frontend-arunjose/multi-docker-frontend:$SHA
kubectl set image deployments/worker-deployment worker=arunjose/multi-docker-worker:$SHA