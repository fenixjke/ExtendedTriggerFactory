public class OpportunityHandler implements ITrigger {
	OpportunityHandlerService opportunityService = new OpportunityHandlerService(
	  (List<Opportunity>)Trigger.new,
	  (Map<Id, Opportunity>)Trigger.newMap,
	  (List<Opportunity>)Trigger.old,
	  (Map<Id, Opportunity>)Trigger.oldMap
	);

	// all before handlers
	public void bulkBefore() {
		this.opportunityService.handleBulkBefore();
	}
	public void beforeInsert(SObject so) {
		Opportunity newOpportunity = (Opportunity)so;
		this.opportunityService.handlerBeforeInsert(newOpportunity);
	}

	public void beforeUpdate(SObject oldSo, SObject so) {
		Opportunity oldOpportunity = (Opportunity)oldSo;
		Opportunity newOpportunity = (Opportunity)so;
		this.opportunityService.handlerBeforeUpdate(oldOpportunity, newOpportunity);
	}
	public void beforeDelete(SObject so) {
		Opportunity oldOpportunity = (Opportunity)so;
		this.opportunityService.handlerBeforeDelete(oldOpportunity);
	}


	// all after handlers
	public void bulkAfter() {
		this.opportunityService.handleBulkAfter();
	}

	public void afterInsert(SObject so) {
		Opportunity newOpportunity = (Opportunity)so;
		this.opportunityService.handlerAfterInsert(newOpportunity);
	}

	public void afterUpdate(SObject oldSo, SObject so) {
		Opportunity oldOpportunity = (Opportunity)oldSo;
		Opportunity newOpportunity = (Opportunity)so;
		this.opportunityService.handlerAfterUpdate(oldOpportunity, newOpportunity);
	}

	public void afterDelete(SObject oldSo) {
		Opportunity oldOpportunity = (Opportunity)oldSo;
		this.opportunityService.handlerAfterDelete(oldOpportunity);
	}


	// final operations
	public void andFinally() {
		this.opportunityService.finalDML();
	}
}