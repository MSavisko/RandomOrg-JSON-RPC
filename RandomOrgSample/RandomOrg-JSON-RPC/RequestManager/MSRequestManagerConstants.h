//
//  MSRequestManagerConstants.h
//  RandomOrgSample
//
//  Created by Maksym Savisko on 3/20/17.
//  Copyright © 2017 Maksym Savisko. All rights reserved.
//

#ifndef MSRequestManagerConstants_h
#define MSRequestManagerConstants_h

static NSString *const MSRequestManagerRandomOrgServerAddress = @"https://api.random.org/json-rpc/1/invoke";

static NSString *const MSRequestManagerRandomOrgHeaderContentType = @"application/json-rpc";
static NSString *const MSRequestManagerRandomOrgHeaderAccept = @"application/json-rpc";

static NSString *const MSRequestManagerContentType = @"Content-Type";
static NSString *const MSRequestManagerAccept = @"Accept";
static NSString *const MSRequestManagerPost = @"POST";

static NSString *const MSRequestManagerErrorDomain = @"com.randomOrg-JSON-RPC.request.manager";

typedef NS_ENUM(NSInteger, MSRequestManagerErrorCode)
{
    MSRequestManagerErrorCodeResponseNoData = -9000
};


#endif /* MSRequestManagerConstants_h */
