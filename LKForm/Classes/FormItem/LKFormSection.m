//
//  LKFormSection.m
//  LKTable
//
//  Created by dosn-001 on 2019/10/25.
//  Copyright © 2019 tinker. All rights reserved.
//

#import "LKFormSection.h"

@implementation LKFormSection

+ (instancetype)sectionWithItems:(NSArray *)items {
    LKFormSection *section = [[self alloc] init];
    section.items = items;
    section.headerHeight = 13;
    section.footerHeight = 0.01;
    return section;
}

- (void)addItem:(__kindof LKFormItem *)item {
    self.items = [self.items arrayByAddingObject:item];
}

- (void)addItems:(NSArray <__kindof LKFormItem *>*)items {
    self.items = [self.items arrayByAddingObjectsFromArray:items];
}

- (void)replaceItemAtIndex:(NSUInteger)index withObject:(__kindof LKFormItem *)object {
    NSAssert(index < self.items.count, @"[LKForm] index must bigger than items length!");
    @synchronized (self) {
        LKFormItem *item = self.items[index];
        item = object;
    }
}

- (void)removeItemAtIndex:(NSUInteger)index {
    NSAssert(index < self.items.count, @"[LKForm] index must bigger than items length!");
    @synchronized (self) {
        NSMutableArray *temp = [NSMutableArray arrayWithCapacity:self.items.count - 1];
        [self.items enumerateObjectsUsingBlock:^(LKFormItem *obj, NSUInteger idx, BOOL *stop) {
            if (index != idx) {
                [temp addObject:obj];
            }
        }];
        self.items = temp;
    }
}

- (void)removeAllItems {
    self.items = @[];
}

@end
