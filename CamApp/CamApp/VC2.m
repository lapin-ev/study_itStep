//
//  VC2.m
//  CamApp
//
//  Created by student on 22.08.15.
//  Copyright (c) 2015 student. All rights reserved.
//

#import "VC2.h"

@interface VC2 ()

@end

NSMutableArray *contactsData;

@implementation VC2

- (void)viewDidLoad {
    [super viewDidLoad];
    contactsData = [NSMutableArray new];

    UIBarButtonItem *item3 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self
                                                                         action:@selector(addContactController:)];
    
    [self.navigationItem setRightBarButtonItems:@[item3]];
    

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return contactsData.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *cellIdentifier = @"ContactCell";

    
    ContactCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[ContactCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier] ;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    MyContactData *item = [contactsData objectAtIndex:indexPath.row];
    cell.firstName.text = item.firstName;
    cell.lastName.text = item.LastName;
    cell.phoneNumber.text = item.phoneNumber;
    cell.email.text = item.eMail;

    cell.ContactPhoto.image = item.ContactPhoto;

    
    /* Now that the cell is configured we return it to the table view so that it can display it */
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"Address book";
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(void) viewDidAppear:(BOOL)animated {
    
    ABAddressBookRef addressBook = [self createAdressBook];
    if (!addressBook) {
        NSLog(@"Access to AB denided");
    }
    else{
        
        CFArrayRef allPeople = ABAddressBookCopyArrayOfAllPeople(addressBook);
        if (allPeople) {
            for (int index=0; index<CFArrayGetCount(allPeople); index++){
                ABRecordRef thisPerson = CFArrayGetValueAtIndex(allPeople, index);
                
                NSString *firstName = (__bridge NSString *)ABRecordCopyValue(thisPerson,
                                                                             kABPersonFirstNameProperty);
                NSString *lastName = (__bridge NSString *)ABRecordCopyValue(thisPerson,
                                                                            kABPersonLastNameProperty);
                
                ABMultiValueRef emailMultiValue = ABRecordCopyValue(thisPerson, kABPersonEmailProperty);
                NSArray *emailAddresses = (__bridge NSArray *)ABMultiValueCopyArrayOfAllValues(emailMultiValue);
                
                ABMultiValueRef phones = (ABMultiValueRef)ABRecordCopyValue(thisPerson, kABPersonPhoneProperty);
                
                NSArray *arrPhotn = (__bridge_transfer NSArray *)ABMultiValueCopyArrayOfAllValues(phones);
                
//                for (int i = 0; i < arrPhotn.count; i++) {
//                    NSLog(@"%@ - %@", (__bridge NSString *)ABMultiValueCopyLabelAtIndex(phones, i), [arrPhotn objectAtIndex:i]);
//                }
                NSData  *imgData = (__bridge NSData *)ABPersonCopyImageData(thisPerson);
                
                UIImage  *img = [UIImage imageWithData:imgData];
                
                MyContactData * contact = [MyContactData new];
                contact.firstName = firstName;
                contact.LastName = lastName;
                contact.eMail = [emailAddresses objectAtIndex:0];
                contact.phoneNumber = [arrPhotn objectAtIndex:0];
                contact.ContactPhoto = img;
                
                [contactsData addObject:contact];
                
                
                CFRelease(emailMultiValue);
            }
            CFRelease(allPeople);
        }
    }
    [self.contactList reloadData];
    
}

- (ABAddressBookRef)createAdressBook {
    ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(nil, nil);
    
    __block BOOL accessGranted = NO;
    
    if (&ABAddressBookRequestAccessWithCompletion != NULL) { // we're on iOS 6
        dispatch_semaphore_t sema = dispatch_semaphore_create(0);
        
        ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error) {
            accessGranted = granted;
            dispatch_semaphore_signal(sema);
        });
        
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
    }
    else { // we're on iOS 5 or older
        accessGranted = YES;
    }
    if (accessGranted) {
        return addressBook;
    } else {
        return nil;
    }
}

-(IBAction) addContactController : (id) sender {
    [self.navigationController pushViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"AddContactViewController"] animated:YES];
    
}

- (IBAction)addPerson {
    ABAddressBookRef addressBook = ABAddressBookCreate();
    if (addressBook) {
        NSString *firstName = @"Peter";
        NSString *lastName = @"Vasilievich";
        NSString *phone = @"0931969695";
        
        ABRecordRef person = ABPersonCreate();
        if (!person) {
            NSLog(@"Не удалось создать новую запись");
            return;
        }
        
        CFErrorRef error = nil;
        
        BOOL couldSetFirstName = ABRecordSetValue(person,
                                                  kABPersonFirstNameProperty,
                                                  (__bridge CFStringRef)firstName,
                                                  &error);
        BOOL couldSetLastName = ABRecordSetValue(person,
                                                 kABPersonLastNameProperty,
                                                 (__bridge CFStringRef)lastName,
                                                 &error);
        
        ABMutableMultiValueRef phones = ABMultiValueCreateMutable(kABMultiStringPropertyType);
        ABMultiValueAddValueAndLabel(phones,
                                     (__bridge CFStringRef)phone,
                                     kABPersonPhoneMobileLabel,
                                     NULL);
        BOOL couldSetPhoneNumber = ABRecordSetValue(person,
                                                    kABPersonPhoneProperty,
                                                    phones,
                                                    &error);
        CFRelease(phones);
        
        if (couldSetFirstName && couldSetLastName && couldSetPhoneNumber) {
            NSLog(@"Удалось установить все данные");
        }
        
        if (ABAddressBookAddRecord(addressBook, person, &error)) {
            NSLog(@"Запись добавлена в адресную книгу");
        }
        
        [self saveAddressBook:addressBook];
        CFRelease(addressBook);
    }
}

- (IBAction)removePerson {
    ABAddressBookRef addressBook = ABAddressBookCreate();
    if (addressBook) {
        CFArrayRef allPeople = ABAddressBookCopyArrayOfAllPeople(addressBook);
        if (allPeople) {
            for (int index=0; index<CFArrayGetCount(allPeople); index++){
                ABRecordRef thisPerson = CFArrayGetValueAtIndex(allPeople, index);
                NSString *firstName = (__bridge NSString *)ABRecordCopyValue(thisPerson,
                                                                             kABPersonFirstNameProperty);
                
                if ([firstName isEqualToString:@"Peter"]) {
                    CFErrorRef error = nil;
                    if (ABAddressBookRemoveRecord(addressBook, thisPerson, &error)) {
                        NSLog(@"Запись удалена");
                    }
                }
            }
            CFRelease(allPeople);
        }
        
        [self saveAddressBook:addressBook];
        CFRelease(addressBook);
    }
}

- (void)saveAddressBook:(ABAddressBookRef)addressBook {
    if (ABAddressBookHasUnsavedChanges(addressBook)) {
        CFErrorRef error = nil;
        if (ABAddressBookSave(addressBook, &error)){
            NSLog(@"Адресная книга сохранена");
        } else {
            NSLog(@"Не удалось сохранить адресную книгу");
        }
    }
}

@end
