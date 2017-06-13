public class OpportunityHandlerService {

	// instances of the records came in a trigger
	public List<Opportunity> newOpportunityList;
	public List<Opportunity> oldOpportunityList;
	public Map<Id, Opportunity> newOpportunityMap;
	public Map<Id, Opportunity> oldOpportunityMap;

	// another handlers??
	public PsaOpportunityHandlerService psaOpportunityHandlerService;

	public SoqlMapsByStage soqlMapsByStage;

	// variables for soql

	public OpportunityHandlerService(List<Opportunity> newList,
	                                 Map<Id, Opportunity> newMap,
	                                 List<Opportunity> oldList, Map<Id,
	                                 Opportunity> oldMap) {

		this.newOpportunityList = newList;
		this.newOpportunityMap = newMap;
		this.oldOpportunityList = oldList;
		this.oldOpportunityMap = oldMap;

		this.soqlMapsByStage = new SoqlMapsByStage();

		// add initialization of your handlers here
		this.psaOpportunityHandlerService = new PsaOpportunityHandlerService();
	}


	public void handleBulkBefore() {

		// stage 1
		// this.psaOpportunityHandlerService.collectInformationForStage1();

	}

	public void handlerBeforeInsert(Opportunity newOpportunity) {

	}

	public void handlerBeforeUpdate(Opportunity oldOpportunity, Opportunity newOpportunity) {

	}

	public void handlerBeforeDelete(Opportunity oldOpportunity) {

	}


	public void handleBulkAfter() {

	}

	public void handlerAfterInsert(Opportunity newOpportunity) {

	}

	public void handlerAfterUpdate(Opportunity oldOpportunity, Opportunity newOpportunity) {

	}

	public void handlerAfterDelete(Opportunity oldOpportunity) {

	}


	//
	// final dml method. Do dml after all handlers here
	//
	public void finalDML() {

	}


	public class SoqlMapsByStage {
		private Map<Integer, Map<String, DynamicSoqlWrapper>> stagetoSoqlMap;

		public SoqlMapsByStage() {
			this.stagetoSoqlMap = new Map<Integer, Map<String, DynamicSoqlWrapper>>();
		}

		public SoqlMapsByStage setNewDynamicSoqlWrapper(DynamicSoqlWrapper dynamicSoqlWrapper, Integer stage) {
			if (dynamicSoqlWrapper == null) {
				return this;
			}

			String sobjectName = dynamicSoqlWrapper.getSobjectName();
			if (this.stagetoSoqlMap.get(stage) != null && this.stagetoSoqlMap.get(stage).containsKey(sobjectName)) {
				String message = 'Passed new dynamic soql wrapper already exists in wrapper map. Please add your information in existing object DynamicSoqlWrapper object';
				throw new OpportunityHandlerService.OpportunityHandlerServiceException(message);
			}

			Map<String, DynamicSoqlWrapper> dynamicSoqlWrapperMap = new Map<String, DynamicSoqlWrapper>();
			dynamicSoqlWrapperMap.put(sobjectName, dynamicSoqlWrapper);
			this.stagetoSoqlMap.put(stage, dynamicSoqlWrapperMap);

			return this;
		}

		public DynamicSoqlWrapper getDynamicSoqlWrapper(String objectName, Integer stage) {
			if (objectName == null || Type.forName(objectName) == null) {
				String message = 'Object name null or incorrect';
				throw new OpportunityHandlerService.OpportunityHandlerServiceException(message);
			}

			if (stage == null) {
				String message = 'Stage number should not be null';
				throw new OpportunityHandlerService.OpportunityHandlerServiceException(message);
			}

			if (this.stagetoSoqlMap.get(stage) == null || ! this.stagetoSoqlMap.get(stage).containsKey(objectName)) {
				DynamicSoqlWrapper dynamicSoqlWrapper = new DynamicSoqlWrapper(objectName);
				Map<String, DynamicSoqlWrapper> dynamicSoqlWrapperMap = new Map<String, DynamicSoqlWrapper>();
				dynamicSoqlWrapperMap.put(objectName, dynamicSoqlWrapper);
				this.stagetoSoqlMap.put(stage, dynamicSoqlWrapperMap);
				return dynamicSoqlWrapper;
			} else {
				return this.stagetoSoqlMap.get(stage).get(objectName);
			}
		}
	}

	public class OpportunityHandlerServiceException extends Exception {}
}