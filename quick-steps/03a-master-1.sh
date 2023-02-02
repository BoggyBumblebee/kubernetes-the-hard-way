{
echo ++++++++++++++++++++++++++++++++++++++++++++++++

wget https://storage.googleapis.com/kubernetes-release/release/v1.24.3/bin/linux/amd64/kubectl
chmod +x kubectl
sudo mv kubectl /usr/local/bin/

kubectl version -o yaml

echo ++++++++++++++++++++++++++++++++++++++++++++++++
}

