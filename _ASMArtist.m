// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ASMArtist.m instead.

#import "_ASMArtist.h"

const struct ASMArtistAttributes ASMArtistAttributes = {
	.name = @"name",
};

const struct ASMArtistRelationships ASMArtistRelationships = {
	.track = @"track",
};

const struct ASMArtistFetchedProperties ASMArtistFetchedProperties = {
};

@implementation ASMArtistID
@end

@implementation _ASMArtist

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Artist" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Artist";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Artist" inManagedObjectContext:moc_];
}

- (ASMArtistID*)objectID {
	return (ASMArtistID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic name;






@dynamic track;

	






@end
