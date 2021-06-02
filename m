Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6F8A3994AE
	for <lists+linux-fpga@lfdr.de>; Wed,  2 Jun 2021 22:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbhFBUk7 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 2 Jun 2021 16:40:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:60979 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229611AbhFBUk7 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 2 Jun 2021 16:40:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622666355;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E0/XuNlWKmhhWtieuI0wskLS78FwuunVTdLwC/mfCYo=;
        b=EBx5pfyQKhVVeDRUBc+4TMq4DsuD5Dxt+qI/5T0e96+8zqPzurckzxWyugg+NxYJ8YFCgC
        Xz9vc0i+ro540sIaoQjjqBnSwjMteaIPZQwONNaYFM83+G1d+Q2P96v33hijZsIsj6U9So
        rElMRYvv6O+SuPpv4Sz/rLQjgbyVTFM=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-36-zgqwifLhNMCxPW-p42wDGg-1; Wed, 02 Jun 2021 16:39:14 -0400
X-MC-Unique: zgqwifLhNMCxPW-p42wDGg-1
Received: by mail-oo1-f69.google.com with SMTP id d12-20020a4aeb8c0000b029023bbaaddcbbso2147490ooj.13
        for <linux-fpga@vger.kernel.org>; Wed, 02 Jun 2021 13:39:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=E0/XuNlWKmhhWtieuI0wskLS78FwuunVTdLwC/mfCYo=;
        b=Yz3c2RUgA8UteQTi+wKyDbze2itDEZVG3dv6BMMAKOdphTOuMNk0zRsBnLVa25905a
         PTDfOu5F4l9+RFtBatOPVRoIMQncz+W2u/Em03KDsDFwVV5afO0pJKdhfeMsUUsl7fkl
         BGa2huYDu+RqG7ojofS3HAAf4AqiEWIHHcRWSUGcfkhQEaUBT9GTUtsaup1hmSAnKZ7b
         HxJRZbAdswpQ9ulM3r793V2vekpDQ1QeVUiPofu4bTjxoijphDHo2Na5wN3HUo1XB4e3
         4i6qXOsQf3ot9XEAJx9aO8NqGlnNJJTreb/QYL+9LhUjbHtHkRbB+tWKnmVnle1A1f9/
         4YEg==
X-Gm-Message-State: AOAM531FJN1MdfsGyGLlSwfhwwZ54UUlpkaXnc+rbrPNOPE+BKkPhwBD
        Kvot9yK8nUZUMCGDdj6Z0rxbX/vV1Jq8K1/vDuLCSPQzMCZbz7bP+/urmCoLfE7LMtVcy6413z5
        oxehprJzXPoGTRXwLI7/Yaw==
X-Received: by 2002:a05:6808:992:: with SMTP id a18mr22575062oic.129.1622666353957;
        Wed, 02 Jun 2021 13:39:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyz2ftAStoo/mrE1T7iYy5n/Cf3MyvtNFl5GUaoW1aAg7LQw1zqt3cIXb7KlwxbYx+Nv62ACw==
X-Received: by 2002:a05:6808:992:: with SMTP id a18mr22575039oic.129.1622666353816;
        Wed, 02 Jun 2021 13:39:13 -0700 (PDT)
Received: from localhost.localdomain (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id h7sm204004ots.44.2021.06.02.13.39.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Jun 2021 13:39:13 -0700 (PDT)
Subject: Re: [PATCH 3/3] fpga: region: Adds runtime PM support
To:     Nava kishore Manne <navam@xilinx.com>,
        Moritz Fischer <mdf@kernel.org>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Michal Simek <michals@xilinx.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>, git <git@xilinx.com>
References: <20210402092049.479-1-nava.manne@xilinx.com>
 <20210402092049.479-4-nava.manne@xilinx.com> <YHDHhf1tQo6vI49W@epycbox.lan>
 <MWHPR02MB2623E61ABFBB478E95DC863FC2499@MWHPR02MB2623.namprd02.prod.outlook.com>
 <PH0PR02MB733699A67717E605045728DAC23D9@PH0PR02MB7336.namprd02.prod.outlook.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <8c7b7fcc-211c-3c22-a105-8c77156fde81@redhat.com>
Date:   Wed, 2 Jun 2021 13:39:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <PH0PR02MB733699A67717E605045728DAC23D9@PH0PR02MB7336.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 6/2/21 3:48 AM, Nava kishore Manne wrote:
> Ping!
>
>> -----Original Message-----
>> From: Nava kishore Manne
>> Sent: Monday, April 19, 2021 10:49 AM
>> To: Moritz Fischer <mdf@kernel.org>
>> Cc: trix@redhat.com; robh+dt@kernel.org; Michal Simek
>> <michals@xilinx.com>; linux-fpga@vger.kernel.org;
>> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; linux-arm-
>> kernel@lists.infradead.org; git <git@xilinx.com>
>> Subject: RE: [PATCH 3/3] fpga: region: Adds runtime PM support
>>
>> Hi Moritz,
>>
>> 	Please find my response inline.
>>
>>> -----Original Message-----
>>> From: Moritz Fischer <mdf@kernel.org>
>>> Sent: Saturday, April 10, 2021 3:01 AM
>>> To: Nava kishore Manne <navam@xilinx.com>
>>> Cc: mdf@kernel.org; trix@redhat.com; robh+dt@kernel.org; Michal Simek
>>> <michals@xilinx.com>; linux-fpga@vger.kernel.org;
>>> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; linux-arm-
>>> kernel@lists.infradead.org; git <git@xilinx.com>
>>> Subject: Re: [PATCH 3/3] fpga: region: Adds runtime PM support
>>>
>>> On Fri, Apr 02, 2021 at 02:50:49PM +0530, Nava kishore Manne wrote:
>>>> Adds support to handle FPGA/PL power domain. With this patch, the PL
>>>> power domain will be turned on before loading the bitstream and
>>>> turned off while removing/unloading the bitstream using overlays.
>>>> This can be achieved by adding the runtime PM support.
>>>>
>>>> Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
>>>> ---
>>>>   drivers/fpga/of-fpga-region.c | 18 +++++++++++++++++-
>>>>   1 file changed, 17 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/fpga/of-fpga-region.c
>>>> b/drivers/fpga/of-fpga-region.c index e405309baadc..35fc2f3d4bd8
>>>> 100644
>>>> --- a/drivers/fpga/of-fpga-region.c
>>>> +++ b/drivers/fpga/of-fpga-region.c
>>>> @@ -15,6 +15,7 @@
>>>>   #include <linux/of_platform.h>
>>>>   #include <linux/slab.h>
>>>>   #include <linux/spinlock.h>
>>>> +#include <linux/pm_runtime.h>
>>>>
>>>>   static const struct of_device_id fpga_region_of_match[] = {
>>>>   	{ .compatible = "fpga-region", },
>>>> @@ -302,6 +303,7 @@ static int
>>>> of_fpga_region_notify_pre_apply(struct
>>> fpga_region *region,
>>>>   	}
>>>>
>>>>   	region->info = info;
>>>> +	pm_runtime_get_sync(dev->parent);
>>>>   	ret = fpga_region_program_fpga(region);
>>>>   	if (ret) {
>>>>   		/* error; reject overlay */
>>>> @@ -324,10 +326,13 @@ static int
>>>> of_fpga_region_notify_pre_apply(struct fpga_region *region,  static
>>>> void
>>> of_fpga_region_notify_post_remove(struct fpga_region *region,
>>>>   					      struct of_overlay_notify_data
>>> *nd)  {
>>>> +	struct device *dev = &region->dev;
>>>> +
>>>>   	fpga_bridges_disable(&region->bridge_list);
>>>>   	fpga_bridges_put(&region->bridge_list);
>>>>   	fpga_image_info_free(region->info);
>>>>   	region->info = NULL;
>>>> +	pm_runtime_put(dev->parent);
>>>>   }
>>>>
>>>>   /**
>>>> @@ -411,9 +416,16 @@ static int of_fpga_region_probe(struct
>>> platform_device *pdev)
>>>>   		goto eprobe_mgr_put;
>>>>   	}
>>>>
>>>> +	pm_runtime_enable(&pdev->dev);
>>>> +	ret = pm_runtime_get_sync(&pdev->dev);
>>>> +	if (ret < 0)
>>>> +		goto err_pm;
>>>> +
>>>> +	pm_runtime_put(&pdev->dev);
>>>> +
>>>>   	ret = fpga_region_register(region);
>>>>   	if (ret)
>>>> -		goto eprobe_mgr_put;
>>>> +		goto err_pm;
>>>>
>>>>   	of_platform_populate(np, fpga_region_of_match, NULL, &region-
>>>> dev);
>>>>   	platform_set_drvdata(pdev, region);  @@ -422,6 +434,9 @@ static
>>>> int of_fpga_region_probe(struct  platform_device *pdev)
>>>>
>>>>   	return 0;
>>>>
>>>> +err_pm:
>>>> +	pm_runtime_put(&pdev->dev);
>>>> +	pm_runtime_disable(&pdev->dev);
>>>>   eprobe_mgr_put:
>>>>   	fpga_mgr_put(mgr);
>>>>   	return ret;
>>>> @@ -434,6 +449,7 @@ static int of_fpga_region_remove(struct
>>>> platform_device *pdev)
>>>>
>>>>   	fpga_region_unregister(region);
>>>>   	fpga_mgr_put(mgr);
>>>> +	pm_runtime_disable(region->dev.parent);
>>>>
>>>>   	return 0;
>>>>   }
>>>> --
>>>> 2.18.0
>>>>
>>> Does this add a dependency on CONFIG_PM?
>>>
>> Yes, the newly added functionality has a dependency on CONFIG_PM if it's
>> disabled the expected power domain (in our cases it's PL) will not powered
>> ON/OFF dynamically at runtime and this is as an expected behavior. Other
>> than this it will not impact the any of the driver existing functionality.

This looks like a general change for a specific board.

Why can't this be done at the board level ?

Tom

>>
>> Regards,
>> Navakishore.

