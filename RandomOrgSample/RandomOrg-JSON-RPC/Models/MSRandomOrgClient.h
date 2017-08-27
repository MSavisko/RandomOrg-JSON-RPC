//
//  MSRandomOrgClient.h
//  RandomOrgSample
//
//  Created by Maksym Savisko on 7/21/17.
//  Copyright © 2017 Maksym Savisko. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 Completion handler block for generations

 result: Array of number that was generated
 error: Error with info from random.org service
 */
typedef void (^ _Nullable MSRandomOrgClientHandlerBlock)(NSArray <NSNumber *> * _Nullable result ,  NSError * _Nullable error);

@interface MSRandomOrgClient : NSObject

/**
 Random Org API Key.
 Look: https://api.random.org/api-keys/beta
 */
@property (nonatomic, strong, readonly, nullable) NSString *apiKey;

/**
 The dispatch queue for `resultHandlerBlock`. If `NULL` (default), the main queue is used.
 */
@property (nonatomic, strong, nullable) dispatch_queue_t callBackQueue;

/**
 Create new instance of random org client

 @param apiKey from Random.org service. Look: https://api.random.org/api-keys/beta
 @return new instance
 */
+ (instancetype) clientWithApiKey:(NSString *) apiKey;

/**
 Initialize new random org client with main thread callback queue.

 @param apiKey from Random.org service. Look: https://api.random.org/api-keys/beta
 @return new instance
 */
- (instancetype) initWithApiKey:(NSString *) apiKey;

/**
 Initalize new random org client

 @param apiKey from Random.org service. Look: https://api.random.org/api-keys/beta
 @param callBackQueue where resultHandlerBlock will be invoked
 @return new instance
 */
- (instancetype) initWithApiKey:(NSString *) apiKey
               andCallBackQueue:(nullable dispatch_queue_t) callBackQueue;

/**
 Generate Integers via Random.org service

 @param minValue Minimum integer value that may exist in response of resulted integers.
 @param maxValue Maximum integer value that may exist in response of resulted integers.
 @param numberValue Number of integers, that may be generated
 @param unigueFlag YES - integers in response will be unique. NO - could be repeatable.
 @param baseValue Indicate, what kind of system will be used for response. 2 - binary, 10 - Decimal, etc.
 @param resultHandlerBlock A block object to be executed when the generations finishes. This block has no return value and takes three arguments: result of generations (could be nullable) and the error that occurred, if any problems exist.
 */
- (void) generateIntegersMin:(NSInteger)minValue
                         max:(NSInteger)maxValue
                      number:(NSUInteger)numberValue
                      unique:(BOOL)unigueFlag
                        base:(NSUInteger)baseValue
               resultHandler:(MSRandomOrgClientHandlerBlock) resultHandlerBlock;


/**
 Generate Integers via Random.org service

 @param minValue Minimum integer value that may exist in response of resulted integers.
 @param maxValue Maximum integer value that may exist in response of resulted integers.
 @param numberValue Number of integers, that may be generated
 @param resultHandlerBlock A block object to be executed when the generations finishes. This block has no return value and takes three arguments: result of generations (could be nullable) and the error that occurred, if any problems exist.
 */
- (void) generateIntegersMin:(NSInteger)minValue
                         max:(NSInteger)maxValue
                      number:(NSUInteger)numberValue
               resultHandler:(MSRandomOrgClientHandlerBlock) resultHandlerBlock;

@end

@interface MSRandomOrgClient (Global)

/**
 Returns the "global" random org client that represents the currently setup client.
 
 The `currentClient` is a convenient representation of the client of the
 current client and is used by other SDK components.
 */
+ (nullable MSRandomOrgClient *) currentClient;

/**
 Sets the "global" random org client that represents the currently setup client.

 @param currentCLient The random org client to set.
 */
+ (void) setCurrentClient:(nullable MSRandomOrgClient *) currentCLient;

/**
 Sets the "global" random org client that represents the currently setup client.

 @param apiKey from Random.org service. Look: https://api.random.org/api-keys/beta
 */
+ (void) setupWithApiKey:(NSString *) apiKey;

@end

@interface MSRandomOrgClient (Methods)

/**
 Generate Integers via Random.org service using 'global' random org client.

 @param minValue Minimum integer value that may exist in response of resulted integers.
 @param maxValue Maximum integer value that may exist in response of resulted integers.
 @param numberValue Number of integers, that may be generated
 @param resultHandlerBlock A block object to be executed when the generations finishes. This block has no return value and takes three arguments: result of generations (could be nullable) and the error that occurred, if any problems exist.
 */
+ (void) generateIntegersMin:(NSInteger)minValue
                         max:(NSInteger)maxValue
                      number:(NSUInteger)numberValue
               resultHandler:(MSRandomOrgClientHandlerBlock) resultHandlerBlock;

@end

NS_ASSUME_NONNULL_END
