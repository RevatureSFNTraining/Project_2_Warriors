public class JobApplicationController {
    @AuraEnabled
    public static Job_Application__c saveApplicant (Job_Application__c applicant) {
        
        upsert applicant;
        return applicant;
    }
}