
FROM fedora
MAINTAINER Your Name <your email address>
RUN dnf install -y procps iputils && \
	dnf -y update \
	dnf clean all

COPY zz-dd-colorls.sh /etc/profile.d/
CMD ["sleep", "infinity"]

