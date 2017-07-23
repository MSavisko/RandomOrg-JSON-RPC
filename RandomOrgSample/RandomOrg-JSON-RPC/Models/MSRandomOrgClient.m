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
    if (self == [super init])
    {
        _requestManager = [MSRequestManager newInstance];
        _apiKey = [apiKey copy];
        _requestQueue = dispatch_queue_create("msrandomorg.serial.background.queue", DISPATCH_QUEUE_CONCURRENT);
    }
    
    return self;
}

- (void) generateIntegers:(NSInteger)minValue max:(NSInteger)maxValue number:(NSUInteger) numberValue resultHandler:(MSRandomOrgClientHandlerBlock) resultHandlerBlock
{
    MSRandomRequest *request = [[MSRandomRequest alloc] initWithMethod:MSRandomRequestMethodTypeBasicIntegers
                                                             andApiKey:self.apiKey
                                                         andParameters:@{
                                                                         RequestParameterQuantityKey : @(numberValue),
                                                                         RequestParameterMinimumKey : @(minValue),
                                                                         RequestParameterMaximumKey : @(maxValue),
                                                                         RequestParameterUniqueKey : @(YES),
                                                                         RequestParameterNumberTypeKey : @(10),
                                                                         RequestParameterApiKey : self.apiKey
                                                                         }];
    
    [self.requestManager generateRandomWithParameters:[request serialize] withCompletion:^(MSRequestResponse * _Nonnull response) {
        
        NSArray <NSNumber *> *result = nil;
        if (response.isSuccess)
        {
            result = [[[response.object valueForKey:@"result"] valueForKey:@"random"] valueForKey:@"data"];
            NSLog(@"Response: %@", result);
        }
        
        if (resultHandlerBlock)
        {
            resultHandlerBlock (result, response.error);
        }
    }];
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

+ (void) generateIntegers:(NSInteger)minValue max:(NSInteger)maxValue number:(NSUInteger) numberValue resultHandler:(MSRandomOrgClientHandlerBlock) resultHandlerBlock
{
    MSRandomOrgClient *currentClient = g_currentRandomOrgClient;
    if (!currentClient)
    {
        return;
    }
    [currentClient generateIntegers:minValue max:maxValue number:numberValue resultHandler:resultHandlerBlock];
}

@end
