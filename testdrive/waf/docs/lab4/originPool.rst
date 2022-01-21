Create Origin Pools
====================

Previously we created an origin pool that was accessible via the Public Internet.
The next lab exercise will create an origin pool that will access resources via
the VoltMesh node that is deployed in our lab AWS environment.

Exercise 1: Create Private Origin Pool
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
We will first create an Origin Pool that refers to the "Private Endpoint" site in our lab environment.

#. Start in VoltConsole and switch back to the "Web App & API Protection" context.

#. Navigate the menu to go to "Manage"->"Load Balancers"->"Origin Pools". Click on *Add Origin Pool*.

#. Enter the following variables:

    ================================= =====
    Variable                          Value
    ================================= =====
    Name                              private
    ================================= =====

#. Click on "Add Item" under the section "Origin Servers"

   Enter the following variables: 

    ================================= =====
    Variable                          Value
    ================================= =====
    Select Type of Origin Server      DNS Name of Origin Server on given Sites
    DNS Name                          private.lab.f5demos.internal
    Site                              |aws_site|
    ================================= =====
    
    |op-pool-basic|

    Click on "Add Item" to return to the previous screen.

#. Below the "Origin Servers" section fill in the Port information

    ================================= =====
    Variable                          Value
    ================================= =====
    Port                              8080
    ================================= =====


#. Under the *List of Health Check(s)* section, click the *Add item* button.

#. Click the *Health Check object* dropdown list. Select the *http* monitor that you previously created.

#. Click the *Save and Exit* button to create the Origin Pool.

.. |app-context| image:: ../_static/app-context.png
.. |op-pool-basic| image:: ../_static/op-pool-basic-private.png