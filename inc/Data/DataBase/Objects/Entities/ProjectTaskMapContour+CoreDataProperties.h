//
//  ProjectTaskMapContour+CoreDataProperties.h
//  
//
//  Created by Nikolay Chaban on 9/11/16.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "ProjectTaskMapContour.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProjectTaskMapContour (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *geoJson;
@property (nullable, nonatomic, retain) NSNumber *mapContourID;
@property (nullable, nonatomic, retain) NSString *previewImage;
@property (nullable, nonatomic, retain) NSNumber *roomId;
@property (nullable, nonatomic, retain) ProjectTaskRoom *room;

@end

NS_ASSUME_NONNULL_END
