//
//  ZombieWorldLayer.h
//  Zombies
//
//  Created by Nathan Holmberg on 24/02/11.
//  Copyright __MyCompanyName__ 2011. All rights reserved.
//


// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"

@class Actor;
@class Board;
@class ZombieCollective;

// HelloWorld Layer
@interface ZombieWorld : CCLayer
{
	// The board to be played on
	Board* mBoard;
	
	// information related to the players
	int mMaxPlayers;
	NSMutableArray* mPlayers;
	NSMutableArray* mPlayerSpawnPoints;
	
	// information related to the zombies
	ZombieCollective* mZombies;
}

// returns a Scene that contains the HelloWorld as the only child
+(id) scene;

-(id) initWithLevel:(NSString*) level_name andNumPlayers:(int) num_players;


@end
