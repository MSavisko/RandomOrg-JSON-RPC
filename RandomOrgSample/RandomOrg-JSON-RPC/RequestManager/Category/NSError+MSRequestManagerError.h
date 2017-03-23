//
//  NSError+MSRequestManagerError.h
//  RandomOrgSample
//
//  Created by Maksym Savisko on 3/20/17.
//  Copyright © 2017 Maksym Savisko. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSError (MSRequestManagerError)

+ (NSError *)ms_errorWithCode:(NSInteger)code userInfo:(NSDictionary *)userInfo;

@end

