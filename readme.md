## Firmware Vagrant

Standardizes our development environment through Vagrant VMs. Docker containers are inadequate, since we need to be able to access the host USB ports to flash firmware. We would also like to load kernel modules that are unavailable on a Docker container (e.g., SocketCAN).

The environment consists of a Debian VM with all the cross-compilers and tools pre-installed. It also attempts to passthrough ST-Link programmers as well.

### IMPORTANT: If you have a laptop with Apple Silicon (M1 or M2 mac)

Running virtual machines on Apple silicon is very hard, since hypervisor support for Apple silicon
is basically non-existant. In this case, it is probably just easist to do your development straight on
your mac.

Most of the toolchains and utilities that you need can be installed via brew.

The below commands should install **most** of what you need:

```shell
xcode-select install
brew install \
    gcc-arm-embedded \
    screen \
    openocd
```

### Installation and Setup

#### Install Vagrant

https://www.vagrantup.com/downloads

On OSX, you can do

```shell
brew install vagrant
```

#### Install Virtualbox

**IMPORTANT:**

* Virtualbox is incompatible with Windows hosts running WSL/WSL2
* The recommended solution for this would be to disable WSL on your system and *try* Vagrant - you might find that you actually prefer it to WSL
  * Vagrant allows you to have multiple VMs running, while WSL locks you into 1 (as far as I know...)
  * Vagrant lets you share folders with your host machine, just like WSL (the performance of the shared folder is much better on Vagrant though imo)
  * If you don't like Vagrant, you can always uninstall and re-enable WSL
* As a fallback, the script `provision_box.sh` can be run manually to install the tools onto your WSL VM, this is not recommended however...
  * You will also not get USB passthrough if you go with this

**Install base VirtualBox**

* https://www.virtualbox.org/wiki/Downloads

**Install the VirtualBox Extension Pack (this is required for USB passthrough)**

1. Scroll down in the above link until you see the following link

![image-20220608002355853](./readme.assets/image-20220608002355853.png)

2. In your VirtualBox GUI, navigate to "Preferences"

![image-20220608002501720](./readme.assets/image-20220608002501720.png)

3. Navigate to "Extensions", and click the "add" button

![image-20220608002602941](./readme.assets/image-20220608002602941.png)

4. Select the previously downloaded extension pack and install it

   ![image-20220608002700463](./readme.assets/image-20220608002700463.png)


##### NOTE For linux users
You can install virtualbox through the command line with a little less hassel.

`sudo apt get update`

`sudo apt install virtualbox virtualbox-ext-pack`

**NOTE** that you need to upgrade `virtualbox` **AND** `virtualbox-ext-pack` at the same time when updates are available. If you do not, you can get some very cryptic errors which are otherwise unhelpful.

#### Setup VM

Clone the repo and run the following commands:

```bash
git clone https://github.com/waterloop/firmware-vagrant
cd firmware-vagrant

vim custom.rb   # (Optional) customize the VM settings by editing ./custom.rb
vagrant up --provision
```

Now, you can log into your box by doing:

```bash
vagrant ssh     # must be ran in the same directory as "vagrantfile"
```

Here are some useful vagrant commands:

```bash
# NOTE: these must be ran in the same directory as the "vagrantfile"
vagrant up        # start the VM
vagrant halt      # shutdown the VM
vagrant ssh       # ssh into the VM

vagrant destroy           # completely removes the VM from your system (careful with this one)
vagrant up --provision    # re-provision the VM
```

#### Using Vagrant with VSCode

You can develop code inside your vagrant box in VSCode using the [remote ssh](https://code.visualstudio.com/docs/remote/ssh-tutorial)
extension.

0. Generate SSH keys (if you haven't already)

```bash
ssh-keygen
```

1. Put the following in your host's $HOME/.ssh/config file:

```
Host vagrant
    Hostname localhost
    User vagrant
    Port 2222
```

2. In VSCode, log into the "vagrant" SSH host

![](./readme.assets/vscode.png)

**Common Issues**

When creating, configuring, and running VMs for the first time using Vagrant, you may encounter the following:

* When asked to choose the network interface, enter the number for the given options, not the network interface name. Ensure to use the network interface which provides internet (wifi or ethernet).
  * eg. enter 1 , not en0
![image-20220922_network](./readme.assets/image-20220922_network.png)

* If you encounter the below error, ensure that Virtualization Technology is enabled in your machine's BIOS. Procedure to do this may vary for different manufactuers.
![image-20220922_network](./readme.assets/image-20220922_vmerror.png)

![image-20220922_bios](./readme.assets/image-20220922_bios.png)

**Shared Folder**

Vagrant will automatically create a shared folder mounted as `/vagrant` inside the VM, which shares the files in the same directory as the `vagrantfile`.  You can use this to easily transfer files from your VM to your host and vice-versa. You might find creating a symlink to be convienent:

```shell
ln -s /vagrant /home/vagrant/shared
```

#### Upgrading VM from Changes to Vagrantfile

This repo's `vagrantfile` will be updated (we will let you know if this happens). When this happens, pull the changes from git and run `vagrant up --provision`, which should updated your VM with the new changes.

In the worst-case scenario, a `vagrant destroy` will probably fix most things (make sure you back up the files on your VM before you do this however)
