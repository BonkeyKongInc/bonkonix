# Bonkonix
bonkey's NixOS &amp; Home Manager Configurations

## Usage ⚒️
``````make
#
#   ______                _                   _ __   __ 
#   | ___ \              | |                 (_)\ \ / / 
#   | |_/ /  ___   _ __  | | __  ___   _ __   _  \ V /  
#   | ___ \ / _ \ | '_ \ | |/ / / _ \ | '_ \ | | /   \  
#   | |_/ /| (_) || | | ||   < | (_) || | | || |/ /^\ \ 
#   \____/  \___/ |_| |_||_|\_\ \___/ |_| |_||_|\/   \/ 

# Rebuild the OS
make os
# Initial build of the home environment
make home_build
# Rebuild the home environment
make home
``````
### Build the ISO 💿
`nix build .#nixosConfigurations.iso-desktop.config.system.build.isoImage`

## TODOs
- [ ] Add specific hw config for SVS1313C5E, speed-stamina button
    * Proper throttling of CPU
    * use propriatary nvidia driver
    * improve disabling of gpe13 interrupt
- [ ] Add nix handling of plasma, based on host [nix managed plasma](https://github.com/nix-community/plasma-manager)
- [ ] The key bootstrapper shall also copy over SSH keys for git to enable the point below
- [ ] Use a separate flake (private git repo) to store my secrets (see ryan4yin)

## Made possible by
- https://github.com/ripxorip/ripxonix

## Inspirations 🖋️
- Wimpy https://github.com/wimpysworld/nix-config
- Misterio77 https://github.com/Misterio77/nix-starter-configs
