local params = import '../params.json';
[{
  ParameterKey: p,
  ParameterValue: std.get(params, p),
} for p in ['S3BucketName', 'CloudTrailS3BucketName']]
