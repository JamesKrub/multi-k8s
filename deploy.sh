docker build -t wanadjanan/multi-client:latest -t wanadjanan/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t wanadjanan/multi-server:latest -t wanadjanan/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t wanadjanan/multi-worker:latest -t wanadjanan/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push wanadjanan/multi-client:latest
docker push wanadjanan/multi-server:latest
docker push wanadjanan/multi-worker:latest

docker push wanadjanan/multi-client:$SHA
docker push wanadjanan/multi-server:$SHA
docker push wanadjanan/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployment/server-deployment server=wanadjanan/multi-server:$SHA
kubectl set image deployment/client-deployment client=wanadjanan/multi-client:$SHA
kubectl set image deployment/worker-deployment worker=wanadjanan/multi-worker:$SHA