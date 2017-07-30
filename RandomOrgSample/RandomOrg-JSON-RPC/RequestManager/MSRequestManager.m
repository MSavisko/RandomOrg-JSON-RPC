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

@synthesize serverAddress = _serverAddress, sessionConfiguration = _sessionConfiguration, backgroundSession = _backgroundSession;

#pragma mark - Initialization

- (instancetype)initUniqueInstance
{
    self = [super init];
    
    if ( self )
    {
        _sessionConfiguration = [self.class randomOrgSessionConfiguration];
        _backgroundSession = [NSURLSession sessionWithConfiguration:_sessionConfiguration delegate:nil delegateQueue:[[NSOperationQueue alloc] init]];
    }
    
    return self;
}

#pragma mark - Public Methods

+ (instancetype) newInstance
{
    return [[self alloc] initUniqueInstance];
}

#pragma mark - MSRequestManagerProtocol Methods

- (NSString *) serverAddress
{
    return MSRequestManagerRandomOrgServerAddress;
}

#pragma mark - Private Methods

- (void) POST:(NSString *)URLString
      session:(nullable NSURLSession *) session
   parameters:(nullable NSDictionary *)parameters
      success:(nullable void (^)(NSURLSessionDataTask *task, id _Nullable responseObject))success
      failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError *error))failure
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
    
    __block NSURLSessionDataTask *dataTask = [session ? : self.backgroundSession dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
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

- (NSInteger) statusCodeFromTask:(NSURLSessionDataTask *) task
{
    return [self statusCodeFromResponse:task.response];
}

- (NSInteger) statusCodeFromResponse:(NSURLResponse *) response
{
    NSInteger statusCode = 0;
    
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
    
    if ([httpResponse respondsToSelector:@selector(statusCode)])
    {
        statusCode = httpResponse.statusCode;
    }
    
    return statusCode;
}


@end
