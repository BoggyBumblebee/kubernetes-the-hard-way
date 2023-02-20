cat >> ~/.bash_profile <<EOF
export ENCRYPTION_KEY=\$(head -c 32 /dev/urandom | base64)
EOF

source .bash_profile
export

## Create the encryption-config.yaml encryption config file
cat > encryption-config.yaml <<EOF
kind: EncryptionConfig
apiVersion: v1
resources:
  - resources:
      - secrets
    providers:
      - aescbc:
          keys:
            - name: key1
              secret: ${ENCRYPTION_KEY}
      - identity: {}
EOF

## Backup encryption-config.yaml
mkdir -p ~/backup/encryptionconfigs

cp ~/encryption-config.yaml ~/backup/encryptionconfigs/

## Copy the encryption-config.yaml encryption config file to each controller instance
{
  for instance in master-1 master-2; do
    scp encryption-config.yaml ${instance}:~/
  done
}

## Move encryption-config.yaml encryption config file to appropriate directory
{
  for instance in master-1 master-2; do
    ssh ${instance} sudo mkdir -p /var/lib/kubernetes/
    ssh ${instance} sudo mv encryption-config.yaml /var/lib/kubernetes/
  done
}
