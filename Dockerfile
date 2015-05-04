FROM ubuntu:14.04
MAINTAINER Richard Liu "richardxxx0x@gmail.com"

# add golang repository
RUN apt-get update
RUN apt-get install python-software-properties
RUN add-apt-repository ppa:gophers/go

# add mongodb repository
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
RUN echo "deb http://repo.mongodb.org/apt/ubuntu "$(lsb_release -sc)"/mongodb-org/3.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb.list

# install golang and mongodb
RUN apt-get install golang-stable
RUN apt-get install mongodb-org=3.0.0 mongodb-org-server=3.0.0 mongodb-org-shell=3.0.0 mongodb-org-mongos=3.0.0 mongodb-org-tools=3.0.0

# install git and openssh
RUN apt-get install git-core mercurial openssh-server openssh-client

# fetch revel and leanote
RUN go get github.com/revel/cmd/revel
RUN go get github.com/leanote/leanote/app

RUN mongorestore -h localhost -d leanote --dir $HOME/leanote/mongodb_backup/leanote_install_data/

EXPOSE 9000

CMD revel run github.com/leanote/leanote


