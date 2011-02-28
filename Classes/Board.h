//
//  Board.h
//  Zombies
//
//  Created by Nathan Holmberg on 24/02/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "cocos2d.h"

@interface Board : NSObject {
	CCSprite* mSprite;
	
	CGSize mDimensions;
	CGSize mSizeOfPlayTile;
	CGPoint mOffsetToFirstTile;
}

@property (nonatomic,readonly) CGSize tileSize;

-(id)initWithSize:(CGPoint)size andResource:(NSString*) resource;

-(CGPoint) getPositionOfSquareAt:(CGPoint) location;

-(BOOL) isTileFree:(CGPoint) location;

-(void) addToScene:(CCLayer*) scene;

@end
