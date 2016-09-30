//
//  OSCellWithCheckmark.m
//  TookTODO
//
//  Created by Lera on 30.09.16.
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

- (void) fillCellWithContent: (id) object
{
    if ([object isKindOfClass: [ProjectTaskStage class]])
    {
        ProjectTaskStage* stage =(ProjectTaskStage*)object;
        
        self.nameLabel.text = stage.title;
        
        self.checkmarkImg.hidden = stage.isSelected ? NO : YES;
    }
    
    else if ([object isKindOfClass: [ProjectSystem class]])
    {
        ProjectSystem* system = (ProjectSystem*)object;
        
    
        
        self.nameLabel.text = system.title;
        
        
        self.checkmarkImg.hidden = system.isSelected ? NO : YES;
    }

    UIFont* customFont            = [UIFont fontWithName: @"SFUIText-Regular"
                                                    size: 15.0f];
    self.nameLabel.font = customFont;

}

- (void) changeCheckmarkState: (BOOL) state
{
    self.checkmarkImg.hidden = state ? NO : YES;
}

- (BOOL) currentCheckMarkState
{
    return self.checkmarkImg.hidden;
}

@end
