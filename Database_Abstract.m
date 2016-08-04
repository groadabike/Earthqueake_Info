//----------------------------------------------------------------------------
//
//  Database_Abstract.m
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

#import "Database_Abstract.h"

@implementation Database_Abstract


-(id) init{
    self = [super init];
    if(self){
        self.databaseName = @"UnderMyFeet.sql";
        NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
        NSString *documentsDir = [documentPaths objectAtIndex:0];
        self.databasePath = [documentsDir stringByAppendingPathComponent:self.databaseName];
        //NSLog(@"%@",self.databasePath);
        [self initializeDatabase];
    }
    return self;
}

- (void)initializeDatabase{
    NSFileManager *filemanager=[NSFileManager defaultManager];
    if([filemanager fileExistsAtPath:self.databasePath])
        return;
    NSString *databasePathFromApp =[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:self.databaseName];
    [filemanager copyItemAtPath:databasePathFromApp toPath:self.databasePath error:nil];
}
@end
