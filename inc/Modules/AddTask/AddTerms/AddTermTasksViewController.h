//
//  AddTermTasksViewController.h
//  TookTODO
//
//  Created by Chaban Nikolay on 9/16/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <UIKit/UIKit.h>

// Classes
#import "TermsData.h"

@protocol AddTaskTermsControllerDelegate;

@interface AddTermTasksViewController : UIViewController

// properties
@property (weak, nonatomic) id <AddTaskTermsControllerDelegate> delegate;

// methods
- (void) updateTerms: (TermsData*) terms
        withDelegate: (id)         delegate;

@end

@protocol AddTaskTermsControllerDelegate <NSObject>

- (void) updateTerms: (TermsData*) terms;

@end
