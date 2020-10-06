variable "vpc_cidr" {
    default = "10.0.0.0/16"
}

variable "env" {
    default = "Test_Web"
}

variable "public_subnets_cidrs" {
    default = "10.0.3.0/24"
}