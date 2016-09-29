//
//  AddTermTasksViewController.h
//  TookTODO
//
//  Created by Chaban Nikolay on 9/16/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AddTaskTermsControllerDelegate;

@interface AddTermTasksViewController : UIViewController

// properties
@property (weak, nonatomic) id <AddTaskTermsControllerDelegate> delegate;

// methods
- (void) updateStartDate: (NSDate*) startDate
          withFinishDate: (NSDate*) finishDate
            withDelegate: (id)      delegate;

@end

@protocol AddTaskTermsControllerDelegate <NSObject>

- (void) updateTermsWithStartDate: (NSDate*)    startDate
                    andFinishDate: (NSDate*)    finishDate
                     withDuration: (NSUInteger) duration;

@end
