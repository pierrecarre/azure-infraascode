# Démo Packer

Installer le plugin Azure pour Packer
```
packer plugins install github.com/hashicorp/azure
```

Exécuter le build de l'image
```
packer build nginx-demo-image.json
```