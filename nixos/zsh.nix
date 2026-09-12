{ pkgs, ... }:

{
  programs.zsh = {
    enable = true;

    # Built-in options
    # AUTO_CD: type a dir name to cd into it.
    # EXTENDED_GLOB: powerful globbing, e.g. ls **/*.py
    # HIST_IGNORE_ALL_DUPS / SHARE_HISTORY: sane, shared history across shells.
    initExtra = ''
      setopt AUTO_CD
      setopt EXTENDED_GLOB
      setopt HIST_IGNORE_ALL_DUPS
      setopt SHARE_HISTORY
      setopt EXTENDED_HISTORY
      setopt INTERACTIVE_COMMENTS
      setopt PROMPT_SUBST

      autoload -Uz vcs_info
      zstyle ':vcs_info:git:*' check-for-changes true
      zstyle ':vcs_info:git:*' stagedstr '+'
      zstyle ':vcs_info:git:*' unstagedstr '!'
      zstyle ':vcs_info:git:*' formats '(%F{cyan}%b%f%F{red}%c%u%f)'
      precmd() { vcs_info }

      PROMPT='%(?.%F{green}λ%f.%F{red}λ%f) %n: %~ ''${vcs_info_msg_0_} '
    '';

    history = {
      size = 10000;
      save = 10000;
      share = true;
    };

    autosuggestion.enable = false;
    syntaxHighlighting.enable = false;
  };
}
