cd /mnt/c/Users/rlyst/Netology/09-ci-05-teamcity/src

docker run -d -e SERVER_URL="http://89.169.159.107:8111" jetbrains/teamcity-agent

ansible-playbook -i /mnt/c/Users/rlyst/Netology/09-ci-05-teamcity/infrastructure/inventory/cicd/hosts.yml /mnt/c/Users/rlyst/Netology/09-ci-05-teamcity/infrastructure/site.yml