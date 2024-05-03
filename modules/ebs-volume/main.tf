resource "aws_ebs_volume" "ebs" {
  availability_zone = var.az
  size              = var.size
}

resource "aws_volume_attachment" "this" {
  device_name = var.device_name
  volume_id   = aws_ebs_volume.ebs.id
  instance_id = var.instance_id
}