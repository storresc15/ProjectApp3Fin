public class FSC_FlightsRecordWrapper {
    	@AuraEnabled
        public String flightCode {get;set;} 
    	@AuraEnabled
        public String fromAirportCode {get;set;}
    	@AuraEnabled
        public String toAirportCode {get;set;}
    	@AuraEnabled
        public String departureDate {get;set;}
    	@AuraEnabled
        public Integer emptySeats {get;set;}
    	@AuraEnabled
        public Integer totalSeats {get;set;}
    	@AuraEnabled
        public Integer price {get;set;}
    	@AuraEnabled
        public String planeType {get;set;}
    	@AuraEnabled
        public String airline {get;set;}
        
        public FSC_FlightsRecordWrapper(JSONParser parser) {
		while (parser.nextToken() != System.JSONToken.END_OBJECT) {
			if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
				String text = parser.getText();
				if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
					if (text == 'flightCode') {
						flightCode = parser.getText();
					} else if (text == 'fromAirportCode') {
						fromAirportCode = parser.getText();
					} else if (text == 'toAirportCode') {
						toAirportCode = parser.getText();
					} else if (text == 'departureDate') {
						departureDate = parser.getText();
					} else if (text == 'emptySeats') {
						emptySeats = parser.getIntegerValue();
					} else if (text == 'totalSeats') {
						totalSeats = parser.getIntegerValue();
					} else if (text == 'price') {
						price = parser.getIntegerValue();
					} else if (text == 'planeType') {
						planeType = parser.getText();
					} else if (text == 'airline') {
						airline = parser.getText();
					} else {
						System.debug(LoggingLevel.WARN, 'JSON2Apex consuming unrecognized property: '+text);
						consumeObject(parser);
					}
				}
			}
		}
	}
	
	
	public static FSC_FlightsRecordWrapper parse(String json) {
		System.JSONParser parser = System.JSON.createParser(json);
		return new FSC_FlightsRecordWrapper(parser);
	}
    
    public static void consumeObject(System.JSONParser parser) {
		Integer depth = 0;
		do {
			System.JSONToken curr = parser.getCurrentToken();
			if (curr == System.JSONToken.START_OBJECT || 
				curr == System.JSONToken.START_ARRAY) {
				depth++;
			} else if (curr == System.JSONToken.END_OBJECT ||
				curr == System.JSONToken.END_ARRAY) {
				depth--;
			}
		} while (depth > 0 && parser.nextToken() != null);
	}
    }