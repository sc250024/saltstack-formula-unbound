# SaltStack Unbound formula
# Use this 'init.sls' to fully setup
# Unbound on a server automatically

include:
{% if salt['pillar.get']('unbound:include') %}
  {% for include in salt['pillar.get']('unbound:include') %}
  - {{ include }}
  {% endfor %}
{% endif %}
  - unbound.install
  - unbound.service
  - unbound.config
