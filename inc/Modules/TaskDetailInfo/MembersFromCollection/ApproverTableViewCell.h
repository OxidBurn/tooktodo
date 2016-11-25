//
//  ApproverTableViewCell.h
//  TookTODO
//
//  Created by Lera on 25.11.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <UIKit/UIKit.h>

//CLasses
#import "ProjectRoleAssignments+CoreDataClass.h"

@interface ApproverTableViewCell : UITableViewCell

- (void) fillCellWithApproverUser: (ProjectRoleAssignments*) approver;

@end
