# homix

This is my attempt at managing home using nix overlays. Many of the ideas came from https://github.com/nmattia/homies.

---
To set up homies:

```
* clone this repo into $HOME/.config/nixpkgs
* write "command -v bashrc >> /dev/null && $(bashrc)" to $HOME/.bashrc
* run "nix-env -i --remove-all homix" (after you run this the first time you can use the homix alias for future changes)
```
