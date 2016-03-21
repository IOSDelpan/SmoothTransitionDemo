//
//  FirstSituationViewController.m
//  SmoothTransitionDemo
//
//  Created by Delpan on 16/3/16.
//  Copyright (c) 2016年 Delpan. All rights reserved.
//

#import "FirstSituationViewController.h"

@interface FirstSituationViewController ()
{
    UILabel *label;
}

@property (nonatomic, assign) BOOL async;

@end

@implementation FirstSituationViewController

+ (instancetype)createWithAsyncLoadData:(BOOL)async
{
    FirstSituationViewController *object = [FirstSituationViewController new];
    object.async = async;
    object.title = @"情形一";
    
    return object;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setUpView];
    [self setUpData];
}

#pragma mark - UI
- (void)setUpView
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, iPhoneWidth, (iPhoneHeight - 64))];
    label.backgroundColor = self.view.backgroundColor;
    label.opaque = YES;
    label.layer.masksToBounds = YES;
    label.numberOfLines = 0;
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor grayColor];
    label.text = @"Waiting...";
    [self.view addSubview:label];
}

#pragma mark - Data
- (void)setUpData
{
    if (_async)
    {
        // 避免控制器出栈时，由于数据未加载完成，导致label被强制保留
        __weak UILabel *weakLabel = label;
        
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            
            NSString *string = getString();
            
            if (weakLabel)
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    weakLabel.text = string;
                });
            }
        });
    }
    else
    {
        label.text = getString();
    }
}

NS_INLINE NSString *getString(void)
{
    NSMutableString *string = [NSMutableString string];
    
    for (int i = 0; i < 500000; i++)
    {
        @autoreleasepool
        {
            [string appendString:[NSString stringWithFormat:@"%d", i % 10]];
        }
    }
    
    return string;
}

@end





























