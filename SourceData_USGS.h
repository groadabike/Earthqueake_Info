//----------------------------------------------------------------------------
//
//  SourceData_USGS.h
//  UnderMyFeet
//
//  Created by Luisa Z. and Gerardo R.
//
//  This class is an implementation of the abstract class SourceData_Abstract.
//  The sourceData is the database of USGS - U.S. Geological Survey.
//  For more info about the webservice of this source go to
//  http://earthquake.usgs.gov/fdsnws/event/1/
//
//  The overwrited method "searchData" request data to USGS and save it into "receivedData" atribute.
//  The overwrited method "saveData" take the data into "reciebedData" and save it into the events table of
//  UnderMyFeet.sql Database.
//
//  Description of the data from dictionary [Features : propierties] from Json - USGS
//
//  field:      |Original type   |SQLite type in Database
//  -----       |-------------   |-----------------------
//  mag:        |Decimal         |DOUBLE
//  place:      |String          |VARCHAR
//  time:       |Long Integer    |VARCHAR
//  updated:    |Long Integer    |VARCHAR
//  tz:         |Integer         |----------
//  url:        |String          |VARCHAR
//  detail:     |String          |----------
//  felt:       |Integer         |----------
//  cdi:        |Decimal         |----------
//  mmi:        |Decimal         |----------
//  alert:      |String          |----------
//  status:     |String          |----------
//  tsunami:    |Integer         |----------
//  sig:        |Integer         |----------
//  net:        |String          |VARCHAR
//  code:       |String          |----------
//  ids:        |String          |----------
//  sources:    |String          |----------
//  types:      |String          |----------
//  nst:        |Integer         |INTEGER
//  dmin:       |Decimal         |DOUBLE
//  rms:        |Decimal         |DOUBLE
//  gap:        |Decimal         |DOUBLE
//  magType:    |String          |VARCHAR
//  type:       |String          |VARCHAR
//
//  Description of the data from array [Features : geometry : coordinates] from Json - USGS
//
//  field       |SQLite type in Database
//  -----       |-----------------------
//  longitude   |DOUBLE
//  latitude    |DOUBLE
//  depth       |DOUBLE
//
//  Description of the data from [Features : id] from Json - USGS
//
//  field       |SQLite type in Database
//  -----       |-----------------------
//  id          |VARCHAR
//
//----------------------------------------------------------------------------

#import <Foundation/Foundation.h>
#import "SourceData_Abstract.h"
#import "EarthquakeEvent.h"


@interface SourceData_USGS : SourceData_Abstract





@end