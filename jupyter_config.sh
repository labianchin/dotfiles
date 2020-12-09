#!/usr/bin/env bash

set -o errexit
set -o nounset

# Installs and configures jupyter notebook

JUPYTER_DEPS=(
  requests pyyaml \
    markdown pelican==3.6.3 numpy pandas pandas-gbq matplotlib graphviz
    jupyter ipython dask jupyter_contrib_nbextensions jupyterlab arrow seaborn qgrid
    fbprophet
    jupyter_nbextensions_configurator jupyter_contrib_nbextensions jupyter_http_over_ws
    plotly jupyter_dashboards jupyter_nbextensions_configurator
    nteract_on_jupyter
    google-auth google-cloud-bigquery
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

install() {
  python3 -m pip install --upgrade pip setuptools
  python3 --version
  python3 -m pip --version
  python3 -m pip install --upgrade "${JUPYTER_DEPS[@]}"
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

  jupyter serverextension enable --sys-prefix jupyter_http_over_ws
}

setup() {
  install
  config
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
    setup
  fi
}

time main "$@"

# It can be installed from within Jupyter with:
# ! curl https://raw.githubusercontent.com/labianchin/dotfiles/master/jupyter_config.sh | bash -x
# Then restart Kernel/Jupyter

# Ideas to try:
# https://github.com/quantopian/qgrid
# https://ipywidgets.readthedocs.io/en/latest/user_install.html
