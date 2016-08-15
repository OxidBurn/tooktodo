//
//  AvatarManager.m
//  TookTODO
//
//  Created by Nikolay Chaban on 8/15/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "AvatarHelper.h"

// Classes
#import "AvatarGenerator.h"
#import "Utils.h"

static dispatch_once_t onceToken;
static AvatarHelper* sharedInstance = nil;

@interface AvatarHelper()

// properties

@property (strong, nonatomic) NSArray* avatarsColors;

// methods

/**
 *  Setup defaults
 */
- (void) setupDefaults;

@end

@implementation AvatarHelper


#pragma mark - Shared -

+ (AvatarHelper*) sharedInstance
{
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}


#pragma mark - Initialization -

- (id) init
{
    if ( self = [super init] )
    {
        [self setupDefaults];
    }
    
    return self;
}


#pragma mark - Defautls -

- (void) setupDefaults
{
    // Check if avatars folder not exist, create it
    [Utils createAvatarDirectoryIfNotExist];
}


#pragma mark - Properties -

- (NSArray*) avatarsColors
{
    if ( _avatarsColors == nil )
    {
        UIColor* avatarGreenColor  = [UIColor colorWithRed: 0.369 green: 0.745 blue: 0.494 alpha: 1.00];
        UIColor* avatarPurpleColor = [UIColor colorWithRed: 0.651 green: 0.553 blue: 0.835 alpha: 1.00];
        UIColor* avatarOrangeColor = [UIColor colorWithRed: 0.945 green: 0.608 blue: 0.404 alpha: 1.00];
        UIColor* avatarBlueColor   = [UIColor colorWithRed: 0.404 green: 0.698 blue: 0.945 alpha: 1.00];
        UIColor* avatarPinkColor   = [UIColor colorWithRed: 0.945 green: 0.404 blue: 0.616 alpha: 1.00];
        
        _avatarsColors = @[avatarGreenColor,
                           avatarPurpleColor,
                           avatarOrangeColor,
                           avatarBlueColor,
                           avatarPinkColor];
    }
    
    return _avatarsColors;
}


#pragma mark - Public -

- (NSString*) generateAvatarForName: (NSString*) name
{
    NSString* avatarFilePath = [[Utils getAvatarsDirectoryPath] stringByAppendingFormat: @"%@.png", name];
    UIColor* avatarColor     = [self getRandomAvatarColor];
    NSString* abbreviation   = [Utils getNameAbbreviation: name];
    CGSize avatarImageSize   = CGSizeMake(60, 60);
    
    // Generate avatar and write it to file in external queue
    NSOperationQueue* writeFileQueue = [NSOperationQueue new];
    
    [writeFileQueue addOperationWithBlock:^{
        
        UIImage* generatedAvatarImage = [[AvatarGenerator alloc] initWithText: abbreviation
                                                          withBackgroundColor: avatarColor
                                                                     withSize: avatarImageSize];
        
        
        
        NSData* avatarImageData = UIImagePNGRepresentation(generatedAvatarImage);
        
        [avatarImageData writeToFile: avatarFilePath
                          atomically: YES];
        
    }];
    
    return avatarFilePath;
}


#pragma mark - Internal methods -

- (UIColor*) getRandomAvatarColor
{
    NSUInteger colorIndex = arc4random_uniform((int32_t)self.avatarsColors.count);
    UIColor* avatarColor  = self.avatarsColors[colorIndex];
    
    return avatarColor;
}

@end
