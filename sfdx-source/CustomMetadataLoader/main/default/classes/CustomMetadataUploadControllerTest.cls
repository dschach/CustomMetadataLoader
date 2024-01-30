/**
 * Copyright (c) 2016, salesforce.com, inc.
 * All rights reserved.
 * Licensed under the BSD 3-Clause license.
 * For full license text, see LICENSE.txt file in the repo root  or https://opensource.org/licenses/BSD-3-Clause
 */
@SuppressWarnings('PMD.ApexUnitTestClassShouldHaveAsserts,PMD.ApexAssertionsShouldIncludeMessage')
@isTest(SeeAllData=false)
public class CustomMetadataUploadControllerTest {
	@IsTest
	private static void testUploadNoFile() {
		CustomMetadataUploadController ctrl = setup(null);
		invokeCreateCMAndValidateError(ctrl, System.Label.FILE_MISSING);
	}

	@IsTest
	private static void testUploadEmptyFile() {
		CustomMetadataUploadController ctrl = setup(Blob.valueOf(''));
		invokeCreateCMAndValidateError(ctrl, System.Label.EMPTY_FILE);
	}

	@IsTest
	private static void testSelectedTypeMissing() {
		CustomMetadataUploadController ctrl = setup(Blob.valueOf('Text__c'), AppConstants.SELECT_STRING);
		invokeCreateCMAndValidateError(ctrl, System.Label.TYPE_OPTION_NOT_SELECTED);
	}

	@IsTest
	private static void testInvalidHeaderMissingFields() {
		CustomMetadataUploadController ctrl = setup(Blob.valueOf('Text__c'));
		invokeCreateCMAndValidateError(ctrl, AppConstants.HEADER_MISSING_DEVNAME_AND_LABEL);
	}

	@IsTest
	private static void testInvalidHeaderWrongFields() {
		CustomMetadataUploadController ctrl = setup(Blob.valueOf('Label,Text__c'));

		ctrl.upsertCustomMetadata();
		ApexPages.Message[] msgs = ApexPages.getMessages();
		System.assert(msgs.size() == 1, 'Should have only one message. Have ' + msgs.size() + '.');
		System.assert(msgs[0].getSummary().contains('Header must contain the api names of the fields.'), 'Actual message:' + msgs[0]);
	}

	@IsTest
	private static void testCreateCustomMetadata() {
		String countryLabel = 'AmericaTest' + Math.random();
		CustomMetadataUploadController ctrl = setup(Blob.valueOf('Label,CountryCode__c,CountryName__c\n' + countryLabel + ',US,America'));

		ctrl.upsertCustomMetadata();

		ApexPages.Message[] msgs = ApexPages.getMessages();
		System.assert(msgs.size() == 0, 'Error messages:' + msgs);
	}

	@IsTest
	private static void testCreateCustomMetadataWithDevName() {
		String countryLabel = 'AmericaTest' + Math.random();
		CustomMetadataUploadController ctrl = setup(Blob.valueOf('DeveloperName,CountryCode__c,CountryName__c\n' + countryLabel + ',US,America'));

		ctrl.upsertCustomMetadata();

		ApexPages.Message[] msgs = ApexPages.getMessages();
		System.assert(msgs.size() == 0, 'Error messages:' + msgs);
	}

	@IsTest
	private static void testInvalidFileRowSizeDoesntMatch() {
		String countryLabel = 'AmericaTest' + Math.random();
		CustomMetadataUploadController ctrl = setup(Blob.valueOf('DeveloperName,CountryCode__c,CountryName__c\n' + countryLabel + ',US'));

		invokeCreateCMAndValidateError(ctrl, System.Label.INVALID_FILE_ROW_SIZE_DOESNT_MATCH + '1');
	}

	static CustomMetadataUploadController setup(Blob file) {
		return setup(file, 'CountryMapping__mdt');
	}

	static CustomMetadataUploadController setup(Blob file, String selectedType) {
		Test.setMock(WebServiceMock.class, new MDWrapperWebServiceMock());
		CustomMetadataUploadController ctrl = new CustomMetadataUploadController();
		ctrl.setSelectedTypeForTest(selectedType);
		ctrl.setCsvBlobForTest(file);
		return ctrl;
	}

	static void invokeCreateCMAndValidateError(CustomMetadataUploadController ctrl, String errorMsg) {
		ctrl.upsertCustomMetadata();
		ApexPages.Message[] msgs = ApexPages.getMessages();
		System.assert(msgs.size() == 1, 'Should have only one message. Have ' + msgs.size() + '.');
		System.assert(msgs[0].getSummary().equals(errorMsg), 'Actual message:' + msgs[0]);
	}
}