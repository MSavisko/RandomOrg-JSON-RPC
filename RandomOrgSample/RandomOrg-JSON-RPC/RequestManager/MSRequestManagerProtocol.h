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
@property (nonatomic, strong) NSURLSession *session;

@end

@protocol MSRequestManagerSetupProtocol <MSRequestManagerProtocol>

//@property (nonatomic, strong) NSURLSessionConfiguration *sessionConfiguration;
//@property (nonatomic, strong) NSURLSession *session;

+ (NSURLSessionConfiguration *) randomOrgSessionConfiguration;

@end

@class MSRequestResponse;

typedef void (^MSRequestManagerResponseCompletionBlock)(MSRequestResponse *response);

@protocol MSRequestManagerBasicProtocol <MSRequestManagerProtocol>

- (void) generateRandomWithParameters:(NSDictionary *) parameters withCompletion:(nullable MSRequestManagerResponseCompletionBlock) completion;

@end

NS_ASSUME_NONNULL_END
