# swarm-ffed-test

Test the limits of Swarm's flat-file cluster definitions and inspection based engine discovery. That subnet has 32767 IP addresses. The tests in this repository will test a Swarm manager's "discovery by inspection" capabilities when presented with large sets of candidate IP addresses.

## Building the Cluster

Use the CloudFormation template, "file-discovery-swarm.cf" to create a small cluster in a HUGE private cloud network. The network will be a 10.0.0.0/16. The only subnet created will be 10.0.128.0/17. The Swarm manager will come up at 10.0.128.10. The other engines will have private IP addresses somewhere else in the subnet. The manager node will have a public IP address assigned. That IP address will be included as an Output of the CloudFormation stack.

## /material

This directory contains the harness, the specific test, and example subnet definitions for /17 through /24 networks.

## /logs

This directory contains the resulting data from the first full test in AWS. The manager node was running on an m3.medium instance and the engines were running on t2.micro instance.
