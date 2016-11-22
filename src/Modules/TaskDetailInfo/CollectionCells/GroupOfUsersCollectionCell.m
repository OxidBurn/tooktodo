//
//  GroupOfUsersCollectionCell.m
//  TookTODO
//
//  Created by Chaban Nikolay on 05.10.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "GroupOfUsersCollectionCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

//Classes
#import "FilledTeamInfo.h"

@interface GroupOfUsersCollectionCell()

// outlets
@property (weak, nonatomic) IBOutlet UILabel* groupNameLabel;

@property (weak, nonatomic) IBOutlet UIImageView* disclosureIndicatorImageView;
@property (weak, nonatomic) IBOutlet UIImageView* firstAvatarImageView;
@property (weak, nonatomic) IBOutlet UIImageView* secondAvatarImageView;
@property (weak, nonatomic) IBOutlet UIImageView* thirdAvatarImageView;
@property (weak, nonatomic) IBOutlet UIImageView* fourthAvatarImageView;
@property (weak, nonatomic) IBOutlet UIImageView* fifthAvatarImageView;

@property (weak, nonatomic) IBOutlet UILabel* numberOfUsersLeftLabel;

// properties
@property (strong, nonatomic) NSArray* arrayWithImages;

// methods

@end

@implementation GroupOfUsersCollectionCell

#pragma mark - Properties -


#pragma mark - Public -

- (void) fillCellWithContent: (TaskCollectionCellsContent*) content
{
    self.groupNameLabel.text = content.cellTitle;
    
    if (content.observers)
    {
        [content.observers enumerateObjectsUsingBlock:^(FilledTeamInfo*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            [self.firstAvatarImageView  sd_setImageWithURL: [NSURL URLWithString: obj.avatarSrc]];
            [self.secondAvatarImageView sd_setImageWithURL: [NSURL URLWithString: obj.avatarSrc]];
            [self.thirdAvatarImageView  sd_setImageWithURL: [NSURL URLWithString: obj.avatarSrc]];
            [self.fourthAvatarImageView sd_setImageWithURL: [NSURL URLWithString: obj.avatarSrc]];
            [self.fifthAvatarImageView  sd_setImageWithURL: [NSURL URLWithString: obj.avatarSrc]];
        }];
    }
    
    else if (content.claiming)
    {
        [content.claiming enumerateObjectsUsingBlock:^(FilledTeamInfo*   _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
           
            [self.firstAvatarImageView  sd_setImageWithURL: [NSURL URLWithString: obj.avatarSrc]];
            [self.secondAvatarImageView sd_setImageWithURL: [NSURL URLWithString: obj.avatarSrc]];
            [self.thirdAvatarImageView  sd_setImageWithURL: [NSURL URLWithString: obj.avatarSrc]];
            [self.fourthAvatarImageView sd_setImageWithURL: [NSURL URLWithString: obj.avatarSrc]];
            [self.fifthAvatarImageView  sd_setImageWithURL: [NSURL URLWithString: obj.avatarSrc]];
        }];
    }
    
}
@end
