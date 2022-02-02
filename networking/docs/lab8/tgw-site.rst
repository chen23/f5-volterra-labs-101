AWS TGW Site
============

The architecture of an AWS TGW Site differs from a AWS VPC Site by creating a "Services" VPC that
hosts the Volterra software.  AWS Transit Gateway is used to steer traffic from attached VPCs to 
the Services VPC.  Any traffic that traverses out of a spoke VPC will traverse the Volterra gateway.

Exercise 1: Create AWS TGW Site
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

- From VoltConsole browse to "Cloud and Edge Sites" and click on "AWS TGW Sites"
- Click on "Add AWS TGW Site
- Provide a Name for the site, i.e. "[unique name]-tgw"
- Under "AWS Configuration" click on "Configure"
- Enter your preferred AWS region
- Provide the CIDR of "10.4.0.0/16" for "Primary IPv4 CIDR block"
- Under "Ingress/Egress Gateway (two Interface) Nodes in AZ" click on "Add Item"
- Click on "Show Advanced Fields"
- Specify an AWS AZ for "AWS AZ Name" (make sure same region as previously entered)
- Change "Subnet for Inside Interface" to "Specify Subnet"
- For the "Inside" subnet specify "10.4.1.0/24"
- For the "Workload" subnet specify "10.4.3.0/24"
- For the "Outside" subnet specify "10.4.0.0/24"
- Click on "Add Item" when you have entered all your subnets to return to the previous screen
- Under "Deployment" select your AWS Cloud Credential
- Click "Apply"

Exercise 2: Apply AWS TGW Site
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

- You should now be able to click on "Apply" next to your newly created site 

Exercise 3: Update Network Configuration
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

It will take several minutes for the site to complete being setup.  Once the site is "online" you
can proceed with connecting additional VPCs and attaching a Global Network

- From "AWS TGW Sites" in VoltConsole find your site and click on the three dots under the "Actions" column
- Click on "Manage Configuration"
- In the top right click on "Edit Configuration"
- Under "VPC Attachments" click on "Edit Configuration"
- Click on "Add Item"
- Enter the VPC ID that you created earlier for your Spoke VPC
- Click on "Add Item" to return to the previous screen
- Under "Network Configuration" click on "Edit Configuration"
- Click on "Show Advanced Fields" in the top right
- Under "Select Global Networks to Connect" click on "Add Item"
- Leave the default of "Direct, Site Local Inside to a Global Network"
- Select your Global Network that you created previously in Lab 4
- Click on "Add Item" to return to the previous screen
- Click on "Apply" to return to the previous screen
- Click on "Save and Exit"

Exercise 4: Apply AWS TGW Site
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Some actions will require you to re-apply your site.  Adding additional VPC attachments requires you to re-apply.

- From "AWS TGW Sites" in VoltConsole find your site and click on the three dots under the "Actions" column
- Click on "Apply"

Exercise 5: Deploy workload VM
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Once the Spoke VPC has been attached to our TGW Site we can deploy a workload VM in our VPC that 
will use the VoltMesh node as its NAT GW.  

From your UDF environment access the "Client" host either via SSH or Web Shell.

Run the following commands to deploy the workload VM.

.. code-block:: Shell
  
  $ cd f5-volterra-labs-101/testdrive/networking/workload_tgw/
  $ terraform apply -auto-approve
    ...
    workload_ip = "10.0.3.81"

You should now be able to access these hosts from the UDF environment "Global Network Client"