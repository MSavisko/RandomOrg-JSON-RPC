//
//  NSURLResponse+MSSerialization.h
//  RandomOrgSample
//
//  Created by Maksym Savisko on 3/20/17.
//  Copyright © 2017 Maksym Savisko. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSURLResponse (MSSerialization)

+ (_Nullable id)ms_responseObjectForResponse:(NSURLResponse *)response
                           data:(NSData *)data
                          error:(NSError * _Nullable __autoreleasing *)error;

@end

NS_ASSUME_NONNULL_END
