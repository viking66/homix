self: super:

let
  bashrc = super.writeScriptBin "bashrc" ''
    echo ". ${../dotfiles/bashrc}"
  '';

  gitconfig = super.writeTextFile {
    name = "gitconfig";
    destination = "/etc/xdg/git/config";
    text = builtins.readFile ../dotfiles/gitconfig;
  };

  git = super.symlinkJoin {
    name = "git";
    buildInputs = [ super.makeWrapper ];
    paths = [ super.git ];
    postBuild = ''
      wrapProgram "$out/bin/git" --set "XDG_CONFIG_HOME" "/home/jason/.nix-profile/etc/xdg";
    '';
  };

  neovim = super.neovim.override {
    vimAlias = true;
    viAlias = true;
    configure = {
      customRC = builtins.readFile ../dotfiles/vimrc;
      packages.myVimPackage = with super.vimPlugins; {
        start = [
          supertab
          vim-colors-solarized
          vim-airline
          vim-airline-themes
          vim-commentary
          # TODO push change to add the following plugin
          # indentLine
        ];
      };
    };
  };

  termite = super.symlinkJoin {
    name = "termite";
    buildInputs = [ super.makeWrapper ];
    paths = [ super.termite ];
    postBuild = ''
      wrapProgram "$out/bin/termite" --add-flags "-c ${../dotfiles/termite.conf}"
    '';
  };

in {
  homix = super.buildEnv {
    name = "homix";
    paths = [
      bashrc
      git
      gitconfig
      neovim
      termite
      super.direnv
      super.dmenu
      super.feh
      super.gnupg
      super.pass
      super.pinentry_ncurses
      super.tmux
      super.xclip
    ];
  };
}
