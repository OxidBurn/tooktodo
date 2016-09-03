//
//  DataManager+Systems.h
//  TookTODO
//
//  Created by Nikolay Chaban on 9/4/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "DataManager.h"

// Classes
#import "ProjectSystem.h"

@interface DataManager (Systems)

- (void) persistSystemsForProject: (NSArray*)              systems
                   withCompletion: (CompletionWithSuccess) completion;

- (NSArray*) getAllSystemsForCurrentProject;

@end
