# install git
sudo apt-get update


sudo apt install git-all -y

# install docker

sudo apt-get install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release -y

sudo mkdir -p /etc/apt/keyrings

curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null


sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin -y

sudo service docker start

# clone environment

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

sudo docker tag exercism/python-test-runner:cfac626c70c4bffc89745557d9058c81ba327d08  exercism/exercism-prog2-track-test-runner

sudo aws --endpoint-url=http://0.0.0.0:3040 --no-sign-request s3 mb s3://exercism-v3-submissions
sudo aws --endpoint-url=http://0.0.0.0:3040 --no-sign-request s3 mb s3://exercism-v3-tooling-jobs

sudo docker compose up -d


# create trigger on db

#CREATE TRIGGER confirm_users BEFORE INSERT on users
 #    for each row if new.confirmed_at is null
 #    then set new.confirmed_at = now();
 #    end if;

