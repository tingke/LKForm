//
//  LKFormViewController.h
//  LKTable
//
//  Created by dosn-001 on 2019/10/25.
//  Copyright © 2019 tinker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LKFormTableViewCell.h"
#import "LKFormItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface LKFormViewController : UIViewController

@property(nonatomic, strong) UITableView *tableView;

@property(nonatomic, strong) NSArray *dataSource;

@end

NS_ASSUME_NONNULL_END
