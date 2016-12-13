//
//  AttachmentView.m
//  TookTODO
//
//  Created by Nikolay Chaban on 08.11.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "AttachmentView.h"

// Classes

@interface AttachmentView()

// outlets
@property (weak, nonatomic) IBOutlet UILabel* attachmentNameLabel;

// properties
@property (strong, nonatomic) NSString* attachmentName;

// methods
- (void) countFrame;

@end

@implementation AttachmentView


#pragma mark - Public -

- (void) fillViewWithAttachmentName: (NSString*) attachmentName
{
    self.attachmentNameLabel.text = attachmentName;
    self.attachmentName           = attachmentName;
    
    [self countFrame];
}


#pragma mark - Internal -

- (void) countFrame
{
    UIFont* labelFont = [UIFont fontWithName: @"Lato-Regular" size: 12];
    
    CGSize labelSize = [self.attachmentName sizeWithAttributes: @{NSFontAttributeName: labelFont}];
    
    labelSize.width +=2;
    
    CGRect labelFrame = self.attachmentNameLabel.frame;
    
    labelFrame.size = labelSize;
    
    self.attachmentNameLabel.frame = labelFrame;
    
    // 14pt is width of image view, and 5pt is horizonatal constraint constant value
    CGFloat viewWidth = labelFrame.size.width + 14 + 5;
    
    CGRect viewFrame = self.frame;
    
    viewFrame.size.width = viewWidth;
    
    self.frame = viewFrame;
}

@end
