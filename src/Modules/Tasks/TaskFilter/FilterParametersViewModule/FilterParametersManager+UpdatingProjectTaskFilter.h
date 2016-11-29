//
//  FilterParametersManager+UpdatingProjectTaskFilter.h
//  TookTODO
//
//  Created by Nikolay Chaban on 11/29/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "FilterParametersManager.h"

// Classes
#import "FilterTagParameterInfo.h"

@interface FilterParametersManager (UpdatingProjectTaskFilter)

- (void) deleteFilterParameterWithInfo: (FilterTagParameterInfo*) info
                        withCompletion: (CompletionWithSuccess)   completion;

- (void) deleteAllProjectsFilterParameterWithInfo: (FilterTagParameterInfo*) info
                                   withCompletion: (CompletionWithSuccess)   completion;

@end
