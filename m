Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03E0F2B72EC
	for <lists+linux-fpga@lfdr.de>; Wed, 18 Nov 2020 01:17:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbgKRARD (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 17 Nov 2020 19:17:03 -0500
Received: from mga04.intel.com ([192.55.52.120]:54467 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726202AbgKRARC (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 17 Nov 2020 19:17:02 -0500
IronPort-SDR: b8bA3KtzE/S/4QUXTeLhqhmt8yqcgsYscoVdTaQI3TJ1uhqoMpgr8Xp4zP/dthyyFbKxD9+aoF
 4ovZvc1EAKeg==
X-IronPort-AV: E=McAfee;i="6000,8403,9808"; a="168466272"
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; 
   d="scan'208";a="168466272"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2020 16:17:02 -0800
IronPort-SDR: DClsseHVbLjb7Cvh9XQq7XZQwYxjsVM4Y8Czp/d1BXkRsDuYYwS+VuNiX+yFdJQeRSnYZX4ifL
 /v5jh9uhvSrw==
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; 
   d="scan'208";a="544268385"
Received: from rhweight-mobl2.amr.corp.intel.com (HELO [10.0.2.4]) ([10.212.81.41])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2020 16:17:01 -0800
Subject: Re: [PATCH v5 6/6] fpga: m10bmc-sec: add max10 get_hw_errinfo
 callback func
To:     Tom Rix <trix@redhat.com>, mdf@kernel.org, lee.jones@linaro.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     lgoncalv@redhat.com, yilun.xu@intel.com, hao.wu@intel.com,
        matthew.gerlach@intel.com
References: <20201114005559.90860-1-russell.h.weight@intel.com>
 <20201114005559.90860-7-russell.h.weight@intel.com>
 <d0e4819b-87b8-ef6f-9ede-adc28e10b2f8@redhat.com>
From:   Russ Weight <russell.h.weight@intel.com>
Message-ID: <be5ecb61-2cfd-a179-3f29-36af8bd69855@intel.com>
Date:   Tue, 17 Nov 2020 16:16:57 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <d0e4819b-87b8-ef6f-9ede-adc28e10b2f8@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On 11/15/20 6:20 AM, Tom Rix wrote:
> On 11/13/20 4:55 PM, Russ Weight wrote:
>> Extend the MAX10 BMC Secure Update driver to include
>> a function that returns 64 bits of additional HW specific
>> data for errors that require additional information.
>> This callback function enables the hw_errinfo sysfs
>> node in the Intel Security Manager class driver.
>>
>> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
>> ---
>> v5:
>>   - No change
>> v4:
>>   - No change
>> v3:
>>   - Changed: iops -> sops, imgr -> smgr, IFPGA_ -> FPGA_, ifpga_ to fpga_
>>   - Changed "MAX10 BMC Secure Engine driver" to "MAX10 BMC Secure Update
>>     driver"
>> v2:
>>   - Implemented HW_ERRINFO_POISON for m10bmc_sec_hw_errinfo() to
>>     ensure that corresponding bits are set to 1 if we are unable
>>     to read the doorbell or auth_result registers.
>>   - Added m10bmc_ prefix to functions in m10bmc_iops structure
>> ---
>>  drivers/fpga/intel-m10-bmc-secure.c | 25 +++++++++++++++++++++++++
>>  1 file changed, 25 insertions(+)
>>
>> diff --git a/drivers/fpga/intel-m10-bmc-secure.c b/drivers/fpga/intel-m10-bmc-secure.c
>> index 4fa8a2256088..a024efb173d3 100644
>> --- a/drivers/fpga/intel-m10-bmc-secure.c
>> +++ b/drivers/fpga/intel-m10-bmc-secure.c
>> @@ -472,11 +472,36 @@ static enum fpga_sec_err m10bmc_sec_cancel(struct fpga_sec_mgr *smgr)
>>  	return ret ? FPGA_SEC_ERR_RW_ERROR : FPGA_SEC_ERR_NONE;
>>  }
>>  
>> +#define HW_ERRINFO_POISON	GENMASK(31, 0)
>> +static u64 m10bmc_sec_hw_errinfo(struct fpga_sec_mgr *smgr)
>> +{
>> +	struct m10bmc_sec *sec = smgr->priv;
>> +	u32 doorbell, auth_result;
> If doorbell and auth_result were poisoned at initialization, the if-checks could be skipped.

Yes - I'll make this change.

- Russ
>
> Tom
>
>> +
>> +	switch (smgr->err_code) {
>> +	case FPGA_SEC_ERR_HW_ERROR:
>> +	case FPGA_SEC_ERR_TIMEOUT:
>> +	case FPGA_SEC_ERR_BUSY:
>> +	case FPGA_SEC_ERR_WEAROUT:
>> +		if (m10bmc_sys_read(sec->m10bmc, M10BMC_DOORBELL, &doorbell))
>> +			doorbell = HW_ERRINFO_POISON;
>> +
>> +		if (m10bmc_sys_read(sec->m10bmc, M10BMC_AUTH_RESULT,
>> +				    &auth_result))
>> +			auth_result = HW_ERRINFO_POISON;
>> +
>> +		return (u64)doorbell << 32 | (u64)auth_result;
>> +	default:
>> +		return 0;
>> +	}
>> +}
>> +
>>  static const struct fpga_sec_mgr_ops m10bmc_sops = {
>>  	.prepare = m10bmc_sec_prepare,
>>  	.write_blk = m10bmc_sec_write_blk,
>>  	.poll_complete = m10bmc_sec_poll_complete,
>>  	.cancel = m10bmc_sec_cancel,
>> +	.get_hw_errinfo = m10bmc_sec_hw_errinfo,
>>  };
>>  
>>  static int m10bmc_secure_probe(struct platform_device *pdev)

