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
	
	NSString* mZombieName;
	
	int mNumZombiesInitial;
	int mNumZombiesPerTurn;
	int mNumZombiesMaxPerPlayer;
	int mNumAPPointsPerZombie;
	
	NSMutableArray* mZombies;
	NSMutableArray* mZombieSpawnPoints;
}

-(id)initOnBoard:(Board*) board withLevelResource: (NSString*) resource andZombieResource: (NSString*) zombie;


-(void) spawnInitialZombies;

-(void) spawnNewTurnZombiesForPlayers:(int) num_players;

-(void) moveZombies;

@end
