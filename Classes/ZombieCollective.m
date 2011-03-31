//
//  ZombieCollective.m
//  Zombies
//
//  Created by Nathan Holmberg on 25/02/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ZombieCollective.h"
#import "Actor_Zombie.h"
#import "Board.h"
#import "ZombieUtils.h"
#import "cocos2d.h"

@implementation ZombieCollective


-(id)initOnBoard:(Board*) board withLevelResource: (NSString*) resource andZombieResource: (NSString*) zombie
{
	self = [super init];
	if( self )
	{
		mBoard = board;
		[mBoard retain];
		mZombieName = [[NSString stringWithString: zombie] retain];
		NSString *path = [CCFileUtils fullPathFromRelativePath:[resource stringByAppendingString: @".plist"]];
		NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:path];
		if( dict )
		{
			mNumZombiesInitial = [[dict valueForKey:@"NumberOfZombiesInitial"] intValue];
			mNumZombiesPerTurn = [[dict valueForKey:@"NumberOfZombiesPerTurn"] intValue];
			mNumZombiesMaxPerPlayer = [[dict valueForKey:@"MaxZombiesPerPlayer"] intValue];
			mNumAPPointsPerZombie = [[dict valueForKey:@"APPointsPerZombie"] intValue];
			
			NSArray* spawn_point_list = [dict valueForKey:@"ZombieSpawnPoints"];
			mZombieSpawnPoints = [[NSMutableArray alloc] initWithCapacity: [spawn_point_list count]];
			for( int i=0; i < [spawn_point_list count]; i++ )
			{
				NSArray* spawn_in = [spawn_point_list objectAtIndex:i];
				NSMutableArray* spawn_out = [[[NSMutableArray alloc] initWithCapacity: [spawn_in count]] autorelease];
				for( int j=0; j < [spawn_in count]; j++ )
				{
					CGPoint temp = [ZombieUtils parseSettingIntoCGPoint: [spawn_in objectAtIndex: j] ];
					[spawn_out addObject:[NSValue valueWithCGPoint: temp] ];
				}
				[mZombieSpawnPoints addObject: [NSArray arrayWithArray:spawn_out]];
				
			}
		}
		else {
			mNumZombiesInitial = 0;
			mNumZombiesPerTurn = 0;
			mNumZombiesMaxPerPlayer = 0;
			mNumAPPointsPerZombie = 1;
		}
	}
	
	return self;
}

-(void) dealloc
{
	[mZombieSpawnPoints release];
	
	[mZombies release];
	
	[mZombieName release];
	
	[mBoard release];
	
	[super dealloc];
}

-(void) spawn: (int) number ofZombiesAtSpawnPoints: (NSArray*) spawn_points
{
	NSMutableArray* spawn_array = [NSMutableArray arrayWithArray:spawn_points];
	while( number > 0 && [spawn_array count] > 0)
	{
		// choose a random spawn point
		int spawn_index = rand() % [spawn_array count];
		CGPoint spawn_point = [[spawn_array objectAtIndex: spawn_index] CGPointValue];
		// remove spawn point from array
		[spawn_array removeObjectAtIndex: spawn_index];
		// check if it is free (on the board)
		if( [mBoard isTileFree: spawn_point] )
		{
			// add if it is create a zombie there
			Actor_Zombie* actor = [[[Actor_Zombie alloc] initOnTile: spawn_point onBoard: mBoard andResource: mZombieName] autorelease];
			actor.isPlayer = NO;
			actor.apPerTurn = mNumAPPointsPerZombie;
			[mZombies addObject:actor];
			//(and decrement number)
			number--;
		}
	}
}

-(void) spawnInitialZombies
{
	if( [mZombieSpawnPoints count] > 0 )
		[self spawn: mNumZombiesInitial ofZombiesAtSpawnPoints: [mZombieSpawnPoints objectAtIndex:0]];
}

-(void) spawnNewTurnZombiesForPlayers:(int) num_players
{
	
	if( [mZombieSpawnPoints count] == 0 )
		return;
	
	int spawn_count = mNumZombiesPerTurn;
	int max_spawn_count = num_players * mNumZombiesMaxPerPlayer;
	// don't spawn too many zombies!!
	if( max_spawn_count - [mZombies count] < spawn_count )
		spawn_count = max_spawn_count - [mZombies count];
	
	// choose one of the spawn arrays to use
	int spawn_array = rand() % [mZombieSpawnPoints count];
	[self spawn: spawn_count ofZombiesAtSpawnPoints: [mZombieSpawnPoints objectAtIndex:spawn_array]];
	
}

@end
