//
//  LKTextFormItem.h
//  LKTable
//
//  Created by dosn-001 on 2019/10/25.
//  Copyright © 2019 tinker. All rights reserved.
//

#import "LKFormItem.h"

@interface LKTextFormItem : LKFormItem

@property(nonatomic, copy) NSString *title;
@property(nonatomic, strong) NSAttributedString *attributedTitle;

@property(nonatomic, copy) NSString *subtitle;
@property(nonatomic, strong) NSAttributedString *attributedSubtitle;

@property(nonatomic, copy) NSString *icon;

@property(nonatomic, getter=isHiddenArrow) BOOL hiddenArrow;

+ (instancetype)itemWithTitle:(NSString *)title subtitle:(NSString *)subtitle;

+ (instancetype)itemWithAttributedTitle:(NSAttributedString *)attributedTitle
                     attributedSubtitle:(NSAttributedString *)attributedSubtitle;

+ (instancetype)itemWithTitle:(NSString *)title icon:(NSString *)icon jumpToController:(Class)vcClass;

+ (instancetype)itemWithTitle:(NSString *)title icon:(NSString *)icon option:(LKSelectRowBlock)rowBlock;

@end
