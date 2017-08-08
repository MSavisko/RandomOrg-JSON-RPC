//
//  MSRandomOrgClient.h
//  RandomOrgSample
//
//  Created by Maksym Savisko on 7/21/17.
//  Copyright © 2017 Maksym Savisko. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^ _Nullable MSRandomOrgClientHandlerBlock)(NSArray <NSNumber *> * _Nullable result ,  NSError * _Nullable error);

@interface MSRandomOrgClient : NSObject

@property (nonatomic, strong, readonly, nullable) NSString *apiKey;

@property (nonatomic, strong, nullable) dispatch_queue_t callBackQueue;

+ (instancetype) clientWithApiKey:(NSString *) apiKey;

- (instancetype) initWithApiKey:(NSString *) apiKey;

- (instancetype) initWithApiKey:(NSString *) apiKey andCallBackQueue:(nullable dispatch_queue_t) callBackQueue;

- (void) generateIntegersMin:(NSInteger)minValue
                         max:(NSInteger)maxValue
                      number:(NSUInteger)numberValue
                      unique:(BOOL)unigueFlag
                        base:(NSUInteger)baseValue
               resultHandler:(MSRandomOrgClientHandlerBlock) resultHandlerBlock;


- (void) generateIntegersMin:(NSInteger)minValue
                         max:(NSInteger)maxValue
                      number:(NSUInteger)numberValue
               resultHandler:(MSRandomOrgClientHandlerBlock) resultHandlerBlock;

@end

@interface MSRandomOrgClient (Global)

+ (nullable MSRandomOrgClient *) currentClient;

+ (void) setCurrentClient:(nullable MSRandomOrgClient *) currentCLient;

+ (void) setupWithApiKey:(NSString *) apiKey;

@end

@interface MSRandomOrgClient (Methods)

+ (void) generateIntegersMin:(NSInteger)minValue
                         max:(NSInteger)maxValue
                      number:(NSUInteger)numberValue
               resultHandler:(MSRandomOrgClientHandlerBlock) resultHandlerBlock;

@end

NS_ASSUME_NONNULL_END
