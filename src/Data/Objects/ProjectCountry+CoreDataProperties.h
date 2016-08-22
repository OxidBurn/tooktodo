//
//  ProjectCountry+CoreDataProperties.h
//  
//
//  Created by Nikolay Chaban on 8/22/16.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "ProjectCountry.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProjectCountry (CoreDataProperties)

@property (nullable, nonatomic, retain) ProjectInfo *project;

@end

NS_ASSUME_NONNULL_END
