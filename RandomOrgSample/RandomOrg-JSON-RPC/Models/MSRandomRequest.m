//
//  MSRandomRequest.m
//  RandomOrgSample
//
//  Created by Maksym Savisko on 5/23/17.
//  Copyright © 2017 Maksym Savisko. All rights reserved.
//

#import "MSRandomRequest.h"
#import "MSRandomOrgConstants.h"

NSString *const RequestMethodKey = @"method";
NSString *const RequestRpcVersionKey = @"jsonrpc";
NSString *const RequestIdKey = @"id";
NSString *const RequestParametersKey = @"params";

RequestParameterKey *const RequestParameterApiKey  = @"apiKey";
RequestParameterKey *const RequestParameterQuantityKey = @"n";
RequestParameterKey *const RequestParameterMinimumKey = @"min";
RequestParameterKey *const RequestParameterMaximumKey = @"max";
RequestParameterKey *const RequestParameterUniqueKey = @"replacement";
RequestParameterKey *const RequestParameterNumberTypeKey = @"base";
RequestParameterKey *const RequestParameterDecimalPlacesKey = @"decimalPlaces";


static NSString *const kDefaultRequestRpcVersion = @"2.0";

static NSString *const RequestMethodStringBasicIntegers = @"generateIntegers";
static NSString *const RequestMethodStringBasicDecimalFractions = @"generateDecimalFractions";
static NSString *const RequestMethodStringBasicGaussians = @"generateGaussians";

@implementation MSRandomRequest

#pragma mark - Public Methods

/**
 Factory method for default basic integer request object

 @param apiKey from Random.org service. Look: https://api.random.org/api-keys/beta
 @return instance
 */
+ (nullable instancetype) defaultBasicIntegerWithApiKey:(nonnull NSString *) apiKey
{
    NSAssert(apiKey != nil || apiKey.length != 0, @"apiKey could not be empty. Look: https://api.random.org/api-keys/beta");
    
    return [[self alloc] initWithMethod:MSRandomRequestMethodTypeBasicIntegers
                              andApiKey:apiKey
                          andParameters:@{
                                          RequestParameterQuantityKey : @(10),
                                          RequestParameterMinimumKey : @(1),
                                          RequestParameterMaximumKey : @(10),
                                          RequestParameterUniqueKey : @(YES),
                                          RequestParameterNumberTypeKey : @(10),
                                          RequestParameterApiKey : apiKey
                                          }];
}

/**
 Serialize object for sending

 @return dictionary with all parameters that must exist
 */
- (nullable NSDictionary *) serialize
{
    NSMutableDictionary *result = [NSMutableDictionary dictionaryWithCapacity:0];
    
    //Add RPC Version
    if (_rpcVersion)
    {
        [result setObject:_rpcVersion forKey:RequestRpcVersionKey];
    }
    
    //Add Method Type
    NSString *methodString = [self getStringFromMethod:_method];
    if (methodString)
    {
        [result setObject:methodString forKey:RequestMethodKey];
    }
    
    //Add Id
    if (_requestId > 0)
    {
        [result setValue:@(_requestId) forKey:RequestIdKey];
    }
    
    //Check parameters
    BOOL isParametersValid = [self isParametersValid:_parameters withMethodType:_method andError:nil];
    
    //Add parameters if valid
    if (isParametersValid)
    {
        [result setObject:_parameters forKey:RequestParametersKey];
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
    NSAssert(method <= MSRandomRequestMethodTypeSize && method >= 0, @"Method type NOT valid. Look: MSRandomRequestMethodType");
    NSAssert(parameters != nil, @"Parameters could not be nil");
    NSAssert(apiKey != nil || apiKey.length != 0, @"apiKey could not be empty. Look: https://api.random.org/api-keys/beta");
    
    self = [self init];
    
    if (self)
    {
        _method = method;
        _apiKey = apiKey;
        _parameters = parameters;
    }
    
    return self;
}

#pragma mark - Properties

- (void) setMethod:(MSRandomRequestMethodType)method
{
    NSAssert(method <= MSRandomRequestMethodTypeSize || method >= 0, @"Method type NOT valid. Look: MSRandomRequestMethodType");
     
    _method = method;
}

- (void) setRequestId:(NSUInteger)requestId
{
    NSAssert(requestId < 32767, @"RequestId must be less or equal 32767");
    
    _requestId = requestId;
}

- (void) setApiKey:(NSString *)apiKey
{
    NSAssert(apiKey != nil, @"ApiKey could not be nil");
    
    _apiKey = apiKey;
}

- (void) setParameters:(NSDictionary<RequestParameterKey *,id> *)parameters
{
    NSAssert(parameters != nil, @"Parameters could not be nil");
    
    _parameters = parameters;
}

#pragma mark - Private Methods

/**
 Convert ENUM Request Method type to string

 @param methodType of EMUN
 @return string value of ENUM method
 */
- (nullable NSString *) getStringFromMethod:(MSRandomRequestMethodType) methodType
{
    NSAssert(methodType <= MSRandomRequestMethodTypeSize || methodType >= 0, @"Method type NOT valid. Look: MSRandomRequestMethodType");
     
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

#pragma mark - Private Check Methods

/**
 Check that reqeust parameters are valid

 @param parameters that exist in request
 @param methodType ENUM of request type
 @param error that will exist if some of parameters will valid or empty
 @return YES - if all parameters valid.
 */
- (BOOL) isParametersValid:(nullable NSDictionary *) parameters withMethodType:(MSRandomRequestMethodType)methodType andError:(NSError * __autoreleasing _Nullable *) error
{
    NSAssert(methodType <= MSRandomRequestMethodTypeSize || methodType >= 0, @"Method type NOT valid. Look: MSRandomRequestMethodType");
     
    //Check, that parameters are not empty
    if (parameters == nil)
    {
        if ( error )
        {
            *error = [NSError errorWithDomain:MSDefaultErrorDomain code:MSRandomOrgErrorCodeRequestParametersEmpty userInfo:nil];
        }
        
        return NO;
    }
    
    //Check, that all mandatory fileds exist
    __block BOOL isMandatoryParameterNotExist = NO;
    NSArray <RequestParameterKey *> *parameterKeysList = [self parametersKeysForMethod:methodType];
    [parameterKeysList enumerateObjectsUsingBlock:^(RequestParameterKey * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop)
    {
        if (![parameters valueForKey:obj] || [parameters valueForKey:obj] == [NSNull null])
        {
            NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
            [userInfo setValue:@"Mandatory parameter of request NOT exist" forKey:NSLocalizedFailureReasonErrorKey];
            [userInfo setValue:[NSString stringWithFormat:@"Parameter %@ NOT exist", obj] forKey:NSLocalizedDescriptionKey];
            
            if (error)
            {
                *error = [NSError errorWithDomain:MSDefaultErrorDomain code:MSRandomOrgErrorCodeRequestNotEnoughParameters userInfo:[userInfo copy]];
            }
            
            isMandatoryParameterNotExist = YES;
            *stop = YES;
        }
    }];
    //If one of parameter of method, that may exist not seted need inf
    if (isMandatoryParameterNotExist)
    {
        return NO;
    }
    
    return YES;
}

/**
 Generate list of keys that may exist in parameters by method.

 @param methodType type of request
 @return list of keys
 */
- (NSArray <RequestParameterKey *> *) parametersKeysForMethod:(MSRandomRequestMethodType)methodType
{
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:0];
    [result addObjectsFromArray:[self basicCommonParametersKeys]];
    
    switch (methodType)
    {
        case MSRandomRequestMethodTypeBasicIntegers:
        {
            [result addObjectsFromArray:@[RequestParameterMinimumKey, RequestParameterMaximumKey, RequestParameterUniqueKey, RequestParameterNumberTypeKey]];
        }
            break;
        
        case MSRandomRequestMethodTypeBasicDecimalFractions:
        {
            [result addObjectsFromArray:@[RequestParameterUniqueKey,RequestParameterDecimalPlacesKey]];
        }
            break;
        
        default:
            break;
    }
    
    return result;
}

/**
 Generate common basic keys for parameters of request. This keys may exist in all basic requests.

 @return list of RequestParameterKey that exist in parameters in all basic random org requests.
 */
- (NSArray <RequestParameterKey *> *) basicCommonParametersKeys
{
    return @[RequestParameterApiKey, RequestParameterQuantityKey];
}


@end
