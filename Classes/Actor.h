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
}
@property(nonatomic,readwrite) int orientation;

-(id)initOnTile:(CGPoint) tile onBoard:(Board*) board andResource: (NSString*) resource;

-(void) addToScene:(CCLayer*) scene;

-(void) relocateToTile:(CGPoint) tile;

-(void) moveToTile:(CGPoint) tile;

-(void) rotate:(int) orientation;

@end
