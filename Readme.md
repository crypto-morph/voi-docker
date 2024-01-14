# VOI Docker image

by Morph42

A Docker image built to mirror D13s instructions - https://d13.co/posts/set-up-voi-participation-node/.  This image can be used on Docker/Kube enabled cloud services such as https://akash.network/. 

## What is included?

The image contains:

  * Ubuntu 22.04
  * Algorand libraries setup to run the VOI chain
  * Helper scripts to speed up sync and enable telemetry

The repo also contains:

  *  `voi-deployment.yaml` - an example for deploying to Cloudmos (https://cloudmos.io/)

## How to use it? 

(example with AKASH - should work for other cloud providers with a little tweaking):

1) AKASH / Cosmos related activity:
   * Get an ATOM wallet setup (Kepir / Leap)
   * add some ATOM to the wallet
   * login to https://app.osmosis.zone/ with the wallet - and purchase some AKT (you need a minimum of 5 AKT to run a server on Cloudmos - at time of writing this is $15 - and in my tests this should be enough for 1 month)
2) Cloudmos setup: 
   * login to https://deploy.cloudmos.io/ with the wallet and click "Deploy"
   * choose Ubuntu and then paste the YAML from `voi-deployment.yaml`
   * Change "{{ your ssh client IP }}" to the machine IP you will be SSHing to the container from when it's setup (e.g your Home IP)
   * Deploy the container
3) From the interface - choose "SSH" to get a shell onto the box
4) If you want SSH access remotely (the web interface is.. limited..) run:
  `passwd` (to set a password)
  `supervisorctl start sshd` (to start SSH)
   you should be able to get to it _just_ from the the IP you set in step 2)
5) The Algod Daemon starts syncing - you can run `goal node status` to watch it - but you can speed it up by running `catchup.sh`. This will fire off the CatchupPoint instructions detailed in D13's guide and it will "follow" the catchup on the terminal - you can Ctrl-C to exit early if you wish.   
  The process will be complete when "Sync Time: 0.0" to show it's synced.
6) `setup-telemetry.sh {my name}` will setup telemetry. (e.g. ./setup-telemetry.sh morph-akash) 


You can now follow the rest of D13's guide to get your keys setup and participation started https://d13.co/posts/set-up-voi-participation-node/#participation. 

