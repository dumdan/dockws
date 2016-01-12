#!/bin/bash
#

target=${1}
target="${target:=libreoffice}"
baseOsName="f23"
fullName="Your Name"
email="email@domain.tld"

myGid=$(id -g)
myUid=$(id -u)
myName=$(id -un)

pushd ${target} >/dev/null 2>&1 || { \
	echo -e "Directory Dot found - \"${target}\" x21 Exiting..."; \
	exit 1 ; }
cat << EOF > Dockerfile
FROM ${myName}/${baseOsName}
MAINTAINER ${fullName} <${email}>
RUN dnf install -y libreoffice && 
	dnf clean all

COPY zz-dd-colorls.sh /etc/profile.d/
RUN groupadd -g ${myGid} ${myName} && \
	useradd -g ${myGid} -u ${myUid} \
	-d /home/${myName} -s /bin/bash \
	-c "${fullName}" ${myName}

USER ${myName}
ENTRYPOINT ["/usr/bin/libreoffice"]
EOF


