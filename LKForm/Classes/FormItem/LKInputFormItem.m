//
//  LKInputFormItem.m
//  LKTable
//
//  Created by dosn-001 on 2019/10/25.
//  Copyright © 2019 tinker. All rights reserved.
//

#import "LKInputFormItem.h"
#import "LKInputFormViewCell.h"

@implementation LKInputFormItem

- (NSString *)cellIdentifier {
    return NSStringFromClass([LKInputFormViewCell class]);
}

+ (instancetype)itemWithText:(NSString *)text
                 placeholder:(NSString *)placeholder
                   textBlock:(LKTextChangeBlock)textBlock {
    LKInputFormItem *item = [[self alloc] init];
    item.text = text;
    item.placeholder = placeholder;
    item.textBlock = textBlock;
    return item;
}

@end
