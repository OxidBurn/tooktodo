//
//  AvatarManager.m
//  TookTODO
//
//  Created by Nikolay Chaban on 8/15/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "AvatarHelper.h"

// Frameworks
#import <SDWebImage/SDWebImageManager.h>

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
                   withAbbreviation: (NSString*) abbreviation
{
    NSString* avatarFilePath = [NSString stringWithFormat: @"%@.png", [self getEmailPrefix: name]];
    UIColor* avatarColor     = [self getRandomAvatarColor];
    CGSize avatarImageSize   = CGSizeMake(60, 60);
    
    // Generate avatar and write it to file in external queue
    NSOperationQueue* writeFileQueue = [NSOperationQueue new];
    
    [writeFileQueue addOperationWithBlock:^{
        
        UIImage* generatedAvatarImage = [[AvatarGenerator alloc] initWithText: abbreviation
                                                          withBackgroundColor: avatarColor
                                                                     withSize: avatarImageSize];
        
        
        
        NSData* avatarImageData = UIImagePNGRepresentation(generatedAvatarImage);
        
        NSString* fullAvatarPath = [self getAvatarPathForName: name];
        
        [avatarImageData writeToFile: fullAvatarPath
                          atomically: YES];
        
    }];
    
    return avatarFilePath;
}

- (NSString*) getAvatarPathForName: (NSString*) name
{
    return [[Utils getAvatarsDirectoryPath] stringByAppendingFormat: @"%@.png", [self getEmailPrefix: name]];
}

- (void) loadAvatarFromWeb: (NSString*) filePath
                  withName: (NSString*) name
{
    SDWebImageManager* manager = [SDWebImageManager sharedManager];
    
    [manager downloadImageWithURL: [NSURL URLWithString: filePath]
                          options: 0
                         progress: nil
                        completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                            
                            // Generate avatar and write it to file in external queue
                            NSOperationQueue* writeFileQueue = [NSOperationQueue new];
                            
                            [writeFileQueue addOperationWithBlock:^{
                                
                                NSData* avatarImageData = UIImagePNGRepresentation(image);
                                
                                NSString* fullAvatarPath = [self getAvatarPathForName: name];
                                
                                [avatarImageData writeToFile: fullAvatarPath
                                                  atomically: YES];
                                
                            }];
                            
                        }];
}


#pragma mark - Internal methods -

- (UIColor*) getRandomAvatarColor
{
    NSUInteger colorIndex = arc4random_uniform((int32_t)self.avatarsColors.count);
    UIColor* avatarColor  = self.avatarsColors[colorIndex];
    
    return avatarColor;
}

- (NSString*) getEmailPrefix: (NSString*) email
{
    NSRange range         = [email rangeOfString: @"@"];
    NSString* emailPrefix = @"";
    if ( range.location != NSNotFound )
    {
        emailPrefix = [email substringToIndex: range.location];
    }
    
    return emailPrefix;
}

@end
