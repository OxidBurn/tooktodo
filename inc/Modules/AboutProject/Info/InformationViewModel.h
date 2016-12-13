//
//  InformationViewModel.h
//  TookTODO
//
//  Created by Nikolay Chaban on 02.09.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InformationViewModel : NSObject <UITableViewDataSource, UITableViewDelegate>

// methods
- (void) updateProjectInfoWithCompletion: (CompletionWithSuccess) completion;

@end
