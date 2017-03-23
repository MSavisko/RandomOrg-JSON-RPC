//
//  NSMutableURLRequest+MSSerialization.m
//  RandomOrgSample
//
//  Created by Maksym Savisko on 3/20/17.
//  Copyright © 2017 Maksym Savisko. All rights reserved.
//

#import "NSMutableURLRequest+MSSerialization.h"

@implementation NSMutableURLRequest (MSSerialization)

+ (NSData * _Nullable)ms_requestObjectForParameters:(NSDictionary * _Nullable)parameters error:(NSError * _Nullable __autoreleasing *)error
{
    if (!parameters)
    {
        return nil;
    }
    
    return [NSJSONSerialization dataWithJSONObject:parameters options:0 error:error];
}

@end
