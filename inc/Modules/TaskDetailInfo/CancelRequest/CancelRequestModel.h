//
//  CancelReguestModel.h
//  TookTODO
//
//  Created by Nikolay Chaban on 17.10.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CancelRequestModel : NSObject

// methods
- (void) sendRequestLetter: (NSString*)             letterText
            withCompletion: (CompletionWithSuccess) completion;

@end