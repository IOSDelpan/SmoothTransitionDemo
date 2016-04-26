//
//  CatalogViewController.m
//  SmoothTransitionDemo
//
//  Created by Delpan on 16/3/16.
//  Copyright (c) 2016年 Delpan. All rights reserved.
//

static NSString *const Identifier = @"Cell";

/** 区头高度 */
static const CGFloat TableViewHeadHeight = 40.0f;

#import "CatalogViewController.h"
#import "FirstSituationViewController.h"
#import "SecondSituationViewController.h"
#import "ThirdSituationViewController.h"

@interface CatalogViewController ()
{
    /** 章节 */
    NSArray *chapters;
}

@end

@implementation CatalogViewController

- (instancetype)initWithStyle:(UITableViewStyle)style
{
    if (self = [super initWithStyle:style])
    {
        self.title = @"目录";
        
        chapters = @[ @{ @"Title" : @"情形一",
                         @"Contents" : @[ @"同步读取数据", @"异步读取数据" ] },
                      
                      @{ @"Title" : @"情形二",
                         @"Contents" : @[ @"默认加载UI", @"viewDidAppear时加载UI", @"在RunLoop下一次循环加载UI", @"定时器加载UI", @"GCD嵌套加载UI" ] },
                      
                      @{ @"Title" : @"情形三",
                         @"Contents" : @[ @"默认加载UI", @"截图加载UI" ] } ];
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:Identifier];
}

#pragma mark - Delegate
#pragma mark UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return chapters.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [chapters[section][@"Contents"] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    cell.textLabel.backgroundColor = [UIColor whiteColor];
    cell.textLabel.layer.masksToBounds = YES;
    cell.textLabel.opaque = YES;
    cell.textLabel.textColor = [UIColor grayColor];
    cell.textLabel.text = chapters[indexPath.section][@"Contents"][indexPath.row];
    
    return cell;
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return TableViewHeadHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, iPhoneWidth, TableViewHeadHeight)];
    headerView.backgroundColor = tableView.backgroundColor;
    
    // 区头标题
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, (iPhoneWidth - 15), TableViewHeadHeight)];
    titleLabel.backgroundColor = headerView.backgroundColor;
    titleLabel.layer.masksToBounds = YES;
    titleLabel.opaque = YES;
    titleLabel.textColor = [UIColor grayColor];
    titleLabel.text = chapters[section][@"Title"];
    [headerView addSubview:titleLabel];
    
    return headerView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UIViewController *controller;
    
    if (indexPath.section == 0)
    {
        controller = [FirstSituationViewController createWithAsyncLoadData:indexPath.row];
    }
    else if (indexPath.section == 1)
    {
        controller = [SecondSituationViewController createWithType:indexPath.row];
    }
    else
    {
        controller = [ThirdSituationViewController createWithType:indexPath.row];
    }
    
    [self.navigationController pushViewController:controller animated:YES];
}

@end




































