//
//  AttachmentView.m
//  TookTODO
//
//  Created by Nikolay Chaban on 08.11.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "AttachmentView.h"

@interface AttachmentView()

// properties
@property (weak, nonatomic) IBOutlet UILabel* attachmentNameLabel;

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
}


#pragma mark - Internal -

- (void) countFrame
{
    
}

@end
