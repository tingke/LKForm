//
//  LKFormViewController.m
//  LKTable
//
//  Created by dosn-001 on 2019/10/25.
//  Copyright © 2019 tinker. All rights reserved.
//

#import "LKFormController.h"
#import "UITableViewCell+LK.h"
#import "LKInputFormViewCell.h"
#import "LKFormHeader.h"

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
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:self.tableStyle];
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    self.tableView.tableFooterView = [UIView new];
    if (@available(iOS 11.0, *)) {
        self.tableView.estimatedRowHeight = 0;
        self.tableView.estimatedSectionHeaderHeight = 0;
        self.tableView.estimatedSectionFooterHeight = 0;
        self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    }
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

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
    if (identifier && ![self.registerIdentifier containsObject:identifier]) {
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
        }
        if (aItem.attributedSubtitle) {
            cell.detailTextLabel.attributedText = aItem.attributedSubtitle;
        }else{
            cell.detailTextLabel.text = aItem.subtitle;
        }
//        if ([aItem.icon hasPrefix:@"http"]) {
//            NSURL *url = [NSURL URLWithString:aItem.icon.URLDecode];
//            [cell.imageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"test"]];
//        }else if(aItem.icon.length){
            cell.imageView.image = [UIImage imageNamed:aItem.icon];
//        }
    }else if([item isKindOfClass:[LKInputFormItem class]]) {
        LKInputFormItem *aItem = (LKInputFormItem *)item;
        LKInputFormViewCell *aCell = (LKInputFormViewCell *)cell;
        aCell.textLabel.text = aItem.title;
        if (aItem.inputType == LKInputTypeInput) {
            aCell.textField.secureTextEntry = aItem.secureTextEntry;
            aCell.textField.placeholder = aItem.placeholder;
            aCell.textField.text = aItem.text;
            if (aItem.textFont) {
                aCell.textField.font = aItem.textFont;
            }
            aCell.textView.hidden = YES;
            aCell.textField.hidden = NO;
        }else {
            aCell.textView.placeholder = aItem.placeholder;
            aCell.textView.text = aItem.text;
            if (aItem.textFont) {
                aCell.textView.font = aItem.textFont;
            }
            aCell.textView.hidden = NO;
            aCell.textField.hidden = YES;
        }
        [self textChangeWithItem:aItem withTextView:aCell.textView orTextField:aCell.textField];
    }else if([item isKindOfClass:[LKCustomFormItem class]]){
        LKCustomFormItem *aItem = (LKCustomFormItem *)item;
        NSAssert([cell conformsToProtocol:@protocol(LKFormProtocol)], @"自定义cell请实现LKFormProtocol协议");
        if(aItem.bindingValue) {
            [cell setValue:aItem.bindingValue forKey:@"model"];
        }
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
        UILabel *view = [UILabel new];
        view.backgroundColor = self.tableView.backgroundColor;
        view.text = group.headerTitle;
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
        UILabel *view = [UILabel new];
        view.backgroundColor = self.tableView.backgroundColor;
        view.text = group.footerTitle;
        return view;
    }
    return group.footerView;
}



//- (void)xxx:(NSNotification *)noti {
//    NSLog(@"xxx:%@", noti.object);
//}

#pragma mark - ————— Public —————

- (UITableViewStyle)tableStyle {
    return UITableViewStylePlain;
}

- (LKFormItem *)itemAtIndexPath:(NSIndexPath *)indexPath {
    LKFormSection *section = self.dataSource[indexPath.section];
    LKFormItem *item = section.items[indexPath.row];
    return item;
}

#pragma mark - ————— Private —————

- (void)textChangeWithItem:(LKInputFormItem *)textItem withTextView:(UITextView *)textView orTextField:(UITextField *)textField {
    
    [[NSNotificationCenter defaultCenter] addObserverForName:UITextViewTextDidChangeNotification object:textView queue:nil usingBlock:^(NSNotification *note) {
        UITextView *textView = note.object;
        textItem.text = textView.text;
        textItem.textBlock(textItem);
    }];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:UITextFieldTextDidChangeNotification object:textField queue:nil usingBlock:^(NSNotification *note) {
        UITextView *textField = note.object;
        textItem.text = textField.text;
        textItem.textBlock(textItem);
    }];
}

#pragma mark - ————— Getter —————

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
