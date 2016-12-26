//
//  AttachmentView.m
//  TookTODO
//
//  Created by Nikolay Chaban on 08.11.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "AttachmentView.h"

// Classes
#import "Utils.h"

@interface AttachmentView()

// outlets
@property (weak, nonatomic) IBOutlet UILabel* attachmentNameLabel;

// properties
@property (strong, nonatomic) NSString* attachmentName;

@end

@implementation AttachmentView


#pragma mark - Public -

- (void) fillViewWithAttachmentName: (NSString*)               attachmentName
                           withFont: (UIFont*)                 font
                           withType: (AttachmentViewTitleType) type
{
    switch ( type )
    {
        case AttachmentTitleDefault:
        {
            self.attachmentNameLabel.text = attachmentName;
        }
            break;
            
        case AttachmentTitleStrikeout:
        {
            NSAttributedString* attrString = [[NSAttributedString alloc] initWithString: attachmentName];
            
            self.attachmentNameLabel.attributedText = [Utils getStrikeoutStringForString: attrString];
            
            self.attachmentNameLabel.textColor = [UIColor colorWithRed: 91.0/256.0
                                                                 green: 100.0/256.0
                                                                  blue: 113.0/256.0
                                                                 alpha: 1.f];
        }
            break;
            
        default:
            break;
    }
    

    self.attachmentName = attachmentName;
    
    [self countFrameForFont: font];
}


#pragma mark - Internal -

- (void) countFrameForFont: (UIFont*) font
{
    CGSize labelSize = [self.attachmentName sizeWithAttributes: @{NSFontAttributeName: font}];
    
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
