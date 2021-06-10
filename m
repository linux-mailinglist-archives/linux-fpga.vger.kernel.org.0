Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E27A93A3380
	for <lists+linux-fpga@lfdr.de>; Thu, 10 Jun 2021 20:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbhFJSr2 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 10 Jun 2021 14:47:28 -0400
Received: from mga11.intel.com ([192.55.52.93]:36621 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230136AbhFJSr1 (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 10 Jun 2021 14:47:27 -0400
IronPort-SDR: RcPlUcgc5T4Ld30NS+Id93BqPTu5ZitpHborxAHhOhU74qsiXsfzROab5ySwgtBS898eQUsZnK
 8NW7BWbbcrqg==
X-IronPort-AV: E=McAfee;i="6200,9189,10011"; a="202344318"
X-IronPort-AV: E=Sophos;i="5.83,264,1616482800"; 
   d="scan'208";a="202344318"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2021 11:45:31 -0700
IronPort-SDR: WJ/LutFKgAFprOs+xNgN6wNarP/RRdsqyKHIxPTbUX3XFTGtprY3FhwmFf2jW4+SArWF0wHDA1
 ZxPMRNCgiFwg==
X-IronPort-AV: E=Sophos;i="5.83,264,1616482800"; 
   d="scan'208";a="477445702"
Received: from rhweight-mobl2.amr.corp.intel.com (HELO [10.0.2.4]) ([10.212.184.121])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2021 11:45:30 -0700
Subject: Re: [PATCH v2 5/8] fpga: region: Rename dev to parent for parent
 device
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     mdf@kernel.org, linux-fpga@vger.kernel.org, trix@redhat.com,
        lgoncalv@redhat.com, hao.wu@intel.com, matthew.gerlach@intel.com,
        richard.gong@intel.com
References: <20210609221135.261837-1-russell.h.weight@intel.com>
 <20210609221135.261837-6-russell.h.weight@intel.com>
 <20210610082502.GG2007225@yilunxu-OptiPlex-7050>
From:   Russ Weight <russell.h.weight@intel.com>
Message-ID: <203fe5b7-f824-49f6-a9fa-4d71c8f5a9f4@intel.com>
Date:   Thu, 10 Jun 2021 11:45:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210610082502.GG2007225@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On 6/10/21 1:25 AM, Xu Yilun wrote:
> Sorry, one more minor comment inline.
>
> On Wed, Jun 09, 2021 at 03:11:32PM -0700, Russ Weight wrote:
>> Rename variable "dev" to "parent" in cases where it represents the parent
>> device.
>>
>> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
>> ---
>> v2:
>>   - This patch contains the renaming of "dev" to "parent" that was previously
>>     part of the patch: "fpga: region: Use standard dev_release for class driver"
>> ---
>>  drivers/fpga/fpga-region.c | 14 +++++++-------
>>  1 file changed, 7 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/fpga/fpga-region.c b/drivers/fpga/fpga-region.c
>> index c3134b89c3fe..563626d66e56 100644
>> --- a/drivers/fpga/fpga-region.c
>> +++ b/drivers/fpga/fpga-region.c
>> @@ -181,7 +181,7 @@ ATTRIBUTE_GROUPS(fpga_region);
>>  
>>  /**
>>   * fpga_region_create - alloc and init a struct fpga_region
>> - * @dev: device parent
>> + * @parent: device parent
>>   * @mgr: manager that programs this region
>>   * @get_bridges: optional function to get bridges to a list
>>   *
>> @@ -192,7 +192,7 @@ ATTRIBUTE_GROUPS(fpga_region);
>>   * Return: struct fpga_region or NULL
>>   */
>>  struct fpga_region
>> -*fpga_region_create(struct device *dev,
>> +*fpga_region_create(struct device *parent,
>>  		    struct fpga_manager *mgr,
>>  		    int (*get_bridges)(struct fpga_region *))
>>  {
>> @@ -214,8 +214,8 @@ struct fpga_region
>>  
>>  	device_initialize(&region->dev);
>>  	region->dev.class = fpga_region_class;
>> -	region->dev.parent = dev;
>> -	region->dev.of_node = dev->of_node;
>> +	region->dev.parent = parent;
>> +	region->dev.of_node = parent->of_node;
>>  	region->dev.id = id;
>>  
>>  	ret = dev_set_name(&region->dev, "region%d", id);
>> @@ -268,7 +268,7 @@ static void devm_fpga_region_release(struct device *dev, void *res)
>>   * Return: struct fpga_region or NULL
>>   */
>>  struct fpga_region
>> -*devm_fpga_region_create(struct device *dev,
>> +*devm_fpga_region_create(struct device *parent,
> You missed the function description doc change in Patch #8

Thanks for catching that Yilun. I have fixed it for the next patchset.

- Russ
>
> Thanks,
> Yilun
>
>>  			 struct fpga_manager *mgr,
>>  			 int (*get_bridges)(struct fpga_region *))
>
>
>>  {
>> @@ -278,12 +278,12 @@ struct fpga_region
>>  	if (!ptr)
>>  		return NULL;
>>  
>> -	region = fpga_region_create(dev, mgr, get_bridges);
>> +	region = fpga_region_create(parent, mgr, get_bridges);
>>  	if (!region) {
>>  		devres_free(ptr);
>>  	} else {
>>  		*ptr = region;
>> -		devres_add(dev, ptr);
>> +		devres_add(parent, ptr);
>>  	}
>>  
>>  	return region;
>> -- 
>> 2.25.1

