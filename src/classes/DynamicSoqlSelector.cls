public class DynamicSoqlSelector {

	private DynamicSoqlWrapper wrapper;
	private String compiledQuery;
	private String sobjectApiName;

	public DynamicSoqlSelector(DynamicSoqlWrapper wrapper) {
		this.wrapper = wrapper;
	}

	public DynamicSoqlSelector buildSoqlString() {
		compiledQuery = this.wrapper.getBaseQuery();
		for (String field : this.wrapper.getFieldSet()) {
			this.compiledQuery += field + ',';
		}

		// TO DO ADD SUBQUERY

		this.compiledQuery = this.compiledQuery.removeEnd(',');
		this.sobjectApiName = this.wrapper.getSobjectName();
		this.compiledQuery += ' FROM ' + this.sobjectApiName;
		Map<String, List<String>> whereConditionsMap = this.wrapper.getWhereConditions();
		if ( ! whereConditionsMap.isEmpty()) {
			this.compiledQuery += ' WHERE ';
		}
		Integer variablesCount = 0;
		for (String condition : whereConditionsMap.keySet()) {
			if (String.isNotBlank(condition)) {
				if (whereConditionsMap.get(condition) == null || whereConditionsMap.get(condition).isEmpty()) {
					this.compiledQuery += '(' + condition + ') OR ';
				} else {
					this.variableMap.get(variablesCount).addAll(whereConditionsMap.get(condition));
					condition = condition.replace(':variable', (':v' + variablesCount));
					this.compiledQuery += '(' + condition + ') OR ';
					variablesCount++;
					if (variablesCount == 20) {
						// TO DO
						System.debug(LoggingLevel.INFO, '*** variablesCount exceeded: ' + variablesCount);
						break;
					}
				}
			}
		}

		this.compiledQuery = this.compiledQuery.removeEnd(' OR ');
		System.debug(LoggingLevel.INFO, '*** this.compiledQuery: ' + this.compiledQuery);
		return this;
	}

	public DynamicSoqlResult execute() {
		List<Sobject> sobjectList = Database.query(this.compiledQuery);
		DynamicSoqlResult result = new DynamicSoqlResult(this.sobjectApiName, sobjectList);
		return result;
	}

	private List<String> v0 = new List<String>();
	private List<String> v1 = new List<String>();
	private List<String> v2 = new List<String>();
	private List<String> v3 = new List<String>();
	private List<String> v4 = new List<String>();
	private List<String> v5 = new List<String>();
	private List<String> v6 = new List<String>();
	private List<String> v7 = new List<String>();
	private List<String> v8 = new List<String>();
	private List<String> v9 = new List<String>();
	private List<String> v10 = new List<String>();
	private List<String> v11 = new List<String>();
	private List<String> v12 = new List<String>();
	private List<String> v13 = new List<String>();
	private List<String> v14 = new List<String>();
	private List<String> v15 = new List<String>();
	private List<String> v16 = new List<String>();
	private List<String> v17 = new List<String>();
	private List<String> v18 = new List<String>();
	private List<String> v19 = new List<String>();
	private Map<Integer, List<String>> variableMap = new Map<Integer, List<String>> {
		0 => v0,
		1 => v1,
		2 => v2,
		3 => v3,
		4 => v4,
		5 => v5,
		6 => v6,
		7 => v7,
		8 => v8,
		9 => v9,
		10 => v10,
		11 => v11,
		12 => v12,
		13 => v13,
		14 => v14,
		15 => v15,
		16 => v16,
		17 => v17,
		18 => v18,
		19 => v19
	};
}