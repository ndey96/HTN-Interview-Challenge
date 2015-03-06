//
//  HTNTableViewController.h
//  HTN Challenge
//
//  Created by Nolan Dey on 2015-02-22.
//  Copyright (c) 2015 Nolan Dey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HTNTableViewController : UITableViewController

@property NSMutableArray *attendees;
@property NSArray *sortedAttendees;

//retrieves JSON data from URL and returns it in an NSData object
- (NSData*) RetrieveRawData;
//converts the JSON data into an NSMutableDictionary
- (NSMutableDictionary*) ConvertToJSONWithData:(NSData*)data;
//each user's data is stored in an element of the attendeeJSONArray
- (void) loadDataFromArray:(NSMutableArray*)attendeeJSONArray;
//sorts the attendees array alphabetically by name
- (NSArray*) sortArray:(NSMutableArray*)attendees;

@end
