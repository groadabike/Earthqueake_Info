//----------------------------------------------------------------------------
//
//  Database_Abstract.h
//  UnderMyFeet
//
//  Created by Luisa Z. and Gerardo R.
//
//  This is an abstract class which declare the atributes and methods for
//  interact with the database.
//
//  In general the method "init" should be rewriten in order to interact only
//  with the propper table.
//
//----------------------------------------------------------------------------

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface Database_Abstract : NSObject

@property (strong) NSString *databasePath;
@property (strong) NSString *databaseName;
@property (strong) NSString *sqlStatement;


- (void)initializeDatabase;

@end
