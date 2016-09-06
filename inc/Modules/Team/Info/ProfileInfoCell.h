//
//  ProfileInfoCell.h
//  TookTODO
//
//  Created by Lera on 05.09.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <UIKit/UIKit.h>

//Classes
#import "TeamMember.h"

@protocol TeamMemberCellDelegate;

@interface ProfileInfoCell : UITableViewCell

@property (nonatomic, weak) id <TeamMemberCellDelegate> delegate;

@property (weak, nonatomic) IBOutlet UILabel *contactsLabel;

@property (weak, nonatomic) IBOutlet UIButton *contactsBtn;

//methods

- (void) fillCellWithInfo: (NSString*)      contactValue
             withBtnImage: (UIImage*)       btnImage
             forIndexPath: (NSIndexPath*)   indexPath;

@end

@protocol TeamMemberCellDelegate <NSObject>


@end