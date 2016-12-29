//
//  RoomLevelSectionView.m
//  TookTODO
//
//  Created by Nikolay Chaban on 04.10.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "RoomLevelSectionView.h"


@interface RoomLevelSectionView()

//outlets
@property (weak, nonatomic) IBOutlet UIImageView* expandImgView;

@property (weak, nonatomic) IBOutlet UILabel* levelTitleLabel;

@property (weak, nonatomic) IBOutlet UIImageView* chekmarkImgView;

@property (weak, nonatomic) IBOutlet UIButton *selctBtn;

// properties

// actions
- (IBAction) expandBtn: (UIButton*) sender;

- (IBAction) selectBtn: (UIButton*) sender;

@end

@implementation RoomLevelSectionView


#pragma mark - Public -

- (void) fillInfo: (ProjectTaskRoomLevel*) level
{
    self.levelTitleLabel.text = [NSString stringWithFormat: @"Уровень %@", level.level];
    
    [self updateExpandedState: level.isExpanded.boolValue];
    
    [self updateSelectedState: level.isSelected.boolValue];
}


#pragma mark - Actions -

- (IBAction) expandBtn: (UIButton*) sender
{

    if ( self.didChangeExpandState )
        self.didChangeExpandState(self.tag);
}

- (IBAction) selectBtn: (UIButton*) sender
{
    if (self.didChangeSelectedState)
        self.didChangeSelectedState(self.tag);
}

- (void) updateExpandedState: (BOOL) isExpanded
{
    UIImage* expandedStateImage = nil;
    
    if ( isExpanded )
    {
        expandedStateImage   = [UIImage imageNamed: @"ArrowHorizontaly"];
        self.backgroundColor = [UIColor colorWithRed:0.902 green:0.9098 blue:0.9176 alpha:1.0];
    }
    else
    {
        expandedStateImage   = [UIImage imageNamed: @"ArrowVertical"];
        self.backgroundColor = [UIColor whiteColor];
    }
    
    self.expandImgView.image = expandedStateImage;
}

- (void) updateSelectedState: (BOOL) isSelected
{
    if (isSelected)
    {
        self.chekmarkImgView.hidden = NO;
        [self.selctBtn setTitle: @""
                       forState: UIControlStateNormal];
    }
    else
    {
        self.chekmarkImgView.hidden = YES;
        [self.selctBtn setTitle: @"Выбрать"
                       forState: UIControlStateNormal];
    }
}

#pragma mark - Refactor -

- (void) fillHeaderViewWithContent: (LevelContent*) levelContent
{
    NSString* levelNumber = levelContent.levelNumber ? levelContent.levelNumber.stringValue : @"";
    
    self.levelTitleLabel.text = [NSString stringWithFormat: @"Уровень %@", levelNumber];
    
    [self updateExpandedState: levelContent.isExpanded];
    
    [self updateSelectedState: levelContent.isSelected];
}


@end
