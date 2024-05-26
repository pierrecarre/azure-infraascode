# Azure & InfraAsCode

## Prérequis

1. S'inscrire avec un compte gratuit sur MS Azure
2. Démarrer un cloud shell sur Azure -> https://learn.microsoft.com/en-us/azure/cloud-shell/get-started/classic?tabs=azurecli
3. Sélectionner un terminal de type bash 
4. Cloner ce dépôt
```
git clone https://github.com/pierrecarre/azure-infraascode.git
```
5. Générer une clé ssh
```
ssh-keygen -t rsa -b 4096 -C "your_name@azshell"
```

## Documentation de référence

1. Terraform : https://developer.hashicorp.com/terraform/cli/v1.7.x/commands
2. Provider Terraform Azure : https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs
3. Ansible : https://docs.ansible.com/ansible/latest/index.html
