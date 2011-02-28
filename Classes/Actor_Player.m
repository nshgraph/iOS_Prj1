//
//  Actor_Player.m
//  Zombies
//
//  Created by Nathan Holmberg on 24/02/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Actor_Player.h"

#import "Board.h"

#define MOVEMENT_THRESHOLD 20

@implementation Actor_Player

-(id)initOnTile:(CGPoint) tile onBoard:(Board*) board andResource: (NSString*) resource
{
	self = [super initOnTile: tile onBoard: board andResource: (NSString*) resource];
	if( self )
	{
		[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
	}
	
	
	return self;
}

- (void)onEnter
{
	[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
	[mSprite onEnter];
}

- (void)onExit
{
	[[CCTouchDispatcher sharedDispatcher] removeDelegate:self];
	[mSprite onExit];
}	

- (BOOL)containsTouchLocation:(UITouch *)touch
{
	CGPoint p = [mSprite convertTouchToNodeSpace:touch];
	CGRect r = mSprite.textureRect;
	return CGRectContainsPoint(r, p);
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
	if ( ![self containsTouchLocation:touch] ) 
		return NO;
	
	NSLog(@"TouchBegan\n");
	
	mTouchStart = [touch locationInView:[touch view]];
	mTouchStart = [[CCDirector sharedDirector] convertToGL:mTouchStart];
	
	return YES;
}

- (void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{
	// If it weren't for the TouchDispatcher, you would need to keep a reference
	// to the touch from touchBegan and check that the current touch is the same
	// as that one.
	// Actually, it would be even more complicated since in the Cocos dispatcher
	// you get NSSets instead of 1 UITouch, so you'd need to loop through the set
	// in each touchXXX method.
	
}

- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
	
	CGPoint touchPointEnd = [touch locationInView:[touch view]];
	touchPointEnd = [[CCDirector sharedDirector] convertToGL:touchPointEnd];
	
	// determine if the movement was long enough to constitute a choice
	if( ccpDistance( mTouchStart, touchPointEnd ) < MOVEMENT_THRESHOLD )
		return;
	
	float direction = (ccpAngleSigned(ccpSub(touchPointEnd,mTouchStart),ccp(0,1))) + 0.25*M_PI; // quarter PI to make the 
	if( direction < 0 )
		direction = 2.0 * M_PI + direction;
	int dir_int = ((int)((4.0 * direction / (2.0 * M_PI))  )) % 4;
	
	// if the movement is in the direction of orientation move
	if( dir_int == mOrientation )
	{
		CGPoint move_vector = ccp((mOrientation % 2) * ( 2 - mOrientation ),
								 ((mOrientation+1) % 2) * ( 1 - mOrientation ) );
		[self moveToTile: ccpAdd(mPosition, move_vector)];
	}
	else { // otherwise rotate towards the direction chosen
		int rotateDir = -1;
		if( dir_int == (mOrientation + 1) % 4 )
			rotateDir = 1;
		[self rotate:((mOrientation + rotateDir + 4) % 4)]; // plus 4 because we don't want to do % operations on negative numbers
	}
	
}


@end
