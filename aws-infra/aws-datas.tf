data "aws_efs_file_system" "ggr_efs_fs" {
  file_system_id = aws_efs_file_system.ggr_efs_fs.id
}

output "efs_fsid_check" {
  value = data.aws_efs_file_system.ggr_efs_fs
}
