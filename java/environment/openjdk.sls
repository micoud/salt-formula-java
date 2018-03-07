{%- from "java/map.jinja" import environment with context %}

java_packages:
  pkg.installed:
  - names: {{ environment.pkgs }}

{%- if environment.get('development', False) %}

java_dev_packages:
  pkg.installed:
  - names: {{ environment.dev_pkgs }}

{%- endif %}

java_home_symlink:
  file.symlink:
  - name: {{ environment.home_dir }}
  {%- if grains['os_family']|lower == 'debian' %}
  - target: /usr/lib/jvm/java-{{ environment.version }}-openjdk-amd64
  {%- elif grains['os_family']|lower == 'redhat' %}
  - target: /usr/lib/jvm/java-{{ environment.version }}-openjdk
  {%- endif %}
  - unless: test -d {{ environment.home_dir }}
