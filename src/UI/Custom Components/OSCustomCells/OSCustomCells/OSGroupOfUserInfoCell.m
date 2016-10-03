//
//  GroupOfUserInfoCell.m
//  TookTODO
//
//  Created by Chaban Nikolay on 9/15/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "OSGroupOfUserInfoCell.h"

// Frameworks
#import <SDWebImage/UIImageView+WebCache.h>

// Classes
#import "FilledTeamInfo.h"

@interface OSGroupOfUserInfoCell()

// outlets
@property (weak, nonatomic) IBOutlet UIImageView*        firstAvatarImageView;
@property (weak, nonatomic) IBOutlet UIImageView*        secondAvatarImageView;
@property (weak, nonatomic) IBOutlet UIImageView*        thirdAvatarImageView;
@property (weak, nonatomic) IBOutlet UIImageView*        forthAvatarImageView;
@property (weak, nonatomic) IBOutlet UIImageView*        fifthAvatarImageView;
@property (weak, nonatomic) IBOutlet UILabel*            numberOfUsersLeftLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint* firstAvatarTrailingConstraint;
@property (weak, nonatomic) IBOutlet UILabel*            groupTitleLabel;

// properties
@property (strong, nonatomic) NSArray* imageViewsArray;

// methods


@end

@implementation OSGroupOfUserInfoCell

#pragma mark - Properties -

- (NSArray*) imageViewsArray
{
    if ( _imageViewsArray == nil )
    {
        _imageViewsArray = @[ self.firstAvatarImageView,
                              self.secondAvatarImageView,
                              self.thirdAvatarImageView,
                              self.forthAvatarImageView,
                              self.fifthAvatarImageView ];
    }
    
    return _imageViewsArray;
}

#pragma mark - Public -

- (void) fillCellWithTitle: (NSString*) titleText
                 withUsers: (NSArray*)  usersArray
{
    self.groupTitleLabel.text = titleText;
    
    [self roundAllImageViews];
    
    [self fillImagesWithUsers: usersArray];
}

#pragma mark - Helpers -

- (void) fillImagesWithUsers: (NSArray*) approvals
{
    [self.imageViewsArray enumerateObjectsUsingBlock:^(UIImageView* obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        obj.hidden = YES;
        
    }];
    
    if ( approvals.count <= 5 )
    {
        [approvals enumerateObjectsUsingBlock: ^(FilledTeamInfo* user, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if ( user )
            {
                UIImageView* imageView = self.imageViewsArray[idx];
                
                imageView.hidden = NO;
                
                [imageView sd_setImageWithURL: [NSURL URLWithString: user.avatarSrc]];
            }
            
        }];
    } else
    {
        NSUInteger approvalsLeft = approvals.count - 5;
        
        self.firstAvatarTrailingConstraint.constant = 57;
        
        self.numberOfUsersLeftLabel.hidden = NO;
        
        self.numberOfUsersLeftLabel.text = [NSString stringWithFormat: @"+%ld", approvalsLeft];
        
        [approvals enumerateObjectsUsingBlock: ^(FilledTeamInfo* user, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if ( idx < 5 )
            {
                UIImageView* imageView = self.imageViewsArray[idx];
                
                imageView.hidden = NO;
                
                [imageView sd_setImageWithURL: [NSURL URLWithString: user.avatarSrc]];
            }
            
        }];
    }
    
}

- (void) roundAllImageViews
{
    [self.imageViewsArray enumerateObjectsUsingBlock:^(UIImageView* imageView, NSUInteger idx, BOOL * _Nonnull stop) {
        
        imageView.layer.cornerRadius = 10;
        imageView.clipsToBounds      = YES;
    }];
}

@end
