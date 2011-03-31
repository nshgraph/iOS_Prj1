//
//  TurnManager.m
//  Zombies
//
//  Created by Victor Jones on 6/03/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TurnManager.h"
#import "Board.h"
#import "Actor.h"
#import "TileSet.h"
#import "ZombieUtils.h"




@implementation TurnManager
	

+(BOOL) isEqualPlayer: (Actor*) actorOne to: (Actor*) actorTwo
{
	if ([actorOne isEqual: actorTwo]){
		return YES;
	} else {
		return NO;
	}
}

// Init method - instantiates players array and gameBoard object.
-(id) initTurnManager
{
	self = [super init];
	if( self ) 
	{
		APCounter = 4;
		players = [[NSMutableArray alloc] init ];
		//gameBoard = inputBoard;
		turnCounter = 0;
	}
	return self;
}

// Adds an actor object to our players array.
-(void) addActorToManager:(Actor*) actor
{
	if (actor.isPlayer == YES){
		[players addObject: actor];
	}
}

// Removes an object to our players array.
-(void) removeActorFromManager:(Actor*) actor
{
	[players removeObject: actor];
}


-(BOOL) isPlayersTurn:(Actor*) actor
{
	BOOL result = NO;
	if ([[players objectAtIndex:turnCounter] isEqual: actor]) {
		return YES;
	} 
	return result;
}

-(void) beginTurn
{
	APCounter = 4;
}

-(void) endCurrentTurn
{
	if ([[players objectAtIndex: turnCounter] isEqual: [players lastObject]])
	{
		// Call zombieCollective to Start Turn.
		turnCounter = 0;
		APCounter = 4;
	} else {
		turnCounter = turnCounter+1;
		APCounter = 4;
	}
}

-(BOOL) canMovePlayer:(Actor*) actor
{
	BOOL result = NO;
	if ([self isPlayersTurn: actor] && APCounter > 0)
	{
			APCounter = APCounter - 1;
		    if (APCounter == 0)
				[self endCurrentTurn];
			return YES;
	}
	if (APCounter == 0)
		[self endCurrentTurn];
	return result;
}

-(void) decrementAP
{
	APCounter = APCounter - 1;
	if (APCounter == 0){
		[self endCurrentTurn];
	}
}



@end
