//
//  TeamInfoTableViewCell.h
//  TookTODO
//
//  Created by Nikolay Chaban on 9/3/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <UIKit/UIKit.h>

// Classes
#import "ProjectRoleAssignments+CoreDataClass.h"

@protocol TeamInfoTableViewCellDelegate;

@interface TeamInfoTableViewCell : UITableViewCell

// properties

@property (weak, nonatomic) id <TeamInfoTableViewCellDelegate> delegate;

// methods

- (void) fillCellWithInfo: (ProjectRoleAssignments*) teamMember
             forIndexPath: (NSIndexPath*)            indexPath;

@end

@protocol TeamInfoTableViewCellDelegate <NSObject>

- (void) didTriggerCallActionAtIndex: (NSUInteger) index;

- (void) didTriggerEmailActionIndex: (NSUInteger) index;

@end
