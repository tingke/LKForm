//
//  LKInputFormItem.h
//  LKTable
//
//  Created by dosn-001 on 2019/10/25.
//  Copyright © 2019 tinker. All rights reserved.
//

#import "LKFormItem.h"
@class LKInputFormItem;

typedef NS_ENUM(NSInteger, LKInputType) {
    LKInputTypeInput,
    LKInputTypeTextarea
};

typedef void(^LKTextChangeBlock)(__kindof LKInputFormItem *item);

@interface LKInputFormItem : LKFormItem

@property(nonatomic, copy) NSString *title;

@property(nonatomic, copy) NSString *text;

@property(nonatomic, strong) UIFont *textFont;

@property(nonatomic, copy) NSString *placeholder;

@property(nonatomic, assign) LKInputType inputType;

@property(nonatomic, assign) BOOL secureTextEntry;

@property(nonatomic, copy) LKTextChangeBlock textBlock;

+ (instancetype)itemWithText:(NSString *)text
                 placeholder:(NSString *)placeholder
                   textBlock:(LKTextChangeBlock)textBlock;

@end
