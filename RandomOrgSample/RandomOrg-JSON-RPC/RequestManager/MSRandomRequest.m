//
//  MSRandomRequest.m
//  RandomOrgSample
//
//  Created by Maksym Savisko on 5/23/17.
//  Copyright © 2017 Maksym Savisko. All rights reserved.
//

#import "MSRandomRequest.h"

NSString *const RequestMethodKey = @"method";
NSString *const RequestRpcVersionKey = @"jsonrpc";

RequestParameterKey *const RequestParameterApiKey  = @"apiKey";
RequestParameterKey *const RequestParameterQuantityKey = @"n";
RequestParameterKey *const RequestParameterMinimumKey = @"min";
RequestParameterKey *const RequestParameterMaximumKey = @"max";
RequestParameterKey *const RequestParameterUniqueKey = @"replacement";
RequestParameterKey *const RequestParameterNumberTypeKey = @"base";

static NSString *const kDefaultRequestRpcVersion = @"2.0";

static NSString *const RequestMethodStringBasicIntegers = @"generateIntegers";
static NSString *const RequestMethodStringBasicDecimalFractions = @"generateDecimalFractions";
static NSString *const RequestMethodStringBasicGaussians = @"generateGaussians";





@implementation MSRandomRequest

#pragma mark - Public Methods

+ (instancetype) defaultBasicIntegerWithApiKey:(nonnull NSString *) apiKey
{
    return [[self alloc] initWithMethod:MSRandomRequestMethodTypeBasicIntegers andApiKey:apiKey andParameters:@{}];
}

- (NSDictionary *) serialize
{
    NSMutableDictionary *result = [NSMutableDictionary dictionaryWithCapacity:0];
    
    //Add RPC Version
    if (_rpcVersion)
    {
        [result setObject:_rpcVersion forKey:RequestRpcVersionKey];
    }
    
    //Add Method type
    NSString *methodString = [self.class getStringFromMethod:_method];
    if (methodString)
    {
        [result setObject:methodString forKey:RequestMethodKey];
    }
    
    //Check for result
    if (result.allKeys.count > 0)
    {
        return result;
    }
    else
    {
        return nil;
    }
}

#pragma mark - Initialization

- (instancetype) init
{
    self = [super init];
    
    if (self)
    {
        _rpcVersion = kDefaultRequestRpcVersion;
        _requestId = arc4random_uniform(32767);
    }
    
    return self;
}

- (instancetype) initWithMethod:(MSRandomRequestMethodType) method andApiKey:(NSString *)apiKey andParameters:(NSDictionary <RequestParameterKey *, id> *) parameters
{
    self = [self init];
    
    if (self)
    {
        _method = method;
        _apiKey = apiKey;
        _parameters = parameters;
    }
    
    return self;
}

#pragma mark - Private Methods

+ (NSString *) getStringFromMethod:(MSRandomRequestMethodType) methodType
{
    NSString *result = nil;
    
    switch (methodType)
    {
        case MSRandomRequestMethodTypeBasicIntegers:
        {
            result = RequestMethodStringBasicIntegers;
        }
            break;
            
        case MSRandomRequestMethodTypeBasicDecimalFractions:
        {
            result = RequestMethodStringBasicDecimalFractions;
        }
            break;
            
        case MSRandomRequestMethodTypeBasicGaussians:
        {
            result = RequestMethodStringBasicGaussians;
        }
            break;
            
        default:
            break;
    }
    
    return result;
}


@end
