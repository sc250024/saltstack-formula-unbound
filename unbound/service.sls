unbound.service:
  service.running:
    - name: unbound
    - enable: True
    - reload: True
    - provider: service
    - require:
      - pkg: unbound
      - file: unbound.config
{% if salt['grains.get']('os_family') == 'Debian' %}
      - file: unbound.service
{% endif %}
    - watch:
      - file: unbound.config
{% if salt['grains.get']('os_family') == 'Debian' %}
      - file: unbound.service
{% endif %}
    - require:
      - pkg: unbound
{% if salt['grains.get']('os_family') == 'Debian' %}
      - file: unbound.service
  file.managed:
    - name: '/etc/default/unbound'
    - source: salt://unbound/files/etc/default/unbound
    - mode: 0644
    - user: root
    - group: root
    - template: jinja
    - show_changes: True
{% endif %}
