public class DynamicSoqlResult {
	public String objectApiName;
	public Map<Id, Sobject> sobjectMap;

	public DynamicSoqlResult(String objectApiName, List<Sobject> sobjectList) {
		this.objectApiName = objectApiName;
		this.sobjectMap = new Map<Id, Sobject>();
		for (Sobject obj : sobjectList) {
			this.sobjectMap.put((Id)obj.get('Id'), obj);
		}
	}
}