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

---

## Recommended VPS provider

**Vultr** is highly recommended for this kind of setup as thats what we are using for testing and personal use. Make sure to click "IPv6 during installation of the server and you should be good to go. 

Feel free to use out reflink to signup and receive a bonus w/ vultr:
<a href="https://www.vultr.com/?ref=7755704"><img src="https://www.vultr.com/media/banner_2.png" width="468" height="60"></a>

---

## About / Background

After doing counless masternode installations and administrating the past two years, we decided to share our modified script with the public.

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

    MN01 PRIVATEKEYGOESHERE TXHASHGOESHERE OUTPUTIDGOESHERE
    MN02 PRIVATEKEYGOESHERE TXHASHGOESHERE OUTPUTIDGOESHERE

### 2.0
By now you have prepared your wallet with the necessary variables and it's time to initialize script and make masternodes. 

The script you will be using is in the *multinode* folder and is called install.sh. You're calling this by using ./ as a prefix. The first flag -p is the project. Currently supported projects is stated further above in the readme file. The second flag -c is the count. This is the total number of MNs you want to have installed. And the third flag is -n which is indicating you will be using network settings for IPv6 (required to have multiple MNs)

The following script will install **3 bitcorn** masternodes using **IPv6**.

    ./install.sh -p bitcorn -c 4 -n 6
Take not of this: The **count/-c** is the **total** number of masternodes of that coin you want to have installed on the VPS. If you already have 3 MNs and want to install 3 more, you need to use `-c 6`. The first 3 masternodes are not affected. 

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

## FOLLOWING IS A COMPLETE GUIDE TO INSTALLING 4 BITCORN MASTERNODES FROM START TO FINISH

SSH to your VPS and clone this Github repository (just copy paste the command):

```bash
git clone https://github.com/cisnes/nodemaster.git && cd nodemaster
```

Lets say you want to install 4 BITCORN masternodes on your VPS using IPv6

```bash
./install.sh -p bitcorn -c 4 -n 6
```

-p flag specifies the project: bitcorn

-c flag specifies the count:   4

-n flag specifies the network protocol: IPv6

The installation can take up to 30 minutes the first time, and once done you will see a splashscreen. As long as it's not saying "COMPILATION FAILED", it's succeeded. 

Now you need to enter the masternode genkeys to the conf-files:

```bash
cd /etc/masternodes
```

Back on the VPS, you can type 
```bash
ls -la
```
and it will list you the different MN configuration files available. You need to add individual genkeys to all of them and copy their IPv6 address. 

The files will be named (for BITORN): `bitcorn_n1.conf` with the number following N indicating the MN number. Now you need to open and edit all of them, but for the sake of the tutorial we will only do 1. 
```bash
nano bitcorn_n1.conf
```
And you will reach the nano text-editor. Now you need to copy the externalIP variable which should have an IPv6 address in itself. You paste this one in your masternodes.conf file locally on your computer the same way as you would've put your IPv4 address. Make sure you include the brackets []. 

By now you should have sent the collateral to your MN addresses in your wallet. Open the local wallets debug console and type
```bash
genkey
```

Copy this genkey and paste it after `masternodeprivkey=`.

Back in your local wallets debug console, type 
```bash
masternode outputs
```

and copy the txhash and outputid to your masternodes.conf file as normal.

Repeat the steps above for all your masternode configuration files.

Once all mastenodes are configured, it's time to start them up with the following command:
```bash
sudo /usr/local/bin/activate_masternodes_bitcorn
```
This can take up to a minute or two, depending on the number of masternodes you are trying to start. Once they're started, the blockchain will start to synchronize. This will probably take more time than usual, as all the nodes are syncing at the same time. 

The normal 
```bash
bitcorn-cli getinfo
```
is not working anymore as you have several masternodes running in parallel, you therefore need to specify which masternode you want to work on like this:
```bash
bitcorn-cli -conf=/etc/masternodes/bitcorn_n1.conf getinfo
```
Replace the number following N with the masternode you wish to check the status on. 

```
bitcorn-cli -conf=/etc/masternodes/bitcorn_n1.conf getinfo

{
  "version": 1000302, 
  "protocolversion": 70701,
  "walletversion": 61000,
  "balance": 0.00000000,
  "privatesend_balance": 0.00000000,
  "blocks": 209481,
  "timeoffset": 0,
  "connections": 5,
  "proxy": "",
  "difficulty": 42882.54964804553,
  "testnet": false,
  "keypoololdest": 1511380627,
  "keypoolsize": 1001,
  "paytxfee": 0.00000000,
  "relayfee": 0.00010000,
  "errors": ""
}
```

## Adding more MNs to your already existing chunk of BITCORN masternodes

The script works the following way that the -c(ount) flag defines the TOTAL number of MNs on the VPS. If you already have 4 masternodes and wish
to install one more, you need to use the number 5 on the -c flag. Like so:

```bash
./install.sh -p bitcorn -c 5 -n 6
```

This will install one more MN in addition to your old 4. The old MNs are not affected.

After that, do the steps described in the main-installation part.


----
## markdown quick reference
# headers

*emphasis*

**strong**

* list

>block quote

    code (4 spaces indent)
[links](https://wikipedia.org)

----
## changelog
* 17-Feb-2013 re-design

----
## thanks
* [markdown-js](https://github.com/evilstreak/markdown-js)
