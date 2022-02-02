Site Mesh
=========

Site Mesh can be used to connect CE sites via direct tunnels instead of traversing an RE.

To setup Site Mesh each of the VoltMesh nodes will need to establish a connection to each other either via
a Public IP address or a shared network that connects the nodes.

Exercise #1: Site Selector
~~~~~~~~~~~~~~~~~~~~~~~~~~

First we will need to create a Site Selector in the "Shared" namespace to identify resources that will be 
part of the Site Mesh.

- From the menu scroll to "Shared Configurations" that is towards the bottom of the list
- Click on "Virtual Sites"
- Click on "Add Virtual Site"
- Give the site a name i.e. "[unique name]-site-mesh"
- For "Site Type" select CE
- Under Site Selector Expression click on "Add Label"
- Select a key of "ves.io/app"
- Select "In" for operator
- Enter a value of "[unique name]-site-mesh"

Exercise #2: Obtain WAN IP Address
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

- From "AWS TGW Sites" in VoltConsole find your site and click on the name of your site
- Click on the "Site Status" tab at the top of the page
- Take note of the "Site WAN IP" (you will use this value in the next exercise)


Exercise #3: Apply Label and Tunnel IP
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

- From "AWS TGW Sites" in VoltConsole find your site and click on the three dots under the "Actions" column
- Click on "Manage Configuration"
- In the top right click on "Edit Configuration"
- Under "Labels" click on "Add Label"
- Enter "ves.io/app"
- Enter a value of "[unique name]-site-mesh"
- Under "Advanced Configurations" enter the "Site WAN IP"

Repeat this for other sites that you would like to include with Site Mesh.