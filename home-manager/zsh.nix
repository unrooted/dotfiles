{ config, pkgs, lib, inputs, ... }:
  {
    config = {
      programs.zsh = {
        enable = true;
	enableAutosuggestions = true;
	enableCompletion = true;
	oh-my-zsh = {
	  enable = true;
	  plugins = [ "git" "sudo" ];
	  theme = "lambda";
        };
	history = {
	  extended = true;
	  path = ".zsh_history";
	  save = 1000000;
	  share = true;
	  size = 1000000;
        };

    initExtra = builtins.readFile ./zshrc;
    };
  };
}
