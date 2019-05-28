# Nodemaster

The **Nodemaster** scripts is a collection of utilities to manage, setup and update masternode instances.

This project was previously developed by NewCapital but lacked project updates. We forked it and Pineapple & Brett have been passionate about making this even better by including more features and coins/tokens. 
We are quite confident this is the single best and almost effortless way to setup different crypto masternodes, without bothering too much about the setup part.

If this script helped you in any way, please contribute some feedback. If you need support, contact Brett or Pineapple in either of these Discords: <a href="https://discord.gg/PpxbJ3u">Pure Investments</a>   or   <a href="https://discord.gg/">CTTV</a>


Feel free to use out reflink to signup and receive a bonus w/ vultr:
<a href="https://www.vultr.com/?ref=7755704"><img src="https://www.vultr.com/media/banner_2.png" width="468" height="60"></a>

## Supported masternode projects

All PIVX based coins can be added to this reository. Currently supported is:
BITCORN (CORN) and 
LEMONAD (LAD)

---

**NOTE on the VPS choice for starters**

**Vultr** is highly recommended for this kind of setup as thats what we are using for testing and personal use. Make sure to click "IPv6 during installation of the server and you should be good to go. 

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


Below are the complex (and juicy) installation commands. Further below is a full guide:

**Install & configure 4 BITCORN masternodes with IPv6 support:**

```bash
./install.sh -p bitcorn -c 4 -n 6
```

**Update daemon of previously installed BITCORN masternodes to the latest version:**

```bash
./install.sh -p bitcorn -u
```

**Install 6 BITCORN masternodes with the git release tag "tags/v3.2.0.6"**

```bash
./install.sh -p bitcorn -c 6 -r "tags/v1.2.0.0"
```

**Wipe all BITCORN masternode data:**

```bash
./install.sh -p lad -w
```

**Install 2 BITCORN masternodes and configure sentinel monitoring (not recently tested, use at own risk):**

```bash
./install.sh -p lad -c 2 -s
```

## Options

The _install.sh_ script support the following parameters:

| Long Option  | Short Option | Values              | description                                                         |
| :----------- | :----------- | ------------------- | ------------------------------------------------------------------- |
| --project    | -p           | "bitcorn"           | shortname for the project                                           |
| --net        | -n           | "4" / "6"           | ip type for masternode. (ipv)6 is default                           |
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
