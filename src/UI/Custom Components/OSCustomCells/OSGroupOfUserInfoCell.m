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
#import "ProjectTaskAssignee+CoreDataProperties.h"

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
    
    [self fillImagesWithUsers: usersArray];
}

- (void) fillCellWithAssignees: (NSArray*)  assigneesArray
                     withTitle: (NSString*) title
{
    self.groupTitleLabel.text = title;
    
    [self fillImagesWithAssignees: assigneesArray];
}

#pragma mark - Helpers -

- (void) fillImagesWithUsers: (NSArray*) approvals
{
    [self resetCellToDefault];
    
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
        
        self.firstAvatarTrailingConstraint.constant = 47;
        
        self.numberOfUsersLeftLabel.hidden = NO;
        
        self.numberOfUsersLeftLabel.text = [NSString stringWithFormat: @"+%ld", (unsigned long)approvalsLeft];
        
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

- (void) fillImagesWithAssignees: (NSArray*) assignees
{
    [self resetCellToDefault];
    
    if ( assignees.count <= 5 )
    {
        [assignees enumerateObjectsUsingBlock: ^(ProjectTaskAssignee* assignee, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if ( assignee )
            {
                UIImageView* imageView = self.imageViewsArray[idx];
                
                imageView.hidden = NO;
                
                [imageView sd_setImageWithURL: [NSURL URLWithString: assignee.avatarSrc]];
            }
            
        }];
    } else
    {
        NSUInteger assigneesLeft = assignees.count - 5;
        
        self.firstAvatarTrailingConstraint.constant = 47;
        
        self.numberOfUsersLeftLabel.hidden = NO;
        
        self.numberOfUsersLeftLabel.text = [NSString stringWithFormat: @"+%ld", (unsigned long) assigneesLeft];
        
        [assignees enumerateObjectsUsingBlock: ^(ProjectTaskAssignee* assignee, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if ( idx < 5 )
            {
                UIImageView* imageView = self.imageViewsArray[idx];
                
                imageView.hidden = NO;
                
                [imageView sd_setImageWithURL: [NSURL URLWithString: assignee.avatarSrc]];
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

- (void) resetCellToDefault
{
    [self roundAllImageViews];
    
    [self.imageViewsArray enumerateObjectsUsingBlock:^(UIImageView* obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        obj.hidden = YES;
        
    }];
    
    self.firstAvatarTrailingConstraint.constant = 3;

    self.numberOfUsersLeftLabel.hidden = YES;
}

@end
