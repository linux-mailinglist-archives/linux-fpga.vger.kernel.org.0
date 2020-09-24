Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96D71277B37
	for <lists+linux-fpga@lfdr.de>; Thu, 24 Sep 2020 23:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbgIXVs2 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 24 Sep 2020 17:48:28 -0400
Received: from mga18.intel.com ([134.134.136.126]:43635 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726205AbgIXVs2 (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 24 Sep 2020 17:48:28 -0400
IronPort-SDR: aKY0DJCbP6zXfkBRojHV42LMNyTO7AVY5bBU5I3bFS9k+GTUwtErSbELo1dbD0zVhXhl13k35F
 6/S1v2TX8wmg==
X-IronPort-AV: E=McAfee;i="6000,8403,9754"; a="149103634"
X-IronPort-AV: E=Sophos;i="5.77,299,1596524400"; 
   d="scan'208";a="149103634"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2020 14:48:27 -0700
IronPort-SDR: ssnsRTuUVyjueYhkIc06VqG7xTF4vVobdiQ2zKoOjNlG6PqIN0aN8BzOl2P5YElYwjEP6plnYq
 jg0vRcVZUigw==
X-IronPort-AV: E=Sophos;i="5.77,299,1596524400"; 
   d="scan'208";a="455530722"
Received: from rhweight-mobl2.amr.corp.intel.com (HELO [10.0.2.15]) ([10.213.163.145])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2020 14:48:27 -0700
Subject: Re: [PATCH v1 12/12] fpga: add max10 get_hw_errinfo callback func
To:     Tom Rix <trix@redhat.com>, mdf@kernel.org, lee.jones@linaro.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     lgoncalv@redhat.com, yilun.xu@intel.com, hao.wu@intel.com,
        matthew.gerlach@intel.com
References: <20200904235305.6254-1-russell.h.weight@intel.com>
 <20200904235305.6254-13-russell.h.weight@intel.com>
 <b90e8435-651c-e901-8be3-b0dac6eaac22@redhat.com>
From:   Russ Weight <russell.h.weight@intel.com>
Message-ID: <59ef7ab5-87be-3c5a-bee1-8bb165e69e48@intel.com>
Date:   Thu, 24 Sep 2020 14:48:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <b90e8435-651c-e901-8be3-b0dac6eaac22@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On 9/6/20 10:14 AM, Tom Rix wrote:
> On 9/4/20 4:53 PM, Russ Weight wrote:
>> Extend the MAX10 BMC Security Engine driver to include
>> a function that returns 64 bits of additional HW specific
>> data for errors that require additional information.
>> This callback function enables the hw_errinfo sysfs
>> node in the Intel Security Manager class driver.
>>
>> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
>> Reviewed-by: Wu Hao <hao.wu@intel.com>
>> ---
>>  drivers/fpga/intel-m10-bmc-secure.c | 27 ++++++++++++++++++++++++++-
>>  1 file changed, 26 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/fpga/intel-m10-bmc-secure.c b/drivers/fpga/intel-m10-bmc-secure.c
>> index 4a66c2d448eb..7fb1c805f654 100644
>> --- a/drivers/fpga/intel-m10-bmc-secure.c
>> +++ b/drivers/fpga/intel-m10-bmc-secure.c
>> @@ -450,6 +450,30 @@ static enum ifpga_sec_err m10bmc_sec_cancel(struct ifpga_sec_mgr *imgr)
>>  	return ret ? IFPGA_SEC_ERR_RW_ERROR : IFPGA_SEC_ERR_NONE;
>>  }
>>  
>> +static u64 m10bmc_sec_hw_errinfo(struct ifpga_sec_mgr *imgr)
>> +{
>> +	struct m10bmc_sec *sec = imgr->priv;
>> +	u32 doorbell = 0, auth_result = 0;
>> +	u64 hw_errinfo = 0;
> hw_errinfo should be initialized to some poison value like -1
>
> to cover the case if either of sys_read's fail.
Yes - that is a good idea. I'll make a change for the next patch version.

- Russ
>
> Tom
>
>> +
>> +	switch (imgr->err_code) {
>> +	case IFPGA_SEC_ERR_HW_ERROR:
>> +	case IFPGA_SEC_ERR_TIMEOUT:
>> +	case IFPGA_SEC_ERR_BUSY:
>> +	case IFPGA_SEC_ERR_WEAROUT:
>> +		if (!m10bmc_sys_read(sec->m10bmc, M10BMC_DOORBELL, &doorbell))
>> +			hw_errinfo = (u64)doorbell << 32;
>> +
>> +		if (!m10bmc_sys_read(sec->m10bmc, M10BMC_AUTH_RESULT,
>> +				     &auth_result))
>> +			hw_errinfo |= (u64)auth_result;
>> +
>> +		return hw_errinfo;
>> +	default:
>> +		return 0;
>> +	}
>> +}
>> +
>>  static const struct ifpga_sec_mgr_ops m10bmc_iops = {
>>  	.user_flash_count = get_qspi_flash_count,
>>  	.bmc_root_entry_hash = get_bmc_root_entry_hash,
>> @@ -467,7 +491,8 @@ static const struct ifpga_sec_mgr_ops m10bmc_iops = {
>>  	.prepare = m10bmc_sec_prepare,
>>  	.write_blk = m10bmc_sec_write_blk,
>>  	.poll_complete = m10bmc_sec_poll_complete,
>> -	.cancel = m10bmc_sec_cancel
>> +	.cancel = m10bmc_sec_cancel,
>> +	.get_hw_errinfo = m10bmc_sec_hw_errinfo
>>  };
>>  
>>  static void ifpga_sec_mgr_uinit(struct m10bmc_sec *sec)

