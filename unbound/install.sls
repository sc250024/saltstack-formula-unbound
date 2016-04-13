unbound.install:
  pkg.installed:
    - name: unbound
{% if salt['pillar.get']('unbound:require') %}
  - require:
  {% for requirement in salt['pillar.get']('unbound:require') %}
    - {{ requirement }}
  {% endfor %}
{% endif %}