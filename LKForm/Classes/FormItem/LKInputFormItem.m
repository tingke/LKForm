//
//  LKInputFormItem.m
//  LKTable
//
//  Created by dosn-001 on 2019/10/25.
//  Copyright © 2019 tinker. All rights reserved.
//

#import "LKInputFormItem.h"

@implementation LKInputFormItem

- (NSString *)cellIdentifier {
    return NSStringFromClass([UITableViewCell class]);
}

+ (instancetype)itemWithText:(NSString *)text
                 placeholder:(NSString *)placeholder {
    LKInputFormItem *item = [[self alloc] init];
    item.text = text;
    item.placeholder = placeholder;
    return item;
}

@end
