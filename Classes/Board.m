//
//  Board.m
//  Zombies
//
//  Created by Nathan Holmberg on 24/02/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Board.h"

#import "ZombieUtils.h"

@implementation Board

@synthesize tileSize = mSizeOfPlayTile;

-(id)initWithSize:(CGPoint)size andResource:(NSString*) resource
{
	self = [super init];
	if( self )
	{
		mSprite = [CCSprite spriteWithFile:[resource stringByAppendingString: @".png"] rect: CGRectMake(0,0,size.x,size.y)];
		mSprite.position = ccp(size.x/2,size.y/2);
		
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
		}
		else {
			mDimensions = CGSizeMake(0, 0);
			mSizeOfPlayTile = CGSizeMake(32, 32);
			mOffsetToFirstTile = CGPointMake( 0, 0 );
		}

	}
	return self;
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
	
	return CGPointMake( mOffsetToFirstTile.x + mSizeOfPlayTile.width*location.x, 
					   mOffsetToFirstTile.y + mSizeOfPlayTile.height*location.y );
}

-(BOOL) isTileFree:(CGPoint) location
{
	return YES;
}

-(void) addToScene:(CCLayer*) scene
{
	[scene addChild: mSprite];
}

@end
