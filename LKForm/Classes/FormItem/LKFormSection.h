//
//  LKFormSection.h
//  LKTable
//
//  Created by dosn-001 on 2019/10/25.
//  Copyright © 2019 tinker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LKFormItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface LKFormSection : NSObject

@property(nonatomic, strong) NSArray *items;
@property(nonatomic, getter=isHidden) BOOL hidden;

@property(nonatomic, strong) UIView *headerView;
@property(nonatomic, copy) NSString *headerTitle;
@property(nonatomic, assign) CGFloat headerHeight;

@property(nonatomic, strong) UIView *footerView;
@property(nonatomic, copy) NSString *footerTitle;
@property(nonatomic, assign) CGFloat footerHeight;

+ (instancetype)sectionWithItems:(NSArray *)items;

- (void)addItem:(__kindof LKFormItem *)item;

- (void)addItems:(NSArray <__kindof LKFormItem *>*)items;

- (void)replaceItemAtIndex:(NSUInteger)index withObject:(__kindof LKFormItem *)object;

- (void)removeItemAtIndex:(NSUInteger)index;

- (void)removeAllItems;

@end

NS_ASSUME_NONNULL_END
