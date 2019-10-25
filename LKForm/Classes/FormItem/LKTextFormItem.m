//
//  LKTextFormItem.m
//  LKTable
//
//  Created by dosn-001 on 2019/10/25.
//  Copyright © 2019 tinker. All rights reserved.
//

#import "LKTextFormItem.h"

@implementation LKTextFormItem

+ (instancetype)itemWithTitle:(NSString *)title subtitle:(NSString *)subtitle {
    LKTextFormItem *item = [[self alloc] init];
    item.subtitle = subtitle;
    item.title = title;
    return item;
}

+ (instancetype)itemWithAttributedTitle:(NSAttributedString *)attributedTitle
                     attributedSubtitle:(NSAttributedString *)attributedSubtitle {
    LKTextFormItem *item = [[self alloc] init];
    item.attributedSubtitle = attributedSubtitle;
    item.attributedTitle = attributedTitle;
    return item;
}

+ (instancetype)itemWithTitle:(NSString *)title icon:(NSString *)icon jumpToController:(Class)vcClass {
    LKTextFormItem *item = [[self alloc] init];
    item.vcClass = vcClass;
    item.title = title;
    item.icon = icon;
    return item;
}

+ (instancetype)itemWithTitle:(NSString *)title icon:(NSString *)icon option:(LKSelectRowBlock)rowBlock {
    LKTextFormItem *item = [[self alloc] init];
    item.selectRowBlock = rowBlock;
    item.title = title;
    item.icon = icon;
    return item;
}

@end
