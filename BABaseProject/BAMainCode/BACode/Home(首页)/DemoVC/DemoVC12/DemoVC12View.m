//
//  DemoVC12View.m
//  BABaseProject
//
//  Created by 博爱 on 16/6/21.
//  Copyright © 2016年 博爱之家. All rights reserved.
//

#import "DemoVC12View.h"


static NSString * const titleMsg = @"欢迎使用 iPhone SE，迄今最高性能的 4 英寸 iPhone。在打造这款手机时，我们在深得人心的 4 英寸设计基础上，从里到外重新构想。它所采用的 A9 芯片，正是在 iPhone 6s 上使用的先进芯片。1200 万像素的摄像头能拍出令人叹为观止的精彩照片和 4K 视频，而 Live Photos 则会让你的照片栩栩如生。这一切，成就了一款外形小巧却异常强大的 iPhone。";
@interface DemoVC12View ()
<
    UITableViewDelegate,
    UITableViewDataSource
>
@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) BAModal *modal1;
@property (nonatomic, strong) UILabel *label1;
@property (nonatomic, strong) UIView  *bgView;

@end

@implementation DemoVC12View

- (UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc] init];
        //        _tableView.frame = CGRectMake(0, 0, BA_SCREEN_WIDTH, BA_SCREEN_HEIGHT - BA_getTabbarHeight);
        
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorColor = [UIColor redColor];
        
        [self addSubview:_tableView];
        
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(0 , 0, 0, 0));
        }];
        
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}

- (NSArray *)titleArray
{
    if (!_titleArray)
    {
        _titleArray = @[@"1、自定义弹窗1", @"2、自定义弹窗2【带图片，按钮】", @"3、自定义警告框3【类似系统警告框, 不带button】", @"4、自定义警告框4【类似系统警告框, 带延时】", @"5、自定义警告框5【类似系统警告框, 带图片，按钮】", @"6、系统警告框6【兼容iOS 7、8】", @"7、系统ActionSheet【兼容iOS 7、8】"];
    }
    return _titleArray;
}

- (instancetype)initWithFrame:(CGRect)frame withSelectRowBlock:(selectRowBlock)selectRowBlock
{
    if (self = [super initWithFrame:frame])
    {
        self.selectBlock = selectRowBlock;
        
        self.tableView.hidden = NO;
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.titleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    
    cell.textLabel.text = self.titleArray[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*! 点击立刻取消该cell的选中状态 */
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0)
    {
        [self alert1];
    }
    if (indexPath.row == 1)
    {
        [self alert2];
    }
    if (indexPath.row == 2)
    {
        [self alert3];
    }
    if (indexPath.row == 3)
    {
        [self alert4];
    }
    if (indexPath.row == 4)
    {
        [self alert5];
    }
    if (indexPath.row == 5)
    {
        [self alert6];
    }
    if (indexPath.row == 6)
    {
        [self ActionSheet1];
    }
    
}

- (void)alert1
{
    if (!_modal1)
    {
        _modal1 = [self creatModal:nil];
    }
    
    self.bgView.hidden = NO;
    
//    if (!_label1)
//    {
//        _label1 = [self creatLabel];
//        _label1.userInteractionEnabled = YES;
//        _label1.text = titleMsg;
//        
//        _label1.font = [UIFont systemFontOfSize:16];
//        
//        CGSize size2 = [BAAutoSizeWithWH BA_AutoSizeOfHeghtWithText:_label1.text font:_label1.font width:BA_SCREEN_WIDTH - 60];
//        _label1.frame = CGRectMake(10, self.tableView.centerX, size2.width, size2.height);
//        _label1.backgroundColor = BA_Green_Color;
//        [_label1 jm_setCornerRadius:10 withBorderColor:BA_Red_Color borderWidth:2];
//    }
    [_modal1 showContentView:_bgView animated:YES];
}

- (void)alert2
{
    BAAlertView *alert = [[BAAlertView alloc] initWithTitle:@"这里是自定义弹框2"
                                                      image:[UIImage imageNamed:@"img0.jpg"]
                                                    message:titleMsg buttonTitles:@[@"Cancle", @"Sure"]];
    alert.hideWhenTapOutside = YES;
//    alert.bgroundColor = BA_Yellow_Color;
//    alert.titleColor = BA_Red_Color;

    
    [alert setDidShowHandler:^{
        BALog(@"alert显示了！");
    }];
    [alert setDidHideHandler:^{
        BALog(@"alert隐藏了！");
    }];
    
    [alert setActionHandler:^(NSInteger index) {
        
        if (index == 0)
        {
            BALog(@"点击了取消按钮！");
            return ;
        }
        if (index == 1)
        {
            BA_OpenUrl([NSURL URLWithString:@"http://boai.github.io"]);
        }
    }];
    [alert show:YES];
}

- (void)alert3
{
    [BAAlertView showTitle:@"警 告3" message:titleMsg];
}

- (void)alert4
{
    [BAAlertView showTitle:@"警 告4" message:titleMsg hideDelay:5];
}

- (void)alert5
{
    [BAAlertView showTitle:@"警 告5" image:[UIImage imageNamed:@"img1.jpg"] message:titleMsg buttonTitles:@[@"Cancle", @"Sure"] handler:^(NSInteger index) {
        
        if (index == 0)
        {
            BALog(@"点击了取消按钮！");
            return ;
        }
        if (index == 1)
        {
            BA_OpenUrl([NSURL URLWithString:@"http://boai.github.io"]);
        }
        
    }];
}

- (void)alert6
{
    [[self getCurrentViewController] BAAlertWithTitle:@"警 告6" message:titleMsg andOthers:@[@"Cancle", @"Sure"] animated:YES action:^(NSInteger index) {
        
        if (index == 0)
        {
            BALog(@"点击了取消按钮！");
            return ;
        }
        if (index == 1)
        {
            BA_OpenUrl([NSURL URLWithString:@"http://boai.github.io"]);
        }

    }];
}

- (void)ActionSheet1
{
    [[self getCurrentViewController] BAActionSheetWithTitle:@"警 告7" message:titleMsg destructive:nil destructiveAction:nil andOthers:@[@"Cancle", @"Sure", @"复制", @"粘贴"] animated:YES action:^(NSInteger index) {
        
        if (index == 0)
        {
            BALog(@"点击了取消按钮！");
            return ;
        }
        if (index == 1)
        {
            BA_OpenUrl([NSURL URLWithString:@"http://boai.github.io"]);
        }
        if (index == 2)
        {
            BALog(@"点击了复制按钮！");
            return ;
        }
        if (index == 3)
        {
            BALog(@"点击了粘贴按钮！");
            return ;
        }
    }];
}

- (BAModal *)creatModal:(UIView *)contentView
{
    BAModal *modal = [BAModal ba_modalWithContentView:contentView];
    modal.hideWhenTouchOutside = YES;
    return modal;
}

- (UILabel *)creatLabel
{
    UILabel *label = [UILabel new];
    label.numberOfLines = 0;
    label.textAlignment = NSTextAlignmentLeft;
    label.textColor = [UIColor colorWithWhite:1 alpha:0.85];
    return label;
}

- (UIView *)bgView
{
    if (!_bgView)
    {
        _bgView = [UIView new];
        _bgView.frame = CGRectMake(10, self.tableView.centerX, BA_SCREEN_WIDTH - 20, 200);
        _bgView.backgroundColor = BA_White_Color;
        _bgView.layer.masksToBounds = YES;
        _bgView.clipsToBounds = YES;
        _bgView.layer.cornerRadius = 8.0f;
        
        UILabel *titleLabel = [UILabel new];
        titleLabel.frame = CGRectMake(0, 0, _bgView.width, 50);
        titleLabel.text = @"打赏红包（有币）";
        titleLabel.font = [UIFont boldSystemFontOfSize:17];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        
        UIView *lineView = [UIView new];
        lineView.frame = CGRectMake(0, titleLabel.bottom, _bgView.width, 1);
        lineView.backgroundColor = BA_Red_Color;
        
        BACustomButton *button1 = [self creatButtonWithFrame:CGRectMake(10, lineView.bottom + 10, (_bgView.width - 30) / 2, 30) title:@"88"];
        BACustomButton *button2 = [self creatButtonWithFrame:CGRectMake(button1.right + 10, button1.top, button1.width, button1.height) title:@"168"];
        BACustomButton *button3 = [self creatButtonWithFrame:CGRectMake(button1.x, button1.bottom + 10, button1.width, button1.height) title:@"288"];
        BACustomButton *button4 = [self creatButtonWithFrame:CGRectMake(button3.right + 10, button3.top, button1.width, button1.height) title:@"388"];

        button1.selected = YES;
        
        button1.tag = 1;
        button2.tag = 2;
        button3.tag = 3;
        button4.tag = 4;
        
        [_bgView BA_AddSubViewsWithArray:@[titleLabel, lineView, button1, button2, button3, button4]];
        
        
    }
    return _bgView;
}

- (BACustomButton *)creatButtonWithFrame:(CGRect)frame title:(NSString *)title
{
    BACustomButton *btn = [BACustomButton buttonWithType:UIButtonTypeCustom];
    btn.frame = frame;
//    btn.clipsToBounds = YES;
    btn.layer.masksToBounds = YES;
    btn.layer.borderWidth = 1.0f;
    
    if (btn.selected)
    {
        btn.layer.borderColor = BA_Red_Color.CGColor;
    }
    else
        btn.layer.borderColor = BA_TEXTGrayColor.CGColor;

    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:BA_Red_Color forState:UIControlStateSelected];
    [btn setTitleColor:BA_TEXTGrayColor forState:UIControlStateNormal];
    
    [btn setImage:[UIImage imageNamed:@"images1.bundle/有币"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"images1.bundle/有币"] forState:UIControlStateSelected];
    
    [btn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];

    return btn;
}

- (IBAction)buttonAction:(UIButton *)sender
{
//    if (sender.tag == 1)
//    {
        sender.selected = !sender.selected;
        BALog(@"你点击了第 %ld 个button！", sender.tag);
//    }
    
//    if (<#condition#>) {
//        <#statements#>
//    }
}




@end
