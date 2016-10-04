//
//  RoomLevelSectionView.m
//  TookTODO
//
//  Created by Lera on 04.10.16.
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

//@property (nonatomic, strong) NSArray* levelsArray;

// actions
- (IBAction) expandBtn: (UIButton*) sender;

- (IBAction) selectBtn: (UIButton*) sender;

@end

@implementation RoomLevelSectionView


#pragma mark - Public -

- (void) fillInfo: (ProjectTaskStage*) level
{
    self.levelTitleLabel.text = level.title;
   // self.expandImgView.image  =
    
    [self updateExpandedState: level.isExpanded.boolValue];
    
}


#pragma mark - Actions -

- (IBAction) expandBtn: (UIButton*) sender
{
    if ( self.didChangeExpandState )
        self.didChangeExpandState(self.tag);
}

- (IBAction) selectBtn: (UIButton*) sender
{
    
}

- (void) updateExpandedState: (BOOL) isExpanded
{
    UIImage* expandedStateImage = nil;
    
    if ( isExpanded )
    {
        expandedStateImage = [UIImage imageNamed: @"ArrowHorizontaly"];
    }
    else
    {
        expandedStateImage = [UIImage imageNamed: @"ArrowVertical"];
    }
    
    self.expandImgView.image = expandedStateImage;
}


//- (void) handleSelectedStageForLevel: (ProjectTaskStage*) stage
//{
//   
//}
@end
