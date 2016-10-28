//
//  AboutProjectTableViewCell.m
//  TookTODO
//
//  Created by Chaban Nikolay on 10/28/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "AboutProjectTableViewCell.h"

@interface AboutProjectTableViewCell()

// properties
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIView *selectedStateView;


// methods


@end

@implementation AboutProjectTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
