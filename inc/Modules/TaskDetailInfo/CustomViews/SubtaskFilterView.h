//
//  SubtaskFilterView.h
//  TookTODO
//
//  Created by Глеб on 10.10.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <UIKit/UIKit.h>

// Classes
#import "TaskRowContent.h"

@interface SubtaskFilterView : UIView

// methods
- (void) fillCellWithContent: (TaskRowContent*) content;

@end
