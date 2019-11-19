//
//  LKInputFormViewCell.h
//  LKTable
//
//  Created by dosn-001 on 2019/10/31.
//  Copyright © 2019 tinker. All rights reserved.
//

#import "LKFormTableViewCell.h"
#import "UITextView+LK.h"

NS_ASSUME_NONNULL_BEGIN

@interface LKInputFormViewCell : LKFormTableViewCell

@property(nonatomic, strong) UITextView *textView;

@property(nonatomic, strong) UITextField *textField;

@end

NS_ASSUME_NONNULL_END
