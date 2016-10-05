//
//  OSCellWithCheckmark.h
//  TookTODO
//
// Created by Nikolay Chaban on 30.09.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ProjectTaskStage+CoreDataClass.h"

@interface OSCellWithCheckmark : UITableViewCell

- (void) fillCellWithContent: (NSString*) title
           withSelectedState: (BOOL)      isHide;

- (void) changeCheckmarkState: (BOOL) state;

- (BOOL) currentCheckMarkState;

@end
