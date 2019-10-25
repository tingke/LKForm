//
//  LKFormItem.h
//  LKTable
//
//  Created by dosn-001 on 2019/10/25.
//  Copyright © 2019 tinker. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LKFormItem : NSObject

@property(nonatomic, copy) NSString *identifier;

@property(nonatomic, assign) CGFloat cellHeight;

@property(nonatomic, strong) id bindingValue;

@property(nonatomic, copy) void(^selectRowBlock)(LKFormItem *item);

@property(nonatomic, strong) Class vcClass;

@end

NS_ASSUME_NONNULL_END
