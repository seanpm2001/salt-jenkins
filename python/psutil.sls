include:
  {%- if grains['os_family'] not in ('FreeBSD', 'Gentoo', 'Windows') %}
  - gcc
  {%- endif %}
  - python.pip
{%- if grains['os_family'] not in ('Arch', 'Solaris', 'FreeBSD', 'Gentoo', 'MacOS', 'Windows') %}
{#- These distributions don't ship the develop headers separately #}
  - python.headers
{%- endif %}

psutil:
  pip.installed:
    - upgrade: True
    - index_url: https://pypi.c7.saltstack.net/simple
    - extra_index_url: https://pypi.python.org/simple
    - require:
      {%- if grains['os_family'] not in ('Arch', 'Solaris', 'FreeBSD', 'Gentoo', 'MacOS', 'Windows') %}
      {#- These distributions don't ship the develop headers separately #}
      - pkg: python-dev
      {%- endif %}
      {%- if grains['os_family'] not in ('FreeBSD', 'Gentoo', 'Windows') %}
        {#- FreeBSD always ships with gcc #}
      - pkg: gcc
      {%- endif %}
      - cmd: pip-install
