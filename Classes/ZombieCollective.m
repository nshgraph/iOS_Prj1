//
//  ZombieCollective.m
//  Zombies
//
//  Created by Nathan Holmberg on 25/02/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ZombieCollective.h"

#import "cocos2d.h"
#import "ZombieUtils.h"

@implementation ZombieCollective


-(id)initOnBoard:(Board*) board withResource: (NSString*) resource
{
	self = [super init];
	if( self )
	{
		mBoard = board;
		NSString *path = [CCFileUtils fullPathFromRelativePath:[resource stringByAppendingString: @".plist"]];
		NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:path];
		if( dict )
		{
			mNumZombiesInitial = [[dict valueForKey:@"NumberOfZombiesInitial"] intValue];
			mNumZombiesPerTurn = [[dict valueForKey:@"NumberOfZombiesPerTurn"] intValue];
			mNumZombiesMaxPerPlayer = [[dict valueForKey:@"MaxZombiesPerPlayer"] intValue];
			
			NSArray* spawn_point_list = [dict valueForKey:@"ZombieSpawnPoints"];
			mZombieSpawnPoints = [[NSMutableArray alloc] initWithCapacity: [spawn_point_list count]];
			for( int i=0; i < [spawn_point_list count]; i++ )
			{
				NSArray* spawn_in = [spawn_point_list objectAtIndex:i];
				NSMutableArray* spawn_out = [[[NSMutableArray alloc] initWithCapacity: [spawn_in count]] autorelease];
				for( int j=0; j < [spawn_point_list count]; j++ )
				{
					CGPoint temp = [ZombieUtils parseSettingIntoCGPoint: [spawn_in objectAtIndex: j] ];
					[spawn_out addObject:[NSValue valueWithCGPoint: temp] ];
				}
				
			}
		}
		else {
			mNumZombiesInitial = 0;
			mNumZombiesPerTurn = 0;
			mNumZombiesMaxPerPlayer = 0;
		}
	}
	
	return self;
}

-(void) dealloc
{
	[mZombieSpawnPoints release];
	
	[mZombies release];
	
	[super dealloc];
}

-(void) spawn: (int) number ofZombiesAtSpawnPoints: (NSArray*) spawn_points
{
	
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
