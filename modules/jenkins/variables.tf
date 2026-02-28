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

variable "allowed_cidr" {
    type = list(string)
    default = ["0.0.0.0/0"]
}