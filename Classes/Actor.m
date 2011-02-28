//
//  Actor.m
//  Zombies
//
//  Created by Nathan Holmberg on 24/02/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Actor.h"

#import "Board.h"

#define ROTATE_DURATION 0.25
#define MOVE_DURATION 0.25


@implementation Actor

BOOL mbIsMoving;

@synthesize orientation = mOrientation;

-(id)initOnTile:(CGPoint) tile onBoard:(Board*) board andResource: (NSString*) resource
{
	self = [super init];
	if( self )
	{
		mPosition = tile;
		mBoard = board;
		[mBoard retain];
		mSize = board.tileSize;
		
		mOrientation = 0;
		
		mbIsMoving = false;
		mSprite = [CCSprite spriteWithFile:[resource stringByAppendingString: @".png"]];
		mSprite.position = [mBoard getPositionOfSquareAt: mPosition];
		mSprite.scale = mBoard.tileSize.width / mSprite.textureRect.size.width;
		
		return self;
	}
	return self;
}

-(void) dealloc
{
	[mBoard release];
	[super dealloc];
}

-(void)setOrientation:(int) orientation
{
	mOrientation = (orientation % 4);
	if( mSprite )
		mSprite.rotation = mOrientation * 90;
}

-(void) addToScene:(CCLayer*) scene
{
	[scene addChild: mSprite];
}

-(void) relocateToTile:(CGPoint) tile
{
	// can't move if already moving
	if( mbIsMoving )
		return;
	
	if ( mSprite )
		mSprite.position = [mBoard getPositionOfSquareAt:tile];
}

-(void) moveToTile:(CGPoint) tile
{
	// can't move if already moving
	if( mbIsMoving )
		return;
	
	mbIsMoving = true;
	
	float duration = MOVE_DURATION;
	
	CGPoint moveTarget = [mBoard getPositionOfSquareAt:tile];
	
	id actionMoveX = [CCMoveTo actionWithDuration:duration position:ccp(moveTarget.x, mSprite.position.y)];
	id actionMoveY = [CCMoveTo actionWithDuration:duration position:moveTarget];
	id actionMoveDone = [CCCallFuncN actionWithTarget:self 
											 selector:@selector(moveFinished:)];
	[mSprite runAction:[CCSequence actions: actionMoveX, actionMoveY,actionMoveDone, nil]];
	
	mPosition = tile;
}


-(void) rotate:(int) orientation
{
	// can't move if already moving
	if( mbIsMoving )
		return;
	
	mbIsMoving = true;
	
	float duration = ROTATE_DURATION;
	int rotateBy = ((orientation - mOrientation + 4) % 4) * 90;
	if( rotateBy > 180 )
		rotateBy = 180 - rotateBy;
	id actionRotate = [CCRotateBy actionWithDuration:duration angle:rotateBy];
	id actionRotateDone = [CCCallFuncN actionWithTarget:self 
											 selector:@selector(moveFinished:)];
	[mSprite runAction:[CCSequence actions: actionRotate, actionRotateDone, nil]];
	mOrientation = (orientation % 4);
}

-(void) moveFinished:(id)sender
{
	mbIsMoving = false;
}


@end
