//
//  GroupOfUsersCollectionCell.m
//  TookTODO
//
//  Created by Chaban Nikolay on 05.10.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "GroupOfUsersCollectionCell.h"

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

@property (weak, nonatomic) IBOutlet UIImageView *firstCheckMark;
@property (weak, nonatomic) IBOutlet UIImageView *secondCheckMark;
@property (weak, nonatomic) IBOutlet UIImageView *thirdCheckMark;
@property (weak, nonatomic) IBOutlet UIImageView *fourthCheckMark;
@property (weak, nonatomic) IBOutlet UIImageView *fifthCheckMark;

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
}
@end
