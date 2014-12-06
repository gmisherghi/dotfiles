dotfiles
========

These are my base config files that I like to keep across all my unix accounts.
To install, clone to ~ and run `./setup.sh`.

Features:
  * bash logs to ~/.bash_logs/hostname.YYYYMM after every command, interleaved if there are multiple shells running.
  * bash sets ups PATH and other variables so applications in ~/apps/foo/bin get setup automatically. (Install applications to their own prefix so they can be easilly removed.)
  * Nice VIM defaults.
  * Screen has a toolbar.
