//
//  SecondSituationViewController.m
//  SmoothTransitionDemo
//
//  Created by Delpan on 16/3/17.
//  Copyright (c) 2016年 Delpan. All rights reserved.
//

/** 文本大小 */
static const NSInteger LabelSize = 15;

#import "SecondSituationViewController.h"

@interface SecondSituationViewController ()
{
    UILabel *tipsLabel;
    
    CADisplayLink *timer;
    
    /** 定时次数 */
    NSInteger timerIndex;
    
    /** X方向上的文本数 */
    NSInteger horizontalCount;
    /** Y方向上的文本数 */
    NSInteger verticalCount;
    /** 文本间距 */
    CGFloat labelDistance;
}

@property (nonatomic, assign) SecondSituationLoadType type;

@end

@implementation SecondSituationViewController

+ (instancetype)createWithType:(SecondSituationLoadType)type
{
    SecondSituationViewController *object = [SecondSituationViewController new];
    object.type = type;
    object.title = @"情形二";
    
    return object;
}

- (instancetype)init
{
    if (self = [super init])
    {
        timerIndex = 0;
        
        labelDistance = LabelSize - 5.5;
        horizontalCount = ceil(iPhoneWidth / labelDistance);
        verticalCount = ceil(iPhoneHeight / labelDistance);
    }
    
    return self;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (_type == SecondSituationLoadViewDidAppearType)
    {
        [self loadAllLabels];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    if (_type == SecondSituationLoadNextLoopType || _type == SecondSituationLoadViewDidAppearType)
    {
        tipsLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, iPhoneWidth, (iPhoneHeight - 64))];
        tipsLabel.backgroundColor = self.view.backgroundColor;
        tipsLabel.opaque = YES;
        tipsLabel.layer.masksToBounds = YES;
        tipsLabel.textAlignment = NSTextAlignmentCenter;
        tipsLabel.textColor = [UIColor grayColor];
        tipsLabel.text = @"Waiting...";
        [self.view addSubview:tipsLabel];
    }
    
    [self willLoadLabels];
}

- (void)willLoadLabels
{
    if (_type == SecondSituationLoadDefaultType)
    {
        [self loadAllLabels];
    }
    else if (_type == SecondSituationLoadNextLoopType)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self loadAllLabels];
        });
    }
    else if (_type == SecondSituationLoadTimerType)
    {
        timer = [CADisplayLink displayLinkWithTarget:self selector:@selector(timerAction:)];
        [timer addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    }
    else if (_type == SecondSituationLoadGCDType)
    {
        [self dispatchTaskAction];
    }
}

#pragma mark - UI
- (void)loadAllLabels
{
    for (int i = 0; i < verticalCount; i++)
    {
        [self loadLabelsWithIndex:i];
    }
}

- (void)loadLabelsWithIndex:(NSInteger)index
{
    CGFloat vertical = index * labelDistance;
    
    for (int j = 0; j < horizontalCount; j++)
    {
        NSDictionary *propertyDic = @{ NSFontAttributeName : [UIFont systemFontOfSize:12.0f],
                                       NSForegroundColorAttributeName : [UIColor whiteColor]};
        
        NSString *string = [NSString stringWithFormat:@"%d", j % 10];
        NSAttributedString *attString = [[NSAttributedString alloc] initWithString:string attributes:propertyDic];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(j * labelDistance, vertical, LabelSize, LabelSize)];
        label.backgroundColor = [UIColor grayColor];
        label.opaque = YES;
        label.clipsToBounds = YES;
        label.attributedText = attString;
        [self.view addSubview:label];
    }
}

#pragma mark - Action
#pragma mark Timer Action
- (void)timerAction:(CADisplayLink *)sender
{
    if (timerIndex < verticalCount)
    {
        [self loadLabelsWithIndex:timerIndex];
        
        timerIndex++;
    }
    else
    {
        [timer invalidate];
        timer = nil;
    }
}

#pragma mark Dispatch Task Action
- (void)dispatchTaskAction
{
    [self loadLabelsWithIndex:timerIndex];
    
    timerIndex++;
    
    if (timerIndex < verticalCount)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self dispatchTaskAction];
        });
    }
}

#pragma mark Back
- (void)navigationPop:(UIButton *)sender
{
    !timer ?: [timer invalidate];
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end

































