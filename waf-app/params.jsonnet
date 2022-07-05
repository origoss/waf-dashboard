local params = import '../params.json';
[{
  ParameterKey: p,
  ParameterValue: std.get(params, p),
} for p in [
  'S3BucketName',
  'S3KeyName',
  'S3ObjectVersion',
  'AlbSubnets',
  'HostedZoneId',
  'DnsName',
  'VpcId',
  'DashboardName',
]]
