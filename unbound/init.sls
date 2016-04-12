# SaltStack Unbound formula
# Use this 'init.sls' to fully setup
# Unbound on a server automatically

{% if salt['pillar.get']('unbound:include') %}
include:
{% for include in salt['pillar.get']('unbound:include') %}
  - {{ include }}
{% endfor %}
{% endif %}
  - unbound.install
  - unbound.service
  - unbound.config
