//
//  ZombieCollective.h
//  Zombies
//
//  Created by Nathan Holmberg on 25/02/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Board;

@interface ZombieCollective : NSObject {
	Board* mBoard;
	
	int mNumZombiesInitial;
	int mNumZombiesPerTurn;
	int mNumZombiesMaxPerPlayer;
	
	NSMutableArray* mZombies;
	NSMutableArray* mZombieSpawnPoints;
}

-(id)initOnBoard:(Board*) board withResource: (NSString*) resource;


-(void) spawnInitialZombies;

-(void) spawnNewTurnZombiesForPlayers:(int) num_players;

@end
