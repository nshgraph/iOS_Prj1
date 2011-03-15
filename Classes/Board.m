//
//  Board.m
//  Zombies
//
//  Created by Nathan Holmberg on 24/02/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Board.h"

#import "Actor.h"
#import "TileSet.h"

#import "ZombieUtils.h"

@implementation Board

@synthesize tileSize = mSizeOfPlayTile;

-(id)initWithSize:(CGPoint)size andResource:(NSString*) resource
{
	self = [super init];
	if( self )
	{
		mSprite = [[CCSprite spriteWithFile:[resource stringByAppendingString: @".png"] rect: CGRectMake(0,0,size.x,size.y)] retain];
		mSprite.contentSize = mSprite.textureRect.size;
		mSprite.position = ccp(mSprite.contentSize.width/2,mSprite.contentSize.height/2);
		
		NSString *path = [CCFileUtils fullPathFromRelativePath:[resource stringByAppendingString: @".plist"]];
		NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:path];
		if( dict )
		{
			CGPoint temp = [ZombieUtils parseSettingIntoCGPoint: [dict valueForKey:@"NumberOfPlayTiles"] ];
			mDimensions = CGSizeMake( temp.x, temp.y );
			temp = [ZombieUtils parseSettingIntoCGPoint: [dict valueForKey:@"SizeOfPlayTile"] ];
			mSizeOfPlayTile = CGSizeMake( temp.x, temp.y );
			temp = [ZombieUtils parseSettingIntoCGPoint: [dict valueForKey:@"OffsetToFirstPlayTile"] ];
			mOffsetToFirstTile = temp;
			// find a list of all the non-free tiles
			
		}
		else {
			mDimensions = CGSizeMake(0, 0);
			mSizeOfPlayTile = CGSizeMake(32, 32);
			mOffsetToFirstTile = CGPointMake( 0, 0 );
		}
		
		mTileSet = [[TileSet alloc] initWithDimensions:mDimensions];
		mTileSetLock = [[NSLock alloc] init];
		
		

	}
	return self;
}

-(void) dealloc
{
	[mSprite release];
	[mTileSet release];
	[mTileSetLock release];
	[super dealloc];
}

-(CGPoint) getPositionOfSquareAt:(CGPoint) location
{
	if( location.x < 0 )
		location.x = 0;
	if( location.x >= mDimensions.width )
		location.x = mDimensions.width - 1;
	if( location.y < 0 )
		location.y = 0;
	if( location.y >= mDimensions.height )
		location.y = mDimensions.height - 1;
	
	return CGPointMake( mOffsetToFirstTile.x + mSizeOfPlayTile.width*location.x - 5, 
					   mOffsetToFirstTile.y + mSizeOfPlayTile.height*location.y - 10 );
}

-(int)orientationTowardsCenterForTile: (CGPoint) tile
{
	int xDist = tile.x - mDimensions.width/2;
	int yDist = tile.y - mDimensions.height/2;
	if( abs(yDist) > abs(xDist) )
	{
		return ( yDist < 0 ) ? 0 : 2;
	}
	else {
		return ( xDist < 0 ) ? 1 : 3;
	}

}

-(BOOL) isTileFree:(CGPoint) location
{
	BOOL result = YES;
	[mTileSetLock lock];
	
	result = [mTileSet isTileFree: location];
	
	[mTileSetLock unlock];
	return result;
}

-(void) addToScene:(CCLayer*) scene
{
	[scene addChild: mSprite];
}

-(void) addActorToBoard:(Actor*) actor
{
	[mSprite addChild: actor.node];
	
	[mTileSetLock lock];
	
	[mTileSet obtainTile: actor.position];
	
	[mTileSetLock unlock];
}


-(void) removeActorFromBoard:(Actor*) actor
{
	[mSprite removeChild: actor.node cleanup:YES];
	
	[mTileSetLock lock];
	
	[mTileSet freeTile: actor.position];
	
	[mTileSetLock unlock];
}

-(BOOL) requestActorMoveFrom:(CGPoint) from_point to:(CGPoint) to_point
{
	BOOL result = NO;
	
	[mTileSetLock lock];
	
	if( [mTileSet isTileFree: to_point] )
	{
		// free the old position
		[mTileSet freeTile: from_point];
		// and make the to_point unavailable
		[mTileSet obtainTile: to_point];
		result = YES;
	}
	
	[mTileSetLock unlock];
	
	return result;
}

@end
