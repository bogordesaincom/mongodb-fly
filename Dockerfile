FROM debian:bullseye

RUN apt-get update; apt install -y curl wget sudo gnupg systemd gnupg2

RUN wget -qO - https://www.mongodb.org/static/pgp/server-6.0.asc | sudo apt-key add -

RUN echo "deb http://repo.mongodb.org/apt/debian bullseye/mongodb-org/6.0 main" | sudo tee /etc/apt/sources.list.d/mongodb-org-6.0.list
RUN sudo apt-get update
RUN sudo apt-get install -y mongodb-org
RUN sed -i "s,\\(^[[:blank:]]*bindIp:\\) .*,\\1 0.0.0.0," /etc/mongod.conf

# Uncomment after create admin and password
# RUN rm -rf /etc/mongod.conf
# COPY mongod.conf /etc/mongod.conf

RUN echo "mongodb-org hold" | sudo dpkg --set-selections
RUN echo "mongodb-org-database hold" | sudo dpkg --set-selections
RUN echo "mongodb-org-server hold" | sudo dpkg --set-selections
RUN echo "mongodb-mongosh hold" | sudo dpkg --set-selections
RUN echo "mongodb-org-mongos hold" | sudo dpkg --set-selections
RUN echo "mongodb-org-tools hold" | sudo dpkg --set-selections

ARG PORT 27017

EXPOSE 27017

ENTRYPOINT ["/usr/bin/mongod", "-f", "/etc/mongod.conf"]
