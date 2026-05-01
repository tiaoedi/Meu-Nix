# 🌙 Meu-Nix — Documentação do Setup

> NixOS com Niri + Noctalia Shell  
> Repositório: https://github.com/tiaoedi/Meu-Nix

---

## 🖥️ Sistema

| Item          | Valor                  |
| ------------- | ---------------------- |
| OS            | NixOS 26.05 (unstable) |
| Host          | Nix                    |
| Usuário       | pc120                  |
| Placa-mãe     | ASUS PRIME B550M-A     |
| GPU           | AMD                    |
| Compositor    | Niri                   |
| Shell         | Noctalia Shell         |
| Login Manager | Ly                     |
| Terminal      | Ghostty                |
| Editor        | Nixvim                 |

---

## ⚡ Aliases principais

| Alias                | Descrição                                   |
| -------------------- | ------------------------------------------- |
| `update`             | Rebuilda o sistema (`nixos-rebuild switch`) |
| `updatef`            | Atualiza os inputs do `flake.lock`          |
| `updateall`          | Atualiza flake e rebuilda o sistema         |
| `noctsave`           | Salva configs do Noctalia e rebuilda        |
| `nixpush`            | Commit + push para o GitHub                 |
| `nixpush "mensagem"` | Commit com mensagem personalizada           |
| `ff`                 | Fastfetch                                   |
| `ya`                 | Yazi (gerenciador de arquivos)              |
| `sr`                 | Reboot                                      |
| `nl`                 | Lista gerações do NixOS                     |
| `ndn`                | Deleta gerações antigas                     |

---

## ⌨️ Atalhos do Niri

| Tecla       | Ação                                  |
| ----------- | ------------------------------------- |
| `Mod+X`     | Menu de sessão (logout, reboot, etc.) |
| `Mod+F5`    | Clipboard do Noctalia                 |
| `Mod+F12`   | Launcher do Noctalia                  |
| `Mod+Print` | Screenshot (Flameshot)                |
| `Mod+F4`    | GIMP                                  |
| `Mod+F6`    | VLC                                   |

---

## 🔧 Manutenção NixOS

```sh
# Rebuildar o sistema
update

# Atualizar flake e rebuildar
updateall

# Listar gerações
nl

# Remover gerações antigas (mais de 7 dias)
sudo nix-collect-garbage --delete-older-than 7d

# Remover todas as gerações antigas
sudo nix-env --profile /nix/var/nix/profiles/system --delete-generations old

# Limpar tudo
sudo nix-collect-garbage -d

# Otimizar o store
sudo nix-store --optimise

# Formatar os arquivos nix
nix fmt .
```

# Regenere o Noctalia

noctalia-shell ipc call state all > ~/Meu-Nix/modules/home/noctalia.json
head -3 ~/Meu-Nix/modules/home/noctalia.json
cd ~/Meu-Nix && git add . && update

---

## 🎨 Noctalia Shell

```sh
# Salvar configurações atuais e rebuildar
noctsave
# Regenere:
noctalia-shell ipc call state all > ~/Meu-Nix/modules/home/noctalia.json
head -3 ~/Meu-Nix/modules/home/noctalia.json
# Abrir configurações
noctalia-shell ipc call settings open

# Toggling via IPC
noctalia-shell ipc call launcher toggle
noctalia-shell ipc call sessionMenu toggle
noctalia-shell ipc call controlCenter toggle
```

---

## 🌐 Rede

```sh
# Reiniciar NetworkManager
sudo systemctl restart NetworkManager

# Editar DNS (systemd-resolved)
sudo vim /etc/systemd/resolved.conf

# Tailscale
sudo tailscale serve --bg 8096
tailscale serve status
sudo tailscale set --hostname portainer

# dns
sudo tailscale up --accept-dns --operator=pc120 --ssh
sudo tailscale up --accept-dns=false --operator=pc120 --ssh

```

---

## 🖥️ Proxmox / LXC

```sh
# Gerenciar LXCs
pct stop 110
pct start 110
pct enter 112
pct exec 110 -- bash

# Virsh (VMs)
sudo virsh list --all
sudo virsh autostart proximox
sudo virsh dominfo proximox | grep Autostart
```

---

## 🔄 Git / Rollback

```sh
# Ver commits por data
git log --oneline --format="%h %ai %s"

# Reverter para um commit específico
cd ~/Meu-Nix
git checkout <hash> -- .
sudo nixos-rebuild switch --flake .#Nix
reboot

# Commitar o revert
git add .
git commit -m "revert to <data>"
git push
```

---

## 📺 Mídia / FFMPEG

```sh
# Converter H265 para MP4
ffmpeg -f hevc -i video.h265 -c copy video.mp4

# Converter todos os H265 em lote
for f in *.h265; do
  ffmpeg -f hevc -err_detect ignore_err -i "$f" -c copy "${f%.h265}.mp4"
done

# Visualizar stream RTSP
ffplay rtsp://admin:senha@192.168.1.3:554/onvif1
```

---

## 🔑 GitHub Token (nix access)

Quando o `updatef` der erro 403:

1. Acesse https://github.com/settings/tokens
2. Regenere o token
3. Atualize em `~/.config/nix/nix.conf`

---

## 📦 Estrutura do Repositório

````
Meu-Nix/
├── flake.nix          # Entrypoint principal
├── flake.lock         # Lock dos inputs
├── hosts/
│   └── Nix/
│       ├── config.nix         # Configuração principal do sistema
│       ├── hardware.nix       # Hardware específico
│       ├── users.nix          # Usuários
│       └── variables.nix      # Variáveis (teclado, etc.)
├── modules/
│   ├── home/                  # Configurações do home-manager
│   │   ├── default.nix        # Importações do home
│   │   ├── niri.nix           # Compositor Niri
│   │   ├── noctalia.nix       # Noctalia Shell
│   │   ├── noctalia.json      # Configurações exportadas do Noctalia
│   │   ├── cli/               # Ferramentas de linha de comando
│   │   ├── editors/           # Nixvim
│   │   └── terminals/         # Ghostty, Tmux
│   ├── packages.nix           # Pacotes do sistema
│   ├── fonts.nix              # Fontes
│   ├── pipewire.nix           # Áudio
│   └── quickshell.nix         # Quickshell
└── zshrc                      # Aliases e configuração do ZSH


# waydroid

sudo waydroid init -s GAPPS -f
sudo systemctl restart waydroid-container
waydroid session start

nix shell github:nix-community/NUR#repos.ataraxiasjel.waydroid-script -c sudo waydroid-script

waydroid session stop
sudo systemctl restart waydroid-container
waydroid session start &
waydroid show-full-ui

# Backup dos dados
sudo cp -r /var/lib/waydroid/data ~/waydroid-backup

# Reinicializa
sudo waydroid init -s GAPPS -f

# Restaura os dados
sudo cp -r ~/waydroid-backup/* /var/lib/waydroid/data/

#yandex
flatpak run ru.yandex.Browser --no-sandbox


##pagina inicial
http://localhost:3000/
https://dashboard-manager--tiaoedi.replit.app

# kitty Atalhos de Teclado
Abrir nova aba: Ctrl + Shift + t
Fechar aba atual: Ctrl + Shift + q (ou simplesmente digite exit no terminal)
Próxima aba: Ctrl + Shift + Right (Seta para a direita)
Aba anterior: Ctrl + Shift + Left (Seta para a esquerda)
Renomear aba: Ctrl + Shift + alt + t


### Docker Para desligar ###########
cd /appdata/navidrome
docker compose down

#### ligar ###
cd /appdata/navidrome
docker compose up -d

## Para apenas reiniciar ##
cd /appdata/navidrome
docker compose restart

### Ventoy
sudo NIXPKGS_ALLOW_INSECURE=1 NIXPKGS_ALLOW_UNFREE=1 nix run nixpkgs#ventoy --impure -- -i /dev/sda```
````
