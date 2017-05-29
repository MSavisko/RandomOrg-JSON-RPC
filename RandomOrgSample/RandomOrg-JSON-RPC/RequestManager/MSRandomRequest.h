//
//  MSRandomRequest.h
//  RandomOrgSample
//
//  Created by Maksym Savisko on 5/23/17.
//  Copyright © 2017 Maksym Savisko. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, MSRandomRequestMethodType)
{
    //This method generates true random integers within a user-defined range.
    MSRandomRequestMethodTypeBasicIntegers = 0,
    MSRandomRequestMethodTypeBasicDecimalFractions,
    MSRandomRequestMethodTypeBasicGaussians,
    MSRandomRequestMethodTypeBasicStrings,
    MSRandomRequestMethodTypeBasicUUIDs,
    MSRandomRequestMethodTypeBasicBlobs,
    MSRandomRequestMethodTypeSignedIntegers,
    MSRandomRequestMethodTypeSignedDecimalFractions,
    MSRandomRequestMethodTypeSignedGaussians,
    MSRandomRequestMethodTypeSignedStrings,
    MSRandomRequestMethodTypeSignedUUIDs,
    MSRandomRequestMethodTypeSignedBlobs,
    MSRandomRequestMethodTypeUsage,
    MSRandomRequestMethodTypeVerifySignature = 13
};

NSUInteger MSRandomRequestMethodTypeSzie() {
    return 13;
}

typedef NSString RequestParameterKey;

NS_ASSUME_NONNULL_BEGIN

extern RequestParameterKey *const RequestParameterApiKey;
extern RequestParameterKey *const RequestParameterQuantityKey;
extern RequestParameterKey *const RequestParameterMinimumKey;
extern RequestParameterKey *const RequestParameterMaximumKey;
extern RequestParameterKey *const RequestParameterUniqueKey;
extern RequestParameterKey *const RequestParameterNumberTypeKey;
extern RequestParameterKey *const RequestParameterDecimalPlacesKey;

@interface MSRandomRequest : NSObject

/**
 A version identifier, which must be "2.0" for this version of the API.
 @default: 2.0
 */
@property (nonatomic, strong, readonly) NSString *rpcVersion;

/**
 A request identifier that allows the client to match responses to request. The service will return this unchanged in its response.
 @default: Random from 0 to 32767
 */
@property (nonatomic) NSUInteger requestId;

/**
 The name of the method to be invoked
 @Look: MSRandomRequestMethodType ENUM
 */
@property (nonatomic) MSRandomRequestMethodType method;

/**
 Your API key, which is used to track the true random bit usage for your client.
 */
@property (nonatomic, strong) NSString *apiKey;

/**
 A structured value containing the parameters that will be supplied to the method.
 */
@property (nonatomic, strong) NSDictionary <RequestParameterKey *, id> *parameters;

/**
 Factory method for default basic integer request object
 
 @param apiKey from Random.org service. Look: https://api.random.org/api-keys/beta
 @return instance
 */
+ (nullable instancetype) defaultBasicIntegerWithApiKey:(nonnull NSString *) apiKey;

/**
 Initialize new instance of request to Random.org

 @param method that represent type of request
 @param apiKey that need for correct
 @param parameters that may exist in request. Look: https://api.random.org/json-rpc/1/basic
 @return instance of class
 */
- (nullable instancetype) initWithMethod:(MSRandomRequestMethodType) method andApiKey:(NSString *)apiKey andParameters:(NSDictionary <RequestParameterKey *, id> *) parameters;

/**
 Serialize instance for sending to Random.org
 
 @return dictionary with all parameters that must exist
 */
- (nullable NSDictionary *) serialize;

@end

NS_ASSUME_NONNULL_END
