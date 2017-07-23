//
//  MSRandomOrgClient.h
//  RandomOrgSample
//
//  Created by Maksym Savisko on 7/21/17.
//  Copyright © 2017 Maksym Savisko. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^MSRandomOrgClientHandlerBlock)(NSArray <NSNumber *> * _Nullable result ,  NSError * _Nullable error);

@interface MSRandomOrgClient : NSObject

@property (nonatomic, strong, readonly, nullable) NSString *apiKey;

+ (instancetype) clientWithApiKey:(NSString *) apiKey;

- (instancetype) initWithApiKey:(NSString *) apiKey;

- (void) generateIntegers:(NSInteger)minValue max:(NSInteger)maxValue number:(NSUInteger) numberValue resultHandler:(MSRandomOrgClientHandlerBlock) resultHandlerBlock;

@end

@interface MSRandomOrgClient (Global)

+ (nullable MSRandomOrgClient *) currentClient;

+ (void) setCurrentClient:(nullable MSRandomOrgClient *) currentCLient;

+ (void) setupWithApiKey:(NSString *) apiKey;

@end

@interface MSRandomOrgClient (Methods)

+ (void) generateIntegers:(NSInteger)minValue max:(NSInteger)maxValue number:(NSUInteger) numberValue resultHandler:(MSRandomOrgClientHandlerBlock) resultHandlerBlock;

@end

NS_ASSUME_NONNULL_END
