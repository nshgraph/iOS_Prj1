//
//  TileSet.m
//  Zombies
//
//  Created by Nathan Holmberg on 1/03/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TileSet.h"


@implementation TileSet

-(id) initWithDimensions:(CGSize) dimensions
{
	self = [super init];
	if( self )
	{
		mDimensions = dimensions;
		
		mBitmap = malloc( sizeof( char ) * dimensions.width *dimensions.height );
		memset( mBitmap, 0, sizeof( char ) * dimensions.width *dimensions.height );
	}
	
	return self;
}

-(void) dealloc
{
	free(mBitmap);
	[super dealloc];
}

-(BOOL) isTileFree:(CGPoint) tile
{
	int subscript = tile.x*mDimensions.height + tile.y;
	return (mBitmap[subscript] == 0 );
}

-(BOOL) freeTile:(CGPoint) tile
{
	BOOL result = YES;
	int subscript = tile.x*mDimensions.height + tile.y;
	if( mBitmap[subscript] == 0 )
		result = NO;
	   
	mBitmap[subscript] = 0;
	return result;
}

-(BOOL) obtainTile:(CGPoint) tile
{
	BOOL result = YES;
	int subscript = tile.x*mDimensions.height + tile.y;
	if( mBitmap[subscript] != 0 )
		result = NO;
	
	mBitmap[subscript] = 1;
	return result;
}

@end
