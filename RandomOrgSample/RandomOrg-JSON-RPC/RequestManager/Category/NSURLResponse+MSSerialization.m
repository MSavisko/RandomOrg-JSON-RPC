//
//  NSURLResponse+MSSerialization.m
//  RandomOrgSample
//
//  Created by Maksym Savisko on 3/20/17.
//  Copyright © 2017 Maksym Savisko. All rights reserved.
//

#import "NSURLResponse+MSSerialization.h"
#import "NSError+MSUnderlying.h"

@implementation NSURLResponse (MSSerialization)

+ (_Nullable id)ms_responseObjectForResponse:(NSURLResponse *)response
                                     data:(NSData *)data
                                    error:(NSError * _Nullable __autoreleasing *)error
{
    id responseObject = nil;
    NSError *serializationError = nil;
    // Workaround for behavior of Rails to return a single space for `head :ok` (a workaround for a bug in Safari), which is not interpreted as valid input by NSJSONSerialization.
    // See https://github.com/rails/rails/issues/1742
    BOOL isSpace = [data isEqualToData:[NSData dataWithBytes:" " length:1]];
    if (data.length > 0 && !isSpace) {
        responseObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:&serializationError];
    } else {
        return nil;
    }
    
    if (error) {
        *error = [NSError ms_error:serializationError withUnderlyingError:*error];
    }
    
    return responseObject;
}

@end
