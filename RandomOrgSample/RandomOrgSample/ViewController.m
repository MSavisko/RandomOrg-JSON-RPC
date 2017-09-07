//
//  ViewController.m
//  RandomOrgSample
//
//  Created by Maksym Savisko on 3/20/17.
//  Copyright © 2017 Maksym Savisko. All rights reserved.
//

#import "ViewController.h"

#import "MSRandomOrgClient.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (IBAction)actionButtonPressed:(UIButton *)sender
{
    [MSRandomOrgClient generateIntegersMin:0
                                       max:5
                                    number:10
                             resultHandler:^(NSArray<NSNumber *> * _Nullable result, NSError * _Nullable error)
    {
        if (!error)
        {
            NSLog(@"Result: %@", result);
        }
    }];
}

@end
