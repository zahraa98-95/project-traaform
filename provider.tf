provider "aws"{
    shared_config_files = ["/home/zahraa/.aws/conf"]
    shared_credentials_files = ["/home/zahraa/.aws/cred"]
    profile = "my-vpc"
    region = "us-east-1"
}