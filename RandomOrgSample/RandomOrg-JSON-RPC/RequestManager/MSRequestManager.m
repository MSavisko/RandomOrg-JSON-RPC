//
//  MSRequestManager.m
//  RandomOrgSample
//
//  Created by Maksym Savisko on 3/20/17.
//  Copyright © 2017 Maksym Savisko. All rights reserved.
//

#import "MSRequestManager.h"
#import "MSRequestManagerConstants.h"

#import "MSRequestManager+Setup.h"

#import "NSURLResponse+MSSerialization.h"
#import "NSMutableURLRequest+MSSerialization.h"
#import "NSError+MSRequestManagerError.h"

@implementation MSRequestManager

@synthesize accessToken = _accessToken, serverAddress = _serverAddress;

#pragma mark - Singleton

+ (instancetype)sharedInstance
{
    static dispatch_once_t pred;
    static id sharedInstance = nil;
    dispatch_once(&pred, ^{
        sharedInstance = [[super alloc] initUniqueInstance];
    });
    
    return sharedInstance;
}

- (instancetype)initUniqueInstance
{
    self = [super init];
    
    if ( self )
    {
        self.sessionConfiguration = [self.class randomOrgSessionConfiguration];
        self.session = [NSURLSession sessionWithConfiguration:self.sessionConfiguration];
    }
    
    return self;
}

- (id)copy
{
    return self;
}

#pragma mark - MSRequestManagerProtocol Methods

- (void) setAccessToken:(NSString *)accessToken
{
    _accessToken = accessToken;
}

- (NSString *) accessToken
{
    return _accessToken;
}

- (NSString *) serverAddress
{
    return MSRequestManagerRandomOrgServerAddress;
}

#pragma mark - Private Methods

- (void) POST:(NSString *)URLString parameters:(nullable id)parameters success:(nullable void (^)(NSURLSessionDataTask *task, id _Nullable responseObject))success failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError *error))failure
{
    NSURL *url = [NSURL URLWithString:URLString];
    
    NSError *requestError = nil;
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = MSRequestManagerPost;
    request.HTTPBody = [NSMutableURLRequest ms_requestObjectForParameters:parameters error:&requestError];
    
    if (requestError)
    {
        if (failure)
        {
            dispatch_async(dispatch_get_main_queue(), ^
                           {
                               failure (nil , requestError);
                           });
        }
        return;
    }
    
    NSURLSessionDataTask *task = [self.session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error)
        {
            if (failure)
            {
                dispatch_async(dispatch_get_main_queue(), ^
                               {
                                   failure ([task copy], error);
                               });
            }
        }
        else
        {
            if (data && response)
            {
                NSError *serializationError = nil;
                id responseObject = nil;
                responseObject = [NSURLResponse ms_responseObjectForResponse:response data:data error:&serializationError];
                
                if (serializationError)
                {
                    if (failure)
                    {
                        dispatch_async(dispatch_get_main_queue(), ^
                                       {
                                           failure ([task copy], serializationError);
                                       });
                    }
                    return;
                }
                
                if (success)
                {
                    dispatch_async(dispatch_get_main_queue(), ^
                                   {
                                       success ([task copy], responseObject);
                                   });
                }
                
            }
            else
            {
                if (failure)
                {
                    dispatch_async(dispatch_get_main_queue(), ^
                                   {
                                       failure ([task copy], [NSError ms_errorWithCode:MSRequestManagerErrorCodeResponseNoData userInfo:nil]);
                                   });
                }
            }
        }
    }];
    
    [task resume];
}



@end
