//
//  zhFirstViewController.m
//  ThemeManager
//
//  Created by zhanghao on 2017/8/26.
//  Copyright © 2017年 snail-z. All rights reserved.
//

#import "zhFirstViewController.h"
#import "zhNextViewController.h"

@interface zhFirstViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *array1;
@property (nonatomic, strong) NSMutableArray *array2;

@end

@implementation zhFirstViewController

- (instancetype)init {
    if (self = [super init]) {
        NSArray *arr1 = @[@"mf700-00014329", @"mf700-00014344", @"mf700-00021233", @"mf700-01036711", @"mf700-02883145"];
        NSArray *arr2 = @[@"604-p00551", @"604-p01490", @"604-p01505", @"ph1449-p02096", @"ph1449-p02101"];
        _array1 = [NSMutableArray arrayWithArray:arr1];
        [_array1 addObjectsFromArray:arr1];
        _array2 = [NSMutableArray arrayWithArray:arr2];
        [_array2 addObjectsFromArray:arr2];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSFontAttributeName] = [UIFont fontWithName:@"GillSans-SemiBoldItalic" size:25];
    textAttrs[NSForegroundColorAttributeName] = ThemePickerWithKey(@"color04");
    [self.navigationController.navigationBar zh_setTitleTextAttributes:textAttrs];
    self.navigationController.navigationBar.zh_overlayColorPicker = ThemePickerWithKey(@"color01");
    
    self.navigationItem.title = @"ThemeManager";
    
    [self commonInitialization];
}

- (void)commonInitialization {
    _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    _tableView.y = 64;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.delaysContentTouches = NO;
    _tableView.rowHeight = 140;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.zh_backgroundColorPicker = ThemePickerWithKey(@"color01");
    self.view = _tableView;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _array1.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UIImageView *imgView = [UIImageView new];
        imgView.frame = CGRectMake(0, 10, self.view.frame.size.width - 20, 125);
        imgView.centerX = self.view.frame.size.width / 2;
        [cell addSubview:imgView];
        [cell zh_setAssociatedValue:imgView withKey:_cmd];
    }
    
    UIImageView *imgView = (UIImageView *)[cell zh_getAssociatedValueForKey:_cmd];
    NSDictionary *imgDict = @{ThemeDay : [UIImage imageNamed:_array1[indexPath.row]],
                              ThemeNight : [UIImage imageNamed:_array2[indexPath.row]],
                              Theme1 : [UIImage imageNamed:_array2[indexPath.row]],
                              Theme2 : [UIImage imageNamed:_array2[indexPath.row]],
                              Theme3 : [UIImage imageNamed:_array2[indexPath.row]]};
    imgView.zh_imagePicker = ThemePickerWithDict(imgDict);
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.zh_backgroundColorPicker = ThemePickerWithKey(@"color01");
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([ThemeManager isCurrentThemeEqual:ThemeNight]) {
        [ThemeManager updateThemeStyle:ThemeDay];
    } else {
        [ThemeManager updateThemeStyle:ThemeNight];
    }
}

@end
