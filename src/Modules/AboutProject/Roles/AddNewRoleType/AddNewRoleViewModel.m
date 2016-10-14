//
//  AddNewRoleViewModel.m
//  TookTODO
//
//  Created by Nikolay Chaban on 10/13/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "AddNewRoleViewModel.h"

// Classes
#import "AddNewRoleModel.h"

@interface AddNewRoleViewModel()

// properties

@property (nonatomic, strong) RACSignal* enableCreationSignal;

@property (strong, nonatomic) AddNewRoleModel* model;

// methods


@end

@implementation AddNewRoleViewModel


#pragma mark - Initialization -

- (instancetype) init
{
    if ( self = [super init] )
    {
        [self initialize];
    }
    
    return self;
}

- (void) initialize
{
    self.enableCreationSignal = [RACObserve(self, roleTitle) map: ^id(NSString* titleValue) {
        
        return @(titleValue.length > 0);
    }];
}


#pragma mark - Properties -

- (AddNewRoleModel*) model
{
    if ( _model == nil )
    {
        _model = [AddNewRoleModel new];
    }
    
    return _model;
}


#pragma mark - Public methods -

- (RACCommand*) createNewRoleCommand
{
    RACCommand* createCommand = [[RACCommand alloc] initWithEnabled: self.enableCreationSignal
                                                        signalBlock: ^RACSignal *(id input) {
                                                            
                                                            return [self.model createRoleWithTitle: self.roleTitle];
                                                            
                                                        }];
    
    return createCommand;
}

#pragma mark - Text field delegate methods -

- (BOOL) textFieldShouldClear: (UITextField*) textField
{
    self.roleTitle = @"";
    
    return YES;
}

@end
