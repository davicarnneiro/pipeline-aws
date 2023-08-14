## /KEY-PAIR
resource "aws_key_pair" "key" {
  key_name   = "aws-key" # gerar chave key com o comando ssh-keygen -f aws-key
  public_key = file("./aws-key.pub")
}

## /EC2
resource "aws_instance" "vm" {
  ami                         = "ami-053b0d53c279acc90"
  instance_type               = "t2.micro"
  key_name                    = aws_key_pair.key.key_name
  subnet_id                   = data.terraform_remote_state.network.outputs.subnet_id
  vpc_security_group_ids      = [data.terraform_remote_state.network.outputs.security_group_id]
  associate_public_ip_address = true

  tags = {
    Name = "vm-terraform"
  }
}
