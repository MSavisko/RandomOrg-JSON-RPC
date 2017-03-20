//
//  MSRequestManagerProtocol.h
//  RandomOrgSample
//
//  Created by Maksym Savisko on 3/20/17.
//  Copyright © 2017 Maksym Savisko. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MSRequestManagerProtocol <NSObject>

@property (nonatomic, copy) NSString *accessToken;
@property (nonatomic, readonly, copy) NSString *serverAddress;

@end

@protocol MSRequestManagerSetupProtocol <MSRequestManagerProtocol>

@property (nonatomic, strong) NSURLSessionConfiguration *sessionConfiguration;
@property (nonatomic, strong) NSURLSession *session;

+ (NSURLSessionConfiguration *) randomOrgSessionConfiguration;

@end
