variable "aws_region" {
    type = string
}

variable "vpc_id" {
    type = string
}

variable "key_name" {
    type = string
}

variable "instance_type" {
    type = string
    default = "t3.micro"
}