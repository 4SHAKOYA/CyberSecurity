## Automated ELK Stack Deployment

The files in this repository were used to configure the network depicted below.

![](https://github.com/4SHAKOYA/CyberSecurity/blob/main/Diagrams/Module13-ELK-Server.jpg)


These files have been tested and used to generate a live ELK deployment on Azure. They can be used to either recreate the entire deployment pictured above. Alternatively, select portions of the **YAML(yml)** file may be used to install only certain pieces of it, such as Filebeat.

#### ELK Server
In order to install the **ELK Server** you will need to execute this YAML script:

  - [ELK Server](https://github.com/4SHAKOYA/CyberSecurity/blob/main/Ansible/install-elk.yml)

    ##### Filebeat
    In order to configure the ELK Server to collect data regarding file activity you have to **configure the ELK server** be executing this **YAML** file:
    
      - [Filebeat Config File](https://github.com/4SHAKOYA/CyberSecurity/blob/main/Ansible/filebeat-config.yml)
    
    Once configured you then need to *execute the following script* so that the other servers are configured to report changes to the ELK server.
    
      - [Filebeat Playbook](https://github.com/4SHAKOYA/CyberSecurity/blob/main/Ansible/filebeat-playbook.yml)

    ##### Metricbeat
    In order to configure the ELK Server to collect the performance metrics of the other servers you first must **configure** the ELK server by executing this **YAML** file:

      - [Metricbeat Config File](https://github.com/4SHAKOYA/CyberSecurity/blob/main/Ansible/metricbeat-config.yml)

    Once this has been successfully executed then you will need to execute this script to instruct the other servers to **report their metrics to the ELK Server**:
 
      - [Metricbeat playbook](https://github.com/4SHAKOYA/CyberSecurity/blob/main/Ansible/metricbeat-playbook.yml)



This document contains the following details:
- Description of the Topology
- Access Policies
- ELK Configuration
  - Beats in Use
  - Machines Being Monitored
- How to Use the Ansible Build


### Description of the Topology

The main purpose of this network is to expose a load-balanced and monitored instance of DVWA, the D*mn Vulnerable Web Application.

Load balancing ensures that the application will be highly **available**, in addition to restricting **access** to the network.  By using a jump box (essentially a virtual machine) provisioned with a software based container product such as docker along with the use of load balancing services make it easy to quickly manage and deploy virtual machines that have been preconfigured and provisioned with their specific roles and needs (such as in this case of the DVWA web servers).  This aids the administrator in offering the abilityto bring more virtual servers online or shutdown as the needs arise.  Additionally, this functionality also gives the administrator the ability to update and apply the most recent application and security updates to a single image while still having the sevices available to the end user.

Integrating an ELK server allows users to easily monitor the vulnerable VMs for changes to the **files, event logs** and system **metrics**.  By using software applications and services such as **Filebeat** and **Metricbeat** allow other computers to send messages and notifications to the ELK server when specific conditions have been meet.  For instance **Filebeat** *can be configured to watch for changes to any (or specific) files* and/or when *new files are created*. **Metricbeat** is a product similar in nature to Filebeat except that instead of notifying the ELK server with file information it sends through information about the *performance* (or metrics) of the virtual server itself.  Information such **CPU Utilization, disk usage and available memory** are important for the system andministrators to determine if there is a problem with the services/server or if the server is being simple being overwhelmed and more servers need to be brought online.

The configuration details of each machine may be found below.


| Name          |          Function         |          IP Address          | Operating System |
|---------------|:-------------------------:|:----------------------------:|:----------------:|
| Jump Box      |          Gateway          |   10.1.0.4 / 52.149.145.79   |      Linux       |
| Web1          |      DVWA Web Server      |           10.1.0.5           |      Linux       |
| Web2          |      DVWA Web Server      |           10.1.0.6           |      Linux       |
| Web3          |      DVWA Web Server      |           10.1.0.8           |      Linux       |
| ELK Server    |  Log/Notification Server  |   10.2.0.4 / 40.78.137.217   |      Linux       |



### Access Policies

The machines on the internal network are not exposed to the public Internet. 

The **Jump Box Provisioner** machine can accept **SSH** connections from the Internet. Access to this machine is only allowed from **my personal IP address**. The **ELK Server** machine can accept **HTTP** connections from the Internet. Access to this machine is restricted to only allow connectivity from **my personal IP address**. Only the **Load Balancer** can accept connections from the internet and access is restricted to **TCP on port 80**.

Machines within the network can only be accessed by **other machines in the same local network** or **any networks which are set up with peerless mode**.  Only the **Jump Box Provisioner** machine can access the **ELK Server** virual machine from its local IP address which is **10.1.0.4**.


A summary of the access policies in place can be found in the table below.

| Name          |   Publicly Accessible   |     Allowed IP Addresses    |
|---------------|:-----------------------:|:---------------------------:|
| Jump Box      |           Yes           | My Personal IP / Local VNET |
| Load Balancer |           Yes           |        Any IP Address       |
| Web1          |            No           |          Local VNET         |
| Web2          |            No           |          Local VNET         |
| Web3          |            No           |          Local VNET         |
| ELK Server    |           Yes           |  My Personal IP / 10.1.0.4  |


### Elk Configuration

Ansible was used to automate configuration of the ELK machine. No configuration was performed manually, 
which is advantageous because it enables us to automate the installation and/or configuration of software 
as well as the operating system so that if the need arises (such as an attack) an identical virtual computer 
can be duplicated and brought online within a very short period of time adding to the **Availability** 
component of the CIA triad.  Additionally updates, both security and software, can be applied against 
the master image ensuring that it is always up to date.


The playbook implements the following tasks:
- Sets the virtual computer memory to be large enough to ensure that Ansible would be able to run correctly
- Installs Docker.io using the apt-install command and ensure the service runs automatically even if the computer restarts.
- Installs the Phython (version 3) programming language and interputer using the apt-install command and also ensures that the interputer it will restart automatically.
- It then downloads a docker container which is an image of a virtual computer which has already been defined and available for download from a given source (in this case from the public internet).
- It then configures the docker container to allow connectivity on specific ports and starts and ensures that the docker service is running and will automatically restart if the computer does.

The following screenshot displays the result of running `docker ps` after successfully configuring the ELK instance.

![](https://github.com/4SHAKOYA/CyberSecurity/blob/main/Diagrams/docker_ps_output.png)


### Target Machines & Beats
This ELK server is configured to monitor the following machines:

| Name          |          IP Address          |
|---------------|:----------------------------:|
| Web1          |           10.1.0.5           |
| Web2          |           10.1.0.6           |
| Web3          |           10.1.0.8           |

 _TODO: List the IP addresses of the machines you are monitoring_

We have installed the following Beats on these machines:
- _TODO: Specify which Beats you successfully installed_

These Beats allow us to collect the following information from each machine:
- _TODO: In 1-2 sentences, explain what kind of data each beat collects, and provide 1 example of what you expect to see. E.g., `Winlogbeat` collects Windows logs, which we use to track user logon events, etc._


### Using the Playbook
In order to use the playbook, you will need to have an Ansible control node already configured. Assuming you have such a control node provisioned: 

SSH into the control node and follow the steps below:
- Copy the _____ file to _____.
- Update the _____ file to include...
- Run the playbook, and navigate to ____ to check that the installation worked as expected.

_TODO: Answer the following questions to fill in the blanks:_
- _Which file is the playbook? Where do you copy it?_
- _Which file do you update to make Ansible run the playbook on a specific machine? How do I specify which machine to install the ELK server on versus which to install Filebeat on?_
- _Which URL do you navigate to in order to check that the ELK server is running?

_As a **Bonus**, provide the specific commands the user will need to run to download the playbook, update the files, etc._
