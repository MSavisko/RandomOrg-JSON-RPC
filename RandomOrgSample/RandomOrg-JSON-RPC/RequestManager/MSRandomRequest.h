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
    MSRandomRequestMethodTypeVerifySignature
};

typedef NSString RequestParameterKey;

NS_ASSUME_NONNULL_BEGIN

extern RequestParameterKey *const RequestParameterApiKey;
extern RequestParameterKey *const RequestParameterQuantityKey;
extern RequestParameterKey *const RequestParameterMinimumKey;
extern RequestParameterKey *const RequestParameterMaximumKey;
extern RequestParameterKey *const RequestParameterUniqueKey;
extern RequestParameterKey *const RequestParameterNumberTypeKey;

@interface MSRandomRequest : NSObject

/**
 A version identifier, which must be "2.0" for this version of the API.
 */
@property (nonatomic, strong) NSString *rpcVersion;

/**
 A request identifier that allows the client to match responses to request. The service will return this unchanged in its response.
 */
@property (nonatomic) NSUInteger requestId;

/**
 The name of the method to be invoked
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

- (instancetype) initWithMethod:(MSRandomRequestMethodType) method andApiKey:(NSString *)apiKey andParameters:(NSDictionary <RequestParameterKey *, id> *) parameters;

- (nullable NSDictionary *) serialize;

@end

NS_ASSUME_NONNULL_END
