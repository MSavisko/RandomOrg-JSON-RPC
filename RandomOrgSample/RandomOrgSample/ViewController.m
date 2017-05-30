//
//  ViewController.m
//  RandomOrgSample
//
//  Created by Maksym Savisko on 3/20/17.
//  Copyright © 2017 Maksym Savisko. All rights reserved.
//

#import "ViewController.h"
#import "MSRequestManager.h"
#import "MSRandomRequest.h"

@interface ViewController ()
@property (nonatomic, strong, nullable) __kindof NSObject <MSRequestManagerBasicProtocol> *requestInstance;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (IBAction)actionButtonPressed:(UIButton *)sender
{
    MSRandomRequest *request = [MSRandomRequest defaultBasicIntegerWithApiKey:@"00000000-0000-0000-0000-000000000000"];
    
    [self.requestInstance generateRandomWithParameters:[request serialize] withCompletion:^(MSRequestResponse * _Nonnull response)
    {
        
    }];
}

- (__kindof NSObject <MSRequestManagerBasicProtocol> *) requestInstance
{
    if (_requestInstance == nil)
    {
        _requestInstance = [MSRequestManager newInstance];
    }
    
    return _requestInstance;
}

@end
