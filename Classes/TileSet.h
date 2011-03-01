//
//  TileSet.h
//  Zombies
//
//  Created by Nathan Holmberg on 1/03/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface TileSet : NSObject {
	CGSize mDimensions;
	char* mBitmap;
}

-(id)initWithDimensions:(CGSize) dimensions;

-(BOOL) isTileFree:(CGPoint) tile;

-(BOOL) freeTile:(CGPoint) tile;

-(BOOL) obtainTile:(CGPoint) tile;

@end
