unbound:
  # If this formula has dependencies or needs to include
  # other SaltStack formulas, define them here.
  # include:
  #   - example_formula.somesls
  # require:
  #   - sls: example_formula.somesls

{% if salt['grains.get']('os_family') == 'Debian' %}
  default:
    enabled: True
    root_trust_anchor_update: True
    root_trust_anchor_file: '/var/lib/unbound/root.key'
    resolvconf: True
    resolvconf_forwarders: True
    daemon_opts: '-c /etc/unbound/unbound.conf'
{% endif %}

  server:
    # Core settings
    core:
      access_controls: # Other options are 'deny', 'allow_snoop', 'deny_non_local', and 'refuse_non_local'
        allow:
          - '127.0.0.0/8'
          - '::1'
          - '::ffff:127.0.0.1'
        refuse:
          - '0.0.0.0/0'
          - '::0/0'
      cache_max_ttl: 86400 # Units in seconds
      cache_min_ttl: 0 # Units in seconds
      chroot: '/etc/unbound' # Path cannot end with '/' !!
      directory: '/etc/unbound' # Path cannot end with '/' !!
      do_daemonize: 'yes'
      do_ip4: 'yes'
      do_ip6: 'yes'
      do_tcp: 'yes'
      do_udp: 'yes'
      do_not_query_localhost: 'yes' # If 'no', the addresses in 'do_not_query_addresses' are set by default
      hide_identity: 'yes'
      hide_version: 'yes'
      identity: 'dns-server' # Leave blank to return hostname
      interfaces:
        - '192.0.2.153'
        - '0.0.0.0' # All IPv4 interfaces
        - '::0'     # All IPv6 interfaces
        - '192.0.2.154@5003' # Listen on different port

      # Adding entries in 'local_data' without defining
      # a local_zone will cause the zone to be automatically
      # created with 'transparent' type.
      # Use format: <RECORD> <RECORD_TYPE> <ADDRESS>
      local_data:
        - 'example.com A 192.0.2.3'
        - 'example.org A 2.3.5.8'
      local_data_ptr: # Same as above, but for PTR records
        - '3.2.0.192 www.example.com'
        - '8.5.3.2 www.example.org'
      local_zones: # Other options are 'deny', 'refuse', 'static', 'redirect', and 'typetransparent'
        nodefault:
          - '30.172.in-addr.arpa.'
        transparent:
          - '29.172.in-addr.arpa.'
      log_queries: 'no'
      log_time_ascii: 'no'
      logfile: '' # Blank is stderr; specifying something here sets 'use-syslog' automatically to 'no'
      module_config: 'validator iterator'
      pidfile: '/etc/unbound/unbound.pid'
      port: 53
      prefetch: 'no'
      root_hints: '' # If set, file will be placed in '/etc/cron.d' to retrieve root hints periodically
      use_syslog: 'yes'
      username: 'unbound'
      verbosity: 1
      version: '' # Leave blank to return package version

    # Advanced settings
    # These settings usually aren't needed
    # Uncomment in case they are

    advanced:
    #   add_holddown: 2592000 # Units in seconds
    #   auto_trust_anchor_file: '/etc/unbound/root.key'
    #   del_holddown: 2592000 # Units in seconds
    #   delay_close: 0 # Units in msec
    #   dlv_anchor_file: 'dlv.isc.org.key'
    #   do_not_query_addresses:
    #     - '127.0.0.1/8'
    #     - '::1'
    #   domains_insecure: # Ignore chain of trust for these domains
    #     - 'example.com'
    #     - 'company.com'
    #   edns_buffer_size: 4096
    #   extended_statistics: 'no'
    #   harden_below_nxdomain: 'no'
    #   harden_dnssec_stripped: 'yes'
    #   harden_glue: 'yes'
    #   harden_large_queries: 'no'
    #   harden_referral_path: 'no'
    #   harden_short_bufsize: 'no'
    #   ignore_cd_flag: 'no'
    #   incoming_num_tcp: 10
    #   infra_cache_numhosts: 10000
    #   infra_cache_slabs: 4
    #   infra_host_ttl: 900 # Units in seconds
    #   interface_automatic: 'no'
    #   jostle_timeout: 200 # Units in msec
    #   keep_missing: 31622400 # Units in seconds
    #   key_cache_size: '4m' # Use m (megabyte), k (kilobyte), or G (gigabyte), or no suffix (bytes)
    #   key_cache_slabs: 4
    #   max_udp_size: 4096
    #   minimal_responses: 'no'
    #   msg_buffer_size: 65552
    #   msg_cache_size: '4m' # Use m (megabyte), k (kilobyte), or G (gigabyte), or no suffix (bytes)
    #   msg_cache_slabs: 4
    #   neg_cache_size: '1m' # Use m (megabyte), k (kilobyte), or G (gigabyte), or no suffix (bytes)
    #   num_queries_per_thread: 1024
    #   num_threads: 1
    #   outgoing_interfaces: # Comment out to use default (all interfaces)
    #     - '192.0.2.153'
    #     - '2001:DB8::5'
    #   outgoing_num_tcp: 10
    #   outgoing_port_avoid: '0-32767'
    #   outgoing_port_permit: '32768-65535'
    #   outgoing_range: 4096
    #   prefetch_key: 'no'
    #   private_addresses:
    #     - '10.0.0.0/8'
    #     - '172.16.0.0/12'
    #     - '192.168.0.0/16'
    #     - '169.254.0.0/16'
    #     - 'fd00::/8'
    #     - 'fe80::/10'
    #   private_domains:
    #     - 'example.com'
    #     - 'company.com'
    #   rrset_cache_size: '4m' # Use m (megabyte), k (kilobyte), or G (gigabyte), or no suffix (bytes)
    #   rrset_cache_slabs: 4
    #   rrset_roundrobin: 'no'
    #   so_rcvbuf: 0
    #   so_reuseport: 'no'
    #   so_sndbuf: 0
    #   ssl_port: 443
    #   ssl_service_key: '/path/to/privatekeyfile.key'
    #   ssl_service_pem: '/path/to/publiccertfile.pem'
    #   ssl_upstream: 'no'
    #   statistics_cumulative: 'no'
    #   statistics_interval: 'no'
    #   target_fetch_policy: '3 2 1 0 0'
    #   tcp_upstream: 'no'
    #   trust_anchor_files:
    #     - '/etc/unbound/trust-anchor1.key'
    #     - '/etc/unbound/trust-anchor2.key'
    #   trust_anchors:
    #     - 'nlnetlabs.nl. DNSKEY 257 3 5 AQPzzTWMz8qSWIQlfRnPckx2BiVmkVN6LPupO3mbz7FhLSnm26n6iG9N Lby97Ji453aWZY3M5/xJBSOS2vWtco2t8C0+xeO1bc/d6ZTy32DHchpW 6rDH1vp86Ll+ha0tmwyy9QP7y2bVw5zSbFCrefk8qCUBgfHm9bHzMG1U BYtEIQ=='
    #     - 'jelte.nlnetlabs.nl. DS 42860 5 1 14D739EB566D2B1A5E216A0BA4D17FA9B038BE4A'
    #   trusted_keys_files: # BIND9 style formatted keys 'trusted-keys { name flag proto algo "key"; };'
    #     - '/etc/unbound/trust-keys1.key'
    #     - '/etc/unbound/trust-keys2.key'
    #   unwanted_reply_threshold: 0
    #   use_caps_for_id: 'no'
    #   val_bogus_ttl: 60 # Units in seconds
    #   val_clean_additional: 'yes'
    #   val_log_level: 0
    #   val_nsec3_keysize_iterations: '1024 150 2048 500 4096 2500'
    #   val_override_date: '' # Blank or '0' turns this off; '-1' ignores the date
    #   val_permissive_mode: 'no'
    #   val_sig_skew_max: 86400 # Units in seconds
    #   val_sig_skew_min: 3600 # Units in seconds

  # Stub zones
  stub_zones:
    example_com_zone:
      name: 'example.com'
      stub_addrs:
        - '192.0.2.68'
        - '192.0.2.69'
      stub_prime: 'no' # Optional
      stub_first: 'no' # Optional
    example_org_zone:
      name: 'example.org'
      stub_hosts:
        - 'ns1.example.com.'
        - 'ns2.example.com.'

  # Forwarding zones
  forward_zones:
    example_com_zone:
      name: 'example.com'
      forward_addrs:
        - '192.0.2.68'
        - '192.0.2.73@5355' # forward to port 5355.
      forward_first: 'no' # Optional
    example_org_one:
      name: 'example.org'
      forward_hosts:
        - 'fwd1.example.com'
        - 'fwd2.example.com'

  # List of Python scripts to run
  python:
    - '/etc/unbound/ubmodule-tst.py'
    - '/etc/unbound/ubmodule-tst2.py'

  # Remote control config section
  remote_control:
    control_enable: 'no'
    control_interfaces:
      - '127.0.0.1'
      - '::1'
    control_port: 8953
    server_key_file: '/etc/unbound/unbound_server.key'
    server_cert_file: '/etc/unbound/unbound_server.pem'
    control_key_file: '/etc/unbound/unbound_control.key'
    control_cert_file: '/etc/unbound/unbound_control.pem'
