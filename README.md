# Deploymemnt of EKS Infrastructure on AWS with Terraform



# Getting Started with Amazon EKS using Terraform

There are terraform scripts in our project. By running the following commands terraform creates
EC2 instance and EKS cluster for us in the desired region. 
Before executing the below scripts the user must have created an IAM role and needs to be configured
on your local machine. Else the access_key & secret_key needs to be configured in terraform script. So, you can create one temprory account from aws dashboard
(click in your account name, then click on "my security credential".then you should open "Access Key" tab, and click in the "Create Access Key").

````
terraform init   //to initialize terraform 
terraform plan   //to review the tf scripts and to make the plan by terraform
terraform apply  //final command to execute the provision of infra on cloud or on-premise
```` 
The deployment of infra will take several minutes.


## Deploying Cluster AutoScaler

Before deploying Cluster Auto Scaler, we need to create AutoScaling Policy & attached to worker node group which is needed to  access the worker nodes and auto scale whenever needed. So you should follow these tow steps:

### 1. create our role for EKS
role_arn=$(aws iam create-role --role-name started-eks-role --assume-role-policy-document file://worker-node-group-policy.json | jq .Role.Arn | sed s/\"//g)
aws iam attach-role-policy --role-name started-eks-role --policy-arn  arn:aws:iam::aws:policy/AmazonEKSClusterPolicy

### 2. Script
You should deploy Auto Scaler as following below:
````
 kubectl apply -f auto-scaler/service-account.yaml
 kubectl apply -f auto-scaler/roles.yaml
 kubectl apply -f auto-scaler/deployment.yaml
````
# Add nodes to our cluster

We should set some command in AWS CLI as following below:

```

# create our role for nodes
role_arn=$(aws iam create-role --role-name eks-role-nodes --assume-role-policy-document file://worker-node-group-policy.json | jq .Role.Arn | sed s/\"//g)

aws iam attach-role-policy --role-name started-eks-role-nodes --policy-arn  arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy
aws iam attach-role-policy --role-name started-eks-role-nodes --policy-arn  arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy
aws iam attach-role-policy --role-name started-eks-role-nodes --policy-arn  arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly

aws eks create-nodegroup \
--cluster-name started-eks \
--nodegroup-name test \
--node-role $role_arn \
--subnets subnet-0ec47e6ae964a233f \
--disk-size 200 \
--scaling-config minSize=1,maxSize=2,desiredSize=1 \
--instance-types t2.small
```

# Answer some question after deployment

before apply our project, we answer some question about our work as following below:

## Q1. What set of tools would we use with the cluster to make it production enviroment ready? Why would we use them and what would be the benefit from using these specific tools?

```
EKS
Kubectl
Terraform
aws-iam-authenticator
EC2
//kubectl & aws-iam-authenticator cli tools need to be installed on local machine.
```
### Amazon EKS
Amazon Elastic Kubernetes Service (Amazon EKS) gives us the flexibility to start, run, and scale Kubernetes applications in the AWS cloud or on-premises.

### Kubectl
The kubectl command line tool lets you control Kubernetes clusters. It help us to access all kubernetes services by applying command and push some YAML config file into kubernetes.

### Terraform: 
* Its another popular Infrastructure as Code tool to create infrastructure in declarative way. Using this tool 
  we can create servers, clusters or any other infra on on-premises, AWS, GCP, IBM Cloud, Azure, etc.


## Q2. What would be our deployment approach and tools? Why?

As we mention in the first question we need some tools to deployment our project. We want to deploy NginX sample deployment to show our work currently work on aws and, deploy a web service is the first step to have web application for any web application project.

in this project we ran docker container installed some utilities,created Terraform file and config,  ran some command line, and created AWS IAM role, attached a policy to the role, we got a vpc template deployment a cloud formation template, ran some more script, download a json, create the node role, added policy to the role, added extra node cluster, etc.

why Terraform? The tipical problem with creating infrastructure from scripts is that is becomes really hard to maintain what if I wanted to make a small change someware in one of the line of the scripts, it may be appened some issue and error . So scripts are not guaranteed yo allways Work. So they have to be maintain. This is where Terraform comes in it.
Terraform allows us to decribr our infrasttucture in an easy to read modular template. We simply tell Terraform to deploy it.

## Q3. What monitoring and cluster services would we use and why?

we created output Terraform to show are status of which step done in terraform. we can use Logging and in Amazon EKS during deploy our project or seeing some warning and arror in this process. And for monitoring after deployment, we can see all cluster and running service in aws dashboard or we can config monitoring tools to visualize all status of our process.





# Clean up 

If you want to clean up all things in terraform, you can run script as following below:

```
terraform destroy
```
