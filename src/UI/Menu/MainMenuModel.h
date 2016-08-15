//
//  MainMenuModel.h
//  TookTODO
//
//  Created by Nikolay Chaban on 8/15/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveCocoa.h>

@interface MainMenuModel : NSObject

// properties


// methods


- (RACSignal*) sendReviewSignal;

- (NSString*) getFullUserName;

- (UIImage*) getUserAvatarImage;

@end
