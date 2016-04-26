//
//  ThirdSituationViewController.m
//  SmoothTransitionDemo
//
//  Created by Delpan on 16/4/11.
//  Copyright © 2016年 Delpan. All rights reserved.
//

#import "ThirdSituationViewController.h"

@interface ThirdSituationViewController ()
{
    UILabel *tipsLabel;
    
    BOOL didLoad;
}

@property (nonatomic, assign) ThirdSituationLoadType type;

@property (nonatomic) UIImageView *snapshotView;

@end

@implementation ThirdSituationViewController

+ (instancetype)createWithType:(ThirdSituationLoadType)type
{
    ThirdSituationViewController *object = [ThirdSituationViewController new];
    object.type = type;
    object.title = @"情形三";
    
    return object;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    !_snapshotView ?: [_snapshotView setHidden:NO];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    !_snapshotView ?: [_snapshotView setHidden:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    !_snapshotView ?: [_snapshotView setHidden:NO];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self loadSubViews];
}

#pragma mark - UI
- (void)loadSubViews
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    if (_type == ThirdSituationLoadDefaultType)
    {
        [self loadRoundViews];
    }
    else
    {
        tipsLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, iPhoneWidth, (iPhoneHeight - 64))];
        tipsLabel.backgroundColor = self.view.backgroundColor;
        tipsLabel.opaque = YES;
        tipsLabel.textAlignment = NSTextAlignmentCenter;
        tipsLabel.textColor = [UIColor grayColor];
        tipsLabel.text = @"Waiting...";
        [self.view addSubview:tipsLabel];
        
        if (_type == ThirdSituationLoadSnapshotType)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
               
                [self loadRoundViews];
                
                self.snapshotView.hidden = NO;
            });
        }
    }
}

- (void)loadRoundViews
{
    CGPoint point = CGPointMake(CGRectGetWidth(self.view.bounds) / 2, (iPhoneHeight - 64) / 2);
    
    UIColor *yellowColor = [UIColor yellowColor];
    UIColor *grayColor = [UIColor grayColor];
    
    for (int i = 0; i < 30; i++)
    {
        CGFloat size = iPhoneWidth - i;
        
        UILabel *subLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, size, size)];
        subLabel.center = point;
        subLabel.backgroundColor = i % 2 ? yellowColor : grayColor;
        subLabel.layer.cornerRadius = size / 2;
        subLabel.layer.masksToBounds = YES;
        subLabel.textAlignment = NSTextAlignmentCenter;
        subLabel.textColor = [UIColor blackColor];
        subLabel.text = [NSString stringWithFormat:@"%d", i + 1];
        [self.view addSubview:subLabel];
    }
    
    didLoad = YES;
}

#pragma mark - Action
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UIViewController *controller = [UIViewController new];
    controller.view.backgroundColor = self.view.backgroundColor;
    controller.title = @"Title";
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark - Set / Get
#pragma mark 截图视图
- (UIImageView *)snapshotView
{
    if (!_snapshotView)
    {
        UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, self.view.opaque, 0);
        CGContextRef context = UIGraphicsGetCurrentContext();
        [self.view.layer renderInContext:context];
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        _snapshotView = [[UIImageView alloc] initWithFrame:self.view.bounds];
        _snapshotView.image = image;
        [self.view addSubview:_snapshotView];
    }
    
    return _snapshotView;
}

@end




































