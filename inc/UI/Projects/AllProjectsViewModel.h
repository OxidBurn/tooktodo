//
//  AllProjectsViewModel.h
//  TookTODO
//
//  Created by Nikolay Chaban on 8/22/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AllProjectsViewModel : NSObject <UITableViewDataSource, UITableViewDelegate>

// properties

@property (copy, nonatomic) void(^didSelectedProject)(NSNumber* projectID);

// methods

- (void) updateProjectsContent;

@end
