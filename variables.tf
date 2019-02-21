### AWS connection settings

variable "aws_access_key" {}
variable "aws_secret_key" {}

// variable "aws_region" {
//   default = "us-east-1"
// }

### AWS configuration settings

variable "user_name" { description = "user to be recorded on AMI tag" }

variable "keypair_name" {
  description = "name of keypair if it already exists; otherwise, one will be created with the pet name of the created VM"
  default     = ""
}

// variable "aws_image" {
//   type = "map"
//   # Default is Canonical, Ubuntu, 16.04 LTS, amd xenial image
//   default = {
//     owner = "679593333241"
//     ami   = "ami-068ab34816099a0a9"
//   }
// }

// variable "aws_subnet" {
//   description = "subnet for the AMI to run on"
//   default = ""
// }

## SSH connection settings

variable "os_username" {
  description = "Default username for the AMI used"
  default     = "ubuntu"
}

variable "private_key_file" {
  description = "Path to private key file"

  # if empty, will default to ${path.cwd}/id_rsa
  default = ""
}

variable "public_key_file" {
  description = "Path to public key file"

  # if empty, will default to ${path.cwd}/id_rsa.pub
  default = ""
}

variable "private_key" {
  description = "content of private ssh key"

  # if empty string will read contents of file at var.private_key_file
  default = ""
}

variable "public_key" {
  description = "Public key"

  # if empty string will read contents of file at var.public_key_file
  default     = ""
}

variable "ssh_agent" {
  description = "Enable or disable SSH Agent. Can correct some connectivity issues. Default: false"
  default     = false
}

### Settings for sleep tests

variable "sleep_test_1" {
  description = "Settings for first sleep test to execute; default is 8 seconds"
  type = "map"
  default = {
    run   = "false"
    sleep = "60"
    count = "1"
  }
}

variable "sleep_test_2" {
  description = "Settings for second sleep test to execute; all time is in seconds"
  type = "map"
  default = {
    run   = "false"
    sleep = "600"
    count = "1"
  }
}

variable "sleep_test_3" {
  description = "Settings for third sleep test to execute; all time is in seconds"
  type = "map"
  default = {
    run   = "false"
    sleep = "900"
    count = "1"
  }
}

variable "sleep_test_4" {
  description = "Settings for fourth sleep test to execute; all time is in seconds"
  type = "map"
  default = {
    run   = "false"
    sleep = "1200"
    count = "1"
  }
}

variable "sleep_test_5" {
  description = "Settings for fifth sleep test to execute; all time is in seconds"
  type = "map"
  default = {
    run   = "true"
    sleep = "1800"
    count = "1"
  }
}

locals {
  private_key_file = "${var.private_key_file == "" ? "${path.cwd}/id_rsa" : var.private_key_file }"
  public_key_file  = "${var.public_key_file == "" ? "${path.cwd}/id_rsa.pub" : var.public_key_file }"
  private_key      = "${var.private_key == "" ? file(coalesce(local.private_key_file, "/dev/null")) : var.private_key}"
  public_key       = "${var.public_key == "" ? file(coalesce(local.public_key_file, "/dev/null")) : var.public_key}"

  keypair_name_temp = "${var.keypair_name == "" ? "${random_pet.label.id}-keypair" : var.keypair_name}"
  keypair_name      = "${replace(local.keypair_name_temp, "/[^-_ \\w]/", "")}"
  create_keypair    = "${var.keypair_name == "" ? 1 : "0"}"

  run_1 = "${var.sleep_test_1["run"] == "true" ? 1 : 0}"
  run_2 = "${var.sleep_test_2["run"] == "true" ? 1 : 0}"
  run_3 = "${var.sleep_test_3["run"] == "true" ? 1 : 0}"
  run_4 = "${var.sleep_test_4["run"] == "true" ? 1 : 0}"
  run_5 = "${var.sleep_test_5["run"] == "true" ? 1 : 0}"
}
