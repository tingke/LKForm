//
//  LKCustomFormItem.h
//  LKTable
//
//  Created by dosn-001 on 2019/10/25.
//  Copyright © 2019 tinker. All rights reserved.
//

#import "LKFormItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface LKCustomFormItem : LKFormItem

@property(nonatomic, copy) NSString *cellIdentifier;

@property(nonatomic, strong) id bindingValue;

@end

NS_ASSUME_NONNULL_END
