Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB0D4073F7
	for <lists+linux-fpga@lfdr.de>; Sat, 11 Sep 2021 01:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232762AbhIJXjz (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 10 Sep 2021 19:39:55 -0400
Received: from mga18.intel.com ([134.134.136.126]:64232 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231453AbhIJXjz (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 10 Sep 2021 19:39:55 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10103"; a="208310823"
X-IronPort-AV: E=Sophos;i="5.85,284,1624345200"; 
   d="scan'208";a="208310823"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2021 16:38:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,284,1624345200"; 
   d="scan'208";a="649557134"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga005.jf.intel.com with ESMTP; 10 Sep 2021 16:38:43 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Fri, 10 Sep 2021 16:38:43 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Fri, 10 Sep 2021 16:38:42 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Fri, 10 Sep 2021 16:38:42 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.48) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Fri, 10 Sep 2021 16:38:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nV06hbTnV6jesgniSYXm3YuCk+lhVxXNdWXzpsIT5LenDszQGOVuoUT+y485KpA5UCDH8yimKRsRJ1+mC5UN9fDUVM22UySawmX6niBn83GetxEjD1mcjzWfigm5pJFOExY0taYEov3h6+7g1vbqUGDrltJp+NJ+/b0a0cr2jNivYp+guYbWfEU07nso+H2qGKPIFUwl3ggyZnHx1wTSaWAnYFxcMsZWe8u0bJVUeIPrck6RE9AUd3q4eRO/nIuR5+p0m4WNZnKfIAx2T1Ngxko8iII57KSrMWDI6c8GVc5M5yUFpj4dYSPVaoNtrhsBsqdHe1I62thKvRS2aTRdxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=0agaoX7vrTKub8KR1HOM9XDuHeHM8Gefu6sWDK1+3dI=;
 b=PPXVeLU3BjLUeAts29iDCU1XCYRwXTigvW+AWLS/QqM+QezUjO6xukJJ/N86vsI88CRsCmfg1qItRdYZwxW65LCkkIuMCI3QOFMlajWaSnCIZkJj1grrux3iIU81zhTqDfJtLmEBHAbtDHzZjyS/z1hPitK3kDv3nr3uvMhIkErjbiKLNiuiyjkkLCNS7qAqnCmuYdFNxA9wLMpEAENvDxNHRlWJK0UJIuk1rgkb6N1eRTbc3z8xq6monrcgNchlJoMtV/L8c9FTDgSRjEGJddBleTXVzR7GqjvSPhzDXKUlZDpwU2i+tb95chEFfikMa4bPTMLfCH1XT4slzc0E7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0agaoX7vrTKub8KR1HOM9XDuHeHM8Gefu6sWDK1+3dI=;
 b=xHOtxCCmSVQDZL/iP0Xj7V19wZxJXo3K3YdOz3E4du5UXqVpyHF8AztQlB6JroZBnvh4jjasld274Sh8ZaMdGR44i+56ntuYXIovaVyeKCR5A+YoXRvy5XzZvvM3fF3YmD1iqElVnDa/8l82f5EPax0Hotj1dKbfCukRdMXtlgw=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
Received: from SA2PR11MB5163.namprd11.prod.outlook.com (2603:10b6:806:113::20)
 by SA2PR11MB5081.namprd11.prod.outlook.com (2603:10b6:806:118::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.25; Fri, 10 Sep
 2021 23:38:38 +0000
Received: from SA2PR11MB5163.namprd11.prod.outlook.com
 ([fe80::90de:46c1:4d23:5c8c]) by SA2PR11MB5163.namprd11.prod.outlook.com
 ([fe80::90de:46c1:4d23:5c8c%6]) with mapi id 15.20.4500.017; Fri, 10 Sep 2021
 23:38:38 +0000
Subject: Re: [PATCH v15 6/6] fpga: image-load: enable cancel of image upload
To:     Xu Yilun <yilun.xu@intel.com>
CC:     <mdf@kernel.org>, <linux-fpga@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <trix@redhat.com>,
        <lgoncalv@redhat.com>, <hao.wu@intel.com>,
        <matthew.gerlach@intel.com>
References: <20210909021846.681121-1-russell.h.weight@intel.com>
 <20210909021846.681121-7-russell.h.weight@intel.com>
 <20210910145545.GA757507@yilunxu-OptiPlex-7050>
From:   Russ Weight <russell.h.weight@intel.com>
Message-ID: <839aa95e-c3d1-1f60-1b36-20d29445e61f@intel.com>
Date:   Fri, 10 Sep 2021 16:38:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
In-Reply-To: <20210910145545.GA757507@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: CY5P221CA0008.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:930:b::10) To SA2PR11MB5163.namprd11.prod.outlook.com
 (2603:10b6:806:113::20)
MIME-Version: 1.0
Received: from [10.0.2.4] (50.43.42.212) by CY5P221CA0008.NAMP221.PROD.OUTLOOK.COM (2603:10b6:930:b::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend Transport; Fri, 10 Sep 2021 23:38:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 668e37ec-2c3b-4888-c784-08d974b41d54
X-MS-TrafficTypeDiagnostic: SA2PR11MB5081:
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA2PR11MB5081E8131DB012C2CC8DD675C5D69@SA2PR11MB5081.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t1dMPzIM6rFkoiwfYqzC/v/kkw8sKI3iW0CAMyslIgbvqB8UcRPp9rB5WqWPBGxJ6uW4VzPx2/hKg/ZLRvYl0w4we7sYZQU5nkM3Gj1bdRfedyhV9QmvjDjbcakwGh1HDaZgBGOPHAkAgm3AgIOw0YkQqr4r6TF0jSr5Nxrv1iJALF4tao2WP5R2TP/4125lNOUkZLWPC49cbxFI1Scl19ME0fTVtJBI1zk3Kr7INWJDI3SeitBm4xJWxlI9SF/9SUihuYHkxxLTToi/GPllMWWFVxaCk3bzRsDoiEj5q0TQQGv1y0vJ0TEh1+TbK6WmAZ8HNpUglaBn59hU+RbsLYN/lEfkYCHUcQZbkDvrYS75hWc6tlRD/oz1BJcGL6EcgwDlv27h24XRKldUwpDc4PHsLdkxKGEwgYrDAszrfjCGmfBMx4tTdoHtxeZz18sHq/3esaY0trGy1oWcNJT1NyAghxiMY74FuSoDruDG8MJ6mS3vF34h4BWEjpguQl33hYEJPlaYlc7St53VYMiySvzJf7TiKq5ZCeyiRYBTo0ys7/Th1fuEXkNzUaeVHkI70PUFqUR2HBCf+Gh1jVuZZd6tfVxO0UJQ4DlRDMB4hQaOT8mh1MffAbubs+1l95ZiTJPG3yvvcE4qdawZSe2+u9l/QXVg5nvXwmSCgQlSPXxkeTbVovjHsPSDimRWdhxC983Pk41AsNNqL2B9e6mbKI4yJPi7VeHAoqrHxuC8Hck=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB5163.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(107886003)(31686004)(16576012)(31696002)(2616005)(186003)(86362001)(5660300002)(66476007)(956004)(38100700002)(2906002)(53546011)(66556008)(316002)(6862004)(26005)(37006003)(8676002)(508600001)(83380400001)(8936002)(6636002)(66946007)(6486002)(4326008)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?anFUdnJqK1I0dUdTL1dYY3c1K3BzMHAyQ1hjQ0dhZDJuZkRrYVhJVytVK1lG?=
 =?utf-8?B?dG9qdDNoWmJhSVpqQmdtSW5vYjBzQkZsVnBqMXppbmorODJaZEpxQ2VIVDcv?=
 =?utf-8?B?bVpBUzF6aTdsYTZON0hrTDVxVFFEZ1dNSmZWUGNjdmhKalBUdUVtRjQ0TTEv?=
 =?utf-8?B?THIxTW4zMGlkUVpnSXQ0WkpMaSt3R1VzRzhsTWRWR1VsWGxmQTFDRTJESHpv?=
 =?utf-8?B?OVFlOFBHR2FCV0J6V3Fwd2tRSHBHdXRsY09Vd3pJVUp1SmsrZStCZUNLeFk5?=
 =?utf-8?B?MUhnZVdURkdYSk1GMXpoWUNLUTdFRExDMmxCU0twTExSQVdxRVVFeHJzancy?=
 =?utf-8?B?TkExVGJTL21IWHB6a2N4S2U2QzdJazk2QWNHQ0JuZFZFbkp5ZjY0ZjA0dndk?=
 =?utf-8?B?amljSDQrZU1EdTUvTmdIQ055bHRaVzNqVjBFMFNPUXN0cnZkVDAzYkdtNjdy?=
 =?utf-8?B?L2pqdEh6TUhUd00va1NkdFNXdDI2Y2RPalFwZW5zRHA4TzFwQzRmVWFvOEdh?=
 =?utf-8?B?ZG9JMDIyTVZUK29ldGE5eGFpU0FCWm1EcjQ1ZUIvem5HZmhvSm5wL2V3Z0RD?=
 =?utf-8?B?WU5CUTd3MjRUM0hvak5NTVo2dHdoeGJuNU95Zkp4MWhZY1V2cjNOK25xZjEr?=
 =?utf-8?B?QzF5aTdjOG14aDU0YzlhSUNkbmcxUGhkK1dTdEhjS1hNNklNYTZ5NW5aTEVr?=
 =?utf-8?B?N1lUTzFVYlJUcVpiRTV1bSs3Z2xNSU83WG9ac3IrVUVFTWVhWlVjZFVuVEhr?=
 =?utf-8?B?MFFUOGFIbWpXcXh0eGtWa2ovUWtobHVuMzk5UytFRDNDczVuV2VCMEE5Y3Fq?=
 =?utf-8?B?aCt6RGdRMjZ5aHZJcEdxaDgxMVp5RnBxaUpzOE9YZnZKeEdGZkpEQ2RKTFF5?=
 =?utf-8?B?UDZua2RDakxaejdPTm9Yd3RHM0dmU05XMHF0YlY4MW83MlJ1UTBmTDQ3TGp5?=
 =?utf-8?B?bFFLNTY2dUxsd2FaQlpzYTdUS09lN0JYYlJSZWl2emR3NElzSHRyaFBUcThh?=
 =?utf-8?B?VVJSU0FNYzlCYjBIWmd4U0YvN29LaEdiWHRSekwrSXRqQnFpcjI5VVAxNEt0?=
 =?utf-8?B?Rm9lQlQzOEZhVFhYNGw5TGJVRGZaTEIvVFZhYVVUWU12QmhIYkw3ZHFiL29M?=
 =?utf-8?B?dHlubng3SGZPVk1tYWxKTko4TlBKV3BOSEdsaEVMTDZ3Z1ZiSitPTHpzWFoy?=
 =?utf-8?B?Q0Z4UlI3K3RxUmxKOWY3cmlCL2pseVdVSEV2VFB0Ui81WCtPVGJJTktrdlE2?=
 =?utf-8?B?RWJUN3FDdE1VK1BkMFN3RHZnY3dEaldQeVVZcVA2M3F6T1pMT2xNTmwrNWlT?=
 =?utf-8?B?bVhzTThGTjJ2WFVELytrVE00MEZtdHJ2M2hyT2ZSOGk4UjFSbGdkWEJTek1J?=
 =?utf-8?B?UFZleEtDS2EwTWJJL3czN2pwU016Q1hPR0wyOW03alhla256TlRHM0MrandR?=
 =?utf-8?B?RS91VWRSZG1aU1NrRSs4MmJqRVh5NjBoRkVYMUIxd05yUjVKQlNaakRaMnhQ?=
 =?utf-8?B?MFFyRmxBUkJ3MlRzTWltbXBsRXltMzhRcnBqODZaYmtmT21hRUF2dWJ2Q0Zj?=
 =?utf-8?B?NVBFRzJIVGNUMWt3VUUxOUlTU0JtbFl6Y0h1SytXQngrQURwV1N0WW54Z1FV?=
 =?utf-8?B?TTdiY01uUDFXS3Avd1d0WTU3MER5R0JNb3Ywa1AzQkQ0K2lmSEE3OVFDUWht?=
 =?utf-8?B?Um1mZ0cxK1VmZDJxYXBmK1dOYjhEejMzTTZQNlhSTDQwSEh1RHJkQXkzNlRs?=
 =?utf-8?Q?NTOpurIZyr8At9jOWHEBvEDq61Rc/gyAP7i4EZu?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 668e37ec-2c3b-4888-c784-08d974b41d54
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB5163.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2021 23:38:38.5861
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VPyoVnYS/yhl7kXn8rkPERv3lx99DkxuumG5UozIQHdwkyNfKY6QER+w4JBNYtPpEtbtVx/bfyZO/PJD/KqymxFa8aKwAJONO/bjyOIlQZQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5081
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On 9/10/21 7:55 AM, Xu Yilun wrote:
> On Wed, Sep 08, 2021 at 07:18:46PM -0700, Russ Weight wrote:
>> Extend the FPGA Image Load class driver to include a cancel IOCTL that
>> can be used to request that an image upload be canceled. The IOCTL may
>> return EBUSY if it cannot be canceled by software or ENODEV if there
>> is no update in progress.
>>
>> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
>> ---
>> v15:
>>  - Compare to previous patch:
>>      [PATCH v14 6/6] fpga: sec-mgr: enable cancel of secure update
>>  - Changed file, symbol, and config names to reflect the new driver name
>>  - Cancel is now initiated by IOCT instead of sysfs
>>  - Removed signed-off/reviewed-by tags
>> v14:
>>  - Updated ABI documentation date and kernel version
>> v13:
>>   - No change
>> v12:
>>   - Updated Date and KernelVersion fields in ABI documentation
>> v11:
>>   - No change
>> v10:
>>   - Rebased to 5.12-rc2 next
>>   - Updated Date and KernelVersion in ABI documentation
>> v9:
>>   - Updated Date and KernelVersion in ABI documentation
>> v8:
>>   - No change
>> v7:
>>   - Changed Date in documentation file to December 2020
>> v6:
>>   - No change
>> v5:
>>   - No change
>> v4:
>>   - Changed from "Intel FPGA Security Manager" to FPGA Security Manager"
>>     and removed unnecessary references to "Intel".
>>   - Changed: iops -> sops, imgr -> smgr, IFPGA_ -> FPGA_, ifpga_ to fpga_
>> v3:
>>   - No change
>> v2:
>>   - Bumped documentation date and version
>>   - Minor code cleanup per review comments
>> ---
>> ---
>>  Documentation/fpga/fpga-image-load.rst |  6 ++++
>>  drivers/fpga/fpga-image-load.c         | 45 +++++++++++++++++++++++---
>>  include/linux/fpga/fpga-image-load.h   |  1 +
>>  include/uapi/linux/fpga-image-load.h   |  1 +
>>  4 files changed, 49 insertions(+), 4 deletions(-)
>>
>> diff --git a/Documentation/fpga/fpga-image-load.rst b/Documentation/fpga/fpga-image-load.rst
>> index 3d5eb51223e3..763e7833a6ea 100644
>> --- a/Documentation/fpga/fpga-image-load.rst
>> +++ b/Documentation/fpga/fpga-image-load.rst
>> @@ -37,3 +37,9 @@ FPGA_IMAGE_LOAD_STATUS:
>>  Collect status for an on-going image upload. The status returned includes
>>  how much data remains to be transferred, the progress of the image load,
>>  and error information in the case of a failure.
>> +
>> +FPGA_IMAGE_LOAD_CANCEL:
>> +
>> +Request that a on-going image upload be cancelled. This IOCTL may return
>> +EBUSY if it cannot be cancelled by software or ENODEV if there is no update
>> +in progress.
>> diff --git a/drivers/fpga/fpga-image-load.c b/drivers/fpga/fpga-image-load.c
>> index 6ec0a39f07b3..c32e4b1ea35a 100644
>> --- a/drivers/fpga/fpga-image-load.c
>> +++ b/drivers/fpga/fpga-image-load.c
>> @@ -46,6 +46,24 @@ static void fpga_image_dev_error(struct fpga_image_load *imgld,
>>  	imgld->lops->cancel(imgld);
>>  }
>>  
>> +static int fpga_image_prog_transition(struct fpga_image_load *imgld,
>> +				      enum fpga_image_prog new_progress)
>> +{
>> +	int ret = 0;
>> +
>> +	mutex_lock(&imgld->lock);
>> +	if (imgld->request_cancel) {
>> +		imgld->err_progress = imgld->progress;
>> +		imgld->err_code = FPGA_IMAGE_ERR_CANCELED;
>> +		imgld->lops->cancel(imgld);
>> +		ret = -ECANCELED;
>> +	} else {
>> +		imgld->progress = new_progress;
>> +	}
>> +	mutex_unlock(&imgld->lock);
>> +	return ret;
>> +}
>> +
>>  static void fpga_image_prog_complete(struct fpga_image_load *imgld)
>>  {
>>  	mutex_lock(&imgld->lock);
>> @@ -77,8 +95,10 @@ static void fpga_image_do_load(struct work_struct *work)
>>  		goto modput_exit;
>>  	}
>>  
>> -	fpga_image_update_progress(imgld, FPGA_IMAGE_PROG_WRITING);
>> -	while (imgld->remaining_size) {
>> +	if (fpga_image_prog_transition(imgld, FPGA_IMAGE_PROG_WRITING))
>> +		goto done;
>> +
>> +	while (imgld->remaining_size && !imgld->request_cancel) {
>>  		ret = imgld->lops->write_blk(imgld, offset);
>>  		if (ret != FPGA_IMAGE_ERR_NONE) {
>>  			fpga_image_dev_error(imgld, ret);
>> @@ -88,7 +108,9 @@ static void fpga_image_do_load(struct work_struct *work)
>>  		offset = size - imgld->remaining_size;
>>  	}
>>  
>> -	fpga_image_update_progress(imgld, FPGA_IMAGE_PROG_PROGRAMMING);
>> +	if (fpga_image_prog_transition(imgld, FPGA_IMAGE_PROG_PROGRAMMING))
>> +		goto done;
>> +
>>  	ret = imgld->lops->poll_complete(imgld);
>>  	if (ret != FPGA_IMAGE_ERR_NONE)
>>  		fpga_image_dev_error(imgld, ret);
>> @@ -159,6 +181,7 @@ static int fpga_image_load_ioctl_write(struct fpga_image_load *imgld,
>>  	imgld->remaining_size = wb.size;
>>  	imgld->err_code = FPGA_IMAGE_ERR_NONE;
>>  	imgld->progress = FPGA_IMAGE_PROG_STARTING;
>> +	imgld->request_cancel = false;
>>  	reinit_completion(&imgld->update_done);
>>  	schedule_work(&imgld->work);
>>  	return 0;
>> @@ -189,7 +212,7 @@ static long fpga_image_load_ioctl(struct file *filp, unsigned int cmd,
>>  				  unsigned long arg)
>>  {
>>  	struct fpga_image_load *imgld = filp->private_data;
>> -	int ret = -ENOTTY;
>> +	int ret = 0;
>>  
>>  	mutex_lock(&imgld->lock);
>>  
>> @@ -200,6 +223,17 @@ static long fpga_image_load_ioctl(struct file *filp, unsigned int cmd,
>>  	case FPGA_IMAGE_LOAD_STATUS:
>>  		ret = fpga_image_load_ioctl_status(imgld, arg);
>>  		break;
>> +	case FPGA_IMAGE_LOAD_CANCEL:
>> +		if (imgld->progress == FPGA_IMAGE_PROG_PROGRAMMING)
>> +			ret = -EBUSY;
>> +		else if (imgld->progress == FPGA_IMAGE_PROG_IDLE)
>> +			ret = -ENODEV;
>> +		else
>> +			imgld->request_cancel = true;
>> +		break;
>> +	default:
>> +		ret = -ENOTTY;
>> +		break;
>>  	}
>>  
>>  	mutex_unlock(&imgld->lock);
>> @@ -374,6 +408,9 @@ void fpga_image_load_unregister(struct fpga_image_load *imgld)
>>  		goto unregister;
>>  	}
>>  
>> +	if (imgld->progress != FPGA_IMAGE_PROG_PROGRAMMING)
>> +		imgld->request_cancel = true;
>> +
> Why we cancel the programing rather than waiting for programing done?

This isn't new - it is the way the security manager was implemented.

Updates can take up to 40 minutes for the N3000. If a person tries
to unload the driver modules, should we hang for 40 minutes? Or should
we try to cancel the update and allow the module to be unloaded?
I think it is reasonable to cancel the update (if possible) under these
circumstances. What do you think?

- Russ

>
> Thanks,
> Yilun
>
>>  	mutex_unlock(&imgld->lock);
>>  	wait_for_completion(&imgld->update_done);
>>  
>> diff --git a/include/linux/fpga/fpga-image-load.h b/include/linux/fpga/fpga-image-load.h
>> index 68f3105b51d2..4e51b9fd1724 100644
>> --- a/include/linux/fpga/fpga-image-load.h
>> +++ b/include/linux/fpga/fpga-image-load.h
>> @@ -52,6 +52,7 @@ struct fpga_image_load {
>>  	enum fpga_image_prog progress;
>>  	enum fpga_image_prog err_progress;	/* progress at time of failure */
>>  	enum fpga_image_err err_code;		/* image load error code */
>> +	bool request_cancel;
>>  	bool driver_unload;
>>  	struct eventfd_ctx *finished;
>>  	void *priv;
>> diff --git a/include/uapi/linux/fpga-image-load.h b/include/uapi/linux/fpga-image-load.h
>> index 6a995bcc0fb7..8d0dfa1f9b77 100644
>> --- a/include/uapi/linux/fpga-image-load.h
>> +++ b/include/uapi/linux/fpga-image-load.h
>> @@ -39,6 +39,7 @@ enum fpga_image_err {
>>  
>>  #define FPGA_IMAGE_LOAD_WRITE	_IOW(FPGA_IMAGE_LOAD_MAGIC, 0, struct fpga_image_write)
>>  #define FPGA_IMAGE_LOAD_STATUS	_IOR(FPGA_IMAGE_LOAD_MAGIC, 1, struct fpga_image_status)
>> +#define FPGA_IMAGE_LOAD_CANCEL	_IO(FPGA_IMAGE_LOAD_MAGIC, 2)
>>  
>>  /**
>>   * FPGA_IMAGE_LOAD_WRITE - _IOW(FPGA_IMAGE_LOAD_MAGIC, 0,
>> -- 
>> 2.25.1

