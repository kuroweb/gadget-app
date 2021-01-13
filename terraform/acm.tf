##########
#  ACM   #
##########

##SSL証明書の定義
resource "aws_acm_certificate" "gadget-acm" {
  domain_name               = aws_route53_record.gadget-host-zone-record.name
  subject_alternative_names = []
  validation_method         = "DNS"
  lifecycle {
    create_before_destroy = true
  }
}
##SSL検証
resource "aws_route53_record" "gadget-certificate" {
  name    = tolist(aws_acm_certificate.gadget-acm.domain_validation_options)[0].resource_record_name
  type    = tolist(aws_acm_certificate.gadget-acm.domain_validation_options)[0].resource_record_type
  records = [tolist(aws_acm_certificate.gadget-acm.domain_validation_options)[0].resource_record_value]
  zone_id = aws_route53_zone.gadget-host-zone.id
  ttl     = 60
}
##検証待機
resource "aws_acm_certificate_validation" "gadget-acm" {
  certificate_arn         = aws_acm_certificate.gadget-acm.arn
  validation_record_fqdns = [aws_route53_record.gadget-certificate.fqdn]
}
