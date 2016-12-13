//
//  InfoiPadViewModel.h
//  TookTODO
//
//  Created by Nikolay Chaban on 28.10.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InfoiPadViewModel : NSObject  <UITableViewDelegate, UITableViewDataSource>

// properties
@property (nonatomic, copy) void(^performSegueWithId)(NSString* segueId);

- (NSString*) getProjectName;

@end
