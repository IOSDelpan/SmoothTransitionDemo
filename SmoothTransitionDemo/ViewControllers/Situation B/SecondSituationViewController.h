//
//  SecondSituationViewController.h
//  SmoothTransitionDemo
//
//  Created by Delpan on 16/3/17.
//  Copyright (c) 2016年 Delpan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, SecondSituationLoadType)
{
    /** 默认加载UI */
    SecondSituationDefaultLoadType = 0,
    /** viewDidAppear时加载UI */
    SecondSituationViewDidAppearLoadType,
    /** RunLoop下次循行加载UI */
    SecondSituationNextLoopLoadType,
    /** 定时器加载UI */
    SecondSituationTimerLoadType
};

@interface SecondSituationViewController : UIViewController

+ (instancetype)createWithType:(SecondSituationLoadType)type;

@end
























