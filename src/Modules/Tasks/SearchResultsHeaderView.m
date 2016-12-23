//
//  SearchBarHeaderView.m
//  TookTODO
//
//  Created by Nikolay Chaban on 22.12.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "SearchResultsHeaderView.h"

@implementation SearchResultsHeaderView

- (void) fillCountOfTasks: (NSString*) countOfTasksText
{
    self.countOfTasksLabel.text = countOfTasksText;
}

@end
