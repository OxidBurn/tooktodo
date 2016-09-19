//
//  TasksProjectTitleView.h
//  TookTODO
//
//  Created by Nikolay Chaban on 9/13/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

// Classes
#import "ProjectInfo+CoreDataClass.h"

@interface TasksProjectTitleView : UIView

// properties

@property (nonatomic, copy) void(^didChangeExpandState)(NSUInteger section);

// methods

- (void) fillInfo: (ProjectInfo*) info;


@end
