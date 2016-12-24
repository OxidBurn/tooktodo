//
//  AttachmentView.h
//  TookTODO
//
//  Created by Nikolay Chaban on 08.11.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, AttachmentViewTitleType)
{
    AttachmentTitleDefault   = 1,
    AttachmentTitleStrikeout = 2,
};

@interface AttachmentView : UIView

// methods
- (void) fillViewWithAttachmentName: (NSString*)               attachmentName
                           withFont: (UIFont*)                 font
                           withType: (AttachmentViewTitleType) type;

@end
