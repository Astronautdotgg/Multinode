# Multinode

----
## What is multinode?


The **Multinode** scripts is a collection of utilities to manage, setup and update masternode instances.

The core of this application is forked from an abandoned project, and we've been passionate about making this even better by including more features and coins/tokens. 
We are quite confident this is the single best and almost effortless way to setup different crypto masternodes, without bothering too much about the setup part.

If this script helped you in any way, please contribute some feedback. If you need support, contact Brett or Pineapple in either of these Discords: <a href="https://discord.gg/PpxbJ3u">Pure Investments</a>   or   <a href="https://discord.gg/">CTTV</a>

## Supported masternode projects

All PIVX based coins can be added to this reository. Currently supported is:

* BITCORN (CORN)
* LEMONAD (LAD)
* Carbon Zero (CZE)
---

## Donations

This is licenced for free, but donations are very welcome. It will help me find motivation to update and improve it. 

Bitcoin:

    1HUpAVhahnnHxAFTWzXX4t8SNza5qES1aS


## Recommended VPS provider

**Vultr** is highly recommended for this kind of setup as thats what we are using for testing and personal use. Make sure to click "IPv6 during installation of the server and you should be good to go. 

Feel free to use out reflink to signup and receive a bonus w/ vultr:
<a href="https://www.vultr.com/?ref=7755704"><img src="https://www.vultr.com/media/banner_2.png" width="468" height="60"></a>

---

## About / Background

After doing countless masternode installations and administrating the past two years, we decided to share our modified script with the public.

Comparing with building from source manually, you will benefit from using this script in the following way(s):

* 100% auto-compilation and 99% of configuration on the masternode side of things. It is currently only tested on a vultr VPS but should work almost anywhere where IPv6 addresses are available
* Developed with 16.04 Ubuntu versions
* Installs 1-100 (or more!) masternodes in parallel on one machine, with individual config and data
* Compilation is currently from source for the desired git repo tag (configurable via config files)
* Some security hardening is done, including firewalling and a separate user
* Automatic startup for all masternode daemons
* This script needs to run as root, the masternodes will and should not!
* It's ipv6 enabled!

# Installation

Below is a guide meant to help you install your masternodes smooth like butter

#### 1.0 - Clone and open project on your VPS

VPS:

    git clone https://github.com/cisnes/multinode.git && cd multinode


### 1.1 - Send collateral to your MN adresses

Make one new receiving address for each of your new masternodes, and send **exactly** the collateral to each of them. You can find collateral in the white paper/reward structure.

### 1.2 - Generate private keys for your masternodes
In your wallet, open the debug console window and type:

    masternode genkey

for each of your new masternodes, and copy these to your masternodes.conf file which you can find in your coins data-folder. 

### 1.3 - Copy Txhash and OutputID to masternodes.conf

Still in the debug console, type:
    
    masternode outputs

And copy the Txhash and OutputID to masternodes.conf and past them in the correct format. Note: The formatting of the file is very strict, and needs to be followed exactly as the example below. Do not have any empty lines in the project and do one MN per line:

    MN01 IPGOESHERE PRIVATEKEYGOESHERE TXHASHGOESHERE OUTPUTIDGOESHERE
    MN02 IPGOESHERE PRIVATEKEYGOESHERE TXHASHGOESHERE OUTPUTIDGOESHERE

### 2.0 Install the masternodes
By now you have prepared your wallet with the necessary variables and it's time to initialize script and make masternodes. 

The script you will be using is in the *multinode* folder and is called install.sh. You're calling this by using ./ as a prefix. The first flag -p is the project. Currently supported projects is stated further above in the readme file. The second flag -c is the count. This is the total number of MNs you want to have installed. And the third flag is -n which is indicating you will be using network settings for IPv6 (required to have multiple MNs)

The following script will install **3 bitcorn** masternodes using **IPv6**.

    ./install.sh -p bitcorn -c 4 -n 6

Take note of this: The **count/-c** is the **total** number of masternodes of that coin you want to have installed on the VPS. If you already have 3 MNs and want to install 3 more, you need to use `-c 6`. The first 3 masternodes are not affected. 


### 2.1 Enter private keys
The first installation of your wanted coin will take up to 30min to get everything set up. Later installations will take a couple of minutes

During the end of the installation, it will ask for your private keys like this:
    
    Genkey for MN01: 

Here you enter the genkey from the masternodes.conf file which you made in step 1.2. 

### 2.2 Find IP-adresses
When the installation is done, you will be returned back to the normal console. Now you need to find the IP-adresses of each MN and paste them in masternodes.conf on your computer. 

Navigate to the correct directory:

    cd /etc/masternodes

Type

    ls

And it will list all the possible configurations. If you installed MN1 to MN4 now, type:
    
    nano bitcorn_n1.conf

Copy the IP-adress which you can find after "bind=". Make sure to include the brackets [] as it's a part of the address. Paste it in the masternodes.conf after the alias. 

Exit the editor by typing pressing CTRL X.
If it ask you if you want to save changes, press N and click enter. 

Do the same for the others as well. Just change the number after n. 

### 2.3 Start masternode services
After you have copied all the IPs to your masternode.conf file and it's complete, it's time to start the MN service on the VPS.
This is done using this command
    
    activate_masternodes_bitcorn


### 2.4 Check masternode status
You can check the status of your coin normally, but now you need to specify which coin you want to check.

    bitcorn-cli -conf=/etc/masternodes/bitcorn_n1.conf getinfo

Replace getinfo with whatever command you would normally use with the CLI. Replace the number with whatever MN you want to check. 


### 2.5 Check block-sync
The blockchain needs to be synced before you can start your MNs through the wallet. Do this by typing 

    bitcorn-cli -conf=/etc/masternodes/bitcorn_n1.conf mnsync status

For all masternodes (again change the number to check all). When it's returning true on synced, you can proceed to next step

### 2.6 Start masternode from wallet
Last step is starting the MN from the wallet. Do it in the debug console of the wallet like this:

    startmasternode alias 0 MN01

Replace MN01 with the alias from masternodes.conf you want to start.
Confirm the MN is started by typing this on the VPS.

    bitcorn-cli -conf=/etc/masternodes/bitcorn_n1.conf masternode status

Again replace the number with what you want to change. 

Now you're done!
## Options

The _install.sh_ script support the following parameters:

| Long Option  | Short Option | Values              | description                                                         |
| :----------- | :----------- | ------------------- | ------------------------------------------------------------------- |
| --project    | -p           | "bitcorn"           | shortname for the project                                           |
| --net        | -n           | "4" / "6"           | ip typae for masternode. (ipv)6 is default                           |
| --release    | -r           | e.g. "tags/v3.2.0.6"| a specific git tag/branch, defaults to latest tested                |
| --count      | -c           | number              | amount of masternodes to be configured                              |
| --update     | -u           | --                  | update specified masternode daemon, combine with -p flag            |
| --sentinel   | -s           | --                  | install and configure sentinel for node monitoring                  |
| --wipe       | -w           | --                  | uninstall & wipe all related master node data, combine with -p flag |
| --help       | -h           | --                  | print help info                                                     |
| --startnodes | -x           | --                  | starts masternode(s) after installation                             |

## Adding more MNs to your already existing chunk of BITCORN masternodes

The script works the following way that the -c(ount) flag defines the TOTAL number of MNs on the VPS. If you already have 4 masternodes and wish
to install one more, you need to use the number 5 on the -c flag. Like so:

```bash
./install.sh -p bitcorn -c 5 -n 6
```

This will install one more MN in addition to your old 4. The old MNs are not affected.

After that, do the steps described in the main-installation part.
s