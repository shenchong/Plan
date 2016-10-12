//
//  MineViewCell.m
//  Planist
//
//  Created by easemob on 16/9/25.
//  Copyright © 2016年 沈冲. All rights reserved.
//

#import "MineViewCell.h"

@implementation MineViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _label = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth-40, 0, 40, self.height)];
        _label.textColor = [UIColor grayColor];
        _label.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:_label];
    }
    return self;
}

@end
