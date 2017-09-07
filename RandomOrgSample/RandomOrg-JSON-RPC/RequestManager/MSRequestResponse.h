//
//  MSRequestResponse.h
//  RandomOrgSample
//
//  Created by Maksym Savisko on 5/30/17.
//  Copyright © 2017 Maksym Savisko. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MSRequestResponse : NSObject

/**
 Indicate, that response was successed (internet OK, response from server OK).
 */
@property (nonatomic) BOOL isSuccess;

/**
 Local device time, that indicate when reuqest started.
 */
@property (nonatomic, strong, nonnull, readonly) NSDate *requestStartTime;

/**
 Response object (usually JSON)
 */
@property (nonatomic, strong, nullable) id object;

/**
 Error from service of requesting proccess (if exist).
 */
@property (nonatomic, strong, nullable) NSError *error;

/**
 Content ID for request. Usually it is an integer from 0 to 32768
 */
@property (nonatomic, strong, nullable) NSString *contentId;

/**
 HTTP status response code.
 If it could not be parsed, return 0.
 */
@property (nonatomic) NSInteger statusCode;

/**
 Create new instance of request

 @return new instance of empty response
 */
+ (nonnull instancetype) response;

@end
