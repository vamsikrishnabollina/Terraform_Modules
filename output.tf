output "Key_Name" {
value = "${aws_key_pair.generated_key.key_name}"
}
output "private_key_openssh" {
  value = "${tls_private_key.key.private_key_pem}"
}

