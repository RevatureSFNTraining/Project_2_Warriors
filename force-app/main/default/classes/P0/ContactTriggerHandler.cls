/*
 * ContactTriggerHandler
 * Author: Wayne He
 * Date Modified: 2021-09-01
 * Description: Helper class for handling Contact triggers.
 */

 public class ContactTriggerHandler {

    /*
     * Grabs a list of contacts, checks if each pass the legal age (21+) for renting out vehicles, and puts the result in a map.
     * Throws an error in Salesforce if one of the contacts is below the legal age.
     * @param  customers - A list of Contacts to be inserted/updated.
     * @return A map of customer IDs and a boolean that determines whether each customer is above the legal age.
     */
    public static Map<Id, boolean> verifyAges(List<Contact> customers) {
        Map<Id, boolean> customerLegalAgeCheckMap = new Map<Id, boolean>();

        //Check if the customers are above 21 years old.
        for (Contact customer : customers) {
            boolean isLegalAge = checkLegalAge(customer.Birthdate);
            if (!isLegalAge)
                customer.Birthdate.addError('Customer is not 21 years of age or above.');

            

            customerLegalAgeCheckMap.put(customer.Id, isLegalAge);
        }

        return customerLegalAgeCheckMap;
    }
    
    /*
     * Checks the database if any of its contacts' emails match the ones that are about to be inserted/updated.
     * Throws an error in Salesforce if a duplicate email already exists in the database.
     * @param customers - A list of Contacts to be inserted/updated.
     */
    public static void checkForDuplicateEmails(List<Contact> customers) {
        //Get E-mails from database and check for duplicates.
        List<Contact> customerDB = [SELECT Id, Email FROM Contact];
        for (Contact customerToEdit : customers) {
            for (Contact customerInDB: customerDB) {
                if (customerToEdit.Email.equals(customerInDB.Email))
                    customerToEdit.Email.addError('A contact with this e-mail already exists.');
            }
        }
    }

    /*
     * Helper method that checks a Contact's age by comparing his/her birth date to today's date.
     * @param birthDate - A Contact's birth date.
     * @return A boolean value that determines if the Contact has passed the legal age (21+) or not.
     */
    private static boolean checkLegalAge(Date birthDate) {
        Date today = Date.today();
        
        //Verify age by comparing year, month, and day.
        integer yearDifference = today.year() - birthDate.year();
        if (yearDifference < 21)
            return false;
        else if (yearDifference == 21) {
            //Check month next.
            integer monthDifference = today.month() - birthDate.month();
            if (monthDifference < 0)
                return false;
            else if (monthDifference == 0) {
                //Check day.
                integer dayDifference = today.day() - birthDate.day();
                if (dayDifference < 0)
                    return false;
            }
        }

        return true;
    }
}