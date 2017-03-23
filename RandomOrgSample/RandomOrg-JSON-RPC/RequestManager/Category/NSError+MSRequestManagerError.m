//
//  NSError+MSRequestManagerError.m
//  RandomOrgSample
//
//  Created by Maksym Savisko on 3/20/17.
//  Copyright © 2017 Maksym Savisko. All rights reserved.
//

#import "NSError+MSRequestManagerError.h"
#import "MSRequestManagerConstants.h"

@implementation NSError (MSRequestManagerError)

+ (NSError *)ms_errorWithCode:(NSInteger)code userInfo:(NSDictionary *)userInfo {
    NSError *error = [NSError errorWithDomain:MSRequestManagerErrorDomain
                                         code:code
                                     userInfo:userInfo];
    return error;
}

@end
