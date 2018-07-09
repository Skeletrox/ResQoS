# ResQoS

## Resource-Centric QoS System

----------

This is the repository for a Resource-Centric QoS System that prioritizes bandwidth based on what routes/resources are called, similar to an information priority lane.

## Setting up

### Your Router

1. Store `initialize.sh` and `tc_script.sh` in your `$HOME` directory.

2. Ensure your account has password-less `sudo` privileges as the above scripts may need to be run non-interactively as `sudo`.

3. Setup `initialize.sh` to run on startup.

4. Edit `initialize.sh` and `tc_script.sh` to point to the appropriate routes and badnwidths. The default setup is given in a section below.

5. Ensure your client is connected to the router at `eth0`. If it is not possible to change the interface to `eth0`, change `initialize.sh` and `tc_script.sh` to work on the other interface.

### Your Server

1. Edit `controller.c` to point to the appropriate location of `script.sh`.

2. Ensure `script.sh` is edited to reflect any changes in directories, addresses and certificate files.

3. Compile `controller.c` using APXS and restart apache: `sudo apxs -i -a -c controller.c && sudo service apache2 restart`

### Your Client

1. Ensure that your router is a gateway to the server. You may have to run `sudo route add -net <server IP>/<mask> gw <IP address of router>`

## Default Setup

The default setup in the respository is:

* A 4Mbps pseudo-congested link that serves all requests
* Any request for `/dunkirk.mp4` is priority and is served at 3Mbps
* Remaining requests are served at 800Kbps

## Enhancements and WIP

* Deleting dynamically created filters [currently running `initalize.sh` again deletes all rules and initializes the system]
