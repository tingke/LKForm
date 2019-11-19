//
//  LKFormViewController.h
//  LKTable
//
//  Created by dosn-001 on 2019/10/25.
//  Copyright © 2019 tinker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LKFormTableViewCell.h"
#import "LKCustomFormItem.h"
#import "LKInputFormItem.h"
#import "LKTextFormItem.h"
#import "LKFormSection.h"

NS_ASSUME_NONNULL_BEGIN

@interface LKFormController : UIViewController

@property(nonatomic, strong) UITableView *tableView;

@property(nonatomic, strong) NSArray <LKFormSection *>*dataSource;

- (UITableViewStyle)tableStyle;

@end

NS_ASSUME_NONNULL_END
