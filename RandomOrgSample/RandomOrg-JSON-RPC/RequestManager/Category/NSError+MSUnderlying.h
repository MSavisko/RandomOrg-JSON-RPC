//
//  NSError+MSUnderlying.h
//  RandomOrgSample
//
//  Created by Maksym Savisko on 3/20/17.
//  Copyright © 2017 Maksym Savisko. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSError (MSUnderlying)

+ (NSError *) ms_error:(NSError *) error withUnderlyingError:(NSError *)underlyingError;

@end
