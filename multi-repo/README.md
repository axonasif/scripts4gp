# Multi repo

Easily setup multiple repos under a different repo without affecting it or even use an empty repo with only a `.gitpod.yml`.

It also tries to mimic the git-submodules behavior in VSCODE `Source Control` panel without actually creating git-submodules physically. (Inspired by [@shaal](https://github.com/shaal)'s idea)

## Examples

You can add these in your `.gitpod.yml` for trying out. Try running `gp init` in your workspace if you don't have this file.

- Setup two sub-repos in your existing repo and **launch one of them in a separate VSCODE instance.**
> Notice the `+open` at the end of last github url.

```yml
tasks:
  - before: |
      curl -sL https://git.io/Jy44e | bash -s -- \
      "https://github.com/bashbox/bashbox" \
      "https://github.com/bashbox/std+open"
```

- Setup two sub-repos from within three specified repos but **use one of them to replace your base repository.**
> Notice the `+base` at the end of the 2nd github url.

```yml
tasks:
  - before: |
      curl -sL https://git.io/Jy44e | bash -s -- \
      "https://github.com/bashbox/bashbox" \
      "https://github.com/bashbox/std+base" \
      "https://github.com/axonasif/gearlock.git"
```

> **Important note:** Make sure to push commit and push the changes of your `.gitpod.yml` file and open a new workspace for your repository. 
