variable "size" {
    description = "The size of the volume in gigabytes"
    type        = number
}

variable "az" {
    description = "The availability zone where the volume will be created"
    type        = string
}

variable "instance_id" {
    description = "The ID of the instance to which the volume will be attached"
    type        = string
}

variable "device_name" {
    description = "The device name to expose the volume"
    type        = string
}
