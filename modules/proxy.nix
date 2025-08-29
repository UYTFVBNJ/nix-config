{ config, lib, pkgs, ... }:

{
  # Install mihomo package
  environment.systemPackages = with pkgs; [
    mihomo
    wget
    curl
  ];

  # Create mihomo user and group
  users.groups.mihomo = {};
  users.users.mihomo = {
    isSystemUser = true;
    group = "mihomo";
    home = "/var/lib/mihomo";
    createHome = true;
  };

  # Create configuration directory
  systemd.tmpfiles.rules = [
    "d /etc/mihomo 0755 mihomo mihomo -"
    "d /var/lib/mihomo 0755 mihomo mihomo -"
  ];

  # Mihomo systemd service
  systemd.services.mihomo = {
    description = "mihomo kernel";
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];
    
    serviceConfig = {
      Type = "simple";
      User = "mihomo";
      Group = "mihomo";
      ExecStart = "${pkgs.mihomo}/bin/mihomo -d /etc/mihomo";
      ExecReload = "/bin/kill -HUP $MAINPID";
      Restart = "on-failure";
      RestartSec = "5s";
      
      # Security settings
      NoNewPrivileges = true;
      ProtectSystem = "strict";
      ProtectHome = true;
      PrivateTmp = true;
      ProtectControlGroups = true;
      ProtectKernelModules = true;
      ProtectKernelTunables = true;
      RestrictAddressFamilies = [ "AF_UNIX" "AF_INET" "AF_INET6" ];
      RestrictRealtime = true;
      RestrictSUIDSGID = true;
      LockPersonality = true;
      MemoryDenyWriteExecute = true;
      
      # Allow binding to privileged ports and network access
      AmbientCapabilities = [ "CAP_NET_BIND_SERVICE" ];
      CapabilityBoundingSet = [ "CAP_NET_BIND_SERVICE" ];
      
      # Allow write access to config directory
      ReadWritePaths = [ "/etc/mihomo" "/var/lib/mihomo" ];
    };
    
    preStart = ''
      # Download GeoIP database if not exists
      if [ ! -f /etc/mihomo/Country.mmdb ]; then
        ${pkgs.wget}/bin/wget -O /etc/mihomo/Country.mmdb \
          "https://cdn.jsdelivr.net/gh/Dreamacro/maxmind-geoip@release/Country.mmdb" || true
      fi
      
      # Create default config if not exists
      if [ ! -f /etc/mihomo/config.yaml ]; then
        cat > /etc/mihomo/config.yaml << 'EOF'
port: 7890
socks-port: 7891
allow-lan: false
mode: rule
log-level: info
external-controller: 127.0.0.1:9090
external-ui: ui

proxies: []
proxy-groups: []
rules: []
EOF
        chown mihomo:mihomo /etc/mihomo/config.yaml
      fi
      
      # Ensure proper ownership
      chown -R mihomo:mihomo /etc/mihomo /var/lib/mihomo
    '';
  };

  # Environment variables for proxy
  environment.variables = {
    HTTP_PROXY = "http://127.0.0.1:7890";
    HTTPS_PROXY = "http://127.0.0.1:7890";
    ALL_PROXY = "socks5://127.0.0.1:7891";
    NO_PROXY = "localhost,127.0.0.1,::1";
  };

  # Add proxy settings to bash profile
  environment.etc."profile.d/proxy.sh" = {
    text = ''
      export HTTP_PROXY="http://127.0.0.1:7890"
      export HTTPS_PROXY="http://127.0.0.1:7890"
      export ALL_PROXY="socks5://127.0.0.1:7891"
      export NO_PROXY="localhost,127.0.0.1,::1"
    '';
  };
}