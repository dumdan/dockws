# dockws
# Docker-based Workstation configuration(s)
(...After a long absence from GitHub...)  
I know, ***I am not the first to do this*** - thank you, **Jessie Frazelle** and many others!

This is my long-overdue attempt at formalizing this "use-pattern" on the Red Hat family of distributions.  
It's just a start - I will continue to add to it, as time permits.  

My setup is, by no means, complete, hence here are some  
  
Caveats:
- I made no attempt to use the DBus for overall desk-top integration (well, I actually did do it, but it involves multiple containers = increased complexity);
- The idea is _first and foremost_ to ***isolate*** the various applications each in their _containerized sandbox_, as opposed to running the whole desktop in a container;
- This setup can, very well, turn into examples of how to solve the same "problems" for other applications.

## Pattern
### **Premise**
   Say you are a system engineer or developer or - maybe ? - just a regular OS user...
### **Problem**
How do you install a new application - or a new version of an existing one - while keeping the rest of the environment "clean"?  
### Comments
Very often, we need / want to keep the "base system" clean (_and working_), while the new app is demanding:
- dependencies that conflict with components already installed and/or
- changes in the configuration files that break the existing (and, maybe, _supported_) system configuration, or
- relaxing the security requirements.  

The most often heard response this question is **"use a virtual machine, and you're done!"**  
_Except..._ **that** doesn't always work very well:
- if the "host" is a machine not very "capable" - say, for example, a run-of-the-mill laptop (your **workstation**) - you **will** feel the virtualization overhead piling-up pretty quickly;
- when the application needs access to some devices of the host in a very "controlled" mode, sometimes with dedicated, nonstandard, device drivers;
- **you** are writing an application that includes such "low level" access.

***Before trying*** anything, please keep in mind **this whole setup is introducing its own changes**. Here are the ones I became aware of, up to now:

1. the "SELinux context" of your __home directory__ will change to __`svirt_sandbox_file_t`__;
2. the **only** communication between the application and the environment (for example, _the desktop manager_) is restricted to the _environment variables_ and _command line arguments_ (for the time being, at least);
3. no "packaging" - it may be less-than-simple, due to the customizations done at "container-build time"

Finally,  
I am ___very biased___ toward the "Red Hat family" of distributions and everything you see here has been tested on Fedora (usually, latest) or the latest releases of RHEL or CentOS. The reason for the "latest" has (or may have) to do with capabilities found in the kernels;  
Also, my main job is quite apart from this activity, hence the amount of time I can dedicate to this project is not guaranteed... (no, I do _not_ think I am unique in this regard).

### [... on, to the next stage...](environment)

