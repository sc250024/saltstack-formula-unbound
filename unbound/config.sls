unbound.config:
  file.managed:
    - name: '/etc/unbound/unbound.conf'
    - source: salt://unbound/templates/unbound.conf.jinja
    - mode: 0644
    - user: root
    - group: root
    - template: jinja
    - require_in:
      - unbound.service
    - watch_in:
      - unbound.service
