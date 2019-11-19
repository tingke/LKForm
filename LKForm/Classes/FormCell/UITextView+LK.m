//
//  UITextView+LK.m
//  LKTable
//
//  Created by dosn-001 on 2019/10/31.
//  Copyright © 2019 tinker. All rights reserved.
//

#import "UITextView+LK.h"
#import <objc/runtime.h>

@interface UITextView ()

@property(nonatomic, strong) UILabel *placeholderLabel;

@end

@implementation UITextView (LK)

+(void)load{
    [super load];
    method_exchangeImplementations(class_getInstanceMethod(self.class, NSSelectorFromString(@"layoutSubviews")),
                                   class_getInstanceMethod(self.class, @selector(kj_PlaceHolder_swizzling_layoutSubviews)));
    method_exchangeImplementations(class_getInstanceMethod(self.class, NSSelectorFromString(@"dealloc")),
                                   class_getInstanceMethod(self.class, @selector(kj_PlaceHolder_swizzled_dealloc)));
    method_exchangeImplementations(class_getInstanceMethod(self.class, NSSelectorFromString(@"setText:")),
                                   class_getInstanceMethod(self.class, @selector(kj_PlaceHolder_swizzled_setText:)));
}
#pragma mark - swizzled
- (void)kj_PlaceHolder_swizzled_dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self kj_PlaceHolder_swizzled_dealloc];
}

- (void)kj_PlaceHolder_swizzling_layoutSubviews {
    if (self.placeholder){
        UIEdgeInsets textContainerInset = self.textContainerInset;
        CGFloat lineFragmentPadding = self.textContainer.lineFragmentPadding;
        CGFloat x = lineFragmentPadding + textContainerInset.left + self.layer.borderWidth;
        CGFloat y = textContainerInset.top + self.layer.borderWidth;
        CGFloat width = CGRectGetWidth(self.bounds)- x - textContainerInset.right - 2*self.layer.borderWidth;
        CGFloat height = [self.placeholderLabel sizeThatFits:CGSizeMake(width, 0)].height;
        self.placeholderLabel.frame = CGRectMake(x, y, width, height);
    }
    [self kj_PlaceHolder_swizzling_layoutSubviews];
}

- (void)kj_PlaceHolder_swizzled_setText:(NSString *)text{
    [self kj_PlaceHolder_swizzled_setText:text];
    if (self.placeholder){
        [self updatePlaceHolder];
    }
}

- (void)updatePlaceHolder {
    if (self.text.length){
        [self.placeholderLabel removeFromSuperview];
        return;
    }
    self.placeholderLabel.font = self.font;
    self.placeholderLabel.textAlignment = self.textAlignment;
    self.placeholderLabel.text = self.placeholder;
    [self insertSubview:self.placeholderLabel atIndex:0];
}

- (UILabel *)placeholder {
    return objc_getAssociatedObject(self, @selector(placeholder));
}

- (void)setPlaceholder:(NSString *)placeholder {
    objc_setAssociatedObject(self, @selector(placeholder), placeholder, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self updatePlaceHolder];
}

- (UIColor *)placeholderColor {
    return self.placeholderLabel.textColor;
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor {
    self.placeholderLabel.textColor = placeholderColor;
}

- (UILabel *)placeholderLabel {
    UILabel *placeHolderLab = objc_getAssociatedObject(self, @selector(placeholderLabel));
    if (!placeHolderLab){
        placeHolderLab = [[UILabel alloc] init];
        placeHolderLab.numberOfLines = 0;
        placeHolderLab.textColor = [UIColor lightGrayColor];
        objc_setAssociatedObject(self, @selector(placeholderLabel), placeHolderLab, OBJC_ASSOCIATION_RETAIN);
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updatePlaceHolder)name:UITextViewTextDidChangeNotification object:self];
    }
    return placeHolderLab;
}

@end
