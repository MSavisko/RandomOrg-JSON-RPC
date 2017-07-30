//
//  MSRandomOrgClient.m
//  RandomOrgSample
//
//  Created by Maksym Savisko on 7/21/17.
//  Copyright © 2017 Maksym Savisko. All rights reserved.
//

#import "MSRandomOrgClient.h"
#import "MSRequestManager+Basic.h"
#import "MSRandomRequest.h"
#import "MSRandomgOrgConstants.h"

static MSRandomOrgClient *g_currentRandomOrgClient = nil;

@interface MSRandomOrgClient ()
@property (nonatomic, strong) MSRequestManager *requestManager;
@property (nonatomic) dispatch_queue_t requestQueue;

@end


@implementation MSRandomOrgClient

#pragma mark - Initialization Methods

+ (instancetype) clientWithApiKey:(NSString *) apiKey
{
    NSAssert(apiKey != nil && apiKey.length > 0, @"Api Key should not be nil");
    
    return [[self alloc] initWithApiKey:apiKey];
}

- (instancetype) initWithApiKey:(NSString *) apiKey
{
    return [self initWithApiKey:apiKey andCallBackQueue:nil];
}

- (instancetype) initWithApiKey:(NSString *)apiKey
               andCallBackQueue:(dispatch_queue_t) callBackQueue
{
    if (self == [super init])
    {
        _requestManager = [MSRequestManager newInstance];
        _apiKey = [apiKey copy];
        _requestQueue = dispatch_queue_create([[NSString stringWithFormat:MSRandomOrgClientQueueRequestFormat, [apiKey copy]] UTF8String], DISPATCH_QUEUE_CONCURRENT);
        _callBackQueue = callBackQueue;
    }
    
    return self;
}

- (void) generateIntegersMin:(NSInteger) minValue
                         max:(NSInteger) maxValue
                      number:(NSUInteger) numberValue
                      unique:(BOOL) unigueFlag
                        base:(NSUInteger) baseValue
               resultHandler:(MSRandomOrgClientHandlerBlock) resultHandlerBlock
{
    void (^executionBlock)() = ^()
    {
        MSRandomRequest *request = [[MSRandomRequest alloc] initWithMethod:MSRandomRequestMethodTypeBasicIntegers
                                                                 andApiKey:self.apiKey
                                                             andParameters:@{
                                                                             RequestParameterQuantityKey : @(numberValue),
                                                                             RequestParameterMinimumKey : @(minValue),
                                                                             RequestParameterMaximumKey : @(maxValue),
                                                                             RequestParameterUniqueKey : @(unigueFlag),
                                                                             RequestParameterNumberTypeKey : @(baseValue),
                                                                             RequestParameterApiKey : self.apiKey
                                                                             }];
        
        [self.requestManager generateRandomWithParameters:[request serialize] withCompletion:^(MSRequestResponse * _Nonnull response)
        {
            NSArray <NSNumber *> *result = nil;
            
            if (response.isSuccess)
            {
                result = [[[response.object valueForKey:@"result"] valueForKey:@"random"] valueForKey:@"data"];
            }
            
            if (resultHandlerBlock)
            {
                dispatch_async(self.callBackQueue ? : dispatch_get_main_queue(), ^{
                    resultHandlerBlock(result, response.error);
                });
            }
            
        }];
    };
    
    dispatch_async(self.requestQueue, ^{
        executionBlock();
    });
}

@end



@implementation MSRandomOrgClient (Global)

#pragma mark - Public Methods

+ (MSRandomOrgClient *) currentClient
{
    return g_currentRandomOrgClient;
}

+ (void) setCurrentClient:(MSRandomOrgClient *) currentCLient
{
    g_currentRandomOrgClient = currentCLient;
}

+ (void) setupWithApiKey:(NSString *) apiKey
{
    NSAssert(g_currentRandomOrgClient == nil, @"Current client exist, use currentClient for invoke");
    NSAssert(apiKey != nil && apiKey.length > 0, @"Api Key should not be nil");
    
    [self setCurrentClient:[self clientWithApiKey:apiKey]];
}

@end

@implementation MSRandomOrgClient (Methods)

+ (void) generateIntegersMin:(NSInteger)minValue max:(NSInteger)maxValue number:(NSUInteger) numberValue resultHandler:(MSRandomOrgClientHandlerBlock) resultHandlerBlock
{
    MSRandomOrgClient *currentClient = g_currentRandomOrgClient;
    if (!currentClient)
    {
        return;
    }
    
    [currentClient generateIntegersMin:minValue
                                   max:maxValue
                                number:numberValue
                                unique:MSRandomOrgClientScaleOfNotationFlag
                                  base:MSRandomOrgClientBaseDefault
                         resultHandler:resultHandlerBlock];
}

@end
