#ifndef COMMON_CONSTANTS
#define COMMON_CONSTANTS

typedef enum
{
    DATA_TYPE_JSON,
    DATA_TYPE_BINARY
}ONGO_DATA_TYPE;

typedef enum
{
    DOWNLOAD_STATUS_FAILED,
    DOWNLOAD_STATUS_SUCCESS
}ONGO_DOWNLOAD_STATUS;

@class OnGoDownloadData;

typedef void(^OnGoDownloadBlock)(OnGoDownloadData* downloadedData);

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

extern NSString* const OGGetMallInfoURL;

#endif