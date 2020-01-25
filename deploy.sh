docker build -t artempv/upday-test .
docker push artempv/upday-test
helm upgrade --install --debug upday-test helm/upday-test