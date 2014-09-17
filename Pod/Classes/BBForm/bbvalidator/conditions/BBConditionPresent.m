

#import "BBConditionPresent.h"
#import "BBTextInputFormElement.h"
#import "BBDatePickerFormElement.h"
#import "BBListPickerFormElement.h"
#import "BBMultiSelectListFormElement.h"

@implementation BBConditionPresent

- (BOOL)check:(BBFormElement *)element;
{
    if ([element isKindOfClass:[BBTextInputFormElement class]])
    {
        NSString *string = ((BBTextInputFormElement*)element).value;
    
        if(!string)
        {
            return NO;
        }
        return string.length > 0 ? YES : NO;
    }
    else if  ([element isKindOfClass:[BBDatePickerFormElement class]])
    {
        NSDate *date = ((BBDatePickerFormElement*)element).date;
        
        if(date != nil)
        {
            return YES;
        }        
    }
    else if  ([element isKindOfClass:[BBListPickerFormElement class]])
    {
        NSInteger index = ((BBListPickerFormElement*)element).index;
        NSString *string =((BBListPickerFormElement*)element).values[index];
        
        if(!string)
        {
            return NO;
        }
        return string.length > 0 ? YES : NO;
    }
    else if  ([element isKindOfClass:[BBMultiSelectListFormElement class]])
    {
        NSArray *selected = ((BBMultiSelectListFormElement*)element).indexPathsForSelectedRows;
        return (selected.count >0) ? YES : NO;
    }
    return NO;
}


#pragma mark - Localization

- (NSString *)createLocalizedViolationString
{
    return BBLocalizedString(@"BBKeyConditionViolationPresent", nil);
}

@end
