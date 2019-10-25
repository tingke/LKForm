//
//  UITableViewCell+LK.h
//  LKTable
//
//  Created by dosn-001 on 2019/10/25.
//  Copyright © 2019 tinker. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITableView (LK)

- (void)registerCell:(Class)cellClass;

- (void)registerCell:(Class)cellClass withIdentifier:(NSString *)identifier;

@end

@interface UITableViewCell (LK)

+ (instancetype)cellWithTableView:(UITableView *)tableView
                   withIdentifier:(NSString *)identifier;

@property(nonatomic, weak) UITableView *tableView;

@end

NS_ASSUME_NONNULL_END
