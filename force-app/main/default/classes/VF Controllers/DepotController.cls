public class DepotController {

    static final Integer MAX_ENTRIES_PER_PAGE = 10;
    
    public List<Account> accounts {get; private set;}
    public List<Depot__c> depots {get; private set;}
    
    public String accountId {get; set;}
    public String pageNumber {get; set;}

    public String nameFilter {get; set;}
    public String locationFilter {get; set;}
    
    public DepotController() {
        accounts = [SELECT Id, Name FROM Account];
        filterDepots();
    }
    
    public List<SelectOption> getAccountItems() {
        List<SelectOption> items = new List<SelectOption>();
        for (Account acc : accounts) {
            items.add(new SelectOption(acc.Id, acc.Name));
        }
        accountId = items[0].getValue();
        return items;
    }
    
    public Integer getFirstIndex() {
        return (Integer.valueOf(pageNumber) - 1) * MAX_ENTRIES_PER_PAGE;
    }
    
    public Integer getNumEntriesPerPage() {
        return MAX_ENTRIES_PER_PAGE;
    }
    
    public List<SelectOption> getPageNumbers() {
        List<SelectOption> pages = new List<SelectOption>();
        Integer totalPages = (Integer) Math.ceil((Decimal) depots.size() / MAX_ENTRIES_PER_PAGE);
        Integer i = 1;
        do {
            pages.add(new SelectOption(String.valueOf(i), String.valueOf(i)));
            i++;
        } while (i <= totalPages);
        return pages;
    }
    
    public void filterDepots() {
        String soqlNameFilter = '%' + nameFilter + '%';
        String soqlLocationFilter = '%' + locationFilter + '%';

        depots = [SELECT Id, Name, Owner__r.Name, Depot_Manager__c, Address__c, Primary_Phone__c FROM Depot__c
            WHERE Owner__c = :accountId AND Name LIKE :soqlNameFilter AND Address__c LIKE :soqlLocationFilter ORDER BY Name];

        //Reset page number and filter details after refreshing depot list with new data.
        pageNumber = '1';
    }

    public void resetFilters() {
        nameFilter = '';
        locationFilter = '';
        filterDepots();
    }

    public PageReference selectDepot() {
        PageReference pf = new PageReference('/apex/LandingPage');
        pf.getParameters().put('depot_id', System.currentPageReference().getParameters().get('depot_id'));
        return pf;
    }
}