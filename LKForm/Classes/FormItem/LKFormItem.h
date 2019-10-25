//
//  LKFormItem.h
//  LKTable
//
//  Created by dosn-001 on 2019/10/25.
//  Copyright © 2019 tinker. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LKFormItem;

typedef void(^LKSelectRowBlock)(__kindof LKFormItem *item);

@interface LKFormItem : NSObject

@property(nonatomic, assign) CGFloat cellHeight;

@property(nonatomic, copy) LKSelectRowBlock selectRowBlock;

@property(nonatomic, weak) UIGestureRecognizer *gesture;

@property(nonatomic, strong) Class vcClass;

- (NSString *)cellIdentifier;

@end

