#!/bin/sh
if [ ! -e '/usr/bin/v2ray' ]; then
    mkdir /tmp/v2ray
	curl -L -H "Cache-Control: no-cache" -o /tmp/v2ray/v2ray.zip https://github.com/v2fly/v2ray-core/releases/latest/download/v2ray-linux-64.zip
    unzip /tmp/v2ray/v2ray.zip -d /tmp/v2ray
    chmod +x /tmp/v2ray/v2ray
    mv /tmp/v2ray/v2ray /usr/bin/v2ray
    rm -rf /tmp/v2ray
    echo "v2ray Downloading Completed!"
fi
cat << EOF > /root/config.json
{
  "log": {
    "loglevel": "debug"
  },
  "inbounds": [
  {
    "port": 38080,
    "listen":"127.0.0.1",
    "protocol": "vmess",
    "settings": {
      "clients": [
        {
          "id": "021dbdd1-6842-467b-8724-3397e80faa5a",
          "alterId": 0
        }
      ]
    },
    "streamSettings": {
      "network": "ws",
      "wsSettings": {
      "path": "/downloads"
      }
    }
  }
  ],
  "outbounds": [
  {
    "protocol": "freedom",
    "settings": {}
  }
  ]
}
EOF

# generate Nginx default config file
# cat << EOF > /etc/nginx/http.d/default.conf
# server {
    # listen $Nginx_PORT default_server;
    # charset utf-8;

    # location /$RAY_PATH {
    # proxy_redirect off;
    # proxy_pass http://127.0.0.1:$RAY_PORT;
    # proxy_http_version 1.1;
    # proxy_set_header Upgrade \$http_upgrade;
    # proxy_set_header Connection "upgrade";
    # proxy_set_header Host \$http_host;
    # }

# }
# EOF


# Start nginx
nginx

# Run V2Ray
v2ray -config /root/config.json

