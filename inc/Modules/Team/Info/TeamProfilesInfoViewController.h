//
//  TeamProfilesInfoViewController.h
//  TookTODO
//
//  Created by Chaban Nikolay on 8/31/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <UIKit/UIKit.h>

//Classes
#import "BaseMainViewController.h"
#import "FilledTeamInfo.h"

@interface TeamProfilesInfoViewController : BaseMainViewController

//Methods

- (void) fillSelectedTeamMember: (FilledTeamInfo*) teamMember;

- (void) refreshTableView;

- (void) reloadUserInformationViewData;

@end

