//
//  MSRequestManagerProtocol.h
//  RandomOrgSample
//
//  Created by Maksym Savisko on 3/20/17.
//  Copyright © 2017 Maksym Savisko. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MSRequestManagerProtocol <NSObject>

@property (nonatomic, readonly, copy) NSString *serverAddress;
@property (nonatomic, strong) NSURLSessionConfiguration *sessionConfiguration;
@property (nonatomic, strong) NSURLSession *backgroundSession;

@end

@protocol MSRequestManagerSetupProtocol <MSRequestManagerProtocol>

- (NSURLSession *) currentThreadSession;
+ (NSURLSessionConfiguration *) randomOrgSessionConfiguration;
+ (NSURLSession *) currentThreadSessionWithConfiguration:(NSURLSessionConfiguration *) configuration;

@end

@class MSRequestResponse;

typedef void (^MSRequestManagerResponseCompletionBlock)(MSRequestResponse *response);

@protocol MSRequestManagerBasicProtocol <MSRequestManagerProtocol>

- (void) generateRandomWithParameters:(NSDictionary *) parameters withCompletion:(nullable MSRequestManagerResponseCompletionBlock) completion;

@end

NS_ASSUME_NONNULL_END
