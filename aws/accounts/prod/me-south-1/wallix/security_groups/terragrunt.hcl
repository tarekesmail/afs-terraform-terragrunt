include "root" {
  path = find_in_parent_folders()
}

locals {
  base_source = "${dirname(find_in_parent_folders())}/..//modules/aws-security-group"
}

terraform {
  source = local.base_source
}

inputs = {
  name   = "SG-WALLIX-ACCESS-SERVER-PROD"
  vpc_id = "vpc-07930a91e648af4ee"
  ingress_rules = {
    "22/tcp" = {
      sources     = ["10.70.76.6/32"]
      description = "allow ingress SSH"
    }
    "3389/tcp" = {
      sources     = ["10.70.76.6/32"]
      description = "allow ingress RDP"
    }
    "25/tcp" = {
      sources     = ["10.70.76.6/32"]
      description = "allow ingress SMTP"
    }
    "465/tcp" = {
      sources     = ["10.70.76.6/32"]
      description = "allow ingress SMTP"
    }
    "587/tcp" = {
      sources     = ["10.70.76.6/32"]
      description = "allow ingress SMTP"
    }
    "123/tcp" = {
      sources     = ["10.70.76.6/32"]
      description = "allow ingress NTP"
    }
    "53/tcp" = {
      sources     = ["10.70.76.6/32"]
      description = "allow ingress DNS"
    }
    "389/tcp" = {
      sources     = ["10.70.76.6/32"]
      description = "allow ingress AD"
    }
    "636/tcp" = {
      sources     = ["10.70.76.6/32"]
      description = "allow ingress AD"
    }
    "2049/tcp" = {
      sources     = ["10.70.76.6/32"]
      description = "allow ingress NFS"
    }
    "445/tcp" = {
      sources     = ["10.70.76.6/32"]
      description = "allow ingress NFS"
    }
    "514/udp" = {
      sources     = ["10.70.76.6/32"]
      description = "allow ingress Syslog"
    }
    "1812/tcp" = {
      sources     = ["10.70.76.6/32"]
      description = "allow ingress Radius"
    }
    "2242/tcp" = {
      sources     = ["10.70.76.6/32"]
      description = "allow ingress SSH"
    }
    "443/tcp" = {
      sources     = ["10.70.76.6/32"]
      description = "allow ingress HTTPS"
    }
    "161/tcp" = {
      sources     = ["10.70.76.6/32"]
      description = "allow ingress SNMP"
    }
    "162/tcp" = {
      sources     = ["10.70.76.6/32"]
      description = "allow ingress SNMP"
    }
    "80/tcp" = {
      sources     = ["10.70.76.7/32"]
      description = "allow ingress HTTP"
    }
    "443/tcp" = {
      sources     = ["10.70.76.7/32"]
      description = "allow ingress Secure HTTP"
    }
  }
  egress_rules = {
    "all_tcp" = {
      destinations = ["0.0.0.0/0"]
      description  = "Allow all TCP outbound access"
    }
    "all_udp" = {
      destinations = ["0.0.0.0/0"]
      description  = "Allow all UDP outbound access"
    }
  }
}
