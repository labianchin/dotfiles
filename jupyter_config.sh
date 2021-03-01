#!/usr/bin/env bash

set -o errexit
set -o nounset

# Installs and configures jupyter notebook

JUPYTER_DEPS=(
  requests pyyaml tqdm pycron ruamel.yaml pytest
  google-auth google-cloud-bigquery
  markdown pelican==3.6.3 numpy pandas pandas-gbq matplotlib graphviz
  jupyter ipython dask jupyter_contrib_nbextensions jupyterlab arrow seaborn qgrid
  #fbprophet
  jupyter_nbextensions_configurator jupyter_contrib_nbextensions jupyter_http_over_ws
  plotly dash
  jupyter_dashboards jupyter_nbextensions_configurator nteract_on_jupyter
  grpcio google-cloud-bigquery-storage pyarrow
  nbconvert
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

python_prepare() {
  python3 -m pip install --upgrade pip setuptools pipx requests pyyaml
  python3 --version
  python3 -m pip --version
  python3 -m pipx --version
}

install() {
  python_prepare
  python3 -m pip install --upgrade "${JUPYTER_DEPS[@]}"
}

pipx_install() {
  #https://www.twoistoomany.com/blog/2020/11/24/how-i-work-pipx/
  time python_prepare
  #time pip download "${JUPYTER_DEPS[@]}"
  time pipx install --python="$(which python3)" --force --verbose jupyterlab || pipx reinstall --python="$(which python3)" --verbose jupyterlab
  time pipx inject --verbose --include-apps jupyterlab jupyter-core nbconvert
  time pipx inject --verbose jupyterlab "${JUPYTER_DEPS[@]}"
  pipx runpip jupyterlab check
  jupyter-lab --version
}

deps(){
  DEPS=(
    requests pyyaml tqdm pycron google-auth ruamel.yaml
    #piecash beancount fava gnucash-to-beancount beancount-import smart_importer
    pipx
    poetry
  )
  python3 -m pip install --upgrade "${DEPS[@]}"
  python3 -m pipx ensurepath
  pipx install tox
  pipx install black
  pipx install flake8
}

poetry() {
  poetry add "${JUPYTER_DEPS[@]}"
  poetry run jupyter dashboards quick-setup
  poetry run jupyter nbextensions_configurator enable
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
