Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 086FF303E6A
	for <lists+linux-fpga@lfdr.de>; Tue, 26 Jan 2021 14:19:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404337AbhAZNSZ (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 26 Jan 2021 08:18:25 -0500
Received: from mga02.intel.com ([134.134.136.20]:5699 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392670AbhAZNSQ (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 26 Jan 2021 08:18:16 -0500
IronPort-SDR: bRDSox69Azof9ZLCF/D2L022i++GFvJRfOUlzYL25xzJK1yEVOVYGv/xatGiqm2E4/AMJBF8bX
 iTWv1vIfuoWw==
X-IronPort-AV: E=McAfee;i="6000,8403,9875"; a="166997905"
X-IronPort-AV: E=Sophos;i="5.79,375,1602572400"; 
   d="scan'208";a="166997905"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2021 05:16:28 -0800
IronPort-SDR: iEy1nPvuu/vEpkIaX4a9ahnPqAYZm0rlGksNsI0dxbqOOiRSdLbTXETvZRwMP8LUorBgbWasmk
 /pOXnRPpsTyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,375,1602572400"; 
   d="scan'208";a="356720174"
Received: from marshy.an.intel.com (HELO [10.122.105.143]) ([10.122.105.143])
  by orsmga006.jf.intel.com with ESMTP; 26 Jan 2021 05:16:27 -0800
Subject: Re: [PATCHv3 2/6] firmware: stratix10-svc: extend SVC driver to get
 the firmware version
To:     Moritz Fischer <mdf@kernel.org>
Cc:     trix@redhat.com, gregkh@linuxfoundation.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        dinguyen@kernel.org, sridhar.rajagopal@intel.com,
        Richard Gong <richard.gong@intel.com>
References: <1611608188-25621-1-git-send-email-richard.gong@linux.intel.com>
 <1611608188-25621-3-git-send-email-richard.gong@linux.intel.com>
 <YA+iOW079Pq6L6yH@epycbox.lan>
From:   Richard Gong <richard.gong@linux.intel.com>
Message-ID: <0ad58df2-ed90-d0c3-e268-a98e34df84d9@linux.intel.com>
Date:   Tue, 26 Jan 2021 07:37:13 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YA+iOW079Pq6L6yH@epycbox.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Moritz,

Thanks for your reviews!

On 1/25/21 11:01 PM, Moritz Fischer wrote:
> Hi Richard,
> 
> On Mon, Jan 25, 2021 at 02:56:24PM -0600, richard.gong@linux.intel.com wrote:
>> From: Richard Gong <richard.gong@intel.com>
>>
>> Extend Intel service layer driver to get the firmware version running at
>> FPGA device. Therefore FPGA manager driver, one of Intel service layer
>> driver's client, can decide whether to handle the newly added bitstream
>> authentication function based on the retrieved firmware version.
>>
>> Signed-off-by: Richard Gong <richard.gong@intel.com>
>> ---
>> v3: new added, changes for getting firmware version
> Thanks for doing that.
>> ---
>>   drivers/firmware/stratix10-svc.c                    | 12 ++++++++++--
>>   include/linux/firmware/intel/stratix10-smc.h        | 21 +++++++++++++++++++--
>>   include/linux/firmware/intel/stratix10-svc-client.h |  4 ++++
>>   3 files changed, 33 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/firmware/stratix10-svc.c b/drivers/firmware/stratix10-svc.c
>> index 3aa489d..1443bbd 100644
>> --- a/drivers/firmware/stratix10-svc.c
>> +++ b/drivers/firmware/stratix10-svc.c
>> @@ -306,6 +306,7 @@ static void svc_thread_recv_status_ok(struct stratix10_svc_data *p_data,
>>   		break;
>>   	case COMMAND_RSU_RETRY:
>>   	case COMMAND_RSU_MAX_RETRY:
>> +	case COMMAND_FIRMWARE_VERSION:
>>   		cb_data->status = BIT(SVC_STATUS_OK);
>>   		cb_data->kaddr1 = &res.a1;
>>   		break;
>> @@ -422,6 +423,11 @@ static int svc_normal_to_secure_thread(void *data)
>>   			a1 = 0;
>>   			a2 = 0;
>>   			break;
>> +		case COMMAND_FIRMWARE_VERSION:
>> +			a0 = INTEL_SIP_SMC_FIRMWARE_VERSION;
>> +			a1 = 0;
>> +			a2 = 0;
>> +			break;
>>   		default:
>>   			pr_warn("it shouldn't happen\n");
>>   			break;
>> @@ -487,11 +493,13 @@ static int svc_normal_to_secure_thread(void *data)
>>   
>>   			/*
>>   			 * be compatible with older version firmware which
>> -			 * doesn't support RSU notify or retry
>> +			 * doesn't support RSU notify, retry or bitstream
>> +			 * authentication.
>>   			 */
>>   			if ((pdata->command == COMMAND_RSU_RETRY) ||
>>   			    (pdata->command == COMMAND_RSU_MAX_RETRY) ||
>> -				(pdata->command == COMMAND_RSU_NOTIFY)) {
>> +			    (pdata->command == COMMAND_RSU_NOTIFY) ||
>> +			    (pdata->command == COMMAND_FIRMWARE_VERSION)) {
>>   				cbdata->status =
>>   					BIT(SVC_STATUS_NO_SUPPORT);
>>   				cbdata->kaddr1 = NULL;
>> diff --git a/include/linux/firmware/intel/stratix10-smc.h b/include/linux/firmware/intel/stratix10-smc.h
>> index c3e5ab0..505fcca 100644
>> --- a/include/linux/firmware/intel/stratix10-smc.h
>> +++ b/include/linux/firmware/intel/stratix10-smc.h
>> @@ -321,8 +321,6 @@ INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_FPGA_CONFIG_COMPLETED_WRITE)
>>   #define INTEL_SIP_SMC_ECC_DBE \
>>   	INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_ECC_DBE)
>>   
>> -#endif
>> -
>>   /**
>>    * Request INTEL_SIP_SMC_RSU_NOTIFY
>>    *
>> @@ -404,3 +402,22 @@ INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_FPGA_CONFIG_COMPLETED_WRITE)
>>   #define INTEL_SIP_SMC_FUNCID_RSU_MAX_RETRY 18
>>   #define INTEL_SIP_SMC_RSU_MAX_RETRY \
>>   	INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_RSU_MAX_RETRY)
>> +
>> +/**
>> + * Request INTEL_SIP_SMC_FIRMWARE_VERSION
>> + *
>> + * Sync call used to query the version of running firmware
>> + *
>> + * Call register usage:
>> + * a0 INTEL_SIP_SMC_FIRMWARE_VERSION
>> + * a1-a7 not used
>> + *
>> + * Return status:
>> + * a0 INTEL_SIP_SMC_STATUS_OK or INTEL_SIP_SMC_STATUS_ERROR
>> + * a1 running firmware version
>> + */
>> +#define INTEL_SIP_SMC_FUNCID_FIRMWARE_VERSION 31
>> +#define INTEL_SIP_SMC_FIRMWARE_VERSION \
>> +	INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_FIRMWARE_VERSION)
>> +
>> +#endif
>> diff --git a/include/linux/firmware/intel/stratix10-svc-client.h b/include/linux/firmware/intel/stratix10-svc-client.h
>> index 7ada1f2..15e5477 100644
>> --- a/include/linux/firmware/intel/stratix10-svc-client.h
>> +++ b/include/linux/firmware/intel/stratix10-svc-client.h
>> @@ -109,6 +109,9 @@ struct stratix10_svc_chan;
>>    *
>>    * @COMMAND_RSU_DCMF_VERSION: query firmware for the DCMF version, return status
>>    * is SVC_STATUS_OK or SVC_STATUS_ERROR
> Is DCMF explaines somewhere? Maybe I missed it.

Documentation/ABI/testing/sysfs-devices-platform-stratix10-rsu.

RSU (Remote System Update) allows user to reliably update the QSPI 
configuration bitstream of an Intel Stratix10 SoC device.

When the user enables RSU function on the device, he/she need to use the 
Intel Quartus tools to build RSU flash image. The flash content should 
include DCMF and other components to make it have RSU function.

DCMF (Decision Configuration Management Firmware) serves as the decision 
maker to select the one of application images or factory image to load. 
When one of the application image failed, DCMF will locate and switch to 
the next application image. If all application failed, the factory image 
will be loaded.

>> + *
>> + * @COMMAND_FIRMWARE_VERSION: query running firmware version, return status
>> + * is SVC_STATUS_OK or SVC_STATUS_ERROR
>>    */
>>   enum stratix10_svc_command_code {
>>   	COMMAND_NOOP = 0,
>> @@ -122,6 +125,7 @@ enum stratix10_svc_command_code {
>>   	COMMAND_RSU_RETRY,
>>   	COMMAND_RSU_MAX_RETRY,
>>   	COMMAND_RSU_DCMF_VERSION,
>> +	COMMAND_FIRMWARE_VERSION,
>>   };
>>   
>>   /**
>> -- 
>> 2.7.4
>>
> Thanks,
> Moritz
> 
Regards,
Richard
