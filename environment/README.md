***(Work in progress)***
# Set-up your environment
Summary:
- [Install Docker](#Install Docker)
- [Convenient Docker](#Convenient Docker) command access
- [Target directory tree](#Target directory tree)
- [Build your own](#Build your own) Fedora Docker image

## Install Docker - unless already done
Use **dnf** (Fedora) or **yum** (RHEL, CentOS), as appropriate:  
   ```
   [<username>@<hostname> ~]$ sudo dnf install docker docker-selinux
   [<username>@<hostname> ~]$ sudo systemctl enable docker
   [<username>@<hostname> ~]$ sudo systemctl start docker
   ```
Depending on your ***sudo*** settings, you may be asked for ***your*** password for each of these *sudo* commands.

## Convenient Docker access
In order to be able to run all the docker commands as described here, please (if you did not do so, already):
 * create a `docker` group
 * add yourself to that group - assuming "you" are `<username>` 

    ```
    [<username>@<hostname> ~]$ sudo -i
    ```
_(again, depending on your ***sudo*** settings, you may be asked for ***your*** password...)_
    ```
    [root@<hostname> ~]# groupadd docker
    [root@<hostname> ~]# gpasswd -a <username> docker
    [root@<hostname> ~]# systemctl restart docker
    ```
    
Now, **log out** and **log back in !** (you need to "pick-up" the group membership in the current log-in session).  
If running in one of the incarnations of "The X terminal" (MATE, GNOME) it **may** be enough to close it (**Ctrl-D**) and open a new one.  

You should, now, be able to "talk" to the Docker daemon _"as yourself"_. Try (at least) this:  

   ```
   [<username>@<hostname> ~]$ docker info
   ```
## Target directory tree
Just to give you an idea of the (possible) directory & file hierarchy which we are working towards:  

**./**  
├── README.md  
├── **f23/** &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <-- the local Fedora image build directory  
│ &nbsp; &nbsp; &nbsp; ├── Dockerfile  
│ &nbsp; &nbsp; &nbsp; └── zz-dd-colorls.sh  
├── **mkdf-loff.sh** &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; _<-- an **example** script that creates_    
│ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;  &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;  &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;  &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;  &nbsp; _the Dockerfile for "libreoffice"_  
├── **libreoffice/** &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <-- the Libre Office image build directory  
│ &nbsp; &nbsp; &nbsp;└── Dockerfile  
\- \- \-  
│  
├── **\<future application directrories>/**  
\- \- \-  
└── **usr-local-bin/** &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <-- the commands to run you containerized applications  
 &nbsp; &nbsp; &nbsp; &nbsp; └── libreoffice.sh
 
_(apologies for the weird-looking "ascii art")_


## Build your own - ***local*** - Fedora Docker image:
Of course, for RHEL and CentOS, **dnf** changes to **yum**, in the `Dockerfile`, below.
   ```
   [<username>@<hostname> ~]$ mkdir f23
   [<username>@<hostname> ~]$ cd f23
   [<username>@<hostname> ~]$ vim Dockerfile
   ```
---- [Dockerfile](f23/Dockerfile) contents, in the **f23** directory ----  
(**Please** don't forget to change _"Your Name"_ and _"your email address"_ with the actual values)
```
FROM fedora
MAINTAINER Your Name <your email address>
RUN dnf install -y procps iputils && \
	dnf -y update \
	dnf clean all
# You may, safely, ignore (comment-out) the next
# COPY command. It reflects my VERY opinionated view
# on how time should be displayed by the "ls" command:
COPY zz-dd-colorls.sh /etc/profile.d/

CMD ["sleep", "infinity"]
```
Now, for the **actual build** (you're still, in the "f23" directory):
   ```
   [<username>@<hostname> ~]$ docker build -t <your username>/f23 .
   ```
***Please, note*** the **dot** at the end of that command. It _is_ important !  
(You do not, really, have to prefix the image with your **\<username\>**, but you **should** do something of that kind - please, see the docs for details)

The build is going to take a while and involves downloading and installing quite a few __rpm__ packages.  
When finished, you should be able to see the new image in the local Docker cache:
```
[<username>@<hostname> ~]$ docker images
REPOSITORY                  TAG                 IMAGE ID            CREATED             VIRTUAL SIZE
<username>/f23              latest              3129cde806e2        6 hours ago         352 MB
<none>                      <none>              62e7ea3bf76c        9 days ago          352.3 MB
docker.io/fedora            latest              597717fc21bd        7 weeks ago         204 MB
[<username>@<hostname> ~]$ 
```
(The actual listing will look a little different, but you get the idea)

***(To be continued...)***


