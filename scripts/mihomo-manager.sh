#!/usr/bin/env bash

# Download subscription config from your VPN provider
download_config() {
    local url="$1"
    if [[ -z "$url" ]]; then
        echo "Usage: $0 download <subscription_url>"
        echo "Example: $0 download 'https://example.com/api/sub?token=abc&addFlag=yes&subType=meta'"
        exit 1
    fi
    
    echo "Downloading config from: $url"
    sudo wget "$url" -O /etc/mihomo/config.yaml
    sudo chown mihomo:mihomo /etc/mihomo/config.yaml
    echo "Config downloaded successfully!"
}

# Test proxy connection
test_proxy() {
    echo "Testing proxy connection..."
    
    # Test HTTP proxy
    echo "Testing HTTP proxy (port 7890)..."
    if wget --proxy=on --timeout=10 -O /dev/null "https://www.google.com" 2>/dev/null; then
        echo "✓ HTTP proxy working"
    else
        echo "✗ HTTP proxy failed"
    fi
    
    # Test SOCKS5 proxy  
    echo "Testing SOCKS5 proxy (port 7891)..."
    if curl --socks5 127.0.0.1:7891 --timeout 10 -s "https://www.google.com" > /dev/null; then
        echo "✓ SOCKS5 proxy working"
    else
        echo "✗ SOCKS5 proxy failed"
    fi
}

# Show service status and logs
status() {
    echo "=== Mihomo Service Status ==="
    sudo systemctl status mihomo
    
    echo -e "\n=== Recent Logs ==="
    sudo journalctl -u mihomo -n 20 --no-pager
}

# Show live logs
logs() {
    echo "Showing live mihomo logs (Ctrl+C to exit)..."
    sudo journalctl -u mihomo -f
}

# Restart service
restart() {
    echo "Restarting mihomo service..."
    sudo systemctl restart mihomo
    echo "Service restarted!"
}

# Show help
show_help() {
    cat << EOF
Mihomo Proxy Manager

Usage:
  $0 download <url>    Download config from subscription URL
  $0 test             Test proxy connections
  $0 status           Show service status and recent logs
  $0 logs             Show live logs
  $0 restart          Restart mihomo service
  $0 help             Show this help

Examples:
  $0 download 'https://example.com/api/sub?token=abc&addFlag=yes&subType=meta'
  $0 test
  $0 status

After downloading config:
  1. Run: $0 restart
  2. Test with: $0 test
EOF
}

# Main command handler
case "$1" in
    download)
        download_config "$2"
        ;;
    test)
        test_proxy
        ;;
    status)
        status
        ;;
    logs)
        logs
        ;;
    restart)
        restart
        ;;
    help|--help|-h)
        show_help
        ;;
    *)
        echo "Unknown command: $1"
        show_help
        exit 1
        ;;
esac