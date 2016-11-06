//
//  MBProgressHUD+SC.m
//  Planist
//
//  Created by easemob on 16/10/14.
//  Copyright © 2016年 沈冲. All rights reserved.
//

#import "MBProgressHUD+SC.h"

@implementation MBProgressHUD (SC)
+ (void)showTextHUDAddedTo:(UIView *)view withText:(NSString *)text detailText:(NSString *)detailText andHideAfterDelay:(NSTimeInterval)delay{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.label.text = text;
    hud.detailsLabel.text = detailText;
    hud.bezelView.color = RGBColor(38, 16, 17, 1);
    hud.contentColor = [UIColor whiteColor];
    hud.mode = MBProgressHUDModeText;
//    hud.offset = CGPointMake(0, -120);
    [hud hideAnimated:YES afterDelay:delay];
}
@end
