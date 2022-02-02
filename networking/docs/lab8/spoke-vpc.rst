Spoke VPC
=========

In this lab exercise we will be creating a "Spoke VPC" that will be used to host our workload.

Unlike the previous labs we will not be deploying a VoltMesh node into this VPC.

Exercise 1: Deploy Spoke VPC
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

From your UDF environment access the "Client" host either via SSH or Web Shell.

Run the following commands to deploy the VPC.

.. code-block:: Shell
  
  $ cd f5-volterra-labs-101/testdrive/networking/terraform/
  $ terraform apply -auto-approve
    ...
    AWS_CONSOLE = "https://XXXXX.signin.aws.amazon.com/console?region=us-east-1"
    AWS_INSTANCE = "192.0.2.10"
    EXTERNAL_SUBNET_ID = "subnet-0f8ec509e82e4d3f5"
    WORKLOAD_SUBNET_ID = "subnet-06c3611948fc6fc83"
    INTERNAL_SUBNET_ID = "subnet-066c974f0e37f0326"
    _VPC_ID = "vpc-05767b378021fdc6c" 