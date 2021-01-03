resource "aws_efs_file_system" "ggr_efs_fs" {
  tags = {
    Name = "ggr-efs"
  }
}

resource "aws_efs_mount_target" "ggr_efs_mt" {
  file_system_id = aws_efs_file_system.ggr_efs_fs.id
  subnet_id     = aws_subnet.ggr_subnet2.id 
}

resource "aws_efs_mount_target" "ggr_efs_mt2" {
  file_system_id = aws_efs_file_system.ggr_efs_fs.id
  subnet_id     = aws_subnet.ggr_subnet1.id
}

