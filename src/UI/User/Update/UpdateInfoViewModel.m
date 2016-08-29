//
//  UpdateInfoViewModel.m
//  TookTODO
//
//  Created by Chaban Nikolay on 8/18/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "UpdateInfoViewModel.h"
#import "UpdateUserInfoModel.h"
#import "UpdatedUserInfo.h"

@interface UpdateInfoViewModel()

// properties

@property (strong, nonatomic) UpdateUserInfoModel* model;

// methods


@end

@implementation UpdateInfoViewModel

- (instancetype) init
{
    self = [super init];
    
    if (self)
    {
        [self setupDefaults];
    }
    
    return self;
}


#pragma mark - Defaults -

- (void) setupDefaults
{
    self.userName                  = [self.model getUserName];
    self.userSurname               = [self.model getSurName];
    self.userPhoneNumber           = [self.model getUserPhoneNumber];
    self.userAdditionalPhoneNumber = [self.model getUserAdditionalPhoneNumber];
}


#pragma mark - Properties -

- (UpdateUserInfoModel *)model
{
    if ( _model == nil )
    {
        _model = [UpdateUserInfoModel new];
    }
    
    return _model;
}

#pragma mark - Public methods -

- (NSString*) getPhoneNumberFormatString
{
    return @"+*(***)***-**-**";
}

- (AKNumericFormatter*) getPhoneNumberFormat
{
    return [AKNumericFormatter formatterWithMask: [self getPhoneNumberFormatString]
                            placeholderCharacter: '*'];
}

- (RACCommand*) saveDataCommand
{
    @weakify(self)
    
    if ( _saveDataCommand == nil )
    {
        _saveDataCommand = [[RACCommand alloc] initWithSignalBlock: ^RACSignal *(id input) {
            
            @strongify(self)
            
            return [RACSignal createSignal: ^RACDisposable *(id<RACSubscriber> subscriber) {
                
                [self.model updateUserValues: [self getFilledObject]];
                
                [subscriber sendNext: nil];
                [subscriber sendCompleted];
                
                return nil;
            }];
            
        }];
    }
    
    return _saveDataCommand;
}

- (UpdatedUserInfo*) getFilledObject
{
    UpdatedUserInfo* info = [[UpdatedUserInfo alloc] init];
    
    info.name                  = self.userName;
    info.surname               = self.userSurname;
    info.phoneNumber           = self.userPhoneNumber;
    info.additionalPhoneNumber = self.userAdditionalPhoneNumber;
    
    return info;
}

@end
