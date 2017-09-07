//
//  MSRequestResponse.m
//  RandomOrgSample
//
//  Created by Maksym Savisko on 5/30/17.
//  Copyright © 2017 Maksym Savisko. All rights reserved.
//

#import "MSRequestResponse.h"

@implementation MSRequestResponse

#pragma mark - Public Class Methods

+ (instancetype) response
{
    return [[self alloc] init];
}

#pragma mark - Initialization

- (instancetype) init
{
    if (self == [super init])
    {
        _requestStartTime = [NSDate date];
    }
    
    return self;
}

@end
