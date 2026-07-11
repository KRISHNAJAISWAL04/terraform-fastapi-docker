variable "instance_type" {
    type = string
    default = "t3.micro"  
}
variable "ami_id" {
    type = string
    default = "ami-0aba19e56f3eaec05"
}
variable "key_pair" {
    type= string
    default = "test2-key"
  
}