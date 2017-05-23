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

#pragma mark - Initialization

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

- (instancetype) initWithToken:(NSString *) token
{
    self = [self initUniqueInstance];
    
    if (self)
    {
        _accessToken = token;
    }
    
    return self;
}

#pragma mark - Public Methods

+ (instancetype) managerWithToken:(NSString *) token
{
    return [[self alloc] initWithToken:token];
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
            failure (nil , requestError);
        }
        return;
    }
    
    __block NSURLSessionDataTask *dataTask = [self.session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error)
        {
            if (failure)
            {
                failure ([dataTask copy], error);
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
                        failure ([dataTask copy], serializationError);
                    }
                    return;
                }
                
                if (success)
                {
                    success ([dataTask copy], responseObject);
                }
                
            }
            else
            {
                if (failure)
                {
                    failure ([dataTask copy], [NSError ms_errorWithCode:MSRequestManagerErrorCodeResponseNoData userInfo:nil]);
                }
            }
        }
    }];
    
    [dataTask resume];
}



@end
