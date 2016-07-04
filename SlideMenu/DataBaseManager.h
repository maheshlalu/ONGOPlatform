#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface DataBaseManager : NSObject 
{
	NSString* _dataBasePath;
	sqlite3 *_database;
	BOOL copyDb;
    NSString* dbName;
}

+(DataBaseManager*)dataBaseManager;
-(NSString*) getDBPath;
-(void)openDatabase;
-(void)dbFlush;

-(BOOL)createDatabase;
-(BOOL)execute:(NSString*)sqlQuery resultsArray:(NSMutableArray*)dataTable;
-(BOOL)execute:(NSString*)sqlStatement;

-(NSInteger)getScalar:(NSString*)sqlStatement;
-(NSString*)getValue1:(NSString*)sqlStatement;

@end
