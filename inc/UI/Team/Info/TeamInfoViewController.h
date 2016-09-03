//
//  TeamInfoViewController.h
//  TookTODO
//
//  Created by Chaban Nikolay on 8/24/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "BaseMainViewController.h"
#import "InviteInfo.h"
#import <MessageUI/MessageUI.h>

@interface TeamInfoViewController : BaseMainViewController <MFMailComposeViewControllerDelegate>

- (void) fillInviteInfo: (InviteInfo*) userInf;

@end
