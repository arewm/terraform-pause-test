provider "aws" {
    access_key = "${var.aws_access_key}"
    secret_key = "${var.aws_secret_key}"
    region     = "eu-west-1"
}

resource "random_pet" "label" {
  separator = "-"
  length    = "2"
}

resource "aws_key_pair" "my_key" {
    count = "${local.create_keypair}"
    key_name = "${local.keypair_name}"
    public_key = "${local.public_key}"
}

resource "aws_instance" "sleep-test" {
  count         = "1"
  ami           = "ami-0d137679f8243e9f8" # Ubuntu 18.04
  instance_type = "t1.micro"

  key_name                    = "${local.keypair_name}"
  associate_public_ip_address = "true"

  instance_initiated_shutdown_behavior = "terminate"

  tags {
    Name  = "${lower(random_pet.label.id)}-liveness"
    owner = "${var.user_name}"
    Usage = "Temp"
    Usage_desc = "Test liveness of Terraform connection"
    Review_freq = "${timeadd("${timestamp()}", "4h")}"
  }
}

data "template_file" "sleep-test-1" {
  template = "${file("${path.module}/sleep.tpl")}"
  vars {
    sleep_time  = "${var.sleep_test_1["sleep"]}"
    sleep_count = "${var.sleep_test_1["count"]}"
  }
}

resource "null_resource" "sleep-test-1" {
  count = "${local.run_1}"
  depends_on = ["aws_instance.sleep-test"]
  connection {
    type        = "ssh"
    user        = "${var.os_username}"
    host        = "${aws_instance.sleep-test.0.public_dns}"
    private_key = "${local.private_key}"
    agent       = "${var.ssh_agent}"
  }

 provisioner "remote-exec" {
  inline = ["${data.template_file.sleep-test-1.rendered}",]
 }
}

data "template_file" "sleep-test-2" {
  template = "${file("${path.module}/sleep.tpl")}"
  vars {
    sleep_time  = "${var.sleep_test_2["sleep"]}"
    sleep_count = "${var.sleep_test_2["count"]}"
  }
}

resource "null_resource" "sleep-test-2" {
  count = "${local.run_2}"
  depends_on = ["null_resource.sleep-test-1"]
  connection {
    type        = "ssh"
    user        = "${var.os_username}"
    host        = "${aws_instance.sleep-test.0.public_dns}"
    private_key = "${local.private_key}"
    agent       = "${var.ssh_agent}"
  }

 provisioner "remote-exec" {
  inline = ["${data.template_file.sleep-test-2.rendered}",]
 }
}

data "template_file" "sleep-test-3" {
  template = "${file("${path.module}/sleep.tpl")}"
  vars {
    sleep_time  = "${var.sleep_test_3["sleep"]}"
    sleep_count = "${var.sleep_test_3["count"]}"
  }
}

resource "null_resource" "sleep-test-3" {
  count = "${local.run_3}"
  depends_on = ["null_resource.sleep-test-2"]
  connection {
    type        = "ssh"
    user        = "${var.os_username}"
    host        = "${aws_instance.sleep-test.0.public_dns}"
    private_key = "${local.private_key}"
    agent       = "${var.ssh_agent}"
  }

 provisioner "remote-exec" {
  inline = ["${data.template_file.sleep-test-3.rendered}",]
 }
}

data "template_file" "sleep-test-4" {
  template = "${file("${path.module}/sleep.tpl")}"
  vars {
    sleep_time  = "${var.sleep_test_4["sleep"]}"
    sleep_count = "${var.sleep_test_4["count"]}"
  }
}

resource "null_resource" "sleep-test-4" {
  count = "${local.run_4}"
  depends_on = ["null_resource.sleep-test-3"]
  connection {
    type        = "ssh"
    user        = "${var.os_username}"
    host        = "${aws_instance.sleep-test.0.public_dns}"
    private_key = "${local.private_key}"
    agent       = "${var.ssh_agent}"
  }

 provisioner "remote-exec" {
  inline = ["${data.template_file.sleep-test-4.rendered}",]
 }
}

data "template_file" "sleep-test-5" {
  template = "${file("${path.module}/sleep.tpl")}"
  vars {
    sleep_time  = "${var.sleep_test_5["sleep"]}"
    sleep_count = "${var.sleep_test_5["count"]}"
  }
}

resource "null_resource" "sleep-test-5" {
  count = "${local.run_5}"
  depends_on = ["null_resource.sleep-test-4"]
  connection {
    type        = "ssh"
    user        = "${var.os_username}"
    host        = "${aws_instance.sleep-test.0.public_dns}"
    private_key = "${local.private_key}"
    agent       = "${var.ssh_agent}"
  }

 provisioner "remote-exec" {
  inline = ["${data.template_file.sleep-test-5.rendered}",]
 }
}
