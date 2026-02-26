{ darkmode, ... }: {
  programs = {
    git = {
      enable = true;
      settings = {
        aliases = {
          adog = "log --all --decorate --oneline --graph";
          co = "checkout";
          nuke = "!f_git_nuke()";
        };
        user.email = "patrik.werner@airolit.com";
        user.name = "patrik werner";
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
  };
}
