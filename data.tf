// will fetch all available Availability Zones in the current region 
data "aws_availability_zones" "available" {
  state = "available"
}
