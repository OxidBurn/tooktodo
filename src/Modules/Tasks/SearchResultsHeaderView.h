//
//  SearchBarHeaderView.h
//  TookTODO
//
//  Created by Nikolay Chaban on 22.12.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchResultsHeaderView : UIView

@property (weak, nonatomic) IBOutlet UILabel *countOfTasksLabel;

- (void) fillCountOfTasks: (NSString*) countOfTasksText;

@end
