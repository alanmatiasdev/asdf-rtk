<div align="center">

# asdf-rtk [![Build](https://github.com/alanmatiasdev/asdf-rtk/actions/workflows/build.yml/badge.svg)](https://github.com/alanmatiasdev/asdf-rtk/actions/workflows/build.yml) [![Lint](https://github.com/alanmatiasdev/asdf-rtk/actions/workflows/lint.yml/badge.svg)](https://github.com/alanmatiasdev/asdf-rtk/actions/workflows/lint.yml)

[rtk](https://github.com/alanmatiasdev/asdf-rtk) plugin for the [asdf version manager](https://asdf-vm.com).

</div>

# Contents

- [Dependencies](#dependencies)
- [Install](#install)
- [Contributing](#contributing)
- [License](#license)

# Dependencies

**TODO: adapt this section**

- `bash`, `curl`, `tar`, and [POSIX utilities](https://pubs.opengroup.org/onlinepubs/9699919799/idx/utilities.html).
- `SOME_ENV_VAR`: set this environment variable in your shell config to load the correct version of tool x.

# Install

Plugin:

```shell
asdf plugin add rtk
# or
asdf plugin add rtk https://github.com/alanmatiasdev/asdf-rtk.git
```

rtk:

```shell
# Show all installable versions
asdf list-all rtk

# Install specific version
asdf install rtk latest

# Set a version globally (on your ~/.tool-versions file)
asdf global rtk latest

# Now rtk commands are available
rtk --version
```

Check [asdf](https://github.com/asdf-vm/asdf) readme for more instructions on how to
install & manage versions.

# Contributing

Contributions of any kind welcome! See the [contributing guide](contributing.md).

[Thanks goes to these contributors](https://github.com/alanmatiasdev/asdf-rtk/graphs/contributors)!

# License

See [LICENSE](LICENSE) © [Alan Matias](https://github.com/alanmatiasdev/)
