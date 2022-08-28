# -*- mode: ruby -*-
# vi: set ft=ruby

# This file contains a default configuration for your development Vagrant VM. It is
# not tracked by git, so you can put any of your custom configurations here and
# they shouldn't be overridden whenever you `git pull`...
#
# Feel free to edit this file to your heart's content.

Vagrant.configure("2") do |config|
    config.vm.provider "virtualbox" do |vb|
        # how much RAM to give the VM
        vb.memory = "4096"

        # how many CPU cores to give the VM
        vb.cpus = 2
    end

    # Create a bridged network adapter (TLDR: this is reccommended)
    #   - By default, the Vagrant creates a NAT adapter that it uses to connect to
    #     the internet and manage the VM
    #           - You can kinda think of this as having a "router" in between your host computer's
    #             network interfaces and the VM's network interfaces
    #
    #   - A bridged adapter will cause your VM to appear as a completely separate device on
    #     your LAN, meaning that it will have its own IP address on the network, and communication
    #     between your host and VM will become easier
    #
    #
    # The below line will make Vagrant prompt you for which network interface you want to bridge.
    # You can skip the prompt by putting the name of the interface (e.g., bridge: "en0: Wi-Fi (Wireless)")
    #
    # NOTE: on Windows, the prompt might not work, and you will probably have to manually specify
    #       the interface like mentioned above
    config.vm.network "public_network", bridge: "", auto_config: true
end

