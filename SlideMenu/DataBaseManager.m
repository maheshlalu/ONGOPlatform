#import "DataBaseManager.h"

#define DB_NAME  @"CXCALENDER.sqlite"
static DataBaseManager *dataBaseManager = nil;

@implementation DataBaseManager
#pragma mark -
#pragma mark - DataBaseManager initialization
-(id) init
{
	self = [super init];
	if (self) 
    {
		// get full path of database in documents directory
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *newDirectory = [NSString stringWithFormat:@"%@",[paths objectAtIndex:0]];
		_dataBasePath = [newDirectory stringByAppendingPathComponent:DB_NAME];
       NSLog(@"DataBase Path:%@",_dataBasePath);
		_database = nil;
		[self openDatabase];
    }
	return self;
}

/*
 * open database
 * if database doesn't exist, create it
 *
 */
-(void)openDatabase 
{
	BOOL ok;
	NSError *error;
	
	/*
	 * determine if database exists.
	 * create a file manager object to test existence
	 *
	 */
	NSFileManager *fm = [NSFileManager defaultManager]; // file manager
	ok = [fm fileExistsAtPath:_dataBasePath];
	
	// if database not there, copy from resource to path
	if (!ok) 
    {
        // location in resource bundle
        NSString *appPath = [[[NSBundle mainBundle] resourcePath] 
                             stringByAppendingPathComponent:DB_NAME];
        if ([fm fileExistsAtPath:appPath]) {
            // copy from resource to where it should be
            copyDb = [fm copyItemAtPath:appPath toPath:_dataBasePath error:&error];
            if (error!=nil) {
                copyDb = FALSE;
            }
            ok = copyDb;
        }
        
    }
    
    
    // open database
    if (sqlite3_open([_dataBasePath UTF8String], &_database) != SQLITE_OK) 
    {
        sqlite3_close(_database); // in case partially opened
        _database = nil; // signal open error
    }
    
    if (!copyDb && !ok) 
    { // first time and database not copied
        ok = [self createDatabase]; // create empty database
        if (ok) 
        {
        }
    }
    
    if (!ok) 
    {   
        // problems creating database
        NSAssert1(0, @"Problem creating database [%@]",
                  [error localizedDescription]);
    }
    
}
-(BOOL)createDatabase 
{
    BOOL ret= FALSE;
    int rc;
    
    // SQL to create new database
    NSArray* queries = [self tableCreation];
    
        if(queries != NULL)
    {
        for (NSString* sql in queries) 
        {
            sqlite3_stmt *stmt;
            rc = sqlite3_prepare_v2(_database, [sql UTF8String], -1, &stmt, NULL);
            ret = (rc == SQLITE_OK);
            if (ret)
            {
                // statement built, execute
                rc = sqlite3_step(stmt);
                ret = (rc == SQLITE_DONE);
                sqlite3_finalize(stmt); // free statement
                //sqlite3_reset(stmt);
            }
        }
    }
    return ret;
}

+(DataBaseManager*)dataBaseManager 
{
	if(dataBaseManager==nil) 
    {
		dataBaseManager = [[DataBaseManager alloc]init];		
	}
	return dataBaseManager;
}
- (NSString *) getDBPath 
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *newDirectory = [NSString stringWithFormat:@"%@",[paths objectAtIndex:0]];
	return [newDirectory stringByAppendingPathComponent:DB_NAME];
}
#pragma mark -
#pragma mark - Insert Query
/*
 * Method to execute the simple queries
 */
-(BOOL)execute:(NSString*)sqlStatement 
{
    
	sqlite3_stmt *statement = nil;
    BOOL status = FALSE;
	////NSLog(@"%@",sqlStatement);
	const char *sql = (const char*)[sqlStatement UTF8String];

	
	if(sqlite3_prepare_v2(_database, sql, -1, &statement, NULL) != SQLITE_OK) {
           NSAssert1(0, @"Error while preparing  statement. '%s'", sqlite3_errmsg(_database));
        status = FALSE; 
    } else {
        status = TRUE;
    }
	if (sqlite3_step(statement)!=SQLITE_DONE) {
      //  NSLog(@"statement %@",sqlStatement);
        	NSAssert1(0, @"Error while deleting. '%s'", sqlite3_errmsg(_database));
        status = FALSE;
	} else {
        status = TRUE;
	}
	
	sqlite3_finalize(statement);
    return status;
}

#pragma mark -
#pragma mark - SQL query methods
/*
 * Method to get the data table from the database
 */
-(BOOL) execute:(NSString*)sqlQuery resultsArray:(NSMutableArray*)dataTable 
{
    
    char** azResult = NULL;
    int nRows = 0;
    int nColumns = 0;
    BOOL status = FALSE;
    char* errorMsg; //= malloc(255); // this is not required as sqlite do it itself
    const char* sql = [sqlQuery UTF8String];
    sqlite3_get_table(
                      _database,  /* An open database */
                      sql,     /* SQL to be evaluated */
                      &azResult,          /* Results of the query */
                      &nRows,                 /* Number of result rows written here */
                      &nColumns,              /* Number of result columns written here */
                      &errorMsg      /* Error msg written here */
                      );
	
    if(azResult != NULL) 
    {
        nRows++; //because the header row is not account for in nRows
		
        for (int i = 1; i < nRows; i++) 
        {   
            NSMutableDictionary* row = [[NSMutableDictionary alloc]initWithCapacity:nColumns];
            for(int j = 0; j < nColumns; j++)
            {
                NSString*  value = nil;
                NSString* key = [NSString stringWithUTF8String:azResult[j]];
                if (azResult[(i*nColumns)+j]==NULL) 
                {
                    value = [NSString stringWithUTF8String:[[NSString string] UTF8String]];
                }
                else
                {
                    value = [NSString stringWithUTF8String:azResult[(i*nColumns)+j]];
                }
				
                [row setValue:value forKey:key];
            }
            [dataTable addObject:row];
        }
        status = TRUE;
        sqlite3_free_table(azResult);
    } 
    else
    {
        NSAssert1(0,@"Failed to execute query with message '%s'.",errorMsg);
        status = FALSE;
    }
    
    return status;
}
/*
 * Method to get the integer value from the database
 */
-(NSInteger)getScalar:(NSString*)sqlStatement
{
	NSInteger count = -1;
	
	const char* sql= (const char *)[sqlStatement UTF8String];
	sqlite3_stmt *selectstmt;
	if(sqlite3_prepare_v2(_database, sql, -1, &selectstmt, NULL) == SQLITE_OK) 
    {
		while(sqlite3_step(selectstmt) == SQLITE_ROW) 
        {
			count = sqlite3_column_int(selectstmt, 0);
		}
	}
	sqlite3_finalize(selectstmt);
	
	return count;
}

/*
 * Method to get the string from the database
 */
-(NSString*)getValue1:(NSString*)sqlStatement
{
	
	NSString* value = nil;
	const char* sql= (const char *)[sqlStatement UTF8String];
	sqlite3_stmt *selectstmt;
	if(sqlite3_prepare_v2(_database, sql, -1, &selectstmt, NULL) == SQLITE_OK) 
    {
		while(sqlite3_step(selectstmt) == SQLITE_ROW) 
        {
			if ((char *)sqlite3_column_text(selectstmt, 0)!=nil)
            {
				value = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 0)];
			}
		}
	}
	return value;
}
#pragma mark -
#pragma mark - Dealloc
-(void)dealloc 
{
	sqlite3_close(_database);
    dataBaseManager = nil;
}


- (NSArray*)tableCreation
{
    /////////////////////// ***********User table ****************////////////////////////////////////
    NSLog(@"Tables Created");
    NSString *calenderTable = @"CREATE TABLE TABLE_CALENDER_EVENTS (ID INTEGER PRIMARY KEY,NAME VARCHAR,JSON VARCHAR,startDate VARCHAR,endDate VARCHAR,DESCRIPTION VARCHAR,ITEM_CODE VARCHAR,jobId VARCHAR,CREATED_BY_ID VARCHAR,month VARCHAR,year VARCHAR )";
    
    NSString *keysTable = @"CREATE TABLE TABLE_KEYS (ID INTEGER PRIMARY KEY,NAME VARCHAR,JSON VARCHAR,DESCRIPTION VARCHAR,ITEM_CODE VARCHAR,jobId VARCHAR,CREATED_BY_ID VARCHAR)";
    
    NSString *featureProductTable = @"CREATE TABLE FEATURE_PRODUCTS (ID INTEGER PRIMARY KEY,NAME VARCHAR,JSON VARCHAR,DESCRIPTION VARCHAR,ITEM_CODE VARCHAR,jobId VARCHAR,CREATED_BY_ID VARCHAR,Campaign_Jobs VARCHAR)";
    
    NSString *featureProductsJob = @"CREATE TABLE FEATURE_PRODUCTS_JOBS (ID INTEGER PRIMARY KEY,ITEM_CODE VARCHAR,CREATED_BY_ID VARCHAR,JOBTYPENAME VARCHAR,jobId VARCHAR,NAME VARCHAR,JSON VARCHAR,DESCRIPTION VARCHAR,PARENT_ID VARCHAR,Image_URL VARCHAR)";
    
    /*
     @property(strong, nonatomic) NSString* ID;
     @property (strong,nonatomic) NSString *Item_Code;
     @property(strong, nonatomic) NSString* createdBy;
     @property (strong,nonatomic) NSString* jobTypeName;
     @property (strong,nonatomic) NSString*jobID;
     @property(strong, nonatomic) NSString* Name;
     @property(strong, nonatomic) NSString* json;
     @property(strong, nonatomic) NSString* description_data;
     */
    
    
    NSArray *sqlQuery = [NSArray arrayWithObjects:calenderTable,keysTable,featureProductTable,featureProductsJob,nil];
    return sqlQuery;
    
}
-(void)dbFlush{
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSArray *contents = [fileManager contentsOfDirectoryAtPath:documentsDirectory error:NULL];
    NSEnumerator *e = [contents objectEnumerator];
    NSString *filename;
    while ((filename = [e nextObject])) {
        NSLog(@"file name %@",filename);
        [fileManager removeItemAtPath:[documentsDirectory stringByAppendingPathComponent:filename] error:NULL];
    }
    dataBaseManager = nil;
    
  /*  NSFileManager *fm = [NSFileManager defaultManager]; // file manager
    NSError *error;
    dataBaseManager = nil;
    BOOL success = [fm removeItemAtPath:_dataBasePath error:&error];
    if (success) {
        NSLog(@"DB Removed");
    }*/
}


- (void)deleteTheEntities{
    
    
    
    
}


@end
