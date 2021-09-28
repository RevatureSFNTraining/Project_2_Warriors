public class returnHome {
	public PageReference returnToHome() {
        PageReference p = new PageReference('/apex/LandingPage');
        p.getParameters().put('depot_id',System.currentPageReference().getParameters().get('depot_id'));
        p.setRedirect(true);
        return p;
    }
}