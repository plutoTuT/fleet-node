#!/bin/sh
set -e
UUID="${UUID:?UUID env required}"
PORT="${PORT:-8080}"
WS_PATH="${WS_PATH:-/ray}"
cat > /tmp/config.json <<JSON
{
  "inbounds": [{
    "listen": "0.0.0.0",
    "port": ${PORT},
    "protocol": "vless",
    "settings": { "clients": [{ "id": "${UUID}" }], "decryption": "none" },
    "streamSettings": { "network": "ws", "wsSettings": { "path": "${WS_PATH}" } }
  }],
  "outbounds": [{ "protocol": "freedom" }]
}
JSON
exec /usr/local/bin/xray run -config /tmp/config.json
