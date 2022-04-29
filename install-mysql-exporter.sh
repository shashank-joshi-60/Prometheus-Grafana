sudo groupadd --system prometheus
sudo useradd -s /sbin/nologin --system -g prometheus prometheus

curl -s https://api.github.com/repos/prometheus/mysqld_exporter/releases/latest   | grep browser_download_url   | grep linux-amd64 | cut -d '"' -f 4   | wget -qi -
tar xvf mysqld_exporter*.tar.gz
sudo mv  mysqld_exporter-*.linux-amd64/mysqld_exporter /usr/local/bin/
sudo chmod +x /usr/local/bin/mysqld_exporter

sudo cp ./.mysqld_exporter.cnf /etc/.mysqld_exporter.cnf
sudo chown root:prometheus /etc/.mysqld_exporter.cnf

sudo cp ./mysql_exporter.service /etc/systemd/system/mysql_exporter.service

sudo systemctl daemon-reload
sudo systemctl enable mysql_exporter
sudo systemctl start mysql_exporter