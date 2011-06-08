//
//  Actor_Player.h
//  Zombies
//
//  Created by Nathan Holmberg on 24/02/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Actor.h"

@interface Actor_Player : Actor<CCTargetedTouchDelegate> {
	CGPoint mTouchStart;
}

-(id)initOnTile:(CGPoint) tile onBoard:(Board*) board andResource: (NSString*) resource isAPlayer: (BOOL) isAPlayer;

@end
