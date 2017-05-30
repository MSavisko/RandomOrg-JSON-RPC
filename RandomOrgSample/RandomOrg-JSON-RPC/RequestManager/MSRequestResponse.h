//
//  MSRequestResponse.h
//  RandomOrgSample
//
//  Created by Maksym Savisko on 5/30/17.
//  Copyright © 2017 Maksym Savisko. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MSRequestResponse : NSObject

@property BOOL isSuccess;
@property (nonatomic, strong) NSDate *requestStartTime;
@property (nonatomic, strong) id object;
@property (nonatomic, strong) NSError *error;
@property (nonatomic, strong) NSString *contentId;
@property (nonatomic) NSInteger statusCode;

+ (instancetype) response;

@end
