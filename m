Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98A1A3D6AF0
	for <lists+linux-fpga@lfdr.de>; Tue, 27 Jul 2021 02:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234297AbhGZXgZ (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 26 Jul 2021 19:36:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28444 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234284AbhGZXgY (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 26 Jul 2021 19:36:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627345011;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yPKnHMawtn4+562UZeA0fPpbczZEHG0RBodp91MmPi0=;
        b=FfIa3e+XVnew5oSoDaO8w3omK5kQNyND21jzYxdXn6j90vkBx7ZxF2qHJFesmnYxQ0oN3T
        iaoUBKO9Llt/OLru90O2kojYnbNokRXovMoFhKqbSXD3kurckJ2RgxH3kU7ELjjpaJ3WEp
        JyvZGrXr/QfaCEnzROiY3eDwa7Yo01M=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-283-SKxJrsOOPDu2lvhkp5K5lw-1; Mon, 26 Jul 2021 20:16:50 -0400
X-MC-Unique: SKxJrsOOPDu2lvhkp5K5lw-1
Received: by mail-qk1-f198.google.com with SMTP id 18-20020a05620a0792b02903b8e915ccceso10264030qka.18
        for <linux-fpga@vger.kernel.org>; Mon, 26 Jul 2021 17:16:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=yPKnHMawtn4+562UZeA0fPpbczZEHG0RBodp91MmPi0=;
        b=LHiI1G8RqvbksDyPfxeITlUOAL8e+KoiSW1T7osW/ux29lZiGvIYc9Cs17v5Yqt4M0
         oqUBM/IQDWWnG28sBhd9mZWK6F1Zzr6Cgj+a87FciDm52zEy6hmsF4Y8fuxAIjNLx2gd
         Z2ehYFKvxA6qveaLGl90D4zFHL4UCFtoKhf5H949l9qEPgjzhxP0+LejB1feh1yDGnMy
         WwvrJyxQ9b5dwzwXJFvSCtR3WsPY9e8r8RJ+3bMS0zUen5oUk1UNEDqTjd/stblQf9Da
         fmTCWPazvb5aULHNdc/KUAIJ7QnHJ2LFIhj8xwoXbp4GRVn4tH6Ghro6+a+GUGTl0/1a
         CFZg==
X-Gm-Message-State: AOAM533SGWagys1lGNv2TIQAElsGeqsnKWYRAN/sAXwZL6j8LVGV4EzR
        0H2IhjNUzS8eWognrdLXIwR2OghhBCzpLKeh0injDkWkbp/WZOu4YHgvYzTJVtTh6TuHhIB3pO7
        5vwuLFGBsINdXNuP52hS/JJE3eNpkqAHSFFYkUCzml966hz2P3STiCm6GCGKnoj4xbwz7
X-Received: by 2002:ae9:f805:: with SMTP id x5mr19675020qkh.373.1627345009440;
        Mon, 26 Jul 2021 17:16:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwqjOcBhQGktxAQ6u7Q5ZYN/xxQjZFe454padRp8KSuiQelvsXyA4IBy4NXrXABxwfTfV8QvA==
X-Received: by 2002:ae9:f805:: with SMTP id x5mr19674997qkh.373.1627345009220;
        Mon, 26 Jul 2021 17:16:49 -0700 (PDT)
Received: from localhost.localdomain (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id w19sm852620qkb.66.2021.07.26.17.16.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jul 2021 17:16:48 -0700 (PDT)
Subject: Re: [PATCH] fpga: region: handle compat_id as an uuid
To:     Russ Weight <russell.h.weight@intel.com>, hao.wu@intel.com,
        mdf@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org
References: <20210726202650.4074614-1-trix@redhat.com>
 <6f30a4c6-61a0-bb57-9f13-bcad3f3589b8@intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <ba28bac6-9c6d-de73-523f-b8ba4bef84de@redhat.com>
Date:   Mon, 26 Jul 2021 17:16:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <6f30a4c6-61a0-bb57-9f13-bcad3f3589b8@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 7/26/21 3:12 PM, Russ Weight wrote:
> On 7/26/21 1:26 PM, trix@redhat.com wrote:
>> From: Tom Rix <trix@redhat.com>
>>
>> An fpga region's compat_id is exported by the sysfs
>> as a 128 bit hex string formed by concatenating two
>> 64 bit values together.
>>
>> The only user of compat_id is dfl.  Its user library
>> opae converts this value into a uuid.
>>
>> ex/
>> $ cat /sys/class/fpga_region/region1/compat_id
>> f3c9941350814aadbced07eb84a6d0bb
>>
>> Is reported as
>> $ fpgainfo bmc
>> ...
>> Pr Interface Id                  : f3c99413-5081-4aad-bced-07eb84a6d0bb
>>
>> Storing a uuid as 2 64 bit values is vendor specific.
>> And concatenating them together is vendor specific.
>>
>> It is better to store and print out as a vendor neutral uuid.
>>
>> Change fpga_compat_id from a struct to a union.
>> Keep the old 64 bit values for dfl.
>> Sysfs output is now
>> f3c99413-5081-4aad-bced-07eb84a6d0bb
> I'm fowarding feedback from Tim Whisonant, one of the OPAE userspace
> developers:
>
> I think that this change to the sysfs for the compat_id node will
> end up breaking the SDK, which does not expect the '-' characters to
> be included when parsing the sysfs value. Currently, it is parsed as
> a raw hex string without regard to any '-' characters. This goes for
> any "guid" currently exported by sysfs and for what we read in the
> device MMIO space.

Yes, it will.

And there are other places, like dfl-afu-main.c:afu_id_show()

outputs raw hex that sdk turns into a uuid.


Some options.

If no one but dfl will ever use it, then v1 of patchset.

If others can use it but don't want to change dfl, then v2 of patchset, 
my favorite.

Or this one for uuid for everyone, what have been v3 but changed too much.


could dfl change generally to output uuid's to the sysfs ?

this would be generally helpful and a one time disruption to the sdk.

Tom

>
> - Russ
>
>> Signed-off-by: Tom Rix <trix@redhat.com>
>> ---
>>   .../ABI/testing/sysfs-class-fpga-region        |  4 ++--
>>   drivers/fpga/dfl-fme-mgr.c                     |  8 ++++----
>>   drivers/fpga/fpga-region.c                     |  4 +---
>>   include/linux/fpga/fpga-mgr.h                  | 18 ++++++++++++------
>>   include/linux/fpga/fpga-region.h               |  2 +-
>>   5 files changed, 20 insertions(+), 16 deletions(-)
>>
>> diff --git a/Documentation/ABI/testing/sysfs-class-fpga-region b/Documentation/ABI/testing/sysfs-class-fpga-region
>> index bc7ec644acc9a..241359fb74a55 100644
>> --- a/Documentation/ABI/testing/sysfs-class-fpga-region
>> +++ b/Documentation/ABI/testing/sysfs-class-fpga-region
>> @@ -5,5 +5,5 @@ Contact:	Wu Hao <hao.wu@intel.com>
>>   Description:	FPGA region id for compatibility check, e.g. compatibility
>>   		of the FPGA reconfiguration hardware and image. This value
>>   		is defined or calculated by the layer that is creating the
>> -		FPGA region. This interface returns the compat_id value or
>> -		just error code -ENOENT in case compat_id is not used.
>> +		FPGA region. This interface returns a uuid value or just
>> +		error code -ENOENT in case compat_id is not used.
>> diff --git a/drivers/fpga/dfl-fme-mgr.c b/drivers/fpga/dfl-fme-mgr.c
>> index d5861d13b3069..012b72712684c 100644
>> --- a/drivers/fpga/dfl-fme-mgr.c
>> +++ b/drivers/fpga/dfl-fme-mgr.c
>> @@ -273,16 +273,16 @@ static const struct fpga_manager_ops fme_mgr_ops = {
>>   };
>>   
>>   static void fme_mgr_get_compat_id(void __iomem *fme_pr,
>> -				  struct fpga_compat_id *id)
>> +				  union fpga_compat_id *id)
>>   {
>> -	id->id_l = readq(fme_pr + FME_PR_INTFC_ID_L);
>> -	id->id_h = readq(fme_pr + FME_PR_INTFC_ID_H);
>> +	id->id_l = cpu_to_be64(readq(fme_pr + FME_PR_INTFC_ID_L));
>> +	id->id_h = cpu_to_be64(readq(fme_pr + FME_PR_INTFC_ID_H));
>>   }
>>   
>>   static int fme_mgr_probe(struct platform_device *pdev)
>>   {
>>   	struct dfl_fme_mgr_pdata *pdata = dev_get_platdata(&pdev->dev);
>> -	struct fpga_compat_id *compat_id;
>> +	union fpga_compat_id *compat_id;
>>   	struct device *dev = &pdev->dev;
>>   	struct fme_mgr_priv *priv;
>>   	struct fpga_manager *mgr;
>> diff --git a/drivers/fpga/fpga-region.c b/drivers/fpga/fpga-region.c
>> index a4838715221ff..f1083b5894635 100644
>> --- a/drivers/fpga/fpga-region.c
>> +++ b/drivers/fpga/fpga-region.c
>> @@ -166,9 +166,7 @@ static ssize_t compat_id_show(struct device *dev,
>>   	if (!region->compat_id)
>>   		return -ENOENT;
>>   
>> -	return sprintf(buf, "%016llx%016llx\n",
>> -		       (unsigned long long)region->compat_id->id_h,
>> -		       (unsigned long long)region->compat_id->id_l);
>> +	return sprintf(buf, "%pU\n", &region->compat_id->uuid);
>>   }
>>   
>>   static DEVICE_ATTR_RO(compat_id);
>> diff --git a/include/linux/fpga/fpga-mgr.h b/include/linux/fpga/fpga-mgr.h
>> index ec2cd8bfceb00..b12f9994932e1 100644
>> --- a/include/linux/fpga/fpga-mgr.h
>> +++ b/include/linux/fpga/fpga-mgr.h
>> @@ -10,6 +10,7 @@
>>   
>>   #include <linux/mutex.h>
>>   #include <linux/platform_device.h>
>> +#include <linux/uuid.h>
>>   
>>   struct fpga_manager;
>>   struct sg_table;
>> @@ -144,14 +145,19 @@ struct fpga_manager_ops {
>>   #define FPGA_MGR_STATUS_FIFO_OVERFLOW_ERR	BIT(4)
>>   
>>   /**
>> - * struct fpga_compat_id - id for compatibility check
>> - *
>> + * union fpga_compat_id - id for compatibility check
>> + * Can be accessed as either:
>> + * @uuid: the base uuid_t type
>> + * or
>>    * @id_h: high 64bit of the compat_id
>>    * @id_l: low 64bit of the compat_id
>>    */
>> -struct fpga_compat_id {
>> -	u64 id_h;
>> -	u64 id_l;
>> +union fpga_compat_id {
>> +	uuid_t uuid;
>> +	struct {
>> +		u64 id_h;
>> +		u64 id_l;
>> +	};
>>   };
>>   
>>   /**
>> @@ -169,7 +175,7 @@ struct fpga_manager {
>>   	struct device dev;
>>   	struct mutex ref_mutex;
>>   	enum fpga_mgr_states state;
>> -	struct fpga_compat_id *compat_id;
>> +	union fpga_compat_id *compat_id;
>>   	const struct fpga_manager_ops *mops;
>>   	void *priv;
>>   };
>> diff --git a/include/linux/fpga/fpga-region.h b/include/linux/fpga/fpga-region.h
>> index 27cb706275dba..7cc2ee543efb4 100644
>> --- a/include/linux/fpga/fpga-region.h
>> +++ b/include/linux/fpga/fpga-region.h
>> @@ -24,7 +24,7 @@ struct fpga_region {
>>   	struct list_head bridge_list;
>>   	struct fpga_manager *mgr;
>>   	struct fpga_image_info *info;
>> -	struct fpga_compat_id *compat_id;
>> +	union fpga_compat_id *compat_id;
>>   	void *priv;
>>   	int (*get_bridges)(struct fpga_region *region);
>>   };

