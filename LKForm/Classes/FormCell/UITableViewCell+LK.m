//
//  UITableViewCell+LK.m
//  LKTable
//
//  Created by dosn-001 on 2019/10/25.
//  Copyright © 2019 tinker. All rights reserved.
//

#import "UITableViewCell+LK.h"
#import <objc/runtime.h>

@implementation UITableView (LK)

- (void)registerCell:(Class)cellClass {
    [self registerCell:cellClass withIdentifier:NSStringFromClass(cellClass)];
}

- (void)registerCell:(Class)cellClass withIdentifier:(NSString *)identifier {
    
    NSString *path = [[NSBundle mainBundle] pathForResource:NSStringFromClass(cellClass) ofType:@"nib"];
    if (path) {
        UINib *nib = [UINib nibWithNibName:NSStringFromClass(cellClass) bundle:nil];
        [self registerNib:nib forCellReuseIdentifier:identifier];
    }else {
        [self registerClass:cellClass forCellReuseIdentifier:identifier];
    }
}

@end

static const NSString *tableKey;

@implementation UITableViewCell (LK)

+ (instancetype)cellWithTableView:(UITableView *)tableView
                   withIdentifier:(NSString *)identifier {
    
    NSString *aIdentifier = identifier?:NSStringFromClass([self class]);
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[self alloc] initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:aIdentifier];
    }
    cell.tableView = tableView;
    return cell;
}

- (UITableView *)tableView {
    return objc_getAssociatedObject(self, &tableKey);
}

- (void)setTableView:(UITableView *)tableView {
    objc_setAssociatedObject(self, &tableKey, tableView, OBJC_ASSOCIATION_ASSIGN);
}

@end
