//
//  TeamInfoTableViewCell.h
//  TookTODO
//
//  Created by Глеб on 03.09.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TeamMember.h"

@protocol TeamInfoTableViewCellDelegate;

@interface TeamInfoTableViewCell : UITableViewCell

// properties

@property (weak, nonatomic) id <TeamInfoTableViewCellDelegate> delegate;

// methods

- (void) fillCellWithInfo: (TeamMember*) teamMember
             forIndexPath: (NSIndexPath*) indexPath;

@end

@protocol TeamInfoTableViewCellDelegate <NSObject>

//- (

@end