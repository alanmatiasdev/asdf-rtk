<div align="center">

# asdf-rtk [![Build](https://github.com/alanmatiasdev/asdf-rtk/actions/workflows/build.yml/badge.svg)](https://github.com/alanmatiasdev/asdf-rtk/actions/workflows/build.yml) [![Lint](https://github.com/alanmatiasdev/asdf-rtk/actions/workflows/lint.yml/badge.svg)](https://github.com/alanmatiasdev/asdf-rtk/actions/workflows/lint.yml)

[RTK](https://github.com/rtk-ai/rtk) plugin for the [asdf version manager](https://asdf-vm.com).

</div>

# Contents

- [Dependencies](#dependencies)
- [Install](#install)
- [Contributing](#contributing)
- [License](#license)

# Dependencies

- `bash`, `curl`, `git`, `tar`, `sha256sum` or `shasum`, and [POSIX utilities](https://pubs.opengroup.org/onlinepubs/9699919799/idx/utilities.html).

This plugin installs official RTK tarball releases from the [rtk-ai/rtk](https://github.com/rtk-ai/rtk) repository for Linux `x86_64`/`aarch64` and macOS `x86_64`/`arm64`.

# Install

Plugin:

```shell
asdf plugin add rtk
# or
asdf plugin add rtk https://github.com/alanmatiasdev/asdf-rtk.git
```

RTK:

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
