//
//  TeamInfoViewModel.h
//  TookTODO
//
//  Created by Nikolay Chaban on 9/3/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

// Frameworks
@import UIKit;

@interface TeamInfoViewModel : NSObject <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>

// properties


// methods

- (void) updateInfoWithCompletion: (CompletionWithSuccess) completion;


@end
