//
//  OSCellWithCheckmark.m
//  TookTODO
//
// Created by Nikolay Chaban on 30.09.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "OSCellWithCheckmark.h"

//Classes
#import "ProjectSystem+CoreDataClass.h"

@interface OSCellWithCheckmark ()

@property (weak, nonatomic) IBOutlet UIImageView *checkmarkImg;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end

@implementation OSCellWithCheckmark

- (void) fillCellWithContent: (NSString*) title
           withSelectedState: (BOOL)      isSelected
{
    self.nameLabel.text = title;
    
    self.checkmarkImg.hidden = isSelected ? NO : YES;
}

- (void) changeCheckmarkState: (BOOL) state
{
    self.checkmarkImg.hidden = !state;
}

- (BOOL) currentCheckMarkState
{
    return self.checkmarkImg.hidden;
}

@end
