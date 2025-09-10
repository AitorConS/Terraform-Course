A networking module that should
1. [DONE]Create a VPC with a given CIDR block
2. Allow the user to provide the configuration for multiple subnets
    2.1 The user should be able to mark a subnet as public or private
        2.1.1 If at least one subnet is public, we need to deploy a IGW
        2.1.2 We need to associate the public subnets with a public RTB
    [DONE]2.2 The user should be able to provide AWS AZ
    [DONE]2.3 The user should be able to provide CIDR blocks
