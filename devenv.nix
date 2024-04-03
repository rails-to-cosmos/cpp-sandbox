{ pkgs, lib, ... }:

{
  env.LD_LIBRARY_PATH = "${pkgs.stdenv.cc.cc.lib}/lib";
  # env.SETUPTOOLS_USE_DISTUTILS = "stdlib";
  env.LANG = "en_US.UTF-8";
  env.PYTHON_VERSION = "3.11";
  env.LIBCLANG_PATH = "${pkgs.libclang.lib}/lib";

  packages = with pkgs; [
    pyenv
    jq

    llvmPackages.libcxxStdenv
    ccls
    jdk8
    autoconf
    ccache
    clang
    libcxx
    gcc
    gpp
    boost
    catch2
    libclang
    cmake
    conan
    git
    gnutls
    jansson
    libxml2
    ncurses
    texinfo
  ];

  enterShell = ''
    pyenv install --skip-existing $PYTHON_VERSION
    pyenv local $PYTHON_VERSION
    echo "Hello, fellow hacker"
  '';

  scripts.wake.exec = ''
    pyenv exec python -m pip install --upgrade pip
    pyenv exec python -m pip install virtualenv
    pyenv exec python -m pip install poetry
    pyenv exec python -m pip install cmake-language-server
  '';

  scripts.python.exec = "pyenv exec poetry run python $@";
  scripts.pip.exec = "pyenv exec poetry run python -m pip $@";
  scripts.poetry.exec = "pyenv exec python -m poetry $@";
  scripts.cmake-language-server.exec = "poetry run cmake-language-server $@";
  scripts.py.exec = "poetry run python $@";
  scripts.run.exec = "poetry run $@";
  scripts.ruff.exec = "poetry run ruff $@";
  scripts.ruff-lsp.exec = "poetry run ruff-lsp $@";
  scripts.semgrep.exec = "poetry run semgrep $@";
  scripts.pylsp.exec = "poetry run pylsp $@";
  scripts.pyls.exec = "poetry run pylsp $@";
  scripts.mypy.exec = "poetry run mypy $@";
  scripts.mypy3.exec = "poetry run mypy $@";
  scripts.pycodestyle.exec = "poetry run pycodestyle $@";
  scripts.pyflakes.exec = "poetry run pyflakes $@";
  scripts.flake8.exec = "poetry run flake8 $@";
  scripts.pyright.exec = "poetry run pyright $@";
  scripts.pylint.exec = "poetry run pylint $@";
}
