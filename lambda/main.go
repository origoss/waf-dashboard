package main

import (
	"fmt"

	"github.com/aws/aws-lambda-go/events"
	"github.com/aws/aws-lambda-go/lambda"
)

func handler(req *events.ALBTargetGroupRequest) (*events.ALBTargetGroupResponse, error) {
	fmt.Println("Handler invoded")
	fmt.Printf("req: %+v\n", req)
	return &events.ALBTargetGroupResponse{
		StatusCode:        200,
		StatusDescription: "OK",
		Headers: map[string]string{
			"Content-Type": "text/plain",
		},
		MultiValueHeaders: map[string][]string{},
		Body:              "WAF test result page",
		IsBase64Encoded:   false,
	}, nil
}

func main() {
	lambda.Start(handler)
}
