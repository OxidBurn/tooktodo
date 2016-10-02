//
//  OSDefaultAlertController.m
//  TookTODO
//
//  Created by Chaban Nikolay on 9/8/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "OSDefaultAlertController.h"

@interface OSDefaultAlertController ()

@property (weak, nonatomic) IBOutlet UILabel* titleLabel;

@property (weak, nonatomic) IBOutlet UILabel* messageLabel;

@property (weak, nonatomic) IBOutlet UIButton* btn;


- (IBAction) onButton: (UIButton *)sender;

@end

@implementation OSDefaultAlertController


- (void) loadView
{
    [super loadView];
    
}

#pragma mark - Public -

- (void) setTitle: (NSString*) title
      withMessage: (NSString*) message
      withBtnText: (NSString*) btnText
{
    self.titleLabel.text     = title;
    self.messageLabel.text   = message;
    self.btn.titleLabel.text = btnText;
}


- (IBAction) onButton: (UIButton*) sender
{
    if ([self.delegate respondsToSelector: @selector(didDismissAlertAction)])
    {
         [self.delegate didDismissAlertAction];
    }
   
}
@end
