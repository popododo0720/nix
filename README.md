# nix
 
## install nix
``` bash
curl -L https://nixos.org/nix/install | sh -s -- --daemon
```

## setup flakes
``` bash
mkdir -p ~/.config/nix
echo 'experimental-features = nix-command flakes' >> ~/.config/nix/nix.conf
```

## git clone
```
git clone git@github.com:popododo0720/nix.git ~/nix-home
cd ~/nix-home
```

## apply
```
nix run home-manager -- switch -b backup --flake .#popododo0720
source ~/.bashrc
```


