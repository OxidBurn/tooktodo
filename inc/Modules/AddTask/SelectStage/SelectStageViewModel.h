//
//  SelectStageViewModel.h
//  TookTODO
//
// Created by Nikolay Chaban on 30.09.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <Foundation/Foundation.h>

//Classes
#import "ProjectTaskStage+CoreDataClass.h"

@interface SelectStageViewModel : NSObject <UITableViewDelegate, UITableViewDataSource>

// methods

- (ProjectTaskStage*) getSelectedStage;

- (void) fillSelectedStage: (ProjectTaskStage*) stage;

@end
