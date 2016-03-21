//
//  RootNavigationController.m
//  SmoothTransitionDemo
//
//  Created by Delpan on 16/3/16.
//  Copyright (c) 2016年 Delpan. All rights reserved.
//

#import "RootNavigationController.h"

@interface RootNavigationController ()

@end

@implementation RootNavigationController

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    viewController.edgesForExtendedLayout = UIRectEdgeNone;
    
    if (self.childViewControllers.count)
    {
        id target = ([viewController respondsToSelector:@selector(navigationPop:)] ? viewController : self);
        
        // 返因按钮
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        backButton.bounds = CGRectMake(0, 0, 40, 40);
        backButton.imageEdgeInsets = UIEdgeInsetsMake(0, -14, 0, 0);
        [backButton setImage:[UIImage imageNamed:@"left"] forState:UIControlStateNormal];
        [backButton addTarget:target action:@selector(navigationPop:) forControlEvents:UIControlEventTouchUpInside];
        
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    }
    
    [super pushViewController:viewController animated:YES];
}

#pragma mark - Action
#pragma mark Back
- (void)navigationPop:(UIButton *)sender
{
    [self popViewControllerAnimated:YES];
}

@end






















