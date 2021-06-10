Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 384A73A338F
	for <lists+linux-fpga@lfdr.de>; Thu, 10 Jun 2021 20:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230428AbhFJSzF (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 10 Jun 2021 14:55:05 -0400
Received: from mga02.intel.com ([134.134.136.20]:63461 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230232AbhFJSzF (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 10 Jun 2021 14:55:05 -0400
IronPort-SDR: JDS4KpizlVwV+W4SQiosbuj8Unf+Im2B4KgqDYn7/1DYX0gBJdcmjNXiriTURM3ing40MrzzLI
 ze8A68b1VM2g==
X-IronPort-AV: E=McAfee;i="6200,9189,10011"; a="192484354"
X-IronPort-AV: E=Sophos;i="5.83,264,1616482800"; 
   d="scan'208";a="192484354"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2021 11:53:08 -0700
IronPort-SDR: mhvfdlgrugm3fPyi8SxbbLIwapsDrEG9goYYGUAcpd9KW80LJGG8a6dBfEa3VKKlLMKi8Bx83r
 rrawFPxNhSEA==
X-IronPort-AV: E=Sophos;i="5.83,264,1616482800"; 
   d="scan'208";a="477448394"
Received: from rhweight-mobl2.amr.corp.intel.com (HELO [10.0.2.4]) ([10.212.184.121])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2021 11:53:07 -0700
Subject: Re: [PATCH v2 8/8] fpga: region: Use standard dev_release for class
 driver
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     mdf@kernel.org, linux-fpga@vger.kernel.org, trix@redhat.com,
        lgoncalv@redhat.com, hao.wu@intel.com, matthew.gerlach@intel.com,
        richard.gong@intel.com
References: <20210609221135.261837-1-russell.h.weight@intel.com>
 <20210609221135.261837-9-russell.h.weight@intel.com>
 <20210610082920.GH2007225@yilunxu-OptiPlex-7050>
From:   Russ Weight <russell.h.weight@intel.com>
Message-ID: <1794f883-b148-dc6e-fee1-f0a99d80ab9d@intel.com>
Date:   Thu, 10 Jun 2021 11:53:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210610082920.GH2007225@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On 6/10/21 1:29 AM, Xu Yilun wrote:
> On Wed, Jun 09, 2021 at 03:11:35PM -0700, Russ Weight wrote:
>> The FPGA region class driver data structure is being treated as a managed
>> resource instead of using standard dev_release call-back to release the
>> class data structure. This change populates the class.dev_release function
>> and changes the fpga_region_free() function to call put_device().
>> It also changes fpga_region_unregister() to call device_del() instead
>> of device_unregister().
>>
>> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
>> ---
>> v2:
>>   - Moved the renaming of "dev" to "parent" to a separate patch
>>   - Call fpga_region_free() in devm_fpga_region_release() instead of put_device()
>> ---
>>  drivers/fpga/fpga-region.c | 30 +++++++++++++++---------------
>>  1 file changed, 15 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/fpga/fpga-region.c b/drivers/fpga/fpga-region.c
>> index 563626d66e56..bdc15fab60c0 100644
>> --- a/drivers/fpga/fpga-region.c
>> +++ b/drivers/fpga/fpga-region.c
>> @@ -204,8 +204,10 @@ struct fpga_region
>>  		return NULL;
>>  
>>  	id = ida_simple_get(&fpga_region_ida, 0, 0, GFP_KERNEL);
>> -	if (id < 0)
>> -		goto err_free;
>> +	if (id < 0) {
>> +		kfree(region);
>> +		return NULL;
>> +	}
>>  
>>  	region->mgr = mgr;
>>  	region->get_bridges = get_bridges;
>> @@ -219,17 +221,12 @@ struct fpga_region
>>  	region->dev.id = id;
>>  
>>  	ret = dev_set_name(&region->dev, "region%d", id);
>> -	if (ret)
>> -		goto err_remove;
>> +	if (ret) {
>> +		put_device(&region->dev);
>> +		return NULL;
>> +	}
>>  
>>  	return region;
>> -
>> -err_remove:
>> -	ida_simple_remove(&fpga_region_ida, id);
>> -err_free:
>> -	kfree(region);
>> -
>> -	return NULL;
>>  }
>>  EXPORT_SYMBOL_GPL(fpga_region_create);
>>  
>> @@ -239,8 +236,7 @@ EXPORT_SYMBOL_GPL(fpga_region_create);
>>   */
>>  void fpga_region_free(struct fpga_region *region)
>>  {
>> -	ida_simple_remove(&fpga_region_ida, region->dev.id);
>> -	kfree(region);
>> +	put_device(&region->dev);
>>  }
>>  EXPORT_SYMBOL_GPL(fpga_region_free);
>>  
>> @@ -253,7 +249,7 @@ static void devm_fpga_region_release(struct device *dev, void *res)
>>  
>>  /**
>>   * devm_fpga_region_create - create and initialize a managed FPGA region struct
>> - * @dev: device parent
>> + * @parent: device parent
> This should be in Patch #5.
>
> Others look good to me. You could append my reviewed-by after this fix.

Thanks Yilun. I made the fix.

- Russ

>
> Reviewed-by: Xu Yilun <yilun.xu@intel.com>
>
>>   * @mgr: manager that programs this region
>>   * @get_bridges: optional function to get bridges to a list
>>   *
>> @@ -310,12 +306,16 @@ EXPORT_SYMBOL_GPL(fpga_region_register);
>>   */
>>  void fpga_region_unregister(struct fpga_region *region)
>>  {
>> -	device_unregister(&region->dev);
>> +	device_del(&region->dev);
>>  }
>>  EXPORT_SYMBOL_GPL(fpga_region_unregister);
>>  
>>  static void fpga_region_dev_release(struct device *dev)
>>  {
>> +	struct fpga_region *region = to_fpga_region(dev);
>> +
>> +	ida_simple_remove(&fpga_region_ida, region->dev.id);
>> +	kfree(region);
>>  }
>>  
>>  /**
>> -- 
>> 2.25.1

