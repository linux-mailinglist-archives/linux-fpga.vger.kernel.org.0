Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30DB1413A1E
	for <lists+linux-fpga@lfdr.de>; Tue, 21 Sep 2021 20:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233197AbhIUSiQ (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 21 Sep 2021 14:38:16 -0400
Received: from mga01.intel.com ([192.55.52.88]:28291 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232890AbhIUSiQ (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 21 Sep 2021 14:38:16 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10114"; a="245869361"
X-IronPort-AV: E=Sophos;i="5.85,311,1624345200"; 
   d="scan'208";a="245869361"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2021 11:36:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,311,1624345200"; 
   d="scan'208";a="533422475"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga004.fm.intel.com with ESMTP; 21 Sep 2021 11:36:47 -0700
Received: from fmsmsx605.amr.corp.intel.com (10.18.126.85) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Tue, 21 Sep 2021 11:36:46 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Tue, 21 Sep 2021 11:36:46 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.108)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Tue, 21 Sep 2021 11:36:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AwlZDGf7xvHufPDt5JRllJhNHTb87xqpjorVdAjcEPk2CxfUaN6mbTqKP7rNuk3nwJMwrVrFcdjeD+6pxrEHa/WvqOTZerKAUc0+z/JwmoIKr/qobdHnAzk/RFUNbzIhldT412OXSebEMnJfsm03al6ON6H4GYPFE/Wi31ryy2QegbMA5hmVcHdOXtGjkYxijCv2D6Z7CpXTl9JElSm9IsfkN9yys/C1zS0luYsXUrFTGwo3ja9Db5zop+YD8f8x4CAimMKMlHQsmaTctVPcsUkPZQ9rAfutcZB8tygrm1x5NyHRhp8XS0IvzzQzcTdkHS6BT/NRhLTl3SFJbUyeMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=bD6A+Dx+euLD0EegS5h+eC8EQ97hTo9jEuPV8pgC6mI=;
 b=FN48NzDli+Q16o1MTChkoBn2wErH19n27yug7RzYeeS+1sGk/saLLxby1SPtoeEgE8q5Z+DDEtMlkqIAuR63rCr5ipXX8ESe4S2YuwvkIXS3mmKDZvgbsR+Ym27aOnquLBbqF5UcUjgdAHZnIubQOci8Bri4fFVBJNwal4X4ikaRvd7MMpxRiFnYmlCEmf26RHNs67Dwe8e6/Kc6m7yqIRnQ4iQbeHcZVT03N0ZJ0h3R2o2RY/VHxbnYqQR5tx3p3KtVdGJX+/1MSr/k06gJwzxEsdIqTyGZJpX+1IXTZqirShB/PCFvRR5E034D1alZCbNM5Ajm8Rp2/PsF6N7f2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bD6A+Dx+euLD0EegS5h+eC8EQ97hTo9jEuPV8pgC6mI=;
 b=L2J5a/K2OMa6EIDw5LqobAoxWfc5xWqZ2hmCk8LU4BrNbrzHmhjJ6wSrYHKdaTmAjV+CXfhBmyHw9iCLswJa5/ErSPJ4smD3c4K6lMQEfvcIogiUmzxkYOf6yyOIn1S6yoizcWrx3CzHVySFM9fgLW733R/IyjQ5GPyjHLWjHHg=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=intel.com;
Received: from SA2PR11MB5163.namprd11.prod.outlook.com (2603:10b6:806:113::20)
 by SN6PR11MB3456.namprd11.prod.outlook.com (2603:10b6:805:c8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.17; Tue, 21 Sep
 2021 18:36:41 +0000
Received: from SA2PR11MB5163.namprd11.prod.outlook.com
 ([fe80::90de:46c1:4d23:5c8c]) by SA2PR11MB5163.namprd11.prod.outlook.com
 ([fe80::90de:46c1:4d23:5c8c%5]) with mapi id 15.20.4523.018; Tue, 21 Sep 2021
 18:36:41 +0000
Subject: Re: [PATCH v15 2/6] fpga: image-load: enable image loads
To:     Hillf Danton <hdanton@sina.com>
CC:     <linux-fpga@vger.kernel.org>, <trix@redhat.com>,
        <linux-kernel@vger.kernel.org>
References: <20210909021846.681121-1-russell.h.weight@intel.com>
 <20210912023739.4078-1-hdanton@sina.com>
From:   Russ Weight <russell.h.weight@intel.com>
Message-ID: <46d8e0ef-59f8-6298-93fb-80638599af8e@intel.com>
Date:   Tue, 21 Sep 2021 11:36:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
In-Reply-To: <20210912023739.4078-1-hdanton@sina.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: MW4PR04CA0202.namprd04.prod.outlook.com
 (2603:10b6:303:86::27) To SA2PR11MB5163.namprd11.prod.outlook.com
 (2603:10b6:806:113::20)
MIME-Version: 1.0
Received: from [10.0.2.4] (50.43.42.212) by MW4PR04CA0202.namprd04.prod.outlook.com (2603:10b6:303:86::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend Transport; Tue, 21 Sep 2021 18:36:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 618d0f7a-d477-4522-a2ce-08d97d2ec159
X-MS-TrafficTypeDiagnostic: SN6PR11MB3456:
X-Microsoft-Antispam-PRVS: <SN6PR11MB34566A2AC5526BA01D7C2BC6C5A19@SN6PR11MB3456.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ljpHKRt0TN+C9iX5qWntugRBZ4PXorb3y57K//Q9BdLdDzn5EBmxrIda75HnHjrUhu9LYP0SQOfRdMFsDa0+NC0L6+1Z4x5BtSvCPxi2c1CQ/7zfklTWo/6z11UqJO3mSgc39ItbxRCoJdNu/2E0MgIDYmn2H/Vgw78txCqIK5dEwOx7kIgmTC8fkZyEHslNieySAV0Fa8kx1JXs5WsNMIhRf+j96LndPFfzHqXFpGQlzJ9lWw/zgFjB4K8Qkr5W3+Om/pUiyfAChuE1SE6xWxf8RI2F4meSj5QQAC3GznmxwNLqINUg0dlkhyXuLIs01CVwOU9cQcSbAHVomd5QhD82vLYfX+DQw3Btobm5RV7Qq8L2K0/dtAzu2Nd0NYcWzzGKoQaRKTRX4BZ1gWHrAsAPNW9iMEucMoKxE7VQqKhOxQ5zb9nYpmFWgdMiT2CSRRAjcIE80OpB4kYCfyGE12fPy/VkJAQKN0SCpBhEj/TamYTcUC5Jdkx9epnEheLMBvAhE8Ob9G81It9L/MOTTsan0j+hoNCR3OXFxoxcnteL8BqHgWipJz8dNdGulCTp1wTuirJHK4HbioESKX8z6lPx2VI7y0DoEcfWSicDs80gIqxBe6zCQYjetXrH+D7ffvu1DctaFFMlhfm71iGj6b6vMKjVP2WiOurFW8hazeXc9qvzGLB6ARgEe9FGjRqrnGMHilR/PhkKRYfBaXWsUSsKacIyBfNgViSbN18is7Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB5163.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66556008)(66476007)(86362001)(8676002)(31696002)(316002)(16576012)(36756003)(4326008)(38100700002)(5660300002)(6486002)(66946007)(53546011)(956004)(31686004)(2616005)(26005)(83380400001)(186003)(6916009)(508600001)(8936002)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N0FWSy8xVjNnMXlBOFQyZE1MeXBjMnY5R1AyeUtYUGVUWkViNGVVeTJXSk1W?=
 =?utf-8?B?Z2ZvamNVckxFK2FqUmtabk1pQ0N3YkZ0SEZlVjJYT2VFc0VESGpKTGpDMUFj?=
 =?utf-8?B?cW9saFBUcHhGalR3QXVFNWtxOVQvQUhxa0FjQlUzZ3pocEJoUjNmMFY1OVMr?=
 =?utf-8?B?Y2grQU9PSlBydVlGM0FrbXZyY2lSTjNnUWVnL1hYb3NEVkE5YUwwTHNGclJu?=
 =?utf-8?B?MU9QWWFVbkFLSVBIOVFlS0pSYjlFNkpnQkMxNUFJR2RscnR4RXBaT1NvRHFB?=
 =?utf-8?B?eEVZbTIrQVpNTVRiUTNKT0w2Z2IzdWNNa1hZWm1DQlNuK3F6RldxZnB1ME4z?=
 =?utf-8?B?VzZ5bWphQzIwazZjczE0Qk5YMlUxdjdkaWF0SUsyUkc4bDgxbklNOGRNSGJp?=
 =?utf-8?B?a0lRR1M3SHpIQWZBdUI4T2ppT1dNSllTVGdyWWFqaUM5U1B4SUVWcnVpc3JK?=
 =?utf-8?B?cjlWRWhZRVpvMmhLL1lucmFnMTlFL3Ewd3ByUWtra0hmeUV3Mjlxa2lYUDFa?=
 =?utf-8?B?aVBlS2VIOTd6MFdXUGl5VW02bDdIbkpieWVBcy9lWk1lRHZna2NwdXRaVVE2?=
 =?utf-8?B?VFlleTNRRHQ1THhicWRUT1NuakZHSTBJeDB5enI0bktEZ1RIckhoMkdBNi8v?=
 =?utf-8?B?TVYzNU9uek4wOWxLNXNaczZoY09oVkdrNHBNRXJMcTQvL1l4NnczSkhHVy9U?=
 =?utf-8?B?YnBObGptQmx4RDdnVjhQa0NCTmIyUnkydXlhQVcvSytzbWVFbXB5ZW1mdG83?=
 =?utf-8?B?eE9ZZmpKTFFRY0plYUZFbHJyR3NPekUxcUFCR2RZbTQ2QWRBYkYyZHZFY013?=
 =?utf-8?B?VVRYeHJJajUwb0I4cmtNSUxTay9Ka3Nub0g2OTBwckswSDFqbkc5TG9BT0hk?=
 =?utf-8?B?Q05WbDd2SzI0RUlZWldsekxGV0N3ZnlSS29IWG5QNnNTd09CQ0g1QTUvQ2Vk?=
 =?utf-8?B?d0ZMMXRMSHBiSm12ak43SEhCZWpTbkpaUTU3dVBqUUxlVlBFcmRFMVlIbFpL?=
 =?utf-8?B?ZUdldXhJcWxEc2RoUUNTNWtaQkJQTWhyN3lmUWRNNXpzZVQxV3RLZUkzN1dv?=
 =?utf-8?B?TFNyZFQ4SWhMeitCZG0yYVdoR25oVEdlcFhEcUFFT3h6SXg3Sk1nQUl0RHNL?=
 =?utf-8?B?MVMyZDRuNmZyanhsL1F3UkVqaDg5MnVXcEFDZWV4cHlvemdEKzNMdGtGeGZ3?=
 =?utf-8?B?SzRPbVowTnd6Y3YzSHl0emU1RXpqT0ZhQnpNNVpYbWIwckRWdmlydndMZmdy?=
 =?utf-8?B?Lys2RW5NRTVsVjkrOXc3aDVVSTBlZFY4TTNpTFYyQlBkdXpSTEtjbm10STNW?=
 =?utf-8?B?cjZ0RkxZSGJJaFNTdm82ZjkzRkVkL05UNzdtZTh6TzZyVXlDNFRkYnJybmlt?=
 =?utf-8?B?R202bXdqYThlWW9hL3ZOTFBreFVVMXFxOTRCSEtyUEpqVGUycDNvVU85bVpk?=
 =?utf-8?B?RjZWc2lmU2lsT2FzMFVHZHNhTjNqckVNTE9WNWd0czFWKzBRb215L1dPWFRH?=
 =?utf-8?B?eXh1TW9DVkdobHR2QS92TEcydWhpUmJGOGdweHUrNWhYTytzZWxqOHcxZVIz?=
 =?utf-8?B?ZFE3OTIrdjJYVFc0TXlKS29Idmo5NVUzUkNsZ3NMN1ByMS90REFoakZtbWVT?=
 =?utf-8?B?WVFiQ2o1VHE2dGtYQm9ZRTFWNTZ2SXAyWHlibXArVFhzbTF6S29EKzBLT3Rk?=
 =?utf-8?B?VVpHM0tQdUZ4Qy93b2I4U2ltMXFFQ3ZZRXo2QVdTSmxyQzZaeHdCTnZiVnZq?=
 =?utf-8?Q?UAgOwtyM+gCQsK+/Rf3HzyEpb6NhxZ4r9UOJFWF?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 618d0f7a-d477-4522-a2ce-08d97d2ec159
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB5163.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2021 18:36:41.8447
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /SbCbN4ZqR9weQ/+K/2W/gpeDixyjtS81AKgkhowsorIUXKcbWi6VV7cA4Zgw/AjOD18NxqXQiNh6gcoHl+1XKnAApDAvBYAmLxY4fsMR84=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3456
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On 9/11/21 7:37 PM, Hillf Danton wrote:
> On Wed,  8 Sep 2021 19:18:42 -0700 Russ Weight wrote:
>> Extend the FPGA Image Load class driver to include IOCTL support
>> (FPGA_IMAGE_LOAD_WRITE) for initiating an upload of an image to a device.
>> The IOCTL will return immediately, and the update will begin in the
>> context of a kernel worker thread.
>>
>> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
>> ---
> Good work overall. Nits below.
> [...]
>
>> +++ b/drivers/fpga/fpga-image-load.c
>> @@ -5,18 +5,181 @@
>>   * Copyright (C) 2019-2021 Intel Corporation, Inc.
>>   */
>>  
>> +#include <linux/delay.h>
>>  #include <linux/fpga/fpga-image-load.h>
>> +#include <linux/fs.h>
>> +#include <linux/kernel.h>
>>  #include <linux/module.h>
>>  #include <linux/slab.h>
>> +#include <linux/uaccess.h>
>>  #include <linux/vmalloc.h>
>>  
>>  #define IMAGE_LOAD_XA_LIMIT	XA_LIMIT(0, INT_MAX)
>>  static DEFINE_XARRAY_ALLOC(fpga_image_load_xa);
>>  
>>  static struct class *fpga_image_load_class;
>> +static dev_t fpga_image_devt;
>>  
>>  #define to_image_load(d) container_of(d, struct fpga_image_load, dev)
>>  
>> +static void fpga_image_dev_error(struct fpga_image_load *imgld,
>> +				 enum fpga_image_err err_code)
>> +{
>> +	imgld->err_code = err_code;
>> +	imgld->lops->cancel(imgld);
>> +}
>> +
>> +static void fpga_image_prog_complete(struct fpga_image_load *imgld)
>> +{
>> +	mutex_lock(&imgld->lock);
>> +	imgld->progress = FPGA_IMAGE_PROG_IDLE;
>> +	complete_all(&imgld->update_done);
>> +	mutex_unlock(&imgld->lock);
>> +}
>> +
>> +static void fpga_image_do_load(struct work_struct *work)
>> +{
>> +	struct fpga_image_load *imgld;
>> +	enum fpga_image_err ret;
>> +	u32 size, offset = 0;
>> +
>> +	imgld = container_of(work, struct fpga_image_load, work);
>> +	size = imgld->remaining_size;
> Bail out if imgld->driver_unload is set.
I'll add this.
>
>> +
>> +	get_device(&imgld->dev);
>> +	if (!try_module_get(imgld->dev.parent->driver->owner)) {
>> +		imgld->err_code = FPGA_IMAGE_ERR_BUSY;
>> +		goto idle_exit;
>> +	}
>> +
>> +	imgld->progress = FPGA_IMAGE_PROG_PREPARING;
>> +	ret = imgld->lops->prepare(imgld);
>> +	if (ret != FPGA_IMAGE_ERR_NONE) {
>> +		fpga_image_dev_error(imgld, ret);
>> +		goto modput_exit;
>> +	}
>> +
>> +	imgld->progress = FPGA_IMAGE_PROG_WRITING;
>> +	while (imgld->remaining_size) {
>> +		ret = imgld->lops->write_blk(imgld, offset);
>> +		if (ret != FPGA_IMAGE_ERR_NONE) {
>> +			fpga_image_dev_error(imgld, ret);
>> +			goto done;
>> +		}
>> +
>> +		offset = size - imgld->remaining_size;
> If cond_resched() is needed here then make imgld->work unbound.
>
> 	queue_work(system_unbound_wq, &imgld->work);
Given that class driver does not have control over the size of
the data or the actual implementation of the writes, it is
probably best to add these changes. I'll do this for the next
submission of theses patches.

>
>> +	}
>> +
>> +	imgld->progress = FPGA_IMAGE_PROG_PROGRAMMING;
>> +	ret = imgld->lops->poll_complete(imgld);
>> +	if (ret != FPGA_IMAGE_ERR_NONE)
>> +		fpga_image_dev_error(imgld, ret);
>> +
>> +done:
>> +	if (imgld->lops->cleanup)
>> +		imgld->lops->cleanup(imgld);
>> +
>> +modput_exit:
>> +	module_put(imgld->dev.parent->driver->owner);
>> +
>> +idle_exit:
>> +	/*
>> +	 * Note: imgld->remaining_size is left unmodified here to provide
>> +	 * additional information on errors. It will be reinitialized when
>> +	 * the next image load begins.
>> +	 */
>> +	vfree(imgld->data);
>> +	imgld->data = NULL;
>> +	put_device(&imgld->dev);
>> +	fpga_image_prog_complete(imgld);
>> +}
>> +
>> +static int fpga_image_load_ioctl_write(struct fpga_image_load *imgld,
>> +				       unsigned long arg)
>> +{
>> +	struct fpga_image_write wb;
>> +	unsigned long minsz;
>> +	u8 *buf;
>> +
>> +	if (imgld->driver_unload || imgld->progress != FPGA_IMAGE_PROG_IDLE)
>> +		return -EBUSY;
>> +
>> +	minsz = offsetofend(struct fpga_image_write, buf);
>> +	if (copy_from_user(&wb, (void __user *)arg, minsz))
>> +		return -EFAULT;
>> +
>> +	if (wb.flags)
>> +		return -EINVAL;
>> +
>> +	/* Enforce 32-bit alignment on the write data */
>> +	if (wb.size & 0x3)
>> +		return -EINVAL;
>> +
>> +	buf = vzalloc(wb.size);
>> +	if (!buf)
>> +		return -ENOMEM;
>> +
>> +	if (copy_from_user(buf, u64_to_user_ptr(wb.buf), wb.size)) {
>> +		vfree(buf);
>> +		return -EFAULT;
>> +	}
>> +
>> +	imgld->data = buf;
>> +	imgld->remaining_size = wb.size;
>> +	imgld->err_code = FPGA_IMAGE_ERR_NONE;
>> +	imgld->progress = FPGA_IMAGE_PROG_STARTING;
>> +	reinit_completion(&imgld->update_done);
>> +	schedule_work(&imgld->work);
>> +
>> +	return 0;
>> +}
>> +
>> +static long fpga_image_load_ioctl(struct file *filp, unsigned int cmd,
>> +				  unsigned long arg)
>> +{
>> +	struct fpga_image_load *imgld = filp->private_data;
>> +	int ret = -ENOTTY;
>> +
>> +	switch (cmd) {
>> +	case FPGA_IMAGE_LOAD_WRITE:
>> +		mutex_lock(&imgld->lock);
>> +		ret = fpga_image_load_ioctl_write(imgld, arg);
>> +		mutex_unlock(&imgld->lock);
>> +		break;
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>> +static int fpga_image_load_open(struct inode *inode, struct file *filp)
>> +{
>> +	struct fpga_image_load *imgld = container_of(inode->i_cdev,
>> +						     struct fpga_image_load, cdev);
>> +
>> +	if (test_and_set_bit(0, &imgld->opened))
>> +		return -EBUSY;
>> +
>> +	filp->private_data = imgld;
>> +
>> +	return 0;
>> +}
>> +
>> +static int fpga_image_load_release(struct inode *inode, struct file *filp)
>> +{
>> +	struct fpga_image_load *imgld = filp->private_data;
>> +
>> +	clear_bit(0, &imgld->opened);
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct file_operations fpga_image_load_fops = {
>> +	.owner = THIS_MODULE,
>> +	.open = fpga_image_load_open,
>> +	.release = fpga_image_load_release,
>> +	.unlocked_ioctl = fpga_image_load_ioctl,
>> +};
>> +
>>  /**
>>   * fpga_image_load_register - create and register an FPGA Image Load Device
>>   *
>> @@ -33,11 +196,17 @@ fpga_image_load_register(struct device *parent,
>>  			 const struct fpga_image_load_ops *lops, void *priv)
>>  {
>>  	struct fpga_image_load *imgld;
>> -	int id, ret;
>> +	int ret;
>> +
>> +	if (!lops || !lops->cancel || !lops->prepare ||
>> +	    !lops->write_blk || !lops->poll_complete) {
>> +		dev_err(parent, "Attempt to register without all required ops\n");
>> +		return ERR_PTR(-ENOMEM);
>> +	}
>>  
>>  	imgld = kzalloc(sizeof(*imgld), GFP_KERNEL);
>>  	if (!imgld)
>> -		return NULL;
>> +		return ERR_PTR(-ENOMEM);
>>  
>>  	ret = xa_alloc(&fpga_image_load_xa, &imgld->dev.id, imgld, IMAGE_LOAD_XA_LIMIT,
>>  		       GFP_KERNEL);
>> @@ -48,13 +217,19 @@ fpga_image_load_register(struct device *parent,
>>  
>>  	imgld->priv = priv;
>>  	imgld->lops = lops;
>> +	imgld->err_code = FPGA_IMAGE_ERR_NONE;
>> +	imgld->progress = FPGA_IMAGE_PROG_IDLE;
>> +	init_completion(&imgld->update_done);
>> +	INIT_WORK(&imgld->work, fpga_image_do_load);
>>  
>>  	imgld->dev.class = fpga_image_load_class;
>>  	imgld->dev.parent = parent;
>> +	imgld->dev.devt = MKDEV(MAJOR(fpga_image_devt), imgld->dev.id);
>>  
>> -	ret = dev_set_name(&imgld->dev, "fpga_image%d", id);
>> +	ret = dev_set_name(&imgld->dev, "fpga_image%d", imgld->dev.id);
>>  	if (ret) {
>> -		dev_err(parent, "Failed to set device name: fpga_image%d\n", id);
>> +		dev_err(parent, "Failed to set device name: fpga_image%d\n",
>> +			imgld->dev.id);
>>  		goto error_device;
>>  	}
>>  
>> @@ -64,6 +239,16 @@ fpga_image_load_register(struct device *parent,
>>  		return ERR_PTR(ret);
>>  	}
>>  
>> +	cdev_init(&imgld->cdev, &fpga_image_load_fops);
>> +	imgld->cdev.owner = parent->driver->owner;
>> +	imgld->cdev.kobj.parent = &imgld->dev.kobj;
>> +
>> +	ret = cdev_add(&imgld->cdev, imgld->dev.devt, 1);
>> +	if (ret) {
>> +		put_device(&imgld->dev);
>> +		return ERR_PTR(ret);
>> +	}
>> +
>>  	return imgld;
>>  
>>  error_device:
>> @@ -83,9 +268,29 @@ EXPORT_SYMBOL_GPL(fpga_image_load_register);
>>   *
>>   * This function is intended for use in an FPGA Image Load driver's
>>   * remove() function.
>> + *
>> + * For some devices, once authentication of the uploaded image has begun,
>> + * the hardware cannot be signaled to stop, and the driver will not exit
>> + * until the hardware signals completion.  This could be 30+ minutes of
>> + * waiting. The driver_unload flag enables a force-unload of the driver
>> + * (e.g. modprobe -r) by signaling the parent driver to exit even if the
>> + * hardware update is incomplete. The driver_unload flag also prevents
>> + * new updates from starting once the unregister process has begun.
>>   */
>>  void fpga_image_load_unregister(struct fpga_image_load *imgld)
>>  {
>> +	mutex_lock(&imgld->lock);
>> +	imgld->driver_unload = true;
>> +	if (imgld->progress == FPGA_IMAGE_PROG_IDLE) {
>> +		mutex_unlock(&imgld->lock);
>> +		goto unregister;
>> +	}
>> +
>> +	mutex_unlock(&imgld->lock);
>> +	wait_for_completion(&imgld->update_done);
> You can cut update_done if wait_for_completion() is replaced with
> flush_work() or cancel_work_sync(&imgld->work).
Thanks! I'll use flush_work() and eliminate the update_done completion
instance.

Thanks for the suggestions!

- Russ
>
>> +
>> +unregister:
>> +	cdev_del(&imgld->cdev);
>>  	device_unregister(&imgld->dev);
>>  }
>>  EXPORT_SYMBOL_GPL(fpga_image_load_unregister);

