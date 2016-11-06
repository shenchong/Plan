//
//  MBProgressHUD+SC.h
//  Planist
//
//  Created by easemob on 16/10/14.
//  Copyright © 2016年 沈冲. All rights reserved.
//

#import <MBProgressHUD/MBProgressHUD.h>

@interface MBProgressHUD (SC)
+ (void)showTextHUDAddedTo:(UIView *)view withText:(NSString *)text detailText:(NSString *)detailText andHideAfterDelay:(NSTimeInterval)delay;
@end
