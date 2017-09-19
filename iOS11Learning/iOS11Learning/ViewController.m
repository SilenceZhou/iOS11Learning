//
//  ViewController.m
//  iOS11Learning
//
//  Created by SilenceZhou on 2017/9/19.
//  Copyright © 2017年 silence. All rights reserved.
//  参考链接： http://www.jianshu.com/p/370d82ba3939
//  官方视频： https://developer.apple.com/videos/play/wwdc2017/204/

#import "ViewController.h"
#import "TestScrollVc.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UISearchController *searchController;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIRefreshControl *refreshContrl;
@end

@implementation ViewController


#pragma mark - Life Cylce

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"😆你好吗";
    [self.view addSubview:self.tableView];
    
    // 1.设置大标题
    self.navigationController.navigationBar.prefersLargeTitles = YES;
    //self.navigationItem.largeTitleDisplayMode = UINavigationItemLargeTitleDisplayModeNever;
    
    
    // 2.设置搜索栏
    self.navigationItem.searchController = self.searchController;
    self.navigationItem.hidesSearchBarWhenScrolling = YES;//决定滑动的时候是否隐藏搜索框；
    
    
    // 3.设置UITableView的refreshControl
    self.tableView.refreshControl = self.refreshContrl;
    
    // 4.添加安全区域
    // self.additionalSafeAreaInsets = UIEdgeInsetsMake(100, 100, 100, 100);
    // self.tableView.adjustedContentInset =
    // self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    
    // 5.
}


#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"I am %ld row", indexPath.row];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 100;
}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.refreshContrl endRefreshing];
    
    // 测试滚动安全区域
    TestScrollVc *aTestScrollVc = [[TestScrollVc alloc] init];
    [self presentViewController:aTestScrollVc animated:YES completion:nil];
    
    
}


- (void)scrollViewDidChangeAdjustedContentInset:(UIScrollView *)scrollView{
    
}


// Swipe actions
// These methods supersede -editActionsForRowAtIndexPath: if implemented
// return nil to get the default swipe actions
- (nullable UISwipeActionsConfiguration *)tableView:(UITableView *)tableView leadingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIContextualAction *action = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleNormal title:@"左边" handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
        NSLog(@"左边出发");
        
        completionHandler(YES);
    }];
    action.title = @"左边hahha ";
    action.backgroundColor = [UIColor blueColor];
    
    UISwipeActionsConfiguration *swipeAction = [UISwipeActionsConfiguration configurationWithActions:@[action]];
    return swipeAction;
}
/**
 滑动操作这里还有一个需要注意的是，当cell高度较小时，会只显示image，不显示title，当cell高度够大时，会同时显示image和title。我写demo测试的时候，因为每个cell的高度都较小，所以只显示image，然后我增加cell的高度后，就可以同时显示image和title了。见下图对比：
 */
- (nullable UISwipeActionsConfiguration *)tableView:(UITableView *)tableView trailingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UIContextualAction *action2 = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleNormal title:@"左边" handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
        NSLog(@"左边出发");
        
        completionHandler(YES);
    }];
    action2.title = @"左边hahha ";
    action2.backgroundColor = [UIColor redColor];
    
    //删除
    UIContextualAction *deleteRowAction = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleDestructive title:@"delete" handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
        
        NSLog(@"删除");
        
        completionHandler (YES);
    }];
    // return 44; 如果同时设置UIContextualAction的 图片和文字， 高度不够的时候不显示文字
    deleteRowAction.image = [UIImage imageNamed:@"delete"];
    deleteRowAction.backgroundColor = [UIColor blueColor];
    
    UISwipeActionsConfiguration *config = [UISwipeActionsConfiguration configurationWithActions:@[action2, deleteRowAction]];
    return config;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 94;
}



#pragma mark - Properties

- (UIRefreshControl *)refreshContrl
{
    if (!_refreshContrl) {
        _refreshContrl = [[UIRefreshControl alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 40)];
        
        _refreshContrl.tintColor = [UIColor redColor];
        
    }
    return _refreshContrl;
}


- (UISearchController *)searchController
{
    if (!_searchController) {
        _searchController = [[UISearchController alloc] initWithSearchResultsController:self];
    }
    return _searchController;
}


- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorInset = UIEdgeInsetsMake(0, 100, 0, 0);
        _tableView.separatorInsetReference = UITableViewSeparatorInsetFromAutomaticInsets;
        
        //        设置为separatorInset属性的值被解释为与单元格边缘的偏移量。
        //        UITableViewSeparatorInsetFromCellEdges, //default
        //        设置为separatorInset属性的值被解释为与自动分隔符insets的偏移量。
        //        UITableViewSeparatorInsetFromAutomaticInsets
        
        // 需要注意了
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
    }
    return _tableView;
}


@end

