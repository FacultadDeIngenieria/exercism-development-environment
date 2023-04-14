# install git
sudo apt-get update


sudo apt install git-all -y

# install docker

sudo apt-get update

sudo apt-get install \
    ca-certificates \
    curl \
    gnupg

sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update

sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

sudo service docker start

# clone environment

cd ..

sudo mkdir prog_2_austral

cd prog_2_austral

mkdir exercism

cd exercism

git clone https://github.com/FacultadDeIngenieria/exercism-development-environment
git clone https://github.com/FacultadDeIngenieria/exercism-website

cd exercism-development-environment

curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"

sudo apt-get install unzip

unzip awscliv2.zip

sudo ./aws/install

sudo docker compose pull

sudo docker tag ghcr.io/facultaddeingenieria/exercism-python-test-runner:main  exercism/exercism-prog2-track-test-runner


sudo docker compose up -d aws

sudo aws --endpoint-url=http://0.0.0.0:3040 --no-sign-request s3 mb s3://exercism-v3-submissions
sudo aws --endpoint-url=http://0.0.0.0:3040 --no-sign-request s3 mb s3://exercism-v3-tooling-jobs

sudo systemctl stop apache2

sudo docker compose up -d


# create trigger on db

# CREATE TRIGGER confirm_users BEFORE INSERT on users
#     for each row if new.confirmed_at is null
#     then set new.confirmed_at = now();
#     end if;

# update tracks

# set has_test_runner = 1;

