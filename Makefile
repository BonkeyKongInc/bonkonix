HOSTNAME = $(shell hostname)
USER = $(shell whoami)

ifndef HOSTNAME
 $(error Hostname unknown)
endif

ifndef USER
 $(error User unknown)
endif

home:
ifdef light
	home-manager switch -b backup --flake ~/bonk/bonkonix/#${USER}@${HOSTNAME} --override-input darkmode_flag github:boolean-option/false
else
	home-manager switch -b backup --flake ~/bonk/bonkonix/#${USER}@${HOSTNAME}
endif
# FIXME No idea why I have to issue `nix profile list` first, if I don't, I get
# no suitable profile found from home-manager?
home_build:
	nix profile list
	home-manager build -b backup --flake ~/bonk/bonkonix/#${USER}@${HOSTNAME}
	-home-manager switch -b backup --flake ~/bonk/bonkonix/#${USER}@${HOSTNAME}
	echo "Rebooting in 3 seconds"
	sleep 3
	sudo reboot
os:
	sudo nixos-rebuild switch --flake ~/bonk/bonkonix/#${HOSTNAME}
boot:
	sudo nixos-rebuild boot --flake ~/bonk/bonkonix/#${HOSTNAME}
