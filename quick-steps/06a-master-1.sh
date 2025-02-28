{
ENCRYPTION_KEY=$(head -c 32 /dev/urandom | base64)


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


for instance in master-1 master-2; do
  scp encryption-config.yaml ${instance}:~/
done


for instance in master-1 master-2; do
  ssh ${instance} sudo mkdir -p /var/lib/kubernetes/
  ssh ${instance} sudo mv encryption-config.yaml /var/lib/kubernetes/
done

}