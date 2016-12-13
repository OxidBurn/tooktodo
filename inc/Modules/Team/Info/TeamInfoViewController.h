//
//  TeamInfoViewController.h
//  TookTODO
//
//  Created by Chaban Nikolay on 8/24/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

// Classes
#import "BaseMainViewController.h"
#import "InviteInfo.h"
#import "TeamProfilesInfoViewController.h"

@interface TeamInfoViewController : BaseMainViewController

// Properties
@property (nonatomic, strong) TeamProfilesInfoViewController* profilesVC;

// methods
- (void) fillInviteInfo: (InviteInfo*) userInf;

@end
