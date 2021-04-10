public class API_AuthorizeDotNet {
  //variables to hold our login credentials
  public static string APILOGIN; 
  public static string APITRANSKEY;
  
    public static void getAuthNetCreds(){
    //get api login setting value
    //test condition to generate test key during test methods
    Authorize_net_Setting__c apiloginsetting =   Authorize_net_Setting__c.getInstance('API Login');
    //get transaction key seting value
    //test condition to generate test key during test methods
    Authorize_net_Setting__c apitranskeysetting =   Authorize_net_Setting__c.getInstance('TransKey');
    APILOGIN = apiloginsetting.value__c;
    APITRANSKEY = apitranskeysetting.value__c;
  }
  public static authnetresp_wrapper authdotnetCharge (authnetreq_wrapper input) {
    //reusable method for getting Authorize.net credentials
    getAuthNetCreds();

    //Construct the request
    HttpRequest req = new HttpRequest();
    //for testing use the test endpoint
    //otherwise use
    //https://secure.authorize.net/gateway/transact.dll
       req.setEndpoint('https://test.authorize.net/gateway/transact.dll'); 
       req.setMethod('POST');
    
    //build message
    Map<string,string> messagestring = new map<String,String>();
    
    //Default Fields
    //See the authorize.net documentation
    //for more information
    messagestring.put('x_login',APILOGIN);
    messagestring.put('x_tran_key',APITRANSKEY);  
    messagestring.put('x_version', '3.1');
    messagestring.put('x_delim_data', 'TRUE');
    //specify delimiter character for response
    messagestring.put('x_delim_char', ';');
    messagestring.put('x_relay_response', 'FALSE');  
    //The type of transaction
    messagestring.put('x_type', 'AUTH_CAPTURE');
    //Processing credit card
    messagestring.put('x_method', 'CC');
      
    //Transaction Specific Information
    //card numbers, expiration, security codes
    messagestring.put('x_card_num', input.ccnum);
    messagestring.put('x_exp_date', input.ccexp);
    messagestring.put('x_card_code', input.ccsec);
    
    //transaction amount
    messagestring.put('x_amount', input.amt);
    //description of transaction
    messagestring.put('x_description', 'Your Transaction: '+input.ordername);
    
    //billing information
    messagestring.put('x_first_name', input.firstname);
    messagestring.put('x_last_name', input.lastname);
    messagestring.put('x_address', input.billstreet);
    messagestring.put('x_city', input.billcity);
    messagestring.put('x_state', input.billstate);
    messagestring.put('x_zip', input.billzip);
    
    //encode the message components
    String encodedmsg = '';
    for (string s : messagestring.keySet()){
      string v = messagestring.get(s);
      //fix null values
      if (string.isblank(v)) v='';
          encodedmsg += s+'='+EncodingUtil.urlEncode(v, 'UTF-8')+'&';
          //debug message value being added
          system.debug('TRACE: message bit '+s+' added');
    }  
    //add message termination
    encodedmsg += 'endofdata';
    system.debug('TRACE: Encoded Message: \n\n' + encodedmsg);

    //set the body of the httprequest
    req.setBody(encodedmsg);
    
    //send and collect response
    Http http = new Http();
     string resp = http.send(req).getbody();
     //debug response
     system.debug('This is the response message to be tracked!!' + resp);
     //split response by our delimiter
       list<string> responses = resp.split(';');

       //use parsing methodto return response wrapper
    authnetresp_wrapper parsedResponse = parseIntoResponseWrapper(responses);

    //debug response wrapper
    system.debug(parsedResponse);
    return parsedResponse;
  } 
    
  

  /**
  * Method to parse split response into wrapper
  **/
  public static authNetResp_Wrapper parseIntoResponseWrapper(list<string> input){
    authNetResp_Wrapper temp = new authNetResp_Wrapper();
    temp.responseCode = input[0];
    temp.ResponseSubcode = input[1];
    temp.ResponseReasonCode =input[2];
    temp.ResponseReasonText=input[3];
    temp.AuthorizationCode=input[4];
    temp.AVSResponse= input[5];
    temp.TransactionID=input[6];
    temp.InvoiceNumber= input[7];
    temp.Description= input[8];
    temp.Amount= input[9];
    temp.Method= input[10];
    temp.TransactionType= input[11];
    temp.CustomerID= input[12];
    temp.FirstName= input[13];
    temp.LastName= input[14];
    temp.Company= input[15];
    temp.Address= input[16];
    temp.City= input[17];
    temp.State= input[18];
    temp.ZIPCode= input[19];
    temp.Country= input[20];
    temp.Phone= input[21];
    temp.Fax= input[22];
    temp.EmailAddress= input[23];
    temp.ShipToFirstName= input[24];
    temp.ShipToLastName= input[25];
    temp.ShipToCompany= input[26];
    temp.ShipToAddress= input[27];
    temp.ShipToCity= input[28];
    temp.ShipToState= input[29];
    temp.ShipToZIPCode= input[30];
    temp.ShipToCountry= input[31];
    temp.Tax= input[32];
    temp.Duty= input[33];
    temp.Freight= input[34];
    temp.TaxExempt= input[35];
    temp.PurchaseOrderNumber= input[36];
    temp.MD5Hash= input[37];
    temp.CardCodeResponse= input[38];
    temp.CardholderAuthenticationVerificationResponse= input[39];
    temp.AccountNumber= input[40];
    temp.CardType= input[41];
    temp.SplitTenderID= input[42];
    temp.RequestedAmount= input[43];
    temp.BalanceOnCard= input[44];
    return temp;
  }
  
  public class authnetReq_Wrapper {
    public string ordername {get;set;}
    public string ccnum {get;set;}  
    public string ccexp {get;set;}
    public string ccsec {get;set;}
    public string amt {get;set;}
    public string firstname {get;set;}
    public string lastname {get;set;}
    public string billstreet {get;set;}
    public string billcity {get;set;}
    public string billstate {get;set;}
    public string billzip {get;set;}
    public string transid {get; set;}
    public string routingnumber {get; set;}
    public string accountnumber {get; set;}
    public string bankaccounttype {get; set;}
    public string bankname {get; set;}
    public string bankaccountname {get; set;}
    
    public authnetreq_wrapper(){}
  }
  
  public class authNetResp_Wrapper{
    // value, index in split string list
    public string responseCode {get;set;} //0
    public string ResponseSubcode{get;set;} //1
    public string ResponseReasonCode{get;set;} //2
    public string ResponseReasonText{get;set;} //3
    public string AuthorizationCode{get;set;} //4
    public string AVSResponse{get;set;} //5
    public string TransactionID{get;set;} //6
    public string InvoiceNumber{get;set;} //7
    public string Description{get;set;} //8
    public string Amount{get;set;} //9
    public string Method{get;set;} //10
    public string TransactionType{get;set;} //11
    public string CustomerID{get;set;} //12
    public string FirstName{get;set;} //13
    public string LastName{get;set;} //14
    public string Company{get;set;} //15
    public string Address{get;set;} //16
    public string City{get;set;} //17
    public string State{get;set;} //18
    public string ZIPCode{get;set;} //19
    public string Country{get;set;} //20
    public string Phone{get;set;} //21
    public string Fax{get;set;} //22
    public string EmailAddress{get;set;} //23
    public string ShipToFirstName{get;set;} //24
    public string ShipToLastName{get;set;} //25
    public string ShipToCompany{get;set;} //26
    public string ShipToAddress{get;set;} //27
    public string ShipToCity{get;set;} //28
    public string ShipToState{get;set;} //29
    public string ShipToZIPCode{get;set;} //30
    public string ShipToCountry{get;set;} //31
    public string Tax{get;set;} //32
    public string Duty{get;set;} //33
    public string Freight{get;set;} //34
    public string TaxExempt{get;set;} //35
    public string PurchaseOrderNumber{get;set;} //36
    public string MD5Hash{get;set;} //37
    public string CardCodeResponse{get;set;} //38
    public string CardholderAuthenticationVerificationResponse{get;set;} //39
    public string AccountNumber{get;set;} //40
    public string CardType{get;set;} //41
    public string SplitTenderID{get;set;} //42
    public string RequestedAmount{get;set;} //43
    public string BalanceOnCard{get;set;} //44
    public authnetresp_wrapper(){}
  }
}