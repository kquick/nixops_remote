let
  accessKeyId = "dev";  # searched for in ~/.ec2-keys or ~/.aws/credentials
  
  # US west 2 (Oregon) NixOS 17.03 2017 Aug
  region = "us-west-2";
  instanceType = "m3.medium";
  ami = "ami-5139ae31";
  
  # EU west 1 (Ireland) NixOS 17.03 2017 Aug
  # region = "eu-west-1";
  # instanceType = "m3.medium";
  # ami = "ami-11734a77";
in
{
   gitter = { resources, ... }:
    {
      deployment = {
        targetEnv = "ec2";
        ec2 = {
          inherit region accessKeyId instanceType ami;
          keyPair = resources.ec2KeyPairs.my-key-pair;
          securityGroups = [ "allow_ssh" ];
        };       
      };
    };

  resources.ec2KeyPairs.my-key-pair = {
    inherit region accessKeyId;
  };
}
