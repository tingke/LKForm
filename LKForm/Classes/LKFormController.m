//
//  LKFormViewController.m
//  LKTable
//
//  Created by dosn-001 on 2019/10/25.
//  Copyright © 2019 tinker. All rights reserved.
//

#import "LKFormController.h"
#import "UITableViewCell+LK.h"

@interface LKFormController ()<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong) NSMutableArray *registerIdentifier;

@end

@implementation LKFormController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupTable];
}

- (void)setupTable {
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.backgroundColor = self.view.backgroundColor;
    self.tableView.estimatedRowHeight = 100;
    [self.view addSubview:self.tableView];
    
    NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
    NSLayoutConstraint *bottomConstraint = [NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
    NSLayoutConstraint *leftConstraint = [NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
    NSLayoutConstraint *rightConstraint = [NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
    [self.view addConstraints:@[topConstraint, bottomConstraint, leftConstraint, rightConstraint]];
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    
    // 1.调整(iOS7以上)表格分隔线边距
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        self.tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }
    // 2.调整(iOS8以上)view边距(或者在cell中设置preservesSuperviewLayoutMargins,二者等效)
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        self.tableView.layoutMargins = UIEdgeInsetsMake(0, 0, 0, 0);
    }
}

#pragma mark - ————— UITableViewDataSource —————

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    LKFormSection *form = self.dataSource[section];
    return form.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LKFormItem *item = [self itemAtIndexPath:indexPath];
    NSString *identifier = item.cellIdentifier;
    if (![self.registerIdentifier containsObject:identifier]) {
        [self.registerIdentifier addObject:identifier];
        [self.tableView registerCell:NSClassFromString(identifier) withIdentifier:identifier];
    }
    UITableViewCell *cell = [UITableViewCell cellWithTableView:tableView withIdentifier:identifier];
    
    if(item.gesture) {
        [cell addGestureRecognizer:item.gesture];
    }
    
    if ([item isKindOfClass:[LKTextFormItem class]]) {
        LKTextFormItem *aItem = (LKTextFormItem *)item;
        cell.accessoryType = !aItem.hiddenArrow;
        if (aItem.attributedTitle) {
            cell.textLabel.attributedText = aItem.attributedTitle;
        }else{
            cell.textLabel.text = aItem.title;
            cell.textLabel.font = [UIFont systemFontOfSize:17];
        }
        if (aItem.attributedSubtitle) {
            cell.detailTextLabel.attributedText = aItem.attributedSubtitle;
        }else{
            cell.detailTextLabel.text = aItem.subtitle;
            cell.detailTextLabel.font = [UIFont systemFontOfSize:17];
        }
//        if ([aItem.icon hasPrefix:@"http"]) {
//            NSURL *url = [NSURL URLWithString:aItem.icon.URLDecode];
//            [cell.imageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"test"]];
//        }else if(aItem.icon.length){
//            cell.imageView.image = [UIImage imageNamed:aItem.icon];
//        }
        
//        if ([item isMemberOfClass:[DSStaticTableAccessoryItem class]]) {
//            DSStaticTableAccessoryItem *accessoryItem = (DSStaticTableAccessoryItem *)item;
//            if (accessoryItem.accessoryView) {
//                if(aItem.showArrow) {
//                    [cell addSubview:accessoryItem.accessoryView];
//                    [accessoryItem.accessoryView mas_makeConstraints:^(MASConstraintMaker *make) {
//                        make.centerY.equalTo(cell);
//                        make.right.equalTo(cell.contentView).offset(0);
//                        make.width.equalTo(@(accessoryItem.accessoryView.width));
//                        make.height.equalTo(@(accessoryItem.accessoryView.height));
//                    }];
//                }else {
//                    cell.accessoryView = accessoryItem.accessoryView;
//                }
//            }else{
//                cell.accessoryType = accessoryItem.accessoryType;
//            }
//        }
    }else if([item isKindOfClass:[LKInputFormItem class]]) {

        LKInputFormItem *aItem = (LKInputFormItem *)item;

    }else if([item isKindOfClass:[LKCustomFormItem class]]){
        LKCustomFormItem *aItem = (LKCustomFormItem *)item;
        
    }
    
    return cell;
}

#pragma mark - ————— UITableViewDelegate —————

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    LKFormItem *item = [self itemAtIndexPath:indexPath];
    if (item.selectRowBlock) {
        item.selectRowBlock(item);
    }else if( [item isKindOfClass:[LKTextFormItem class]] && item.vcClass) {
        LKTextFormItem *aItem = (LKTextFormItem *)item;
        UIViewController *vc = [[aItem.vcClass alloc] init];
        vc.title = aItem.title;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    LKFormItem *item = [self itemAtIndexPath:indexPath];
    return item.cellHeight >= 0 ? (item.cellHeight == 0 ? 44 : item.cellHeight) : UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    LKFormSection *group = self.dataSource[section];
    if (group.headerHeight == 0) {
        return 0.001;
    }
    return group.headerHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    LKFormSection *group = self.dataSource[section];
    if (!group.headerView) {
        UIView *view = [UIView new];
        view.backgroundColor = self.tableView.backgroundColor;
        return view;
    }
    return group.headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    LKFormSection *group = self.dataSource[section];
    if (group.footerHeight == 0) {
        return 0.001;
    }
    return group.footerHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    LKFormSection *group = self.dataSource[section];
    if (!group.footerView) {
        UIView *view = [UIView new];
        view.backgroundColor = self.tableView.backgroundColor;
        return view;
    }
    return group.footerView;
}

#pragma mark - ————— Public —————

- (LKFormItem *)itemAtIndexPath:(NSIndexPath *)indexPath {
    LKFormSection *section = self.dataSource[indexPath.section];
    LKFormItem *item = section.items[indexPath.row];
    return item;
}

#pragma mark - ————— Private —————

#pragma mark - ————— Getter —————

- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        _tableView.tableFooterView = [UIView new];
        if (@available(iOS 11.0, *)) {
            _tableView.estimatedRowHeight = 0;
            _tableView.estimatedSectionHeaderHeight = 0;
            _tableView.estimatedSectionFooterHeight = 0;
            _tableView.scrollIndicatorInsets = _tableView.contentInset;
        }
    }
    return _tableView;
}

- (void)setDataSource:(NSArray *)dataSource{
    _dataSource = dataSource;
    [self.tableView reloadData];
}

- (NSMutableArray *)registerIdentifier {
    if (!_registerIdentifier) {
        _registerIdentifier = [NSMutableArray array];
    }
    return _registerIdentifier;
}

@end
