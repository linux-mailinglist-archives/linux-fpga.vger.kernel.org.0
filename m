Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD4272B729B
	for <lists+linux-fpga@lfdr.de>; Wed, 18 Nov 2020 00:46:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbgKQXpb (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 17 Nov 2020 18:45:31 -0500
Received: from mga03.intel.com ([134.134.136.65]:33814 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725774AbgKQXpb (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 17 Nov 2020 18:45:31 -0500
IronPort-SDR: XXp+fbR8e/z+H7nG9k9D3i9OCQ+z4fj7SbInqEFdL6XWofamBpTrclLiCFkb1wlMVCmml3QnUZ
 utPxzgfNGGKw==
X-IronPort-AV: E=McAfee;i="6000,8403,9808"; a="171132059"
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; 
   d="scan'208";a="171132059"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2020 15:45:30 -0800
IronPort-SDR: q39NSC9S6TGndX61I+NTZYVCHnAwO31TJgmoCrqbrmTx3AQA//uFj2eJ4azz7CUOsq/yxJpM2A
 ldY2S5jLYN+w==
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; 
   d="scan'208";a="544259242"
Received: from rhweight-mobl2.amr.corp.intel.com (HELO [10.0.2.4]) ([10.212.81.41])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2020 15:45:29 -0800
Subject: Re: [PATCH v5 3/6] fpga: m10bmc-sec: expose max10 flash update count
To:     Moritz Fischer <mdf@kernel.org>
Cc:     lee.jones@linaro.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, trix@redhat.com, lgoncalv@redhat.com,
        yilun.xu@intel.com, hao.wu@intel.com, matthew.gerlach@intel.com
References: <20201114005559.90860-1-russell.h.weight@intel.com>
 <20201114005559.90860-4-russell.h.weight@intel.com>
 <20201115200330.GA284619@epycbox.lan>
From:   Russ Weight <russell.h.weight@intel.com>
Message-ID: <d99a7077-18cc-f08a-b3a3-a66301cf814d@intel.com>
Date:   Tue, 17 Nov 2020 15:45:27 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201115200330.GA284619@epycbox.lan>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On 11/15/20 12:03 PM, Moritz Fischer wrote:
> On Fri, Nov 13, 2020 at 04:55:56PM -0800, Russ Weight wrote:
>> Extend the MAX10 BMC Secure Update driver to provide a
>> sysfs file to expose the flash update count for the FPGA
>> user image.
>>
>> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
>> Reviewed-by: Tom Rix <trix@redhat.com>
>> ---
>> v5:
>>   - Renamed sysfs node user_flash_count to flash_count and updated the
>>     sysfs documentation accordingly.
>> v4:
>>   - Moved the sysfs file for displaying the flash count from the
>>     FPGA Security Manager class driver to here. The
>>     m10bmc_user_flash_count() function is removed and the
>>     functionality is moved into a user_flash_count_show()
>>     function.
>>   - Added ABI documentation for the new sysfs entry
>> v3:
>>   - Changed: iops -> sops, imgr -> smgr, IFPGA_ -> FPGA_, ifpga_ to fpga_
>>   - Changed "MAX10 BMC Secure Engine driver" to "MAX10 BMC Secure Update
>>     driver"
>>   - Removed wrapper functions (m10bmc_raw_*, m10bmc_sys_*). The
>>     underlying functions are now called directly.
>> v2:
>>   - Renamed get_qspi_flash_count() to m10bmc_user_flash_count()
>>   - Minor code cleanup per review comments
>>   - Added m10bmc_ prefix to functions in m10bmc_iops structure
>> ---
>>  .../testing/sysfs-driver-intel-m10-bmc-secure |  8 +++++
>>  drivers/fpga/intel-m10-bmc-secure.c           | 34 +++++++++++++++++++
>>  2 files changed, 42 insertions(+)
>>
>> diff --git a/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-secure b/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-secure
>> index 2992488b717a..73a3aba750e8 100644
>> --- a/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-secure
>> +++ b/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-secure
>> @@ -27,3 +27,11 @@ Description:	Read only. Returns the root entry hash for the BMC image
>>  		"hash not programmed".  This file is only visible if the
>>  		underlying device supports it.
>>  		Format: "0x%x".
>> +
>> +What:		/sys/bus/platform/devices/n3000bmc-secure.*.auto/security/flash_count
>> +Date:		Oct 2020
>> +KernelVersion:  5.11
>> +Contact:	Russ Weight <russell.h.weight@intel.com>
>> +Description:	Read only. Returns number of times the secure update
>> +		staging area has been flashed.
>> +		Format: "%u".
>> diff --git a/drivers/fpga/intel-m10-bmc-secure.c b/drivers/fpga/intel-m10-bmc-secure.c
>> index 198bc8273d6b..6ad897001086 100644
>> --- a/drivers/fpga/intel-m10-bmc-secure.c
>> +++ b/drivers/fpga/intel-m10-bmc-secure.c
>> @@ -11,6 +11,7 @@
>>  #include <linux/mfd/intel-m10-bmc.h>
>>  #include <linux/module.h>
>>  #include <linux/platform_device.h>
>> +#include <linux/slab.h>
>>  
>>  struct m10bmc_sec {
>>  	struct device *dev;
>> @@ -77,7 +78,40 @@ DEVICE_ATTR_SEC_REH_RO(bmc, BMC_PROG_MAGIC, BMC_PROG_ADDR, BMC_REH_ADDR);
>>  DEVICE_ATTR_SEC_REH_RO(sr, SR_PROG_MAGIC, SR_PROG_ADDR, SR_REH_ADDR);
>>  DEVICE_ATTR_SEC_REH_RO(pr, PR_PROG_MAGIC, PR_PROG_ADDR, PR_REH_ADDR);
>>  
>> +#define FLASH_COUNT_SIZE 4096	/* count stored as inverted bit vector */
>> +
>> +static ssize_t flash_count_show(struct device *dev,
>> +				struct device_attribute *attr, char *buf)
>> +{
>> +	struct m10bmc_sec *sec = dev_get_drvdata(dev);
>> +	unsigned int stride = regmap_get_reg_stride(sec->m10bmc->regmap);
>> +	unsigned int num_bits = FLASH_COUNT_SIZE * 8;
>> +	u8 *flash_buf;
>> +	int cnt, ret;
> (Nit) Can you make this:
>
> 	struct m10bmc_sec *sec = dev_get_drvdata(dev);
> 	unsigned int stride, num_bits;
> 	u8 *flash_buf;
> 	int cnt, ret;
>
> 	stride = regmap_get_reg_stride(sec->m10bmc->regmap);
> 	num_bits = FLASH_COUNT_SIZE * 8;

Sure - I'll make the change. Thanks,

- Russ
>
>
>> +
>> +	flash_buf = kmalloc(FLASH_COUNT_SIZE, GFP_KERNEL);
>> +	if (!flash_buf)
>> +		return -ENOMEM;
>> +
>> +	ret = regmap_bulk_read(sec->m10bmc->regmap, STAGING_FLASH_COUNT,
>> +			       flash_buf, FLASH_COUNT_SIZE / stride);
>> +	if (ret) {
>> +		dev_err(sec->dev,
>> +			"failed to read flash count: %x cnt %x: %d\n",
>> +			STAGING_FLASH_COUNT, FLASH_COUNT_SIZE / stride, ret);
>> +		goto exit_free;
>> +	}
>> +	cnt = num_bits - bitmap_weight((unsigned long *)flash_buf, num_bits);
>> +
>> +exit_free:
>> +	kfree(flash_buf);
>> +
>> +	return ret ? : sysfs_emit(buf, "%u\n", cnt);
>> +}
>> +static DEVICE_ATTR_RO(flash_count);
>> +
>>  static struct attribute *m10bmc_security_attrs[] = {
>> +	&dev_attr_flash_count.attr,
>>  	&dev_attr_bmc_root_entry_hash.attr,
>>  	&dev_attr_sr_root_entry_hash.attr,
>>  	&dev_attr_pr_root_entry_hash.attr,
>> -- 
>> 2.25.1
>>
> Otherwise looks good to me,
>
> - Moritz

