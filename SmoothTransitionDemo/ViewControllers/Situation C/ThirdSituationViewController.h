//
//  ThirdSituationViewController.h
//  SmoothTransitionDemo
//
//  Created by Delpan on 16/4/11.
//  Copyright © 2016年 Delpan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ThirdSituationLoadType)
{
    /** 默认加载UI */
    ThirdSituationLoadDefaultType = 0,
    /** viewDidAppear时加载UI */
    ThirdSituationLoadSnapshotType,
};

@interface ThirdSituationViewController : UIViewController

+ (instancetype)createWithType:(ThirdSituationLoadType)type;

@end

















