//
//  HelloWorldLayer.m
//  Zombies
//
//  Created by Nathan Holmberg on 24/02/11.
//  Copyright __MyCompanyName__ 2011. All rights reserved.
//

// Import the interfaces
#import "ZombieWorldScene.h"

#import "ZombieUtils.h"

#import "Actor_Player.h"
#import "Board.h"
#import "ZombieCollective.h"

// ZombieWorld implementation
@implementation ZombieWorld

+(id) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	ZombieWorld *layer = [[[ZombieWorld alloc] initWithLevel: @"Base-1Screen" andNumPlayers: 2] autorelease];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}


-(void)parseLevel:(NSString*) level_name
{
	NSString *path = [CCFileUtils fullPathFromRelativePath:[level_name stringByAppendingString: @".plist"]];
	NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:path];
	if( dict )
	{
		mMaxPlayers = [[dict valueForKey:@"MaxPlayers"] intValue];
		
		NSArray* spawn_array = [dict valueForKey:@"PlayerSpawnPoints"];
		mPlayerSpawnPoints = [[NSMutableArray alloc] initWithCapacity:mMaxPlayers];
		for( int i=0; i < [spawn_array count]; i++ )
		{
			NSString* data = [spawn_array objectAtIndex:i];
			
			[mPlayerSpawnPoints addObject: [NSValue valueWithCGPoint:[ZombieUtils parseSettingIntoCGPoint: data ]]];
		}
		
	}
	else {
		mMaxPlayers = 1;
		mPlayerSpawnPoints = [[NSArray alloc] initWithObjects:[NSValue valueWithCGPoint:ccp(0,0)],nil];
	}
}



// on "init" you need to initialize your instance
-(id) initWithLevel:(NSString*) level_name andNumPlayers:(int) num_players
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init] )) {
		
		[self parseLevel:(NSString*) level_name];
		
		if( num_players > mMaxPlayers )
			num_players = mMaxPlayers;
		
		
		CGSize winSize = [[CCDirector sharedDirector] winSize];
		mBoard = [[Board alloc] initWithSize: ccp(winSize.width, winSize.height) andResource: level_name];
		[mBoard addToScene: self];
		
		mPlayers = [[NSMutableArray alloc] initWithCapacity: num_players];
		for( int i=0; i < num_players; i++ )
		{
			CGPoint spawn_point = [[mPlayerSpawnPoints objectAtIndex: i] CGPointValue];
			Actor* actor = [[[Actor_Player alloc] initOnTile: spawn_point onBoard: mBoard andResource: [NSString stringWithFormat:@"Player%i",(i+1)]] autorelease];
			[mPlayers addObject: actor];
		}
		
		mZombies = [[ZombieCollective alloc] initOnBoard: mBoard withLevelResource: level_name andZombieResource:@"Zombie"];
		[mZombies spawnInitialZombies];
		
	}
	return self;
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	[mBoard release];
	
	[mPlayers release];
	
	[mPlayerSpawnPoints release];
	
	[mZombies release];
	
	// don't forget to call "super dealloc"
	[super dealloc];
}

@end
