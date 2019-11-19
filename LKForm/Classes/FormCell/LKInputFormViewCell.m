//
//  LKInputFormViewCell.m
//  LKTable
//
//  Created by dosn-001 on 2019/10/31.
//  Copyright © 2019 tinker. All rights reserved.
//

#import "LKInputFormViewCell.h"

@interface LKInputFormViewCell ()

@end

@implementation LKInputFormViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.textView];
        [self.contentView addSubview:self.textField];
//        [self setupContraints];
    }
    return self;
}

- (void)setupContraints {
    
    CGFloat width = [self.textLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, self.frame.size.height) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName:self.textLabel.font} context:nil].size.width;
    NSLog(@"%f", width);
    
    NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:self.textView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:12];
    NSLayoutConstraint *bottomConstraint = [NSLayoutConstraint constraintWithItem:self.textView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-12];
    NSLayoutConstraint *leftConstraint = [NSLayoutConstraint constraintWithItem:self.textView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.textLabel attribute:NSLayoutAttributeLeft multiplier:1.0 constant:(width + 15)];
    NSLayoutConstraint *rightConstraint = [NSLayoutConstraint constraintWithItem:self.textView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-15];
    [self.contentView addConstraints:@[topConstraint, bottomConstraint, leftConstraint, rightConstraint]];
    
    NSLayoutConstraint *tTopConstraint = [NSLayoutConstraint constraintWithItem:self.textField attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
    NSLayoutConstraint *tBottomConstraint = [NSLayoutConstraint constraintWithItem:self.textField attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
    NSLayoutConstraint *tLeftConstraint = [NSLayoutConstraint constraintWithItem:self.textField attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.textLabel attribute:NSLayoutAttributeLeft multiplier:1.0 constant:(width + 15)];
    NSLayoutConstraint *tRightConstraint = [NSLayoutConstraint constraintWithItem:self.textField attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-15];
    [self.contentView addConstraints:@[tTopConstraint, tBottomConstraint, tLeftConstraint, tRightConstraint]];
    
    self.textView.translatesAutoresizingMaskIntoConstraints = NO;
    self.textField.translatesAutoresizingMaskIntoConstraints = NO;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat width = [self.textLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, self.frame.size.height) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName:self.textLabel.font} context:nil].size.width;
    
    CGFloat x = width + 30;
    if (self.textLabel.alpha == 0) {
        x = 15;
    }
    
    self.textField.frame = CGRectMake(x, 0, self.frame.size.width - x - 15, self.frame.size.height);
    self.textView.frame = CGRectMake(x, 5, self.frame.size.width - x - 15, self.frame.size.height-10);
}

#pragma mark - ————— Getter && Setter —————

- (UITextView *)textView {
    if (!_textView) {
        _textView = [[UITextView alloc] init];
        _textView.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    }
    return _textView;
}

- (UITextField *)textField {
    if (!_textField) {
        _textField = [[UITextField alloc] init];
    }
    return _textField;
}

@end
