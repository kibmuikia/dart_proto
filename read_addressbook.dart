import 'dart:io';

import 'addressbook.pb.dart';

// Iterates though all people in the AddressBook and prints info about them.
void printAddressBook(AddressBook addressBook) {
  for (Person person in addressBook.people) {
    print('Person ID: ${ person.id}');
    print('  Name: ${ person.name}');
    if (person.hasEmail()) {
      print('  E-mail address:${ person.email}');
    }

    for (Person_PhoneNumber phoneNumber in person.phones) {
      switch (phoneNumber.type) {
        case Person_PhoneType.PHONE_TYPE_MOBILE:
          print('   Mobile phone #: ');
          break;
        case Person_PhoneType.PHONE_TYPE_HOME:
          print('   Home phone #: ');
          break;
        case Person_PhoneType.PHONE_TYPE_WORK:
          print('   Work phone #: ');
          break;
        default:
          print('   Unknown phone #: ');
          break;
      }
      print(phoneNumber.number);
    }
  }
}

// Reads the entire address book from a file and prints all
// the information inside.
main(List arguments) {
  if (arguments.length != 1) {
    print('Usage: list_person ADDRESS_BOOK_FILE');
    exit(-1);
  }

  // Read the existing address book.
  File file = new File(arguments.first);
 AddressBook addressBook = new AddressBook.fromBuffer(file.readAsBytesSync());
  printAddressBook(addressBook);
}