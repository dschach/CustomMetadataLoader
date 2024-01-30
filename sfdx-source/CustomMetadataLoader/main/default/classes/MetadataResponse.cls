/**
 * Copyright (c) 2016, salesforce.com, inc.
 * All rights reserved.
 * Licensed under the BSD 3-Clause license.
 * For full license text, see LICENSE.txt file in the repo root  or https://opensource.org/licenses/BSD-3-Clause
 */

public with sharing class MetadataResponse {
	private Boolean isSuccess;
	private List<Message> messages;
	private MetadataMappingInfo mappingInfo;

	@SuppressWarnings('PMD.EmptyStatementBlock')
	public MetadataResponse() {
	}

	public MetadataResponse(Boolean bIsSuccess, MetadataMappingInfo info, List<MetadataResponse.Message> messagesList) {
		this.isSuccess = bIsSuccess;
		this.messages = messagesList;
		this.mappingInfo = info;
	}

	public Boolean isSuccess() {
		return this.isSuccess;
	}

	public void setIsSuccess(Boolean isSuccess) {
		this.isSuccess = isSuccess;
	}

	public void setMappingInfo(MetadataMappingInfo info) {
		this.mappingInfo = info;
	}
	public MetadataMappingInfo getMappingInfo() {
		return this.mappingInfo;
	}

	public List<Message> getMessages() {
		return this.messages;
	}

	public void setMessages(List<Message> msg) {
		this.messages = msg;
	}

	public with sharing class Message {
		public Integer messageCode;
		public String messageDetail;

		@SuppressWarnings('PMD.EmptyStatementBlock')
		public Message() {
		}

		public Message(Integer code, String message) {
			this.messageCode = code;
			this.messageDetail = message;
		}
	}

	public String debug() {
		return 'MetadataResponse{' + 'success=' + isSuccess() + ', messages=' + getMessages() + ', mapping info=' + getMappingInfo() + '}';
	}
}