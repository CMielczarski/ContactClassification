global without sharing class AA_UtilityClass{
	
	global static list<Profile> pFiles = [SELECT ID, Name FROM Profile];
		
	global static list<RecordType> typeList = [SELECT ID, DeveloperName FROM RecordType WHERE 
																						(sObjectType = 'Contact' AND (developerName = 'Contact_KRS' OR DeveloperName = 'SRS_Contacts' OR developerName = 'Individual' OR developerName = 'contactTemp' OR developerName = 'HD_Physicians' OR developerName = 'HD_Contacts' OR developerName = 'General_Contact')) 
																						OR 
																						(sObjectType = 'Event' AND (DeveloperName = 'KRS_Standard_Event' OR DeveloperName = 'SRS_Events'))
																						OR 
																						(sObjectType = 'Account' AND (DeveloperName = 'HD_Accounts' OR DeveloperName = 'KRS_Standard_Account' OR DeveloperName = 'SRS_Accounts' OR DeveloperName = 'Center' OR developerName = 'Household' OR DeveloperName = 'Referring_Facility_Child' OR DeveloperName = 'accountLacTemp' OR DeveloperName = 'PF_Chain' OR DeveloperName = 'PF_Client'))
																						OR
																						(sObjectType = 'Lead' AND (DeveloperName = 'KRS_SRS_Lead' OR DeveloperName = 'KRS_HRS_Lead'))
																						OR
																						(sObjectType = 'Task' AND (DeveloperName = 'Partner_First_Task' OR DeveloperName = 'KRS_Standard_Task' OR DeveloperName = 'SRS_Tasks'))
																						OR
																						(sObjectType = 'Sales_Performance__c' and (DeveloperName = 'Legacy'))
																						OR
																						(sObjectType = 'Opportunity' AND DeveloperName = 'SRS')
																						OR
																						(sObjectType = 'Case' AND (DeveloperName = 'Referral' OR DeveloperName = 'General_Inquiry' OR DeveloperName = 'caseTemp' OR DeveloperName = 'AfterHours' OR DeveloperName = 'Hospital_Transfer'))
																						OR 
																						(sObjectType = 'Patient_New__c' AND (DeveloperName = 'patientTemp' OR DeveloperName = 'patientValid'))
																						OR
																						(sObjectType = 'Assessment__c' AND (DeveloperName = 'assessmentTemp' OR DeveloperName = 'assessmentValid'))
																						];
	
	global static id eventCalendarID = '0234O000008L62F';
																						
	global static list<User> usrList = [SELECT ID, Name FROM User WHERE (Name = 'Cheryl Land' OR Name = 'Jen Humphrey' OR Name = 'Brad Miner' OR Name = 'Jerry Novickas')];
	
	global static list<Unit__c> activeUnits = [SELECT ID, Name FROM Unit__c WHERE Active__c = true];
	
	global static list<Unit__c> inactiveUnits = [SELECT ID, Name FROM Unit__c WHERE Active__c = false];
	
	global static list<HRS_BDO_Territory__c> hBDOs = [SELECT ID, HRS_BDO__c, Outside_US_Territories__c, US_Territories__c FROM HRS_BDO_Territory__c];
  	global static list<SRS_BDO_Territory__c> sBDOs = [SELECT ID, SRS_BDO__c, Role__c, States__c, CT_VP__c FROM SRS_BDO_Territory__c];
  
	global static list<SRS_BDO_Territory__c> bdos = [SELECT ID, SRS_BDO__c, SRS_BDO__r.Name FROM SRS_BDO_Territory__c];
	
	global static id uIDMarketo = [SELECT ID FROM User WHERE Name =: 'Marketo Integration'].ID;
	global static id uIDRon = [SELECT ID FROM User WHERE Name =: 'Ron Kilgore'].ID;
  	global static id uIDErika = [SELECT ID FROM User WHERE Name =: 'Erika Bantz'].ID;
    global static id uIDBeth = [SELECT ID FROM User WHERE Name =: 'Beth Niemann'].ID;
    global static id uIDPatricia = [SELECT ID FROM User WHERE Name =: 'Patricia Rose'].ID;
	
	global static list<User> srsCalendarEditList = [SELECT ID FROM User WHERE (Name = 'Jerry Novickas' OR Name = 'Jen Humphrey' OR Name = 'Cheryl Land' OR Name = 'Chris Mielczarski')];
	
	global static ID hrsDefaultUser = [SELECT ID, Name FROM User WHERE Name = 'Nicholas Talsma'].ID;
	
	global static ID srsDefaultUser = [SELECT ID, Name FROM User WHERE Name = 'Jerry Novickas'].ID;
	
	global static ID crmFusionDefaultUser = [SELECT ID, Name FROM User WHERE Name = 'Charles Cox'].ID;
	
	global static List<UserRole> inactiveRoles = [SELECT ID, Name FROM UserRole WHERE Name Like '%Inactive%'];
	
	global static ID hdLead = [SELECT ID, DeveloperName FROM RecordType Where sObjectType = 'Lead' AND DeveloperName = 'Sales_HD_Lead'].Id;
	
	global static ID iquviaLead = [SELECT ID, DeveloperName FROM RecordType Where sObjectType = 'Lead' AND DeveloperName = 'HD_Sales'].Id;
	
	global static ID unassignedHDAccount = '0011B000024ajWxQAI';
	
	global static list<UserRole> rList = [SELECT ID, Name FROM UserRole];
	
	//Begin General System Gets
	public static ID getCRMFusionID{
		get{
			ID crmFusionUser = crmFusionDefaultUser;
			return crmFusionUser;
			}
		set;
		}
	
  	public static ID getCenterID{
  		get{
  			ID centerAccount;
  			for(recordType rt: typeList){
  				if(rt.developerName == 'Center'){
  					centerAccount = rt.ID;
  					}		
  				}
  				return centerAccount;
  			}
  		set;	
  		}
  	
  	public static ID getInactiveID{
		get{
			id inactiveProfileID;
			for(Profile up : pFiles){
    			if(up.Name == 'Inactive Profile'){
    				inactiveProfileID = up.ID;
    				}				
    			}
    			return inactiveProfileID;
			}
		set;
		}				
	
	public static map<ID, string> getProfileMap{
		get{
			map<ID, string> profileMap = new map<ID, string>();
			for(Profile up : pFiles){
    			profileMap.put(up.ID, up.Name);
				}
			return profileMap;
			}
		set;	
		}
	
	public static map<ID,String> getRoleMap{
    	get{
    		map<ID, string> roleMap = new map<ID, string>();
    		for(UserRole ur : rList){
    			roleMap.put(ur.ID, ur.Name);
    			}
    		return roleMap;	
    		}
    	set;	
		}
	
	public static list<id> getInactiveRoleIDs{
		get{
			list<ID> inactiveRoleIds = new list<ID>();
			for(UserRole ur : inactiveRoles){
				inactiveRoleIds.add(ur.id);
				} 
			
			return inactiveRoleIds;
			}
		set;	
		}
	
	public static ID getSysAdminID{
		get{
			ID sysAdmin;
			for(Profile up : pFiles){
    		if(up.Name == 'System Administrator'){
    			sysAdmin = up.ID;
    			}
    		}
    		return sysAdmin;	
			}
		set;
		}
	
	public static list<ID> getAllHDProfileIDs{
		get{
			list<ID> hdProfiles = new list<ID>();
			for(Profile up : pFiles){
    			if(up.Name == 'Sales: HD Associate' || up.Name == 'Sales: HD Associate Redesign' || up.Name == 'Sales: HD Manager' || up.Name == 'Sales: HD Manager Redesign' || up.Name == 'Sales: HD PAC' || up.Name == 'Sales: HD PAC Redesign' || up.Name == 'Sales: HD Trainer' || up.Name == 'Sales - HD Admin'){
    				hdProfiles.add(up.ID);
    				}
    			}
			return hdProfiles;
			}
		set;
		}
	
	public static list<ID> getAllLacunaProfileIDs{
		get{
			list<ID> lacProfiles = new list<ID>();
			for(Profile up : pFiles){
    			if(up.Name.contains('Contact Center')){
    				lacProfiles.add(up.ID);
    				}
    			}
			return lacProfiles;
			}
		set;
		}
		
	public static list<ID> getAllRHCProfileIDs{
		get{
			list<ID> rhcProfiles = new list<ID>();
			for(Profile up : pFiles){
    			if(up.Name == 'RHC Ops: ADO' || up.Name == 'RHC Ops: Manager' || up.Name == 'RHC: CPS User' || up.Name == 'RHC: Read Only' || up.Name == 'PF/KRS Support'){
    				rhcProfiles.add(up.ID);
    				}
    			}
			return rhcProfiles;
			}
		set;
		}
	
	public static list<ID> getAllHRSProfileIDs{
		get{
			list<ID> hrsProfiles = new list<ID>();
			for(Profile up : pFiles){
				if(up.Name.contains('HRS')){
					hrsProfiles.add(up.ID);
					}
				}
			return hrsProfiles;
			}
		set;
		}

	public static list<ID> getAllSRSProfileIDs{
		get{
			list<ID> srsProfiles = new list<ID>();
			for(Profile up : pFiles){
    			if(up.Name.contains('KRS') && !up.Name.contains('PF/KRS Support')){
    				srsProfiles.add(up.ID);
    				}
    			}
			return srsProfiles;
			}
		set;
		}
		
	public static list<RecordType> getRHCAccountTypes{
		get{
			list<RecordType> accountTypes = new list<RecordType>();
			accountTypes = [SELECT ID, Name, Description FROM RecordType WHERE sObjectType = 'Account' AND (DeveloperName = 'PF_Chain' OR DeveloperName = 'PF_Client')];
			return accountTypes;
			}
		set;	
		}
		
	public static list<ID> getRHCAccountTypeIDs{
		get{
			list<ID> accountIDs = new list<ID>();
			for(RecordType rt: [SELECT ID, Name, Description FROM RecordType WHERE sObjectType = 'Account' AND (DeveloperName = 'PF_Chain' OR DeveloperName = 'PF_Client')]){
				accountIDs.add(rt.ID);
				}
			return accountIDs;	
			}
		set;	
		}	
	
	public static list<RecordType> getLACAccountTypes{
		get{
			list<RecordType> accountTypes = new list<RecordType>();
			accountTypes = [SELECT ID, Name, Description FROM RecordType WHERE sObjectType = 'Account' AND (DeveloperName = 'Household')];
			return accountTypes;
			}
		set;	
		}	
										
	public static list<RecordType> getHRSAccountTypes{
		get{
			list<RecordType> accountTypes = new list<RecordType>();
			accountTypes = [SELECT ID, Name, Description FROM RecordType WHERE sObjectType = 'Account' AND (DeveloperName = 'KRS_Standard_Account')];
			return accountTypes;
			}
		set;	
		}

	public static list<RecordType> getSRSAccountTypes{
		get{
			list<RecordType> accountTypes = new list<RecordType>();
			accountTypes = [SELECT ID, Name, Description FROM RecordType WHERE sObjectType = 'Account' AND (DeveloperName = 'SRS_Accounts')];
			return accountTypes;
			}
		set;
		}
	
	public static list<RecordType> getHDAccountTypes{
		get{
			list<RecordType> accountTypes = new list<RecordType>();
			accountTypes = [SELECT ID, Name, Description FROM RecordType WHERE sObjectType = 'Account' AND (DeveloperName = 'HD_Accounts' OR DeveloperName = 'Sales_HD_Account')];
			return accountTypes;
			}
		set;	
		}	
	
	//Begin HD/NCD Gets
	public static ID getHDAdminProfileID{
		get{
			ID sysId;
			for(Profile up : pFiles){
    			if(up.Name == 'Sales - HD Admin'){
    				sysId = up.ID;
    				}
    			}
    			return sysId;
			}		
		set;
		}
	
	public static ID getHDLead{
		get{
			ID leadID = hdLead;
			return leadID;
			}
		set;
		}
		
	public static ID getIquviaLead{
		get{
			ID leadID = iquviaLead;
			return leadID;
			}
		set;
		}
	
	public static ID getHDAdminAccount{
		get{
			ID hdAdmin = unassignedHDAccount;
			return hdAdmin;
			}
		set;	
		}
		
	public static ID getNcdAssociate{
		get{
			id ncdAssociate;
			for(Profile p : pFiles){
  				if(p.Name == 'Sales: NCD Associate'){
  					ncdAssociate = p.ID;		
  					} 
			}
			return ncdAssociate;
			}
		set;	
		}
	
    public static ID getNewHDID{
  		get{
  			ID newHDAccount;
  			for(recordType rt: typeList){
  				if(rt.developerName == 'HD_Accounts'){
  					newHDAccount = rt.ID;
  					}
  				}
  			return newHDAccount;
  			}
  		set;	
  		}
  		
  	public static ID getHDAssociateID{
		get{
			ID SALES_HD_Associate;
			for(Profile up : pFiles){
    		if(up.Name == 'Sales: HD Associate Redesign'){
    			SALES_HD_Associate = up.ID;
    			}
			}
			return SALES_HD_Associate;
			}
		set;
		}
		
	public static ID getNCDAssociateID{
		get{
			ID SALES_NCD_Associate;
			for(Profile up : pFiles){
    		if(up.Name == 'Sales: NCD Associate'){
    			SALES_NCD_Associate = up.ID;
    			}
    		}
    		return SALES_NCD_Associate;	
			}
		set;
		}
		
	public static ID getHDLibraryID{
		get{
			ID hdLib = getHDLibraryID;
			return hdLib;
			}
			set;		
		}
	
	public static ID getHDPhysicianID{
		get{
			ID hdPhysType;
			for(RecordType rt: typeList){
   				if(rt.DeveloperName == 'HD_Physicians'){
   					hdPhysType = rt.ID;
   					}	
   				}
   			return hdPhysType;
			}
		set;	
		}
		
	public static ID getHDContactID{
		get{
			ID hdConType;
			for(RecordType rt: typeList){
   				if(rt.DeveloperName == 'HD_Contacts'){
   					hdConType = rt.ID;
   					}	
   				}
   			return hdConType;
			}
		set;
		}				
  	
  	//Begin HD Unit Gets
	public static list<Unit__c> getUnitList{
		get{
			list<Unit__c> uList = new list<Unit__c>();
			uList = activeUnits;
			return uList;
			}
		set;
		}
	
	public static list<ID> getActiveUnitIDList{
		get{
			list<ID> uList = new list<ID>();
			for(Unit__c u : activeUnits){
				uList.add(u.ID);
				}
			return uList;
			}
		set;
		}
		
	public static list<ID> getInactiveUnitIDList{
		get{
			list<ID> uList = new list<ID>();
			for(Unit__c u : inactiveUnits){
				uList.add(u.ID);
				}
			return uList;
			}
		set;
		}	
	
	//Begin Lacuna/Contact Center Group Gets
	public static ID getindvCtc{
  		get{
  			id indvCtc;
  			for(RecordType rt: typeList){
  				if(rt.developerName == 'Individual'){
  					indvCtc = rt.ID;
  					}
  				}
  				return indvCtc;
  			}
  		set;
  		}
  	
  public static ID gethouseAcc{
  	get{
  		id houseAcc;
  		for(RecordType rt: typeList){
  			if(rt.developerName == 'Household'){
  				houseAcc = rt.ID;
  				}
  			}
  			return houseAcc;
  		}
  	set;
  	}
  
  public static ID gettempContact{
  	get{
  		id tempContact;
  		for(RecordType rt: typeList){
  			if(rt.developerName == 'contactTemp'){
  				tempContact = rt.ID;
  				}
  			}
  			return tempContact;
  		}
  	set;
  	} 
    
    public static ID getPatientTempID{
		get{
			ID ptRefType;
			for(RecordType rt: typeList){
   				if(rt.DeveloperName == 'patientTemp'){
   					ptRefType = rt.ID;
   					}	
   				}
   			return ptRefType;
			}
		set;	
		}
		
	public static ID getAssessmentTempID{
		get{
			ID assmRefType;
			for(RecordType rt: typeList){
   				if(rt.DeveloperName == 'assessmentTemp'){
   					assmRefType = rt.ID;
   					}	
   				}
   			return assmRefType;
			}
		set;	
		}
		
	public static ID getPatientValidID{
		get{
			ID ptRefType;
			for(RecordType rt: typeList){
   				if(rt.DeveloperName == 'patientValid'){
   					ptRefType = rt.ID;
   					}	
   				}
   			return ptRefType;
			}
		set;	
		}
		
	public static ID getAssessmentValidID{
		get{
			ID assmRefType;
			for(RecordType rt: typeList){
   				if(rt.DeveloperName == 'assessmentValid'){
   					assmRefType = rt.ID;
   					}	
   				}
   			return assmRefType;
			}
		set;	
		}
		
	public static ID getAccountTempID{
		get{
			ID accRefType;
			for(RecordType rt: typeList){
   				if(rt.DeveloperName == 'accountLacTemp'){
   					accRefType = rt.ID;
   					}	
   				}
   			return accRefType;
			}
		set;	
		}
	
	
	public static list<RecordType> getCaseTypeList{
		get{
			list<RecordType> caseTypeList;
			for(RecordType rt: typeList){
   				if(rt.DeveloperName == 'AfterHours' || rt.DeveloperName == 'General_Inquiry'){
   					caseTypeList.add(rt);
   					}	
   				}
   			return caseTypeList;
			}
		set;	
		}
	
	public static ID getCaseTempID{
		get{
			ID caseRefType;
			for(RecordType rt: typeList){
   				if(rt.DeveloperName == 'caseTemp'){
   					caseRefType = rt.ID;
   					}	
   				}
   			return caseRefType;
			}
		set;	
		}
	
	public static ID getCaseReferralID{
		get{
			ID caseRefType;
			for(RecordType rt: typeList){
   				if(rt.DeveloperName == 'Referral'){
   					caseRefType = rt.ID;
   					}	
   				}
   			return caseRefType;
			}
		set;	
		}
		
	public static ID getCaseAfterHoursID{
		get{
			ID caseRefType;
			for(RecordType rt: typeList){
   				if(rt.DeveloperName == 'AfterHours'){
   					caseRefType = rt.ID;
   					}	
   				}
   			return caseRefType;
			}
		set;	
		}
		
	public static ID getCaseTransferID{
		get{
			ID caseRefType;
			for(RecordType rt: typeList){
   				if(rt.DeveloperName == 'Hospital_Transfer'){
   					caseRefType = rt.ID;
   					}	
   				}
   			return caseRefType;
			}
		set;	
		}	
	
	public static ID getCaseInquiryID{
		get{
			ID caseRefType;
			for(RecordType rt: typeList){
   				if(rt.DeveloperName == 'General_Inquiry'){
   					caseRefType = rt.ID;
   					}	
   				}
   			return caseRefType;
			}
		set;	
		}
    
    public static ID getContactCenterProfile{
    		get{
    			ID contactCenterProfile;
    		for(Profile p : pFiles){
  				if(p.Name == 'Contact Center Representative'){
  					contactCenterProfile = p.ID;		
  					}
  					}
  				return contactCenterProfile;	
    			}
    		set;
    	}	
    
    //Begin KHRS Group Gets
    public static ID getEventCalendarID{
    	get{
    		id calendarID = eventCalendarID;
    		return calendarID;
    		}
    	set;
    	}
    	
    public static boolean getEventCalendarEditPermissions{
    	get{
    		boolean canEdit;
    		list<User> users = srsCalendarEditList;
    		list<string> ids = new list<string>();
    		for(User u: users){
    			system.debug('ID: ' + u.ID);
    			ids.add(u.ID);
    			}
    		system.debug('UserID: ' + UserInfo.getUserId());
    		system.debug('Comparison: ' + ids.contains(UserInfo.getUserId()));
    		if(ids.contains(UserInfo.getUserId())){
    			canEdit = true;
    			}
    		else{
    			canEdit = false;
    			}
    		system.debug('CanEdit value: ' + canEdit);		
			return canEdit;
    		}
    	set;
    	}	
    
    public static list<HRS_BDO_Territory__c> getHRSBDO{
		get{
			list<HRS_BDO_Territory__c> hList = new list<HRS_BDO_Territory__c>();
			hList = hBDOs;
			return hList;
			}
		set;
		}
		
	public static list<SRS_BDO_Territory__c> getSRSBDO{
		get{
			list<SRS_BDO_Territory__c> sList = new list<SRS_BDO_Territory__c>();
			sList = sBDOs;
			return sList;
			}
		set;
		}
	
	public static map<String, ID> getSRSInfo{
		get{
			map <String, ID> info = new map<String, ID>();
			for(SRS_BDO_Territory__c sbt : bdos){
  				info.put(sbt.SRS_BDO__r.Name, sbt.SRS_BDO__c);
    			}
    		return info;
			}
		set;
		}
	
	public static ID getSRSOpporunityID{
		get{
			ID srsType;
			for(RecordType rt: typeList){
   				if(rt.DeveloperName == 'SRS'){
   					srsType = rt.ID;
   					}	
   				}
   			return srsType;
			}
		set;	
		}
	
	public static ID getSRSStandardID{
  		get{
  			ID srsAccount;
  			for(recordType rt: typeList){
  				if(rt.developerName == 'SRS_Accounts'){
  				srsAccount = rt.ID;
  				}
  				}
  			return srsAccount;
  			}
  		set;	
  		}
  		
  	public static ID getHRSID{
  		get{
  			ID hrsAccount;
  			for(recordType rt: typeList){
  				if(rt.developerName == 'KRS_Standard_Account'){
  				hrsAccount = rt.ID;
  				}
  				}
  			return hrsAccount;
  			}
  		set;	
  		}		
    
    public static ID getHRSContact{
  		get{
  			ID hrsContact;
  			for(recordType rt: typeList){
  				if(rt.developerName == 'Contact_KRS'){
  				hrsContact = rt.ID;
  				}
  				}
  			return hrsContact;
  			}
  		set;	
  		}
    
    public static ID getsrsContact{
		get{
			id krsContact;
			for(RecordType rt: typeList){
  				if(rt.developerName == 'SRS_Contacts'){
  					krsContact = rt.ID;
  					}
  				}
  				return krsContact;
			}
		set;
		}
    
    public static ID getsrsEvent{
  	get{
  		id krsEvent;
  		for(RecordType rt: typeList){
  			if(rt.developerName == 'SRS_Events'){
  				krsEvent = rt.ID;
  				}
  			}
  			return krsEvent;
  		}
  	set;
  	}
  	
  	public static ID gethrsEvent{
  	get{
  		id krsEvent;
  		for(RecordType rt: typeList){
  			if(rt.developerName == 'KRS_Standard_Event'){
  				krsEvent = rt.ID;
  				}
  			}
  			return krsEvent;
  		}
  	set;
  	}
    
    public static ID getHRSDefault{
		get{
			ID hrsDefault = hrsDefaultUser;
			return hrsDefault;
			}
		set;	
		}
		
	public static ID getSRSDefault{
		get{
			ID srsDefault = srsDefaultUser;
			return srsDefault;
			}
		set;	
		}	
	
	public static ID getHRSLead{
		get{
			id hrsLead;
			for(RecordType rt: typeList){
   				if(rt.DeveloperName == 'KRS_HRS_Lead'){
   					hrsLead = rt.ID;
   					}	
   				}
   			return hrsLead;	
			}
		set;
		}
		
	public static ID getSRSLead{
		get{
			id srsLead;
		for(RecordType rt: typeList){
			if(rt.DeveloperName == 'KRS_SRS_Lead'){
   					srsLead = rt.ID;
   					}
			}
			return srsLead;
			}
			set;
		}	
	
	public static ID getSRSTask{
		get{
			id krsTask;
			for(RecordType rt: typeList){
			if(rt.DeveloperName == 'SRS_Tasks'){
   					krsTask = rt.ID;
   					}
			}
			return krsTask;
			}
		set;	
		}
		
	public static ID getHRSTask{
		get{
			id krsTask;
			for(RecordType rt: typeList){
			if(rt.DeveloperName == 'KRS_Standard_Task'){
   					krsTask = rt.ID;
   					}
			}
			return krsTask;
			}
		set;	
		}
	
	public static ID getRon{
		get{
		ID idRon = uIDRon;
		return idRon; 	
		}
		set;
		}
	
	public static ID getErika{
		get{
		ID idErika = uIDErika;
		return idErika;	
		}
		set;
		}
    
    public static ID getBeth{
		get{
		ID idBeth = uIDBeth;
		return idBeth;	
		}
		set;
		}
	
	public static ID getMarketo{
		get{
			ID idMarketo = uIDMarketo;
			return idMarketo;
			}
		set;
		}

    public static ID getPatricia{
		get{
		ID idPatricia = uIDPatricia;
		return idPatricia;	
		}
		set;
		}
    
    public static list<string> getBethZip{
        get{
            list<string> bethZip = new list<string>{'63071', '63330', '63333', '63334', '63336', '63339', '63344', '63345', '63350', '63351', '63352', '63353', '63359', '63361', '63363', '63382', '63384', '63388', '63401', '63430', '63431', '63432', '63433', '63434', '63435', '63436', '63437', '63438', '63439', '63440', '63441', '63442', '63443', '63445', '63446', '63447', '63448', '63450', '63451', '63452', '63453', '63454', '63456', '63457', '63458', '63459', '63460', '63461', '63462', '63463', '63464', '63465', '63466', '63467', '63468', '63469', '63471', '63472', '63473', '63474', '63501', '63530', '63531', '63532', '63533', '63534', '63535', '63536', '63537', '63538', '63539', '63540', '63541', '63543', '63544', '63545', '63546', '63547', '63548', '63549', '63551', '63552', '63555', '63556', '63557', '63558', '63559', '63560', '63561', '63563', '63565', '63566', '63567', '63620', '63621', '63622', '63623', '63625', '63626', '63629', '63630', '63631', '63632', '63633', '63636', '63638', '63645', '63646', '63650', '63654', '63655', '63656', '63660', '63662', '63663', '63664', '63665', '63666', '63674', '63675', '63701', '63702', '63703', '63705', '63730', '63732', '63735', '63736', '63737', '63738', '63739', '63740', '63742', '63743', '63744', '63745', '63746', '63747', '63748', '63750', '63751', '63752', '63753', '63755', '63758', '63760', '63763', '63764', '63766', '63767', '63769', '63770', '63771', '63772', '63774', '63775', '63776', '63779', '63780', '63781', '63782', '63783', '63784', '63785', '63787', '63801', '63820', '63821', '63822', '63823', '63824', '63825', '63826', '63827', '63828', '63829', '63830', '63833', '63834', '63837', '63839', '63840', '63841', '63845', '63846', '63847', '63848', '63849', '63850', '63851', '63852', '63853', '63855', '63857', '63860', '63862', '63863', '63866', '63867', '63868', '63869', '63870', '63873', '63874', '63875', '63876', '63877', '63878', '63879', '63880', '63881', '63882', '63901', '63902', '63931', '63932', '63933', '63934', '63935', '63936', '63937', '63938', '63939', '63940', '63941', '63942', '63943', '63944', '63945', '63947', '63950', '63951', '63952', '63953', '63954', '63955', '63956', '63957', '63960', '63961', '63962', '63963', '63964', '63965', '63966', '63967', '64001', '64002', '64011', '64012', '64013', '64014', '64015', '64016', '64017', '64018', '64019', '64020', '64021', '64022', '64024', '64028', '64029', '64030', '64034', '64035', '64036', '64037', '64040', '64048', '64050', '64051', '64052', '64053', '64054', '64055', '64056', '64057', '64058', '64060', '64061', '64062', '64063', '64064', '64065', '64066', '64067', '64068', '64069', '64070', '64071', '64072', '64073', '64074', '64075', '64076', '64077', '64078', '64079', '64080', '64081', '64082', '64083', '64084', '64085', '64086', '64087', '64088', '64089', '64090', '64092', '64093', '64096', '64097', '64098', '64101', '64102', '64105', '64106', '64108', '64109', '64110', '64111', '64112', '64113', '64114', '64116', '64117', '64118', '64119', '64120', '64121', '64123', '64124', '64125', '64126', '64127', '64128', '64129', '64130', '64131', '64132', '64133', '64134', '64136', '64137', '64138', '64139', '64141', '64142', '64144', '64145', '64146', '64147', '64148', '64149', '64150', '64151', '64152', '64153', '64154', '64155', '64156', '64157', '64158', '64160', '64161', '64162', '64163', '64164', '64165', '64166', '64167', '64168', '64170', '64171', '64172', '64173', '64179', '64180', '64183', '64184', '64185', '64187', '64188', '64189', '64190', '64191', '64192', '64193', '64194', '64195', '64196', '64197', '64198', '64199', '64401', '64402', '64420', '64421', '64422', '64423', '64424', '64426', '64427', '64428', '64429', '64430', '64431', '64432', '64433', '64434', '64436', '64437', '64438', '64439', '64440', '64441', '64442', '64443', '64444', '64445', '64446', '64447', '64448', '64449', '64451', '64453', '64454', '64455', '64456', '64457', '64458', '64459', '64461', '64463', '64465', '64466', '64467', '64468', '64469', '64470', '64471', '64473', '64474', '64475', '64476', '64477', '64478', '64479', '64480', '64481', '64482', '64483', '64484', '64485', '64486', '64487', '64489', '64490', '64491', '64492', '64493', '64494', '64496', '64497', '64498', '64499', '64501', '64502', '64503', '64504', '64505', '64506', '64507', '64508', '64601', '64620', '64622', '64623', '64624', '64625', '64628', '64630', '64631', '64632', '64633', '64635', '64636', '64637', '64638', '64639', '64640', '64641', '64642', '64643', '64644', '64645', '64646', '64647', '64648', '64649', '64650', '64651', '64652', '64653', '64654', '64655', '64656', '64657', '64658', '64659', '64660', '64661', '64664', '64667', '64668', '64670', '64671', '64672', '64673', '64674', '64676', '64679', '64680', '64681', '64682', '64683', '64686', '64688', '64689', '64701', '64720', '64722', '64723', '64724', '64725', '64726', '64728', '64730', '64733', '64734', '64735', '64738', '64739', '64740', '64741', '64742', '64743', '64744', '64745', '64746', '64747', '64748', '64750', '64751', '64752', '64755', '64756', '64759', '64761', '64762', '64763', '64765', '64766', '64767', '64769', '64770', '64771', '64772', '64776', '64777', '64778', '64779', '64780', '64781', '64783', '64784', '64788', '64789', '64790', '64801', '64802', '64803', '64804', '64830', '64831', '64832', '64833', '64834', '64835', '64836', '64840', '64841', '64842', '64843', '64844', '64847', '64848', '64849', '64850', '64853', '64854', '64855', '64856', '64857', '64858', '64859', '64861', '64862', '64863', '64864', '64865', '64866', '64867', '64868', '64869', '64870', '64873', '64874', '64944', '64999', '65001', '65010', '65011', '65013', '65016', '65017', '65018', '65020', '65022', '65023', '65024', '65025', '65026', '65031', '65032', '65034', '65035', '65037', '65038', '65039', '65040', '65042', '65043', '65046', '65047', '65048', '65049', '65050', '65051', '65052', '65053', '65054', '65055', '65058', '65059', '65063', '65064', '65065', '65067', '65068', '65069', '65072', '65074', '65075', '65076', '65077', '65078', '65079', '65080', '65081', '65082', '65083', '65084', '65085', '65101', '65102', '65103', '65104', '65105', '65106', '65107', '65108', '65109', '65110', '65111', '65201', '65202', '65203', '65205', '65211', '65212', '65215', '65216', '65217', '65218', '65230', '65231', '65232', '65233', '65236', '65237', '65239', '65240', '65243', '65244', '65246', '65247', '65248', '65250', '65251', '65254', '65255', '65256', '65257', '65258', '65259', '65260', '65261', '65262', '65263', '65264', '65265', '65270', '65274', '65275', '65276', '65278', '65279', '65280', '65281', '65282', '65283', '65284', '65285', '65286', '65287', '65299', '65301', '65302', '65305', '65321', '65322', '65323', '65324', '65325', '65326', '65327', '65329', '65330', '65332', '65333', '65334', '65335', '65336', '65337', '65338', '65339', '65340', '65344', '65345', '65347', '65348', '65349', '65350', '65351', '65354', '65355', '65360', '65401', '65402', '65409', '65433', '65436', '65438', '65439', '65440', '65441', '65443', '65444', '65446', '65449', '65452', '65453', '65456', '65457', '65459', '65461', '65462', '65463', '65464', '65466', '65468', '65470', '65473', '65479', '65483', '65484', '65486', '65501', '65529', '65532', '65534', '65535', '65536', '65540', '65541', '65542', '65543', '65546', '65548', '65550', '65552', '65555', '65556', '65557', '65559', '65560', '65564', '65565', '65566', '65567', '65570', '65571', '65572', '65580', '65582', '65583', '65584', '65586', '65588', '65589', '65590', '65591', '65601', '65603', '65604', '65605', '65606', '65607', '65608', '65609', '65610', '65611', '65612', '65613', '65614', '65615', '65616', '65617', '65618', '65619', '65620', '65622', '65623', '65624', '65625', '65626', '65627', '65629', '65630', '65631', '65632', '65633', '65634', '65635', '65636', '65637', '65638', '65640', '65641', '65644', '65645', '65646', '65647', '65648', '65649', '65650', '65652', '65653', '65654', '65655', '65656', '65657', '65658', '65659', '65661', '65663', '65664', '65666', '65668', '65669', '65672', '65673', '65674', '65675', '65676', '65679', '65680', '65681', '65682', '65685', '65686', '65688', '65689', '65690', '65692', '65701', '65705', '65706', '65707', '65708', '65710', '65712', '65713', '65714', '65715', '65720', '65721', '65722', '65723', '65724', '65725', '65726', '65727', '65728', '65729', '65730', '65731', '65732', '65733', '65734', '65735', '65737', '65738', '65739', '65740', '65741', '65742', '65744', '65745', '65746', '65747', '65752', '65753', '65754', '65755', '65756', '65757', '65759', '65760', '65761', '65762', '65764', '65765', '65766', '65767', '65768', '65769', '65770', '65771', '65772', '65773', '65774', '65775', '65776', '65777', '65778', '65779', '65781', '65783', '65784', '65785', '65786', '65787', '65788', '65789', '65790', '65791', '65793', '65801', '65802', '65803', '65804', '65805', '65806', '65807', '65808', '65809', '65810', '65814', '65817', '65890', '65897', '65898', '65899', '72643'};
            return bethZip;
            }
        set;
    	}
    
    public static list<string> getPatriciaZip{
        get{
            list<string> patriciaZip = new list<string>{'63001', '63005', '63006', '63010', '63011', '63012', '63013', '63014', '63015', '63016', '63017', '63019', '63020', '63021', '63022', '63023', '63024', '63025', '63026', '63028', '63030', '63031', '63032', '63033', '63034', '63036', '63037', '63038', '63039', '63040', '63041', '63042', '63043', '63044', '63045', '63047', '63048', '63049', '63050', '63051', '63052', '63053', '63055', '63056', '63057', '63060', '63061', '63065', '63066', '63068', '63069', '63070', '63072', '63073', '63074', '63077', '63079', '63080', '63084', '63087', '63088', '63089', '63090', '63091', '63099', '63101', '63102', '63103', '63104', '63105', '63106', '63107', '63108', '63109', '63110', '63111', '63112', '63113', '63114', '63115', '63116', '63117', '63118', '63119', '63120', '63121', '63122', '63123', '63124', '63125', '63126', '63127', '63128', '63129', '63130', '63131', '63132', '63133', '63134', '63135', '63136', '63137', '63138', '63139', '63140', '63141', '63143', '63144', '63145', '63146', '63147', '63150', '63151', '63155', '63156', '63157', '63158', '63160', '63163', '63164', '63166', '63167', '63169', '63171', '63177', '63178', '63179', '63180', '63182', '63188', '63190', '63195', '63196', '63197', '63198', '63199', '63301', '63302', '63303', '63304', '63332', '63338', '63341', '63342', '63343', '63346', '63347', '63348', '63349', '63357', '63362', '63365', '63366', '63367', '63368', '63369', '63370', '63373', '63376', '63377', '63378', '63379', '63380', '63381', '63383', '63385', '63386', '63387', '63389', '63390', '63601', '63624', '63628', '63637', '63640', '63648', '63651', '63653', '65014', '65036', '65041', '65061', '65062', '65066', '65660', '65662', '65667', '65702', '65704', '65711', '65717'};
        	return patriciaZip;
            }
        set;
    	}
    
    public static list<string> getCSuite{
        get{
            list<string> cSuite = new list<string>{'Board Member', 'CEO', 'CEO/Administrator', 'CFO', 'Chariman', 'Chief Clinical Officer', 'Chief Compliance Officer', 'Chief Development Officer', 'Chief Executive Officer', 'Chief Executive Officer/Executive Administrator', 'Chief Executive Officer/President', 'Chief Financial Officer', 'Chief Financial Officer/Executive Vice President', 'Chief Operations Officer', 'Chief Purchasing Officer', 'Chief Strategy Officer', 'Controller', 'COO', 'Director of Operations', 'Director of Purchasing', 'Director of Quality', 'Director/Board Member', 'Executive Partner', 'Executive Vice President', 'Facility Owner, President/CEO, Chief Operating Officer', 'Partner', 'President', 'President & CEO', 'President/CEO', 'President and CEO', 'President and Chief Executive Officer', 'President, CEO', 'President/Chief Operating Officer', 'President/Owner', 'President/CEO', 'Principal', 'Quality Officer', 'Regional', 'Regional Administrator', 'Regional Director', 'Regional Director of Clinical Services', 'Regional Director of Operations', 'Regional Manager', 'Regional Vice President', 'RVP', 'Senior Vice President', 'Treasurer', 'Vice President', 'Vice President of Finance', 'Vice President of Health Services', 'Vice President of Human Resources', 'Vice President of Nursing', 'Vice President of Operations', 'Vice President of the Board', 'Vice President, Operations', 'Vice President/Administrator', 'VP', 'VP Clinical', 'VP Clinical Services', 'VP of Clinical Services', 'VP of Finance', 'VP of Health Services', 'VP of Operations', 'VP of Ops', 'VP Operations'};
            return cSuite;
            }
        set;
        }

    public static list<string> getFacAdmin{
        get{
            list<string> facAdmin = new list<string>{'Admin', 'Administrator', 'Administr', 'Administator', 'Administrator in Training', 'Administrator/CEO', 'Administrator/Owner', 'Adminstrator', 'Assistant Executive Director', 'Assisted Living Director', 'Assisted Living Manager', 'Associate Administrator', 'Associate Executive Director', 'Asst. Administrator', 'Campus Administrator', 'Center Executive Director', 'ED', 'Ex Dir', 'Exec Director', 'Exectuive Director', 'Executiive Director', 'Executive Administrator', 'Executive Assistant', 'Executive Director', 'Executive Director/Executive Administrator', 'Executive Director/Administrator', 'General Manager', 'Health Care Administrator', 'Health Care Coordinator', 'Health Center Administrator', 'Health Services Administrator', 'Healthcare Administrator', 'Interim Administrator', 'Interim Executive Director', 'NHA', 'Nursing Home Administrator', 'Owner', 'Owner/Executive Administrator', 'Owner/Administrator', 'Owner/Operator', 'Senior Executive Director'};
            return facAdmin;
            }
        set;
        }

    public static list<string> getClinical{
        get{
            list<string> clinical = new list<string>{'ADNS', 'ADON', 'Assistant Director of Nursing', 'Center Nurse Executive', 'CNA/Caregiver', 'CNO', 'Director of Clinical Services', 'Director of Health Services', 'Director of Nurses', 'Director of Nursing', 'Director of Nursing Services', 'DNS', 'DNS/DON', 'DON', 'DON, Corporate Nurse, Regional Nurse', 'MDS', 'Nurse', 'Nurse Assessment Coordinator/MDS Coordinator', 'Nurse Consultant', 'Nurse Manager', 'Nursing Director', 'Nursing Services', 'Nursing Services Director', 'RN'};
            return clinical;
            }
        set;
		}
	/*		
	public static list<string> getRegionChoices{
		get{
			list<string> clinical = new list<string>{'AK', 'AL', 'AR', 'AZ', 'CA', 'CO', 'CT', 'DC', 'DE', 'FL', 'GA', 'HI', 'IA', 'ID', 'IL', 'IN', 'KS', 'KY', 'LA', 'MA', 'MD', 'ME', 'MI', 'MN', 'MO', 'MS', 'MT', 'NC', 'ND', 'NE', 'NH', 'NJ', 'NM', 'NV', 'NY', 'OH', 'OK', 'OR', 'PA', 'PR', 'RI', 'SC', 'SD', 'TN', 'TX', 'UT', 'VA', 'VT', 'WA', 'WI', 'WV', 'WY'};
			return clinical;
			}
		set;
		}
	
	public static list<string> getTitleChoices{
		get{
			list<string> clinical = new list<string>{'All', 'C-Suite', 'Fac-Admin', 'Clinical'};
			return clinical;
			}
		set;
		}
    */
    public static ID getKRSSRSSupportID{
		get{
			ID srsSupport;
			for(Profile up : pFiles){
    		if(up.Name == 'KRS: SRS Support Admin'){
    			srsSupport = up.ID;
    			}
    		}
    		return srsSupport;	
			}
		set;
		}
		
	public static ID getKRSSRSAdminID{
		get{
			ID srsSupport;
			for(Profile up : pFiles){
    		if(up.Name == 'KRS: SRS Admin'){
    			srsSupport = up.ID;
    			}
    		}
    		return srsSupport;	
			}
		set;
		}
    
    public static list<ID> getAllKRSProfiles{
    		get{
    			list<ID> krsProfiles = new list<ID>();
    		for(Profile p : pFiles){
  				if(p.Name == 'KRS: SRS Admin' || p.Name == 'KRS: SRS Support Admin' || p.Name == 'KRS: SRS User' || p.Name == 'KRS: SRS Finance'){
  					krsProfiles.add(p.ID);		
  					}
  					}
  				return krsProfiles;	
    			}
    		set;
    	}
    
    public static list<ID> getKRSProfiles{
    		get{
    			list<ID> krsProfiles = new list<ID>();
    		for(Profile p : pFiles){
  				if(p.Name == 'KRS: SRS Admin' || p.Name == 'KRS: SRS Support Admin' || p.Name == 'System Administrator'){
  					krsProfiles.add(p.ID);		
  					}
  					}
  				return krsProfiles;	
    			}
    		set;
    	}
    
    public static list<ID> getKRSNoDeleteProfiles{
    		get{
    			list<ID> krsNoDeleteProfiles = new list<ID>();
    		for(Profile p : pFiles){
  				if(p.Name == 'KRS: SRS Finance' || p.Name == 'KRS: SRS User'){
  					krsNoDeleteProfiles.add(p.ID);		
  					}
  					}
  				return krsNoDeleteProfiles;	
    			}
    		set;
    	}
    	
    public static list<ID> getNonKRSAdmins{
    	get{
    		list<ID> krsNonAdmins = new list<ID>();
    		for(Profile p: pFiles){
    			if(p.Name == 'KRS: Read Only' || p.Name == 'KRS: SRS Finance' || p.Name == 'KRS: SRS User'){
  					krsNonAdmins.add(p.ID);		
  					}	
    			}
    		return krsNonAdmins;
    		}
    	set;
    }	
    
    public static list<ID> getKRSUSers{
    	get{
    		list<ID> krsUsers = new list<ID>();
    		for(User u : usrList){
  				krsUsers.add(u.ID);
  				}
  				return krsUsers;
    		}
    	set;
    }
    
    public static list<Account> getSRSAthroughL{
		get{
			list<Account> srsAccount = [SELECT ID, 
								  			   Name 
						   				FROM Account 
								   		WHERE RecordTypeID =: getSRSStandardID 
						   				AND Name > 'A' AND Name < 'L'];
			return srsAccount;
			}
			set;		
		}
		
	public static list<Account> getSRSMthroughS{
		get{
			list<Account> srsAccount = [SELECT ID, 
								  			   Name 
						   				FROM Account 
								   		WHERE RecordTypeID =: getSRSStandardID 
						   				AND Name > 'M' AND Name < 'S'];
			return srsAccount;
			}
			set;		
		}
		
	public static list<Account> getSRSSthroughZ{
		get{
			list<Account> srsAccount = [SELECT ID, 
								  			   Name 
						   				FROM Account 
								   		WHERE RecordTypeID =: getSRSStandardID 
						   				AND Name > 'S'];
			return srsAccount;
			}
			set;		
		}
    
    //Begin RHC/KHRS Gets
    public static ID getPFTask{
		get{
			ID pfTask;
			for(RecordType rt: typeList){
   				if(rt.DeveloperName == 'Partner_First_Task'){
   					pfTask = rt.ID;
   					}	
   				}
			return pfTask;
			}
		set;	
		}
		
	public static list<ID> getRHCAccIDs{
		get{
			list<ID> rhcAccIDs = new list<ID>();
			for(RecordType rt: typeList){
   				if(rt.DeveloperName == 'PF_Chain' || rt.DeveloperName == 'PF_Client'){
   					rhcAccIDs.add(rt.ID);
   					}
				}
				return rhcAccIDs;
			}
		set;
		}	
    
    public static ID getLegacySalesPerfID{
		get{
			ID legacyType;
			for(RecordType rt: typeList){
   				if(rt.DeveloperName == 'Legacy'){
   					legacyType = rt.ID;
   					}	
   				}
   			return legacyType;
			}
		set;	
		}	
	
	//Begin Error Correct Methods
    public static String removeDiacritics(String text){
        for (String letter : patterns.keySet())
            text = text.replaceAll(patterns.get(letter), letter);
        return text;
    	}
    	
    static Map<String, String> patterns = new Map<String, String>{
        'A' => '[\u0041\u24B6\uFF21\u00C0\u00C1\u00C2\u1EA6\u1EA4\u1EAA\u1EA8\u00C3\u0100\u0102\u1EB0\u1EAE\u1EB4\u1EB2\u0226\u01E0\u00C4\u01DE\u1EA2\u00C5\u01FA\u01CD\u0200\u0202\u1EA0\u1EAC\u1EB6\u1E00\u0104\u023A\u2C6F]',
        'AA' => '[\uA732]',
        'AE' => '[\u00C6\u01FC\u01E2]',
        'AO' => '[\uA734]',
        'AU' => '[\uA736]',
        'AV' => '[\uA738\uA73A]',
        'AY' => '[\uA73C]',
        'B' => '[\u0042\u24B7\uFF22\u1E02\u1E04\u1E06\u0243\u0182\u0181]',
        'C' => '[\u0043\u24B8\uFF23\u0106\u0108\u010A\u010C\u00C7\u1E08\u0187\u023B\uA73E]',
        'D' => '[\u0044\u24B9\uFF24\u1E0A\u010E\u1E0C\u1E10\u1E12\u1E0E\u0110\u018B\u018A\u0189\uA779]',
        'DZ' => '[\u01F1\u01C4]',
        'Dz' => '[\u01F2\u01C5]',
        'E' => '[\u0045\u24BA\uFF25\u00C8\u00C9\u00CA\u1EC0\u1EBE\u1EC4\u1EC2\u1EBC\u0112\u1E14\u1E16\u0114\u0116\u00CB\u1EBA\u011A\u0204\u0206\u1EB8\u1EC6\u0228\u1E1C\u0118\u1E18\u1E1A\u0190\u018E]',
        'F' => '[\u0046\u24BB\uFF26\u1E1E\u0191\uA77B]',
        'G' => '[\u0047\u24BC\uFF27\u01F4\u011C\u1E20\u011E\u0120\u01E6\u0122\u01E4\u0193\uA7A0\uA77D\uA77E]',
        'H' => '[\u0048\u24BD\uFF28\u0124\u1E22\u1E26\u021E\u1E24\u1E28\u1E2A\u0126\u2C67\u2C75\uA78D]',
        'I' => '[\u0049\u24BE\uFF29\u00CC\u00CD\u00CE\u0128\u012A\u012C\u0130\u00CF\u1E2E\u1EC8\u01CF\u0208\u020A\u1ECA\u012E\u1E2C\u0197]',
        'J' => '[\u004A\u24BF\uFF2A\u0134\u0248]',
        'K' => '[\u004B\u24C0\uFF2B\u1E30\u01E8\u1E32\u0136\u1E34\u0198\u2C69\uA740\uA742\uA744\uA7A2]',
        'L' => '[\u004C\u24C1\uFF2C\u013F\u0139\u013D\u1E36\u1E38\u013B\u1E3C\u1E3A\u0141\u023D\u2C62\u2C60\uA748\uA746\uA780]',
        'LJ' => '[\u01C7]',
        'Lj' => '[\u01C8]',
        'M' => '[\u004D\u24C2\uFF2D\u1E3E\u1E40\u1E42\u2C6E\u019C]',
        'N' => '[\u004E\u24C3\uFF2E\u01F8\u0143\u00D1\u1E44\u0147\u1E46\u0145\u1E4A\u1E48\u0220\u019D\uA790\uA7A4]',
        'NJ' => '[\u01CA]',
        'Nj' => '[\u01CB]',
        'O' => '[\u004F\u24C4\uFF2F\u00D2\u00D3\u00D4\u1ED2\u1ED0\u1ED6\u1ED4\u00D5\u1E4C\u022C\u1E4E\u014C\u1E50\u1E52\u014E\u022E\u0230\u00D6\u022A\u1ECE\u0150\u01D1\u020C\u020E\u01A0\u1EDC\u1EDA\u1EE0\u1EDE\u1EE2\u1ECC\u1ED8\u01EA\u01EC\u00D8\u01FE\u0186\u019F\uA74A\uA74C]',
        'OI' => '[\u01A2]',
        'OO' => '[\uA74E]',
        'OU' => '[\u0222]',
        'P' => '[\u0050\u24C5\uFF30\u1E54\u1E56\u01A4\u2C63\uA750\uA752\uA754]',
        'Q' => '[\u0051\u24C6\uFF31\uA756\uA758\u024A]',
        'R' => '[\u0052\u24C7\uFF32\u0154\u1E58\u0158\u0210\u0212\u1E5A\u1E5C\u0156\u1E5E\u024C\u2C64\uA75A\uA7A6\uA782]',
        'S' => '[\u0053\u24C8\uFF33\u1E9E\u015A\u1E64\u015C\u1E60\u0160\u1E66\u1E62\u1E68\u0218\u015E\u2C7E\uA7A8\uA784]',
        'T' => '[\u0054\u24C9\uFF34\u1E6A\u0164\u1E6C\u021A\u0162\u1E70\u1E6E\u0166\u01AC\u01AE\u023E\uA786]',
        'TZ' => '[\uA728]',
        'U' => '[\u0055\u24CA\uFF35\u00D9\u00DA\u00DB\u0168\u1E78\u016A\u1E7A\u016C\u00DC\u01DB\u01D7\u01D5\u01D9\u1EE6\u016E\u0170\u01D3\u0214\u0216\u01AF\u1EEA\u1EE8\u1EEE\u1EEC\u1EF0\u1EE4\u1E72\u0172\u1E76\u1E74\u0244]',
        'V' => '[\u0056\u24CB\uFF36\u1E7C\u1E7E\u01B2\uA75E\u0245]',
        'VY' => '[\uA760]',
        'W' => '[\u0057\u24CC\uFF37\u1E80\u1E82\u0174\u1E86\u1E84\u1E88\u2C72]',
        'X' => '[\u0058\u24CD\uFF38\u1E8A\u1E8C]',
        'Y' => '[\u0059\u24CE\uFF39\u1EF2\u00DD\u0176\u1EF8\u0232\u1E8E\u0178\u1EF6\u1EF4\u01B3\u024E\u1EFE]',
        'Z' => '[\u005A\u24CF\uFF3A\u0179\u1E90\u017B\u017D\u1E92\u1E94\u01B5\u0224\u2C7F\u2C6B\uA762]',
        'a' => '[\u0061\u24D0\uFF41\u1E9A\u00E0\u00E1\u00E2\u1EA7\u1EA5\u1EAB\u1EA9\u00E3\u0101\u0103\u1EB1\u1EAF\u1EB5\u1EB3\u0227\u01E1\u00E4\u01DF\u1EA3\u00E5\u01FB\u01CE\u0201\u0203\u1EA1\u1EAD\u1EB7\u1E01\u0105\u2C65\u0250]',
        'aa' => '[\uA733]',
        'ae' => '[\u00E6\u01FD\u01E3]',
        'ao' => '[\uA735]',
        'au' => '[\uA737]',
        'av' => '[\uA739\uA73B]',
        'ay' => '[\uA73D]',
        'b' => '[\u0062\u24D1\uFF42\u1E03\u1E05\u1E07\u0180\u0183\u0253]',
        'c' => '[\u0063\u24D2\uFF43\u0107\u0109\u010B\u010D\u00E7\u1E09\u0188\u023C\uA73F\u2184]',
        'd' => '[\u0064\u24D3\uFF44\u1E0B\u010F\u1E0D\u1E11\u1E13\u1E0F\u0111\u018C\u0256\u0257\uA77A]',
        'dz' => '[\u01F3\u01C6]',
        'e' => '[\u0065\u24D4\uFF45\u00E8\u00E9\u00EA\u1EC1\u1EBF\u1EC5\u1EC3\u1EBD\u0113\u1E15\u1E17\u0115\u0117\u00EB\u1EBB\u011B\u0205\u0207\u1EB9\u1EC7\u0229\u1E1D\u0119\u1E19\u1E1B\u0247\u025B\u01DD]',
        'f' => '[\u0066\u24D5\uFF46\u1E1F\u0192\uA77C]',
        'g' => '[\u0067\u24D6\uFF47\u01F5\u011D\u1E21\u011F\u0121\u01E7\u0123\u01E5\u0260\uA7A1\u1D79\uA77F]',
        'h' => '[\u0068\u24D7\uFF48\u0125\u1E23\u1E27\u021F\u1E25\u1E29\u1E2B\u1E96\u0127\u2C68\u2C76\u0265]',
        'hv' => '[\u0195]',
        'i' => '[\u0069\u24D8\uFF49\u00EC\u00ED\u00EE\u0129\u012B\u012D\u00EF\u1E2F\u1EC9\u01D0\u0209\u020B\u1ECB\u012F\u1E2D\u0268\u0131]',
        'j' => '[\u006A\u24D9\uFF4A\u0135\u01F0\u0249]',
        'k' => '[\u006B\u24DA\uFF4B\u1E31\u01E9\u1E33\u0137\u1E35\u0199\u2C6A\uA741\uA743\uA745\uA7A3]',
        'l' => '[\u006C\u24DB\uFF4C\u0140\u013A\u013E\u1E37\u1E39\u013C\u1E3D\u1E3B\u017F\u0142\u019A\u026B\u2C61\uA749\uA781\uA747]',
        'lj' => '[\u01C9]',
        'm' => '[\u006D\u24DC\uFF4D\u1E3F\u1E41\u1E43\u0271\u026F]',
        'n' => '[\u006E\u24DD\uFF4E\u01F9\u0144\u00F1\u1E45\u0148\u1E47\u0146\u1E4B\u1E49\u019E\u0272\u0149\uA791\uA7A5]',
        'nj' => '[\u01CC]',
        'o' => '[\u006F\u24DE\uFF4F\u00F2\u00F3\u00F4\u1ED3\u1ED1\u1ED7\u1ED5\u00F5\u1E4D\u022D\u1E4F\u014D\u1E51\u1E53\u014F\u022F\u0231\u00F6\u022B\u1ECF\u0151\u01D2\u020D\u020F\u01A1\u1EDD\u1EDB\u1EE1\u1EDF\u1EE3\u1ECD\u1ED9\u01EB\u01ED\u00F8\u01FF\u0254\uA74B\uA74D\u0275]',
        'oi' => '[\u01A3]',
        'ou' => '[\u0223]',
        'oo' => '[\uA74F]',
        'p' => '[\u0070\u24DF\uFF50\u1E55\u1E57\u01A5\u1D7D\uA751\uA753\uA755]',
        'q' => '[\u0071\u24E0\uFF51\u024B\uA757\uA759]',
        'r' => '[\u0072\u24E1\uFF52\u0155\u1E59\u0159\u0211\u0213\u1E5B\u1E5D\u0157\u1E5F\u024D\u027D\uA75B\uA7A7\uA783]',
        's' => '[\u0073\u24E2\uFF53\u00DF\u015B\u1E65\u015D\u1E61\u0161\u1E67\u1E63\u1E69\u0219\u015F\u023F\uA7A9\uA785\u1E9B]',
        't' => '[\u0074\u24E3\uFF54\u1E6B\u1E97\u0165\u1E6D\u021B\u0163\u1E71\u1E6F\u0167\u01AD\u0288\u2C66\uA787]',
        'tz' => '[\uA729]',
        'u' => '[\u0075\u24E4\uFF55\u00F9\u00FA\u00FB\u0169\u1E79\u016B\u1E7B\u016D\u00FC\u01DC\u01D8\u01D6\u01DA\u1EE7\u016F\u0171\u01D4\u0215\u0217\u01B0\u1EEB\u1EE9\u1EEF\u1EED\u1EF1\u1EE5\u1E73\u0173\u1E77\u1E75\u0289]',
        'v' => '[\u0076\u24E5\uFF56\u1E7D\u1E7F\u028B\uA75F\u028C]',
        'vy' => '[\uA761]',
        'w' => '[\u0077\u24E6\uFF57\u1E81\u1E83\u0175\u1E87\u1E85\u1E98\u1E89\u2C73]',
        'x' => '[\u0078\u24E7\uFF58\u1E8B\u1E8D]',
        'y' => '[\u0079\u24E8\uFF59\u1EF3\u00FD\u0177\u1EF9\u0233\u1E8F\u00FF\u1EF7\u1E99\u1EF5\u01B4\u024F\u1EFF]',
        'z' => '[\u007A\u24E9\uFF5A\u017A\u1E91\u017C\u017E\u1E93\u1E95\u01B6\u0225\u0240\u2C6C\uA763]'
    };
    
    
    //Begin Test Data Generation Methods
    public static string getTestJSON{
    	get{
    		string testJson = '{"results" : [{"address_components":[{"long_name" : "1700","short_name" : "1700","types" : ["street_number"]},{"long_name" : "East 123rd Street","short_name" :"E 123rd St","types" : ["route"]},{"long_name" : "Rosehill North Business Park","short_name": "Rosehill North Business Park","types" : ["neightborhood","political"]},{"long_name" : "Olathe","short_name" : "Olathe","types" : ["locality", "political"]},{"long_name" : "Johnson County","short_name":"Johnson County","types" : [ "administrative_area_level_2", "political" ]},{"long_name" : "Kansas","short_name" : "KS","types" : ["administrative_area_level_1", "political" ]},{"long_name" : "United States","short_name" : "US","types" : [ "country", "political" ]},{"long_name" : "66061","short_name" : "66061","types" : [ "postal_code" ]},{"long_name" : "5882","short_name" : "5882","types" : [ "postal_code_suffix" ]}],"formatted_address":"1700 E 123rd St, Olathe, KS 66061, USA","geometry" : {"location" : {"lat" : 38.906494,"lng" : -94.787249},"location_type" : "ROOFTOP","viewport" : {"northeast" : {"lat" : 38.90784298029149,"lng" : -94.78590001970851},"southwest" : {"lat" : 38.9051450197085,"lng" : -94.78859798029151}}},"place_id" : "ChIJ-_zEG5SVwIcRmbVmco91PCA","plus_code" : {"compound_code" : "W647+H4 Olathe, Kansas, United States","global_code" :"86C7W647+H4"},"types" : [ "establishment", "point_of_interest" ]}],"status" : "OK"}';
    		return testJson;
    	}
    	set;
    }
    
    public static list<Account> getTestList{
    	get{
    		list<Account> testList = new list<Account>();
    		id CenterID = getCenterID;
    		Account objAccount = new Account(Name='TestAccount', 
        								 RecordTypeId = CenterID,
        								 ShippingPostalCode = '40202',
        								 ShippingStreet = '680 S 4th S',
        								 ShippingCity = 'Louisville',
        								 ShippingState = 'KY',
        								 Phone = '555-555-5555',
        								 Shipping_Geolocation__Latitude__s = 38.2459027,
        								 Shipping_Geolocation__Longitude__s = -85.7704417);
        	Account objAccount2 = new Account(Name='TestAccount2', 
        								 RecordTypeId = CenterID,
        								 ShippingPostalCode = '40202',
        								 ShippingStreet = '680 S 4th S',
        								 ShippingCity = 'Louisville',
        								 ShippingState = 'KY',
        								 Phone = '555-555-5555',
        								 Shipping_Geolocation__Latitude__s = 38.2459027,
        								 Shipping_Geolocation__Longitude__s = -85.7704417);
			Account objAccount3 = new Account(Name='TestAccount', 
        								 RecordTypeId = CenterID,
        								 ShippingPostalCode = '40202',
        								 ShippingStreet = '680 S 4th S',
        								 ShippingCity = 'Louisville',
        								 ShippingState = 'KY',
        								 Phone = '555-555-5555',
        								 Shipping_Geolocation__Latitude__s = 38.2459027,
        								 Shipping_Geolocation__Longitude__s = -85.7704417);        								 							 
        	testList.add(objAccount);
        	testList.add(objAccount2);
        	testList.add(objAccount3);
    		return testList;
    		}
    	set;
    }
    
}