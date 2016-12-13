//
//  AttachmentsCell.m
//  TookTODO
//
//  Created by Chaban Nikolay on 11.10.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "AttachmentsCell.h"

// Helpers
#import "NSDate+Helper.h"

@interface AttachmentsCell()

// outlets
@property (weak, nonatomic) IBOutlet UIImageView* attachmentImageView;
@property (weak, nonatomic) IBOutlet UILabel*     attachmentNameLabel;
@property (weak, nonatomic) IBOutlet UILabel*     attachmentDetailLabel;

// properties


// methods


@end

@implementation AttachmentsCell

#pragma mark - Public -

- (void) fillCellWithContent: (TaskRowContent*) content
{
    self.attachmentImageView.image = content.attachmentImage;
    
    self.attachmentNameLabel.text  = content.attachmentTitle;
    
    self.attachmentDetailLabel.text = [NSDate stringFromDate: [NSDate date]];
}

@end
