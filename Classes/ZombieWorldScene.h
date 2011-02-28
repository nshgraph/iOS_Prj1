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

// HelloWorld Layer
@interface ZombieWorld : CCLayer
{
	Board* mBoard;
	
	
	int mMaxPlayers;
	NSMutableArray* mPlayers;
	NSMutableArray* mPlayerSpawnPoints;
}

// returns a Scene that contains the HelloWorld as the only child
+(id) scene;

-(id) initWithLevel:(NSString*) level_name andNumPlayers:(int) num_players;


@end
