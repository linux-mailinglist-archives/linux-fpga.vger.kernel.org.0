Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D7EA2C4C80
	for <lists+linux-fpga@lfdr.de>; Thu, 26 Nov 2020 02:19:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730646AbgKZBRx (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 25 Nov 2020 20:17:53 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:8588 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728995AbgKZBRw (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 25 Nov 2020 20:17:52 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4ChKcM3svwzLvWy;
        Thu, 26 Nov 2020 09:17:23 +0800 (CST)
Received: from [10.174.177.149] (10.174.177.149) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.487.0; Thu, 26 Nov 2020 09:17:46 +0800
Subject: Re: [PATCH] fpga: dfl: add missing platform_device_put in
 build_info_create_dev
To:     "Wu, Hao" <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
        Moritz Fischer <mdf@kernel.org>
CC:     "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20201125065030.154074-1-miaoqinglang@huawei.com>
 <DM6PR11MB381903C990E8D7C76EF04E5F85FA0@DM6PR11MB3819.namprd11.prod.outlook.com>
From:   Qinglang Miao <miaoqinglang@huawei.com>
Message-ID: <f2ac1d09-4e9d-31ed-6ba2-fea3219ff4a9@huawei.com>
Date:   Thu, 26 Nov 2020 09:17:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <DM6PR11MB381903C990E8D7C76EF04E5F85FA0@DM6PR11MB3819.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.149]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



ÔÚ 2020/11/25 18:06, Wu, Hao Ð´µÀ:
>> Subject: [PATCH] fpga: dfl: add missing platform_device_put in
>> build_info_create_dev
>>
>> platform_device_put is missing when it fails to set fdev->id. Set
>> a temp value to do sanity check.
> 
> will this case be covered already by build_info_free()?
> 
> Hao
Yes, you're right Hao.

build_info_create_dev is performed in parse_feature_list which follows
build_info_free.

So please ignore this patch.

Thanks!
> 
>>
>> Fixes: 543be3d8c999 ("fpga: add device feature list support")
>> Reported-by: Hulk Robot <hulkci@huawei.com>
>> Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
>> ---
>>   drivers/fpga/dfl.c | 9 ++++++---
>>   1 file changed, 6 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
>> index b450870b7..8958f0860 100644
>> --- a/drivers/fpga/dfl.c
>> +++ b/drivers/fpga/dfl.c
>> @@ -877,10 +877,13 @@ build_info_create_dev(struct
>> build_feature_devs_info *binfo,
>>
>>   	INIT_LIST_HEAD(&binfo->sub_features);
>>
>> -	fdev->id = dfl_id_alloc(type, &fdev->dev);
>> -	if (fdev->id < 0)
>> -		return fdev->id;
>> +	int tmp_id = dfl_id_alloc(type, &fdev->dev);
>> +	if (tmp_id < 0) {
>> +		platform_device_put(fdev);
>> +		return tmp_id;
>> +	}
>>
>> +	fdev->id = tmp_id;
>>   	fdev->dev.parent = &binfo->cdev->region->dev;
>>   	fdev->dev.devt = dfl_get_devt(dfl_devs[type].devt_type, fdev->id);
>>
>> --
>> 2.23.0
> 
> .
> 
