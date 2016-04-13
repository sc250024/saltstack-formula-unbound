unbound.service:
  service.running:
    - name: unbound
    - enable: True
    - reload: True
    - require:
      - pkg: unbound
      - file: unbound.service
{% if salt['grains.get']('os_family') == 'Debian' %}
  file.managed:
    - name: '/etc/default/unbound'
    - source: salt://unbound/files/etc/default/unbound
    - mode: 0644
    - user: root
    - group: root
    - template: jinja
    - show_changes: True
{% endif %}
