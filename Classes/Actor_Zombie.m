//
//  Actor_Zombie.m
//  Zombies
//
//  Created by Nathan Holmberg on 25/02/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Actor_Zombie.h"

#import "Board.h"


@implementation Actor_Zombie

@synthesize apPerTurn = mAPPerTurn;

-(id)initOnTile:(CGPoint) tile onBoard:(Board*) board andResource: (NSString*) resource isAPlayer: (BOOL) isAPlayer
{
	self = [super initOnTile:tile onBoard:board andResource:resource isAPlayer: isAPlayer];
	if( self )
	{
		
		self.orientation = [board orientationTowardsCenterForTile: tile];
		
	}
	
	return self;
}

-(void) doTurnWithTargetLocations:(NSArray*)targetLocations
{
	
}

@end
