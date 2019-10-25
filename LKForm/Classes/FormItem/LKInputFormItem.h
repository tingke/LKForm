//
//  LKInputFormItem.h
//  LKTable
//
//  Created by dosn-001 on 2019/10/25.
//  Copyright © 2019 tinker. All rights reserved.
//

#import "LKFormItem.h"

typedef NS_ENUM(NSInteger, LKInputType) {
    LKInputTypeInput,
    LKInputTypeTextarea
};

@interface LKInputFormItem : LKFormItem

@property(nonatomic, copy) NSString *text;

@property(nonatomic, copy) NSString *placeholder;

@property(nonatomic, assign) LKInputType inputType;

@property(nonatomic, assign) BOOL secureTextEntry;

+ (instancetype)itemWithText:(NSString *)text
                 placeholder:(NSString *)placeholder;

@end
