//
//  ContactInfoCell.m
//  TookTODO
//
//  Created by Chaban Nikolay on 9/6/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "ContactInfoCell.h"

@interface ContactInfoCell ()

//Properties

@property (weak, nonatomic) IBOutlet UILabel *contactInfoLabel;
@property (weak, nonatomic) IBOutlet UIButton *contactActionBtn;


//Method
- (IBAction)onContactActionBtn:(UIButton *)sender;

@end

@implementation ContactInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)onContactActionBtn:(UIButton *)sender {
}
@end
