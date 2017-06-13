public class DynamicSoqlWrapper {
	private String baseQuery;
	private Set<String> fieldSet;
	private String sobjectApiName;
	private Map<String, List<String>> whereConditionsMap;
	private String compiledSoql;

	public DynamicSoqlWrapper(String objectName) {
		this.baseQuery = 'SELECT ';
		this.fieldSet = new Set<String> {'Id'};
		this.whereConditionsMap = new Map<String, List<String>>();
		this.sobjectApiName = objectName;
	}

	public DynamicSoqlWrapper setField(String field) {
		this.fieldSet.add(field);
		return this;
	}

	public DynamicSoqlWrapper setListOfFields(List<String> fieldSet) {
		this.fieldSet.addAll(fieldSet);
		return this;
	}

	public DynamicSoqlWrapper setWhereCondition(String whereCondition, List<String> collection) {

		if (collection != null && ! collection.isEmpty()) {
			if ( ! whereCondition.contains(':variable')) {
				String message = 'Where condition should contains exact the follow: \':variable\', when you use collection as filter. ';
				message += 'Please, change name of variable in string condition';
				throw new DynamicSoqlWrapperException(message);
			}
		}

		if (this.whereConditionsMap.containsKey(whereCondition)) {
			this.whereConditionsMap.get(whereCondition).addAll(collection);
		} else {
			this.whereConditionsMap.put(whereCondition, collection);
		}

		return this;
	}

	public String getSobjectName() {
		return this.sobjectApiName;
	}

	public String getBaseQuery() {
		return this.baseQuery;
	}

	public Set<String> getFieldSet() {
		return this.fieldSet;
	}

	public Map<String, List<String>> getWhereConditions() {
		return this.whereConditionsMap;
	}

	public DynamicSoqlResult executeSoql() {
		DynamicSoqlSelector selector = new DynamicSoqlSelector(this);
		return selector.buildSoqlString().execute();
	}

	public class DynamicSoqlWrapperException extends Exception {}
}