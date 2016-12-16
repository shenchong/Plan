//
//  SCTextView.h
//  Planist
//
//  Created by easemob on 2016/12/13.
//  Copyright © 2016年 沈冲. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SCTextView;
@protocol SCTextViewDelegate <NSObject>

@optional
- (void)SCTextViewDidChange:(SCTextView *)textView height:(CGFloat)height;

@end


@interface SCTextView : UIView
@property (nonatomic, assign) CGFloat maxHeight;

@property (nonatomic, assign) CGFloat mixHegith;

@property (nonatomic, copy) NSString *placeholder;

@property (nonatomic, copy) NSString *text;

@property (nonatomic, strong) UIFont *font;

@property (nonatomic, assign) NSTextAlignment textAlignment;

@property (nonatomic, strong) UIColor *backColor;

@property (nonatomic, strong) UITextView *textView;

@property (nonatomic, weak) id<SCTextViewDelegate> textDelegate;
@end
