#!/usr/bin/env bash

set -o errexit
set -o nounset

# Installs and configures jupyter notebook

install() {
  pip install --upgrade pip setuptools
  pip install \
    requests pyyaml \
    markdown pelican==3.6.3 numpy pandas pandas-gbq matplotlib graphviz \
    jupyter ipython dask jupyter_contrib_nbextensions jupyterlab arrow seaborn qgrid \
    google-auth google-cloud-bigquery \
    jupyter_nbextensions_configurator jupyter_contrib_nbextensions jupyter_http_over_ws \
    plotly==2.7.0 cufflinks==0.13.0 jupyter_dashboards jupyter_nbextensions_configurator \
    nteract_on_jupyter --upgrade
}

config() {
  # https://ndres.me/post/best-jupyter-notebook-extensions/
  # https://codeburst.io/jupyter-notebook-tricks-for-data-science-that-enhance-your-efficiency-95f98d3adee4

  jupyter dashboards quick-setup --sys-prefix
  jupyter nbextensions_configurator enable --sys-prefix
  jupyter contrib nbextension install --sys-prefix
  for e in execute_time/ExecuteTime collapsible_headings/main autosavetime/main scratchpad/main notify/notify; do
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
