# AWS Related Scripts

2018-02-19

I plan on uploading cloudformation templates and AWS sample files to this repo. Any other AWS related bits will end up here as well.

1. Windows is different.
  While trying to setup an ALB with two windows instances, I kept running into issues with my metadata. I was using configsets for my linux instances and those work as expected. For windows, for some reason once a reboot happens, the process discontinues running the rest of the userdata section.

  In the end, if a reboot is required for windows, there is race on the reboot and handing off the signal to the system. You can read more here.

  https://aws.amazon.com/premiumsupport/knowledge-center/create-complete-bootstrapping/

  I got rid of the config set and just ran all my metadata in one config set. I made sure cfn-init.exe ran cfn-signal.exe last to let the process know all is well.

2. Documentation is key.
  I was trying to make a NLB using AWS::ElasticLoadBalancingV2::LoadBalancer. When I got to the section of specifying subnets, for some reason I kept getting an error saying that was not valid. I read, and reread, the documentation about V2 but it seemed to imply that if I am trying to make an NLB, I can't use Subnets.

  Eventually a colleague of mine pointed out that yes you can use Subnets as he has done it already.

  Ah documentation. You fickle, fickle beast.

3. Trying terraform.
  When I started using cloudformation I was also setting up a process to build windows servers (on-prem only) using terraform. I knew terraform had hooks to AWS but I never had a chance to try it out. I'll probably challenge myself to build both a cloudformation nested stack and a terraform module to setup an environment.
