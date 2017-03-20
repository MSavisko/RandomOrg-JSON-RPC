//
//  NSMutableURLRequest+MSSerialization.h
//  RandomOrgSample
//
//  Created by Maksym Savisko on 3/20/17.
//  Copyright © 2017 Maksym Savisko. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSMutableURLRequest (MSSerialization)

+ (NSData * _Nullable)ms_requestObjectForParameters:(NSDictionary * _Nullable)parameters error:(NSError * _Nullable __autoreleasing *)error;

@end

NS_ASSUME_NONNULL_END
