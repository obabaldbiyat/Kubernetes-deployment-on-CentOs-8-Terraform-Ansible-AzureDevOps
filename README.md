# Brief-15

## Pour recuperer la clé ssh privée ##
Dans le pipeline AzureDevOps, rajouter une etape "command line script" et copier les 2 lignes suivantes.

terraform output -raw private >private_key.pem
cat private_key.pem

## pour eviter d'enter 'yes' lors de connection ssh ##
a mettre dans le fichier de l'agent ansible : /etc/ansible/ansible.cfg
[defaults]
host_key_checking = False
