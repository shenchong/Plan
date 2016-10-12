//
//  UIScrollView+Header.h
//  Planist
//
//  Created by easemob on 16/9/23.
//  Copyright © 2016年 沈冲. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (Header)

/**
 *  头部缩放视图图片
 */
@property (nonatomic, strong) UIImage *sc_headerScaleImage;

/**
 *  头部缩放视图图片高度
 */
@property (nonatomic, assign) CGFloat sc_headerScaleImageHeight;

@end
