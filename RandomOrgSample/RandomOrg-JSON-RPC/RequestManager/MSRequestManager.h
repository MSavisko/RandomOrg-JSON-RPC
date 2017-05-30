//
//  MSRequestManager.h
//  RandomOrgSample
//
//  Created by Maksym Savisko on 3/20/17.
//  Copyright © 2017 Maksym Savisko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MSRequestManagerProtocol.h"
#import "MSRequestResponse.h"

NS_ASSUME_NONNULL_BEGIN

@interface MSRequestManager : NSObject <MSRequestManagerProtocol>

// clue for improper use (produces compile time error)
+ (instancetype)new __attribute__((unavailable("new not available, call initUniqueInstanceinstead")));
- (instancetype)init __attribute__((unavailable("init not available, call initUniqueInstance instead")));
- (instancetype)copy __attribute__((unavailable("copy not available, call initUniqueInstance instead")));

+ (nullable instancetype) newInstance;

@end

NS_ASSUME_NONNULL_END
