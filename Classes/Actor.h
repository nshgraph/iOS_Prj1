//
//  Actor.h
//  Zombies
//
//  Created by Nathan Holmberg on 24/02/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "cocos2d.h"

@class Board;

@interface Actor : NSObject {
	CGPoint mPosition;
	CGSize mSize;
	CCSprite* mSprite;
	int mOrientation;
	Board* mBoard;
	BOOL mIsPlayer;
}

@property(nonatomic,readwrite) int orientation;
@property(nonatomic,readwrite) BOOL isPlayer;
@property(nonatomic,readonly) CGPoint position;
@property(nonatomic,readonly) CCNode* node;


-(id)initOnTile:(CGPoint) tile onBoard:(Board*) board andResource: (NSString*) resource isAPlayer: (BOOL) isPlayable;

-(void) relocateToTile:(CGPoint) tile;

-(void) moveToTile:(CGPoint) tile;

-(void) rotate:(int) orientation;

@end
