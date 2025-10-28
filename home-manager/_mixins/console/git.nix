{ darkmode, ... }: {
  programs = {
    git = {
      enable = true;
      delta = {
        enable = true;
        options = {
          features = "decorations";
          navigate = true;
          side-by-side = true;
          light = !darkmode;
          syntax-theme = "1337";
        };
      };
      aliases = {
        adog = "log --all --decorate --oneline --graph";
        co = "checkout";
        nuke = "!f_git_nuke()";
      };
      userEmail = "patrik.werner@airolit.com";
      userName = "patrik werner";
      extraConfig = {
        push = {
          default = "matching";
        };
        pull = {
          rebase = true;
        };
        init = {
          defaultBranch = "master";
        };
      };
    };
  };
}
