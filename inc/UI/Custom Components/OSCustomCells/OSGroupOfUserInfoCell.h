//
//  GroupOfUserInfoCell.h
//  TookTODO
//
//  Created by Chaban Nikolay on 9/15/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OSGroupOfUserInfoCell : UITableViewCell

// metthods

- (void) fillCellWithTitle: (NSString*) titleText
                 withUsers: (NSArray*)  usersArray;

- (void) fillCellWithAssignees: (NSArray*)  assigneesArray
                     withTitle: (NSString*) title;

@end
