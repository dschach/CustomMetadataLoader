/**
 * Copyright (c) 2016, salesforce.com, inc.
 * All rights reserved.
 * Licensed under the BSD 3-Clause license.
 * For full license text, see LICENSE.txt file in the repo root  or https://opensource.org/licenses/BSD-3-Clause
 */

/**
 * Please note this is just a sample usage class. You need to replace hard-coded
 * values with real values.
 *
 **/
public class MetadataLoaderClient {
	//public void migrateMetatdataApex() {}

	/*********************************************************
	 * @description This will create custom object and then migrate Custom Settings data
	 * to Custom Metadata Types records as is
	 *
	 * @param csName Name of Custom Setting Api (VAT_Settings_CS__c)
	 * @param mdtName Name of Custom Metadata Types Api (VAT_Settings__mdt)
	 *********************************************************/
	public void migrateAsIsWithObjCreation(String csName, String mdtName) {
		MetadataLoader loader = MetadataLoaderFactory.getLoader(MetadataOpType.APEXWRAPPER);
		loader.migrateAsIsWithObjCreation(csName, mdtName);
	}

	/*********************************************************
	 * @description Migrate Custom Settings data to Custom Metadata Types records as is
	 *
	 * @param csName Name of Custom Setting Api (VAT_Settings_CS__c)
	 * @param mdtName Name of Custom Metadata Types Api (VAT_Settings__mdt)
	 *********************************************************/
	public void migrateAsIsMapping(String csName, String mdtName) {
		MetadataLoader loader = MetadataLoaderFactory.getLoader(MetadataOpType.APEXWRAPPER);
		loader.migrateAsIsMapping(csName, mdtName);
	}

	/*********************************************************
	 * @description Migrate Custom Settings data to Custom Metadata Types records if you
	 * have only one field mapping
	 *
	 * @param csNameWithField Name of Custom Setting Api.fieldName (VAT_Settings_CS__c.Active__c)
	 * @param mdtNameWithField Name of Custom Metadata Types Api.fieldName
	 *            (VAT_Settings__mdt.IsActive__c)
	 *********************************************************/
	public void migrateSimpleMapping(String csNameWithField, String mdtNameWithField) {
		MetadataLoader loader = MetadataLoaderFactory.getLoader(MetadataOpType.APEXWRAPPER);
		loader.migrateSimpleMapping(csNameWithField, mdtNameWithField);
	}

	/*********************************************************
	 * @description Migrate Custom Settings data to Custom Metadata Types records if you
	 * have only different Api names in Custom Settings and Custom Metadata
	 * Types
	 *
	 * @param csName Name of Custom Setting Api (VAT_Settings_CS__c)
	 * @param mdtName Name of Custom Metadata Types Api (VAT_Settings__mdt)
	 * @param jsonMapping Json Mapping (Sample below)
	 * @example
	 * { "Active__c" : "IsActive__c",
	 * "Timeout__c" : "GlobalTimeout__c",
	 * "EndPointURL__c" : "URL__c" }
	 *
	 *********************************************************/
	public void migrateCustomMapping(String csName, String mdtName, String jsonMapping) {
		MetadataLoader loader = MetadataLoaderFactory.getLoader(MetadataOpType.APEXWRAPPER);
		loader.migrateCustomMapping(csName, mdtName, jsonMapping);
	}
}