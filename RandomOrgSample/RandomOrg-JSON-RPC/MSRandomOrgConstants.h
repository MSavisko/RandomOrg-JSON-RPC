//
//  MSRandomOrgConstants.h
//  RandomOrgSample
//
//  Created by Maksym Savisko on 5/29/17.
//  Copyright © 2017 Maksym Savisko. All rights reserved.
//

#ifndef MSRandomOrgConstants_h
#define MSRandomOrgConstants_h

static NSString *const MSDefaultErrorDomain = @"com.MaksymSavisko.RandomOrgJsonRpc";

//-11XXX - RandomRequestErrors
//-111XX - RandomRequestParameterErrors
//
typedef NS_ENUM(NSInteger, MSRandomOrgErrorCode){
    
    MSRandomOrgErrorCodeUnknown = -10000,

    MSRandomOrgErrorCodeRequestNotEnoughParameters = -11101,
    MSRandomOrgErrorCodeRequestParametersEmpty = -11102
};

#endif /* MSRandomOrgConstants_h */
