//
//  MSRequestManager+Private.h
//  RandomOrgSample
//
//  Created by Maksym Savisko on 3/20/17.
//  Copyright © 2017 Maksym Savisko. All rights reserved.
//

#import "MSRequestManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface MSRequestManager (Private)

- (void) POST:(NSString *)URLString parameters:(nullable id)parameters success:(nullable void (^)(NSURLSessionDataTask *task, id _Nullable responseObject))success failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError *error))failure;

@end

NS_ASSUME_NONNULL_END
