//
//  AddNewRoleViewModel.h
//  TookTODO
//
//  Created by Nikolay Chaban on 10/13/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

// Frameworks
#import "ReactiveCocoa.h"
@import UIKit;

@interface AddNewRoleViewModel : NSObject <UITextFieldDelegate>

// properties

@property (strong, nonatomic) NSString* roleTitle;

// methods

- (RACCommand*) createNewRoleCommand;

@end
