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

@property (weak, nonatomic) IBOutlet UIImageView *firstCheckMark;
@property (weak, nonatomic) IBOutlet UIImageView *secondCheckMark;
@property (weak, nonatomic) IBOutlet UIImageView *thirdCheckMark;
@property (weak, nonatomic) IBOutlet UIImageView *fourthCheckMark;
@property (weak, nonatomic) IBOutlet UIImageView *fifthCheckMark;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *firstAvatarLeadingConstraint;

// properties
@property (strong, nonatomic) NSArray* arrayWithImages;
@property (nonatomic, strong) NSArray* checkMarksArray;

// methods

@end

@implementation GroupOfUsersCollectionCell


#pragma mark - Properties -

- (NSArray*) arrayWithImages
{
    if (_arrayWithImages == nil)
    {
        _arrayWithImages = @[ self.firstAvatarImageView,
                              self.secondAvatarImageView,
                              self.thirdAvatarImageView,
                              self.fourthAvatarImageView,
                              self.fifthAvatarImageView ];
    }
    
    return _arrayWithImages;
}

- (NSArray*) checkMarksArray
{
    if (_checkMarksArray == nil)
    {
        _checkMarksArray = @[self.firstCheckMark,
                             self.secondCheckMark,
                             self.thirdCheckMark,
                             self.fourthCheckMark,
                             self.fifthCheckMark];
    }
    
    return _checkMarksArray;
}

#pragma mark - Public -

- (void) fillCellWithContent: (TaskCollectionCellsContent*) content
{
    self.groupNameLabel.text = content.cellTitle;
    
    if (content.observers)
    {
        [self fillImagesWithUsers: content.observers];
    }
    
    else if (content.claiming)
    {
        [self fillImagesWithUsers: content.claiming];
        [self handleApprovedMarkForContent: content];
        
    }

}


#pragma mark - Helpers -

- (void) fillImagesWithUsers: (NSArray*) approvals
{
    [self resetCellToDefault];
    
    if ( approvals.count <= 5 )
    {
        [approvals enumerateObjectsUsingBlock: ^(FilledTeamInfo* user, NSUInteger idx, BOOL * _Nonnull stop) {
            
            UIImageView* imageView = self.arrayWithImages[idx];
                
            imageView.hidden = NO;
            
            if ( [user respondsToSelector: @selector(avatarSrc)] )
            {
                [imageView sd_setImageWithURL: [NSURL URLWithString: user.avatarSrc]];
            }
            else
            {
                imageView.image = [UIImage imageNamed: @"emptyAvatarIcon"];
            }
            
        }];
    }
    
    else
    {
        NSUInteger approvalsLeft = approvals.count - 5;
        
        self.numberOfUsersLeftLabel.hidden = NO;
        
        self.numberOfUsersLeftLabel.text = [NSString stringWithFormat: @"+%ld", (unsigned long)approvalsLeft];
        
        [approvals enumerateObjectsUsingBlock: ^(FilledTeamInfo* user, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if ( idx < 5 )
            {
               
                UIImageView* imageView = self.arrayWithImages[idx];
                
                imageView.hidden = NO;
                
                if ( [user respondsToSelector: @selector(avatarSrc)] )
                {
                    [imageView sd_setImageWithURL: [NSURL URLWithString: user.avatarSrc]];
                }
                
                else
                {
                    imageView.image = [UIImage imageNamed: @"emptyAvatarIcon"];
                }
            }
            
        }];
    }
    
}

- (void) handleApprovedMarkForContent: (TaskCollectionCellsContent*) content
{
    if (content.claiming.count <= 5)
    {
        [content.claiming enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            UIImageView* imageView = self.checkMarksArray[idx];
            imageView.hidden = NO;
            
            if (content.hasApprovedTask == YES)
            {
                imageView.image = [UIImage imageNamed: @"GreenChack"];
            }
            
            else if (content.hasApprovedTask == NO)
            {
                imageView.image = [UIImage imageNamed: @"PencilChack"];
            }
        }];
        
    }
    
    else
    {
        [content.claiming enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if ( idx < 5 )
            
            {
                UIImageView* imageView = self.checkMarksArray[idx];
                imageView.hidden = NO;
            
                if (content.hasApprovedTask == YES)
                {
                    imageView.image = [UIImage imageNamed: @"GreenChack"];
                }
            
                else if (content.hasApprovedTask == NO)
                {
                    imageView.image = [UIImage imageNamed: @"PencilChack"];
                }
            }
        }];
    }
    

}


- (void) roundAllImageViews
{
    [self.arrayWithImages enumerateObjectsUsingBlock:^(UIImageView* imageView, NSUInteger idx, BOOL * _Nonnull stop) {
        
        imageView.layer.cornerRadius = 10;
        imageView.clipsToBounds      = YES;
    }];
}

- (void) resetCellToDefault
{
    [self roundAllImageViews];
    
    [self.arrayWithImages enumerateObjectsUsingBlock:^(UIImageView* obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        obj.hidden = YES;
        
    }];
    
    self.numberOfUsersLeftLabel.hidden = YES;
}

@end
