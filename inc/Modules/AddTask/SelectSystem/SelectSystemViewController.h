//
//  SelectSystemViewController.h
//  TookTODO
//
// Created by Nikolay Chaban on 30.09.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <UIKit/UIKit.h>

//Classes
#import "ProjectSystem+CoreDataClass.h"

@protocol SelectSystemViewControllerDelegate;

@interface SelectSystemViewController : UIViewController

// properties
@property (weak, nonatomic) id <SelectSystemViewControllerDelegate> delegate;

//methods
- (void) fillSelectedSystem: (ProjectSystem*)                          system
               withDelegate: (id <SelectSystemViewControllerDelegate>) delegate;

@end

@protocol SelectSystemViewControllerDelegate <NSObject>

- (void) returnSelectedSystem: (ProjectSystem*) system;

@end
