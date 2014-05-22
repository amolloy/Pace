// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ASMTrack.h instead.

#import <CoreData/CoreData.h>


extern const struct ASMTrackAttributes {
	__unsafe_unretained NSString *duration;
	__unsafe_unretained NSString *name;
	__unsafe_unretained NSString *tempo;
	__unsafe_unretained NSString *trackHash;
} ASMTrackAttributes;

extern const struct ASMTrackRelationships {
	__unsafe_unretained NSString *artist;
} ASMTrackRelationships;

extern const struct ASMTrackFetchedProperties {
} ASMTrackFetchedProperties;

@class ASMArtist;






@interface ASMTrackID : NSManagedObjectID {}
@end

@interface _ASMTrack : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (ASMTrackID*)objectID;





@property (nonatomic, strong) NSDecimalNumber* duration;



//- (BOOL)validateDuration:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* name;



//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* tempo;



@property float tempoValue;
- (float)tempoValue;
- (void)setTempoValue:(float)value_;

//- (BOOL)validateTempo:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* trackHash;



@property int64_t trackHashValue;
- (int64_t)trackHashValue;
- (void)setTrackHashValue:(int64_t)value_;

//- (BOOL)validateTrackHash:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) ASMArtist *artist;

//- (BOOL)validateArtist:(id*)value_ error:(NSError**)error_;





@end

@interface _ASMTrack (CoreDataGeneratedAccessors)

@end

@interface _ASMTrack (CoreDataGeneratedPrimitiveAccessors)


- (NSDecimalNumber*)primitiveDuration;
- (void)setPrimitiveDuration:(NSDecimalNumber*)value;




- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;




- (NSNumber*)primitiveTempo;
- (void)setPrimitiveTempo:(NSNumber*)value;

- (float)primitiveTempoValue;
- (void)setPrimitiveTempoValue:(float)value_;




- (NSNumber*)primitiveTrackHash;
- (void)setPrimitiveTrackHash:(NSNumber*)value;

- (int64_t)primitiveTrackHashValue;
- (void)setPrimitiveTrackHashValue:(int64_t)value_;





- (ASMArtist*)primitiveArtist;
- (void)setPrimitiveArtist:(ASMArtist*)value;


@end
