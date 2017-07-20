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
    
    dispatch_queue_t backgroundQueue = dispatch_queue_create("msrandomorg.serial.background.queue", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_async(backgroundQueue, ^
    {
        [self.requestInstance generateRandomWithParameters:[request serialize] withCompletion:^(MSRequestResponse * _Nonnull response)
         {
             
             void (^_responseBlock)() = ^(){
                 NSLog(@"Response: %@", response.object);
             };
             
             if (![NSThread isMainThread])
             {
                 dispatch_async(dispatch_get_main_queue(),_responseBlock);
             }
             else
             {
                 _responseBlock ();
             }
             
             
         }];
    });
    
    
    /*
    [self.requestInstance generateRandomWithParameters:[request serialize] withCompletion:^(MSRequestResponse * _Nonnull response)
    {
        NSLog(@"Response: %@", response.object);
    }];
    */
}

- (__kindof NSObject <MSRequestManagerBasicProtocol> *) requestInstance
{
    if (_requestInstance == nil)
    {
        _requestInstance = (NSObject <MSRequestManagerBasicProtocol> *) [MSRequestManager newInstance] ;
    }
    
    return _requestInstance;
}

@end
