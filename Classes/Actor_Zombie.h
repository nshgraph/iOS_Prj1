//
//  Actor_Zombie.h
//  Zombies
//
//  Created by Nathan Holmberg on 25/02/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Actor.h"

@interface Actor_Zombie : Actor {
	int mAPPerTurn;
}

@property(nonatomic,readwrite) int apPerTurn;

-(id)initOnTile:(CGPoint) tile onBoard:(Board*) board andResource: (NSString*) resource;

-(void) doTurnWithTargetLocations:(NSArray*)targetLocations;

@end
