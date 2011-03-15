//
//  TurnManager.h
//  Zombies
//
//  Created by Victor Jones on 6/03/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Actor.h"

@interface TurnManager : NSObject {
	int pointsPool;
	int APCounter;
	int turnCounter;
	NSMutableArray* players;
	Board* gameBoard;
	
}

-(id) initTurnManager;
-(void) addActorToManager:(Actor*) actor;
-(void) removeActorFromManager:(Actor*) actor;
-(BOOL) isPlayersTurn:(Actor*) actor;
-(void) endCurrentTurn;
-(BOOL) canMovePlayer:(Actor*) actor;
	
	
	


@end
