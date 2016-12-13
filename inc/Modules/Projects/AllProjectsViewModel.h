//
//  AllProjectsViewModel.h
//  TookTODO
//
//  Created by Nikolay Chaban on 8/22/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

// Classes
#import "ProjectsEnumerations.h"
#import "PopoverModel.h"

@interface AllProjectsViewModel : NSObject <UITableViewDataSource, UITableViewDelegate, PopoverModelDelegate, PopoverModelDataSource, UISearchBarDelegate>

// properties

@property (copy, nonatomic) void(^didSelectedProject)(NSNumber* projectID);

@property (nonatomic, copy) void(^didShowProjectSettings)(NSNumber* projectID);

@property (nonatomic, copy) void(^reloadTable)();

@property (copy, nonatomic) void(^endSearching)();

@property (nonatomic, copy) void(^dismissController)();

// methods

- (void) updateProjectsContent;

@end
