// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ASMArtist.h instead.

#import <CoreData/CoreData.h>


extern const struct ASMArtistAttributes {
	__unsafe_unretained NSString *name;
} ASMArtistAttributes;

extern const struct ASMArtistRelationships {
	__unsafe_unretained NSString *track;
} ASMArtistRelationships;

extern const struct ASMArtistFetchedProperties {
} ASMArtistFetchedProperties;

@class ASMTrack;



@interface ASMArtistID : NSManagedObjectID {}
@end

@interface _ASMArtist : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (ASMArtistID*)objectID;





@property (nonatomic, strong) NSString* name;



//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) ASMTrack *track;

//- (BOOL)validateTrack:(id*)value_ error:(NSError**)error_;





@end

@interface _ASMArtist (CoreDataGeneratedAccessors)

@end

@interface _ASMArtist (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;





- (ASMTrack*)primitiveTrack;
- (void)setPrimitiveTrack:(ASMTrack*)value;


@end
