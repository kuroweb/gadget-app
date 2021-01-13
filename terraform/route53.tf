###########
# Route53 #
###########
resource "aws_route53_zone" "gadget-host-zone" {
  name    = "gadget-community.com"
  comment = "gadget-community.com host zone"
}

resource "aws_route53_record" "gadget-host-zone-record" {
  zone_id = aws_route53_zone.gadget-host-zone.zone_id
  name    = aws_route53_zone.gadget-host-zone.name
  type    = "A"

  alias {
    name                   = aws_lb.gadget-alb.dns_name
    zone_id                = aws_lb.gadget-alb.zone_id
    evaluate_target_health = true
  }
}
