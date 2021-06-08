#!/usr/bin/env bash

set -o errexit
set -o nounset

# Installs and configures jupyter notebook

JUPYTER_DEPS=(
  requests pyyaml tqdm pycron ruamel.yaml pytest
  google-cloud-bigquery
  markdown pelican==3.6.3 numpy pandas matplotlib graphviz arrow seaborn
  jupyter ipython dask jupyter_contrib_nbextensions jupyterlab qgrid
  'pystan==2.19.1.1'
  jupyter_nbextensions_configurator jupyter_contrib_nbextensions jupyter_http_over_ws
  plotly dash
  jupyter_dashboards jupyter_nbextensions_configurator nteract_on_jupyter
  grpcio google-cloud-bigquery-storage pyarrow
  nbconvert
  fbprophet
  )

check() {
  local -r python_version=$(python3 --version)
  if [[ "$python_version" != "Python 3."* ]]; then
    echo "Got Python version $python_version"
    echo "Check https://docs.brew.sh/Homebrew-and-Python"
    # brew install python@3.8 pyenv
    # brew link --overwrite python@3.8
    exit 99
  fi
}

pyenv_setup() {
  # Use pyenv to setup a stable python version
  # Avoid brew, otherwise brew upgrade can break pipx apps with invalid/bad interpreter
  pyenv --version
  pyenv install --skip-existing 3.8.10
  pyenv global 3.8.10
  pyenv versions
  "$(pyenv prefix)/bin/python" --version
  export PATH="$(pyenv prefix)/bin:$PATH"
}

python_prepare() {
  pyenv_setup
  python -m pip install --upgrade pip setuptools pipx requests pyyaml
  python --version
  python -m pip --version
  python -m pipx --version
}

install() {
  python_prepare
  python -m pip install --upgrade "${JUPYTER_DEPS[@]}"
}

pipx_jupyter_check() {
  set -o xtrace
  pipx runpip jupyterlab check
  jupyter-lab --version
  jupyter --version
  python --version
  # Check python version used by jupyter executable
  # We want to avoid brew versions
  which jupyter
  $(head -1 "$(which jupyter)" | cut -c3-) --version
}

pipx_install() {
  #https://www.twoistoomany.com/blog/2020/11/24/how-i-work-pipx/
  time python_prepare
  #time pip download "${JUPYTER_DEPS[@]}"
  time pipx install --force --verbose jupyterlab || pipx reinstall --verbose jupyterlab
  time pipx inject --verbose --include-apps jupyterlab jupyter-core nbconvert
  time pipx inject --verbose jupyterlab "${JUPYTER_DEPS[@]}"
  pipx_jupyter_check
}

config() {
  # https://ndres.me/post/best-jupyter-notebook-extensions/
  # https://codeburst.io/jupyter-notebook-tricks-for-data-science-that-enhance-your-efficiency-95f98d3adee4

  jupyter dashboards quick-setup --sys-prefix
  jupyter nbextensions_configurator enable --sys-prefix
  jupyter contrib nbextension install --sys-prefix
  for e in execute_time/ExecuteTime collapsible_headings/main autosavetime/main scratchpad/main notify/notify google.cloud.bigquery jupytemplate/main; do
    jupyter nbextension enable "$e";
  done
  # https://research.google.com/colaboratory/local-runtimes.html
a
  jupyter serverextension enable --sys-prefix jupyter_http_over_ws
}

setup() {
  pipx_install
  #config
}

server() {
  jupyter notebook \
    --NotebookApp.allow_origin='https://colab.research.google.com' \
    --port=8888
}

main() {
  if [[ $# -gt 0 ]]; then
    "$@"
  else
    pipx_install
    #setup
  fi
}

time main "$@"

# It can be installed from within Jupyter with:
# ! curl https://raw.githubusercontent.com/labianchin/dotfiles/master/jupyter_config.sh | bash -x
# Then restart Kernel/Jupyter

# Ideas to try:
# https://github.com/quantopian/qgrid
# https://ipywidgets.readthedocs.io/en/latest/user_install.html
