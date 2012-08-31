/**
 **************************************************************************
 **                              QCard                                   **
 **************************************************************************
 * @package     app                                                      **
 * @subpackage  N/A                                                      **
 * @name        QCard                                                    **
 * @copyright   oohoo.biz                                                **
 * @link        http://oohoo.biz                                         **
 * @author      Theodore Pham                                            **
 * @license     http://www.gnu.org/copyleft/gpl.html GNU GPL v3 or later **
 **************************************************************************
 **************************************************************************/

#import "SettingViewController.h"
#import "Singleton.h"
#import "sqlite3.h"
#import "AuthenticateViewController.h"


@interface NSURLRequest (DummyInterface)
+ (BOOL)allowsAnyHTTPSCertificateForHost:(NSString*)host;
+ (void)setAllowsAnyHTTPSCertificate:(BOOL)allow forHost:(NSString*)host;
@end

@interface SettingViewController ()

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    Singleton *global = [Singleton globalVar];

    NSArray *keys = [global.courseName allKeys];
    id key, value;
    
	for(NSString *key in keys){
        NSLog(@"%@ is %@", key, [global.courseName objectForKey:key]);
        NSLog(@"BreaK");
    }

    //Initialize and allocate memory for array
    listOfItems = [[NSMutableArray alloc] init];

    for (int i=0; i < [global.courseName count]; i++){
        
        key = [keys objectAtIndex: i];
        value = [global.courseName objectForKey: key];
        
        //Allocates memory for array and then adds all the files
        NSMutableArray *courseFiles = [[NSMutableArray alloc] init ];
        for(int j=0; j < [value count]; j++){
            [courseFiles addObject:[value objectAtIndex:j]];
        }
                
        NSDictionary *courseHeaders = [NSDictionary dictionaryWithObject:courseFiles forKey:@"CourseFiles"];
        [listOfItems addObject:courseHeaders];
        
        NSLog(@"Key: %@ for values: %@", key, value);
    }

	//Set the title
	self.navigationItem.title = @"CourseFiles";
}

/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}

#pragma mark Table view methods

/**
* This function retrieves the number of table sections
* Returns the number of sections in the table. (Courses)
**/
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSLog(@"Number of sections: %i", [listOfItems count]);
	return [listOfItems count];
}


/**
* This function counts the number of subsections and stores it in a 2-D associative array
* Returns the number of subsections under each section. (Files)
**/
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	
	//Number of rows it should expect should be based on the section
	NSDictionary *dictionary = [listOfItems objectAtIndex:section];
    NSArray *array = [dictionary objectForKey:@"CourseFiles"];
	return [array count];
}

/**
 * This function grabs the course name for each section
 * Returns the array keys which corresponds to the section titles
 **/
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    Singleton *global = [Singleton globalVar];

    //Grabs all the key in the array which corresponds to the course name
    NSArray *keys = [global.courseName allKeys];
    
    for(int i=0; i < [keys count]; i++){
        if (section == i){

            NSLog(@"Header %@", [keys objectAtIndex:i]);
            //return [global.courseName objectForKey:[[global.courseName allKeys] objectAtIndex:i]];
            return [keys objectAtIndex:i];

        }
    }
}

// Customize the appearance of table view cells.
/**
 * This function displays the file names under each course section
 * Returns the cell row
 **/
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Set up the cell...
	
	//First get the dictionary object
	NSDictionary *dictionary = [listOfItems objectAtIndex:indexPath.section];
	NSArray *array = [dictionary objectForKey:@"CourseFiles"];
	NSString *cellValue = [array objectAtIndex:indexPath.row];

    //Displays the file name for each subsection
    cell.textLabel.text = cellValue;
    
    //Image on the left of the cell
    cell.imageView.image = [UIImage imageNamed:@"blank.png"];
    
    return cell;
}

/**
 * This function downloads the user selected files for any course. The file name is passed
 * to a php file on the server which grabs the file content and relays that information back
 * to the app which stores it in a database and creates a database if it does not exist already.
 **/
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    //Grabs the stored default value of the server name
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString *serverName = [prefs stringForKey:@"server"];
    
    //Return value
    NSString *rval;
    
    //Grab row number
    int row = indexPath.row;
    NSLog(@"cell ROW: %d", row);
    
    //Grab name of cell
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    NSString *url_file = [NSString stringWithFormat:@"https://%@/moodle/mod/qcardloader/infoControl.php?filename=%@&request=app", serverName, cell.textLabel.text];

    NSURL *URL_file = [NSURL URLWithString:url_file];
        
    NSURLRequest *request = [NSURLRequest requestWithURL:URL_file];
    NSURLResponse *response;
    NSError *error = nil;
    
    //Bypass certificates for HTTPS pages
    [NSURLRequest setAllowsAnyHTTPSCertificate:YES forHost:[URL_file host]];
    NSData *file_content = [NSURLConnection sendSynchronousRequest:request
                                         returningResponse:&response error:&error];
    //Gives date and time and time zone
    NSDate *today = [NSDate date];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat: @"EEEE MMMM d, YYYY h:mm a, zzz"];
    
    NSString *courseName;
    NSString *fileContent;
    
    if(file_content){
        NSLog(@"FILE RETRIEVED!");
//        NSLog(@"%@", file_content);
        
        if(error){
            NSLog(@"Error while retrieving file");
            
        } else {
            //Contains the return value(file content) 
            rval = [[NSString alloc] initWithData: file_content encoding:NSUTF8StringEncoding];
            NSLog(@"Rval b4: %@", rval);

            NSArray *str = [rval componentsSeparatedByString:@"#"];
            NSEnumerator *enumz = [str objectEnumerator];
            
            //Stores the coursename
            courseName = [enumz nextObject];
            NSLog(@"----------%@",courseName);
            //Stores the contents of the file
            fileContent = [enumz nextObject];
            NSLog(@"----------%@",fileContent);
            
            
            //Checkmarks if user downloaded the file
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
            
            // Database variables
            NSString *databaseName;
            NSString *databasePath;
            
            // Setup some globals
            databaseName = @"test.db";
            NSFileManager *fileManager = [NSFileManager defaultManager];
            
            // Get the path to the documents directory and append the databaseName
            NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *documentsDir = [documentPaths objectAtIndex:0];
            databasePath = [documentsDir stringByAppendingPathComponent:databaseName];
            NSLog(@"DatabasePath: %@", databasePath);
            
            //Checks if file exists at this path
            BOOL exist = [fileManager fileExistsAtPath: databasePath];
            
            if(!exist){
                NSLog(@"DATABASE NOT WRITABLE");
                NSString *bundle_path = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"db"];
                //Copy path
                exist = [fileManager copyItemAtPath:bundle_path toPath:databasePath error:&error];
                if (!exist){
                    NSLog(@"FAILED!");
                } else {
                    NSLog(@"SUCCESSFULLY COPIED");
                }
            } else {
                NSLog(@"DATABASE WRITABLE");
            }
            
            sqlite3 *database;
            //Open the database
            int result = sqlite3_open([databasePath UTF8String], &database);
            NSLog(@"DB Result: %d", result);
            
            //Database failed to open or DNE
            if(result != SQLITE_OK){
                //Closes database
                sqlite3_close(database);
                
                NSLog(@"DATABASE FAILED TO OPEN: %@", [dateFormat stringFromDate: today]);
                
            //Successfully opened database
            } else {
                NSLog(@"Database successfully opened");
                
                char *errMsg;
                
                //Creates a table if it does not exist already
                const char *sql_stmt = "CREATE TABLE IF NOT EXISTS FILES (ID INTEGER PRIMARY KEY AUTOINCREMENT, COURSENAME TEXT, FILENAME TEXT, CONTENT TEXT, DOWNLOADED NUMERIC)";
                
                if (sqlite3_exec ( database, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK){
                    NSLog(@"Failed to create table");
                    
                } else {
                    
                    //Create record inserting string
                    NSString *insertSQL = [NSString stringWithFormat:@"INSERT INTO FILES(ID, COURSENAME, FILENAME, CONTENT, DOWNLOADED) VALUES ('%d', '%@', '%@', '%@', '%d')", NULL, courseName, cell.textLabel.text, fileContent, 1];
                    
                    const char *sql = [insertSQL UTF8String];
                    sqlite3_stmt *sqlStatement;
                    
                    //Creates the object and checks if it is ok
                    if (sqlite3_prepare_v2(database, sql, -1, &sqlStatement, NULL) != SQLITE_OK){
                        NSLog(@"Problem with prep  statement");
                        NSLog(@"%s", sqlite3_errmsg(database));
                        NSLog(@"%d", sqlite3_prepare_v2(database, sql, -1, &sqlStatement, NULL));

                    } else { 
                        //evaluates sql statement
                        if (sqlite3_step(sqlStatement) == SQLITE_DONE){
                            //deletes prepared statement(instance of object representing a single sql statment) to avoid resource leaks
                            sqlite3_finalize(sqlStatement);
                            //close database
                            sqlite3_close(database);
                            
                        }
                        
                        /*********************Testing data retrieval
                        **********************/
                         
                        const char *dbpath = [databasePath UTF8String];
                        sqlite3_stmt *statement;
                        if (sqlite3_open(dbpath, &database) == SQLITE_OK)
                        {
                            //Grabs the file content from selected file
                            NSString *querySQL = [NSString stringWithFormat: @"SELECT content FROM files WHERE filename=\"%@\"",     cell.textLabel.text];
                            
                            const char *query_stmt = [querySQL UTF8String];
                            
                            if (sqlite3_prepare_v2(database, query_stmt, -1, &statement, NULL) == SQLITE_OK)
                            {
                                if (sqlite3_step(statement) == SQLITE_ROW)
                                {
                                    NSString *addressField = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
                                    //address.text = addressField;
                                    
    //                                NSString *phoneField = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)];
                                    //phone.text = phoneField;
    //                                self.addressLabel.text = [NSString stringWithFormat:@"Address is %@ and Contact Number is %@", addressField, phoneField];
    //                                status.text = @"Match found";
                                    NSLog(@"PROBABILITY 1000");
    //                                NSLog([NSString stringWithFormat:@"Address is %@ and Contact Number is %@", addressField, phoneField]);
                                    
                                    UIAlertView *alert1 = [[UIAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:@"Address is %@ and Contact Number is %@", addressField]delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                                    [alert1 show];
                                    
                                } else {
    //                                status.text = @"Match not found";

                                }
                                sqlite3_finalize(statement);
                            }
                            sqlite3_close(database);
                        }
                        /**********************
                        *********************//*END TEST*/
                    }
                }
            }//end else
        }
    //Files were not retrieved
    } else {
        NSLog(@"NOT RETRIEVED!");

        cell.accessoryType = UITableViewCellAccessoryNone;
        
    }
    //Animates the delselecting of a row after it is selected
    [tableView deselectRowAtIndexPath: indexPath animated:YES];
    
}

/**
* Displays the files for each course in a table format.
**/
- (void)tableView:(UITableView*)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //Image on the right side of the cell, can be customized to represent downloaded and not downloaded yet***
    
//    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//    cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
//    //Using checkmark
//    cell.accessoryType = UITableViewCellAccessoryCheckmark;
//    cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"speaker.png"]];
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}


@end
