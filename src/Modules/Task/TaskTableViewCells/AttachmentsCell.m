//
//  AttachmentsCell.m
//  TookTODO
//
//  Created by Глеб on 11.10.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "AttachmentsCell.h"

@interface AttachmentsCell()

// outlets
@property (weak, nonatomic) IBOutlet UIImageView* attachmentImageView;
@property (weak, nonatomic) IBOutlet UILabel*     attachmentNameLabel;
@property (weak, nonatomic) IBOutlet UILabel*     attachmentDetailLabel;

// properties


// methods


@end

@implementation AttachmentsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
