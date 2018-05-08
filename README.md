# AWS Related Scripts

2018-05-05

I plan on uploading cloudformation templates and AWS sample files to this repo. Any other AWS related bits will end up here as well.

1. Windows is different.

  While trying to setup an ALB with two windows instances, I kept running into issues with my metadata. I was using configsets for my linux instances and those work as expected. For windows, for some reason once a reboot happens, the process discontinues running the rest of the userdata section.

  In the end, if a reboot is required for windows, there is race on the reboot and handing off the signal. You can read more here.

  [Create Complete Bootstrapping](https://aws.amazon.com/premiumsupport/knowledge-center/create-complete-bootstrapping/)

  I got rid of the config set and just ran all my metadata in one config set. I made sure cfn-init.exe ran cfn-signal.exe last to let my CreationPolicy know my instance was ready.

2. Documentation is key.

  I was trying to make a NLB using AWS::ElasticLoadBalancingV2::LoadBalancer. When I got to the section of specifying subnets, for some reason I kept getting an error saying that was not valid. I read, and reread, the documentation about V2 but it seemed to imply that if I am trying to make an NLB, I can't use Subnets.

  Eventually a colleague of mine pointed out that yes you can use Subnets as he has done it already.

  Ah documentation. You fickle, fickle beast.

3. Trying terraform.

  When I started using cloudformation I was also setting up a process to build windows servers (on-prem only) using terraform. I knew terraform had hooks to AWS but I never had a chance to try it out. I'll probably challenge myself to build both a cloudformation nested stack and a terraform module to setup an environment.

4. VSS-Enabled Snapshots for EBS Volumes

  So I have been following the guide [Using Run Command to Take VSS-Enabled Snapshots of EBS Volumes](https://docs.aws.amazon.com/systems-manager/latest/userguide/integration-vss.html). I was using the 2018.01 version of the windows AMI which should have contained all the components necessary for the VSS enabled snapshot. What I found was that any windows AMI made after 11/28 dropped the VSS component due to issues between backup software and the component. It has yet to be baked in again.

  I had to create a State Manager association to push out the VSS component on all the windows instanced that required it. Once that was done, I was able to run the AWSEC2-CreateVssSnapshot command document and get my snapshots.

  Next phase is to test out the snapshots by cloning them and rebuilding a new server out of them. That and tagging the snapshots with the date and time of the snapshot and what instance they come from.


To-Do:
  1. Setup AWS Environment.
  2. Build a dispora server.
    https://wiki.diasporafoundation.org/Installation
  3. Setup chef server.
  4. Build a docker environment.
  5. Try out ECS.
 
