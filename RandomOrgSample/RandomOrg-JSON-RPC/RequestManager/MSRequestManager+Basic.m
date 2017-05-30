//
//  MSRequestManager+Basic.m
//  RandomOrgSample
//
//  Created by Maksym Savisko on 5/23/17.
//  Copyright © 2017 Maksym Savisko. All rights reserved.
//

#import "MSRequestManager+Basic.h"
#import "MSRequestManager+Private.h"

@implementation MSRequestManager (Basic)

- (void) generateRandomWithParameters:(NSDictionary *) parameters withCompletion:(nullable MSRequestManagerResponseCompletionBlock) completion
{
    NSAssert(parameters != nil, @"parameters of random generation could not be nil");

    MSRequestResponse *response = [MSRequestResponse response];
    
    [self POST:self.serverAddress parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
    {
        response.object = responseObject;
        response.isSuccess = YES;
        response.statusCode = [self statusCodeFromTask:task];
        
        if (completion)
        {
            completion (response);
        }
    }
       failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
    {
        response.isSuccess = NO;
        response.statusCode = [self statusCodeFromTask:task];
        response.error = error;
        
        if (completion)
        {
            completion (response);
        }
    }];
}

@end
