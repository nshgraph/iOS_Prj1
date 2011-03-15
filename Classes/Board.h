//
//  Board.h
//  Zombies
//
//  Created by Nathan Holmberg on 24/02/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TurnManager.h"
#import "cocos2d.h"

@class Actor;
@class TileSet;

@interface Board : NSObject {
	CCSprite* mSprite;
	TurnManager* mTurnManager;
	CGSize mDimensions;
	CGSize mSizeOfPlayTile;
	CGPoint mOffsetToFirstTile;
	
	TileSet* mTileSet;
	NSLock *mTileSetLock;
}

@property (nonatomic,readonly) CGSize tileSize;

-(id)initWithSize:(CGPoint)size andResource:(NSString*) resource;

-(CGPoint) getPositionOfSquareAt:(CGPoint) location;

-(int)orientationTowardsCenterForTile: (CGPoint) tile;

-(BOOL) isTileFree:(CGPoint) location;

-(void) addToScene:(CCLayer*) scene;

-(void) addActorToBoard:(Actor*) actor;

-(void) removeActorFromBoard:(Actor*) actor;

-(BOOL) canMovePlayer:(Actor*) actor;

-(BOOL) requestActorMoveFrom:(CGPoint) from_point to:(CGPoint) to_point;

@end
