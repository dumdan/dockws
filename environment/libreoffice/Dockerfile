FROM daniel/f23
MAINTAINER Your Name <email@domain.tld>
RUN dnf install -y libreoffice && 
	dnf clean all

COPY zz-dd-colorls.sh /etc/profile.d/
RUN groupadd -g 1000 daniel && 	useradd -g 1000 -u 1000 	-d /home/daniel -s /bin/bash 	-c "Your Name" daniel

USER daniel
ENTRYPOINT ["/usr/bin/libreoffice"]
