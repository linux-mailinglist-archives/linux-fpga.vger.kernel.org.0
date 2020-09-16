Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3271D26C7FA
	for <lists+linux-fpga@lfdr.de>; Wed, 16 Sep 2020 20:37:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728085AbgIPShe (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 16 Sep 2020 14:37:34 -0400
Received: from mga18.intel.com ([134.134.136.126]:36560 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727988AbgIPShX (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 16 Sep 2020 14:37:23 -0400
IronPort-SDR: tsBJm73/uW+R5NGjRmz83B6C499fY/J6xZnQ6JUX5Oyo7IDVN08ZVO53rJ94oxnTm92aqrG00r
 Kkl5JtWXwDKQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9746"; a="147295243"
X-IronPort-AV: E=Sophos;i="5.76,433,1592895600"; 
   d="scan'208";a="147295243"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2020 11:37:22 -0700
IronPort-SDR: yIqZKZoIAucByuRZ7QV+Timoc9IDh9Gyc/zaJ2tGn7uHDEPCY+a1Dj5ZPAgLpX+n4KtCjSWlpR
 sJd8cUynKMnA==
X-IronPort-AV: E=Sophos;i="5.76,433,1592895600"; 
   d="scan'208";a="302655780"
Received: from rhweight-mobl2.amr.corp.intel.com (HELO [10.0.2.15]) ([10.213.173.247])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2020 11:37:21 -0700
Subject: Re: [PATCH v1 03/12] fpga: expose max10 flash update counts in sysfs
To:     Tom Rix <trix@redhat.com>, mdf@kernel.org, lee.jones@linaro.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     lgoncalv@redhat.com, yilun.xu@intel.com, hao.wu@intel.com,
        matthew.gerlach@intel.com
References: <20200904235305.6254-1-russell.h.weight@intel.com>
 <20200904235305.6254-4-russell.h.weight@intel.com>
 <a4ee319d-9f6f-5a27-415e-b1fabd1d5465@redhat.com>
From:   Russ Weight <russell.h.weight@intel.com>
Message-ID: <9cc5197e-72f9-e0de-c1c6-a0dc331fb48f@intel.com>
Date:   Wed, 16 Sep 2020 11:37:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <a4ee319d-9f6f-5a27-415e-b1fabd1d5465@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On 9/5/20 1:39 PM, Tom Rix wrote:
> On 9/4/20 4:52 PM, Russ Weight wrote:
>> Extend the MAX10 BMC Security Engine driver to provide a
>> handler to expose the flash update count for the FPGA user
>> image.
>>
>> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
>> Reviewed-by: Wu Hao <hao.wu@intel.com>
>> ---
>>  drivers/fpga/intel-m10-bmc-secure.c | 32 +++++++++++++++++++++++++++++
>>  1 file changed, 32 insertions(+)
>>
>> diff --git a/drivers/fpga/intel-m10-bmc-secure.c b/drivers/fpga/intel-m10-bmc-secure.c
>> index 1f86bfb694b4..b824790e43aa 100644
>> --- a/drivers/fpga/intel-m10-bmc-secure.c
>> +++ b/drivers/fpga/intel-m10-bmc-secure.c
>> @@ -10,6 +10,7 @@
>>  #include <linux/mfd/intel-m10-bmc.h>
>>  #include <linux/module.h>
>>  #include <linux/platform_device.h>
>> +#include <linux/slab.h>
>>  #include <linux/vmalloc.h>
>>  
>>  struct m10bmc_sec {
>> @@ -99,7 +100,38 @@ SYSFS_GET_REH(bmc, BMC_REH_ADDR)
>>  SYSFS_GET_REH(sr, SR_REH_ADDR)
>>  SYSFS_GET_REH(pr, PR_REH_ADDR)
>>  
>> +#define FLASH_COUNT_SIZE 4096
> This seems too high at most it should be 64.

The flash count size represents the size of the flash memory that stores the
count. The count is represented in flash as an inverted bit vector.

I suppose a comment would be helpful here...

>> +#define USER_FLASH_COUNT 0x17ffb000
> Why shouldn't this be in intel-m10-bmc.h ?

Sure - I'll move it there with the other addresses.

>> +
>> +static int get_qspi_flash_count(struct ifpga_sec_mgr *imgr)
> what does 'qspi' mean ?

It means Quad-SPI, the controller type that connects to the FLASH. This term
does seem out of place here. There is also a BMC flash count. I'll change this to
"user".

>
> unless there are going to be several *flash_count's consider
>
> removing this substring.
>
>> +{
>> +	struct m10bmc_sec *sec = imgr->priv;
>> +	unsigned int stride = regmap_get_reg_stride(sec->m10bmc->regmap);
>> +	unsigned int cnt, num_bits = FLASH_COUNT_SIZE * 8;
>> +	u8 *flash_buf;
>> +	int ret;
>> +
>> +	flash_buf = kmalloc(FLASH_COUNT_SIZE, GFP_KERNEL);
>> +	if (!flash_buf)
>> +		return -ENOMEM;
>> +
>> +	ret = m10bmc_raw_bulk_read(sec->m10bmc, USER_FLASH_COUNT, flash_buf,
>> +				   FLASH_COUNT_SIZE / stride);
>> +	if (ret) {
>> +		dev_err(sec->dev, "%s failed to read %d\n", __func__, ret);
>> +		goto exit_free;
>> +	}
>> +
>> +	cnt = num_bits - bitmap_weight((unsigned long *)flash_buf, num_bits);
> Simplify ret = num_bits...

yes - will do.
Thanks!

- Russ

>> +
>> +exit_free:
>> +	kfree(flash_buf);
>> +
>> +	return ret ? : cnt;
> Then simplify
>
> return ret;
>
> Tom
>
>> +}
>> +
>>  static const struct ifpga_sec_mgr_ops m10bmc_iops = {
>> +	.user_flash_count = get_qspi_flash_count,
>>  	.bmc_root_entry_hash = get_bmc_root_entry_hash,
>>  	.sr_root_entry_hash = get_sr_root_entry_hash,
>>  	.pr_root_entry_hash = get_pr_root_entry_hash,

