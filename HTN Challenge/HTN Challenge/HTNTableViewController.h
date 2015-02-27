//
//  HTNTableViewController.h
//  HTN Challenge
//
//  Created by Nolan Dey on 2015-02-22.
//  Copyright (c) 2015 Nolan Dey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HTNTableViewController : UITableViewController

@property NSMutableDictionary* attendeeInfo;
- (NSData*) RetrieveRawData;
- (NSMutableDictionary*) ConvertToJSONWithData:(NSData*)data;

@end
