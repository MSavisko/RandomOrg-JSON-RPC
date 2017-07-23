//
//  MSRequestManager+Setup.m
//  RandomOrgSample
//
//  Created by Maksym Savisko on 3/20/17.
//  Copyright © 2017 Maksym Savisko. All rights reserved.
//

#import "MSRequestManager+Setup.h"
#import "MSRequestManagerConstants.h"

@implementation MSRequestManager (Setup)

@dynamic sessionConfiguration;
@dynamic mainSession;
@dynamic currentSession;
@dynamic backgroundSession;

+ (NSURLSessionConfiguration *) randomOrgSessionConfiguration
{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration ephemeralSessionConfiguration];
    configuration.HTTPAdditionalHeaders = @{
                                            MSRequestManagerContentType : MSRequestManagerRandomOrgHeaderContentType,
                                            MSRequestManagerAccept : MSRequestManagerRandomOrgHeaderAccept
                                            };
    
    return configuration;
}

@end
