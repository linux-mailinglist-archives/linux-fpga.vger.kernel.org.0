Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A52F1417E9C
	for <lists+linux-fpga@lfdr.de>; Sat, 25 Sep 2021 02:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233848AbhIYAbM (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 24 Sep 2021 20:31:12 -0400
Received: from mga02.intel.com ([134.134.136.20]:59878 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229575AbhIYAbL (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 24 Sep 2021 20:31:11 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10117"; a="211441587"
X-IronPort-AV: E=Sophos;i="5.85,321,1624345200"; 
   d="scan'208";a="211441587"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2021 17:29:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,321,1624345200"; 
   d="scan'208";a="519497094"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga001.jf.intel.com with ESMTP; 24 Sep 2021 17:29:37 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Fri, 24 Sep 2021 17:29:36 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Fri, 24 Sep 2021 17:29:36 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Fri, 24 Sep 2021 17:29:36 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.102)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Fri, 24 Sep 2021 17:29:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XqzhG2Vr8Ra0nTF4zO2LJRqmLrUBsn0S/QaCo1RqBa4y+tinqhzPGcidIiERTnKhG+NIML7AAWxiteFWPRgcvDhs1U2ZZxkw/r1LohRr9J2IFIanAUKrccBjF7iXkVUnAu6xBlwkfBOtGyre+8Ke/WC8oDROUVpVefu779xjHxi8StTEGDTakLT2c/2Etp0IBpTMNA8L0jyqG9blSK8F6Jhey1CQPiXOYYgSlQIfn11L6aucAnpHMlUCYH7zNxT4JKVH1PAbystb6Xl1xa/gAURYkeJF185yYoNreVITNFPeRSAMv0i635t5fiwutYGhTWlA/wcz7zbUdZbJH7SyVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=Gl/BXO2cfJWrsscoQOCnp90TiZz6JGMfrXmP/nilyqw=;
 b=au5JZdB8lzFoBpZTbIto+LLFa1WOUwMx+lhd+RUkx5kvHA8xG0HBHZpUb5Y8q+5Cl65Tjt2+9Hw7u2ii/gT41RiyT+cvuPUXMVIWL87nwG0np9HpDhTT7Kkd/dN/0DzxRssvCu4cYTf7oOtDRxAKGqPE+Zlc1hhxh8GHEDAnGWDSeNGEUSNXlvjRIYdlZ5LLYNStD6onAlLYo7Eufsowm9tOXFe4Hxqrc4QRrG9kQnpkd/+jjuqyCA8DZikZZdsz/nj7xyGQd6jIKWS92KgASzsPL6ec2hDkNa4caPYRMjhJ99guAiTHS6rQekCOW7ww0FmP3oWoqLdA+6C/6qTfuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gl/BXO2cfJWrsscoQOCnp90TiZz6JGMfrXmP/nilyqw=;
 b=toCifI0kfXpl2baYqUtYndjmUumRahSxGhhhmQRsjX+9A2H8oYOHaVQLPe9NA1AMX+j3OotYjb9hnji2XfPU52gKZ6TZsX8lQc/2xRxo5qM8DFLdT3SfwuYuH/z1GQuBIenuIXjhEow2bHqpb2n7EWriJZVCCf0YgeayI2GCkyk=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
Received: from SA2PR11MB5163.namprd11.prod.outlook.com (2603:10b6:806:113::20)
 by SA2PR11MB5147.namprd11.prod.outlook.com (2603:10b6:806:118::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Sat, 25 Sep
 2021 00:29:32 +0000
Received: from SA2PR11MB5163.namprd11.prod.outlook.com
 ([fe80::90de:46c1:4d23:5c8c]) by SA2PR11MB5163.namprd11.prod.outlook.com
 ([fe80::90de:46c1:4d23:5c8c%5]) with mapi id 15.20.4544.018; Sat, 25 Sep 2021
 00:29:32 +0000
Subject: Re: [PATCH v16 5/5] fpga: image-load: enable cancel of image upload
To:     Xu Yilun <yilun.xu@intel.com>
CC:     <mdf@kernel.org>, <linux-fpga@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <trix@redhat.com>,
        <lgoncalv@redhat.com>, <hao.wu@intel.com>,
        <matthew.gerlach@intel.com>
References: <20210923001056.282790-1-russell.h.weight@intel.com>
 <20210923001056.282790-6-russell.h.weight@intel.com>
 <20210924145338.GA1342075@yilunxu-OptiPlex-7050>
From:   Russ Weight <russell.h.weight@intel.com>
Message-ID: <d03bc8f3-5afc-207c-62db-68bb4d533e36@intel.com>
Date:   Fri, 24 Sep 2021 17:29:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
In-Reply-To: <20210924145338.GA1342075@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: MWHPR2001CA0003.namprd20.prod.outlook.com
 (2603:10b6:301:15::13) To SA2PR11MB5163.namprd11.prod.outlook.com
 (2603:10b6:806:113::20)
MIME-Version: 1.0
Received: from [10.0.2.4] (50.43.42.212) by MWHPR2001CA0003.namprd20.prod.outlook.com (2603:10b6:301:15::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend Transport; Sat, 25 Sep 2021 00:29:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 56a371fa-d12d-4bf3-841c-08d97fbb8b52
X-MS-TrafficTypeDiagnostic: SA2PR11MB5147:
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA2PR11MB51470E694AEC9E62F0B5104BC5A59@SA2PR11MB5147.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kxmNwFsUcGOFS5jtudgaE/NPzh3tR+LPznRdrlb0KXEbjzI2pcYbj3lr/+4k/aGBDA5bSzA5QqKuWHZkrdQUzCAhEvsG4skc4uf1TzDvrofPhru26Iut2DTp7cNhBLLRVWF1BGWurMU4DXqV2G73xQDWBhsA26I3eztGu6obyNoUzSmYjZJSG5Qi90eiB61WsJrl1HYD7S1yDRqdloO+GT8vLcn1wF1YMhFrEI9YDrtdXHxKF6kd7K93kTADj0WgWiIR2chnXr/OWrA8w7+F8mELQyj2swa9upeAa/KclflTBncSRVWUs7BlMblztrNgKJeQ6BpeCTdYRHi/rznbiQOmZ4+mS6yN9gyYGWwIY0dNXlCanYIp0fEQna9zGYHjqJY6MvuD+gRhh1dhO64LpW1DhUB/EZRuetGCV6ymZPNiYYXNZvcY60gcDZj6XXqhuL2YKZ1sJkn7lcm5H/X3tGQwzFkVev6YjmxTAr7R6wvH4RqTSbdNRylj7mjm9QOsovEnsG0GQiwQWuykSPYXSDzuZYr0tFQty75ftXlAhbkn9itLA48As0rqu9d6WIM849vIct0m7NY5xtsOQMGcEDU3XtFd23xYcXIj0jvQsuP+vmeaz9IHhxpYy2vlvc9dumRIkd+WhKDHPlEyVPCtHI2zkpI+9IPSANyjd6CxZOxcvtwIBepqH+i6rulQwCfPwXDKKnATlZlrDhXdfE6BpkZte7510od8nxjmv+1ogOwSto/fG197bfeHsynEYRzQ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB5163.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6486002)(6666004)(508600001)(66476007)(26005)(8936002)(53546011)(316002)(5660300002)(107886003)(86362001)(2906002)(36756003)(16576012)(8676002)(186003)(6862004)(956004)(6636002)(2616005)(31686004)(83380400001)(4326008)(66556008)(66946007)(37006003)(31696002)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bmFLNG5MejRjR2duMjRGTTI3ZG85MFc5VHMwYXF1L3l4ek9RTFVBWUlOSzVX?=
 =?utf-8?B?ZjNCdkYwV2xxblZ4Z3A5cmhEdnA5SEVybVYwT2QyNmtTL3RmM3BqaCtlNzl1?=
 =?utf-8?B?UW5HZ2p3bzRCNUZlK3hSYTdsRUd6NThJTHltRHl4SUthTjZkcjROSks0cndv?=
 =?utf-8?B?Sms2UDhJQVUwT25GZUVSNDJRaEhuZ1gwSDl1QUNuN29qSUFhZGpWVlNSMnF1?=
 =?utf-8?B?cjBCUUdCMjFNNUROOERzbmhRcFllL2UxTmwrKzQvakRHaXpSYWpLVTNqY3ZN?=
 =?utf-8?B?aDFnY0hDcDJFMHVucE9aVHFrY1I1eGUwN2ExUmY3ZHNGNzd3c1VYOTdsckU5?=
 =?utf-8?B?VEhaLy9WS2Zhait5aFEyemtZQWRWYmNiM0JVcUJLUFFCc0h5TGRDV3YybEk4?=
 =?utf-8?B?WEQ1Zm1nWGJxNDg5Um85SmxReElTcCtHMmNyQnppMlJOQlMySWF3NUtVVHFM?=
 =?utf-8?B?SWZDSXpIS2RZQ1l4djF3ODZrYmcya1gweUdvb1FKYzcxQVh2VEpZZ1NYUFY1?=
 =?utf-8?B?alBKN2w5K0VYTDIwU1hqSmQyQmwrUmtFQXlIZnI0QUFJdmkzM0oyd0ZVeEwx?=
 =?utf-8?B?ZmUxN3RXQzVTT0hpeWRWejk3M3JULy9aZzljSWFTUGlLRzVRazdtbHorQ0No?=
 =?utf-8?B?VHgxTjM2RjhIcEdmRjNYVWRFTDhIU0VERXJPWWR1Y25Dck5zWEZUODI4cHVy?=
 =?utf-8?B?VWkvdGRuR0ZUTTZjNW5BTE9QZmRSWFVHVCtSL3NsSjlzN0h5VDNrNTA4bzVZ?=
 =?utf-8?B?S2hEajNVUnBZNTM5b0tsWmhHM0dTR3NuWklJTm8waFdhendnQ0E0enpRNzZ3?=
 =?utf-8?B?ZFdSd09vbzF5VmlSUXltcXdmNUtaSkhCTnFBSDVxZzNrVVN4aFA1TCtWTlFt?=
 =?utf-8?B?ci9YbFBqaS9TMitKNytWQ1hNcVkvWWE3ODd0Q1Z1a3Vpc1dMQTczcXdwd3dC?=
 =?utf-8?B?SEZmMUIxcHd2R0IzN0RVcFIrMTI2eDRYbzU0N0Jvek5SdTRoVkVnc28wU2s0?=
 =?utf-8?B?WisrTGJaeHJHMTRiOFViMEFBaFVxbkhmdFhVZ0c4UVZHZFp6a0pyZHJQMlRj?=
 =?utf-8?B?dmFCZjIrQm55b0QwMzA4RW5lZXRoTC9JUFF3TVdVRFJpeFhZM0xuYzJTUytF?=
 =?utf-8?B?bVAvVTE5SkRzWEVTNzBkTDE4RzhEZU42eStucE9ja0J0RHVHdWVJUnNRcDhU?=
 =?utf-8?B?QmIyUllReFJ2c09GTVh0T1RnZS9lNEdlOTRkbDhGQUkveDRGaGluSU0xdEJ1?=
 =?utf-8?B?amhVb3VLakQ4OVNQeXRvdU9JTmZTY3JiOW94UnlDT05hWTdaOU9zSEs0TU1z?=
 =?utf-8?B?U015R0pTOFJVT1lLeU5ETTN2RUhpSnhMZ052VHAwaXl0N1ZCdnpuY01mNC82?=
 =?utf-8?B?NEhmT1lZRnFxTktOakM1SUdpdGQ2YWloUXZtTmFXbXc0VWhVbDIxMG9NYjB6?=
 =?utf-8?B?OGdYRmtSL05RLytiSm9JM1RscTNnUHJ6VkVZdmcrN1RwbjJlbGFYZXZ6ZmFH?=
 =?utf-8?B?TjhLZ2psTW9pb2Y4T0liNkpnUlBDUXRSMHB6eUNacjhQSlhYSysrTVlzMjAy?=
 =?utf-8?B?K0dTbnlvZit3MDI3cFlIbHlISi8xS0l1ZDZHb2pON3EwUVpCRTN5Y0ZkMndn?=
 =?utf-8?B?MTRud2ovem9iNVNEMFJUUG4zR2lodThYdkJsRk5BOUhuKzZJSGtVdkN5UVRW?=
 =?utf-8?B?SytYTWF2V2pTVlBXSnIzU0VxeXFLejdzd2RveCtVaHRqYlJ1djVKdXdZZkxF?=
 =?utf-8?Q?VQn/DMjQ20FiXE5Or7ORqLH2+OF7HsEGadxBQB0?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 56a371fa-d12d-4bf3-841c-08d97fbb8b52
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB5163.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2021 00:29:32.4849
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ua2JUS4VA02UhHjx8m5ZvjhVe/zIs3Sg8uTpmUWqryeI4MsIzHnJ0NvnRldMTAXLOJky+k/j0jH4dOQvO7fsJ2G2sutnGXYUX96zR0HcIfY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5147
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On 9/24/21 7:53 AM, Xu Yilun wrote:
> On Wed, Sep 22, 2021 at 05:10:56PM -0700, Russ Weight wrote:
>> Extend the FPGA Image Load framework to include a cancel IOCTL that can be
>> used to request that an image upload be canceled. The IOCTL may return
>> EBUSY if it cannot be canceled by software or ENODEV if there is no update
>> in progress.
>>
>> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
>> ---
>> v16:
>>  - This was previously patch 6/6
>>  - Amend fpga_image_load_release() to request cancellation of an ongoing
>>    update when possible.
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
>>  Documentation/fpga/fpga-image-load.rst |  6 ++++
>>  drivers/fpga/fpga-image-load.c         | 49 +++++++++++++++++++++++---
>>  include/linux/fpga/fpga-image-load.h   |  1 +
>>  include/uapi/linux/fpga-image-load.h   |  2 ++
>>  4 files changed, 53 insertions(+), 5 deletions(-)
>>
>> diff --git a/Documentation/fpga/fpga-image-load.rst b/Documentation/fpga/fpga-image-load.rst
>> index 572e18afebb9..21fa85f18680 100644
>> --- a/Documentation/fpga/fpga-image-load.rst
>> +++ b/Documentation/fpga/fpga-image-load.rst
>> @@ -40,3 +40,9 @@ FPGA_IMAGE_LOAD_STATUS:
>>  Collect status for an on-going image upload. The status returned includes
>>  how much data remains to be transferred, the progress of the image load,
>>  and error information in the case of a failure.
>> +
>> +FPGA_IMAGE_LOAD_CANCEL:
>> +
>> +Request that a on-going image upload be cancelled. This IOCTL may return
> 		an
I'll fix it
>> +EBUSY if it cannot be cancelled by software or ENODEV if there is no update
>    -EBUSY					 -ENODEV

From the userspace perspective, these are seen as positive errno numbers.
I think this is OK as is? If not, I need to change it in other places as well.
>
>> +in progress.
>> diff --git a/drivers/fpga/fpga-image-load.c b/drivers/fpga/fpga-image-load.c
>> index 2e9a5a041535..a95d18077d58 100644
>> --- a/drivers/fpga/fpga-image-load.c
>> +++ b/drivers/fpga/fpga-image-load.c
>> @@ -46,6 +46,24 @@ static void fpga_image_dev_error(struct fpga_image_load *imgld, u32 err_code)
>>  	imgld->ops->cancel(imgld);
>>  }
>>  
>> +static int fpga_image_prog_transition(struct fpga_image_load *imgld,
>> +				      u32 new_progress)
>> +{
>> +	int ret = 0;
>> +
>> +	mutex_lock(&imgld->lock);
>> +	if (imgld->request_cancel) {
>> +		imgld->err_progress = imgld->progress;
>> +		imgld->err_code = FPGA_IMAGE_ERR_CANCELED;
>> +		imgld->ops->cancel(imgld);
> We could only cancel in 2 conditions.
> This is the first one: on progress transition.
>
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
>> @@ -79,8 +97,10 @@ static void fpga_image_do_load(struct work_struct *work)
>>  		goto modput_exit;
>>  	}
>>  
>> -	fpga_image_update_progress(imgld, FPGA_IMAGE_PROG_WRITING);
>> -	while (imgld->remaining_size) {
>> +	if (fpga_image_prog_transition(imgld, FPGA_IMAGE_PROG_WRITING))
>> +		goto done;
>> +
>> +	while (imgld->remaining_size && !imgld->request_cancel) {
> This is the second condition: when we finished a block write. But if the
> low level driver accepts the whole block size, we cannot cancel in
> between.
>
> Actually the framework doesn't know when to successfully cancel an
> update. It depends on the hardware.
>
> So maybe the framework just calls cancel() immediately in IOCTL,
> let the low level driver decides if it is feasible and how to cancel.

Yes - I agree. This current implementation assumes too much about
the low-level driver. I have some ideas to try in the next patchset.

Thanks,
- Russ
>
> Thanks,
> Yilun
>
>>  		/*
>>  		 * The write_blk() op has the option to use the blk_size
>>  		 * value provided here, or to modify it to something more
>> @@ -105,7 +125,9 @@ static void fpga_image_do_load(struct work_struct *work)
>>  		cond_resched();
>>  	}
>>  
>> -	fpga_image_update_progress(imgld, FPGA_IMAGE_PROG_PROGRAMMING);
>> +	if (fpga_image_prog_transition(imgld, FPGA_IMAGE_PROG_PROGRAMMING))
>> +		goto done;
>> +
>>  	ret = imgld->ops->poll_complete(imgld);
>>  	if (ret != FPGA_IMAGE_ERR_NONE)
>>  		fpga_image_dev_error(imgld, ret);
>> @@ -178,8 +200,8 @@ static int fpga_image_load_ioctl_write(struct fpga_image_load *imgld,
>>  	imgld->remaining_size = wb.size;
>>  	imgld->err_code = FPGA_IMAGE_ERR_NONE;
>>  	imgld->progress = FPGA_IMAGE_PROG_STARTING;
>> +	imgld->request_cancel = false;
>>  	queue_work(system_unbound_wq, &imgld->work);
>> -
>>  	return 0;
>>  
>>  exit_free:
>> @@ -208,7 +230,7 @@ static long fpga_image_load_ioctl(struct file *filp, unsigned int cmd,
>>  				  unsigned long arg)
>>  {
>>  	struct fpga_image_load *imgld = filp->private_data;
>> -	int ret = -ENOTTY;
>> +	int ret = 0;
>>  
>>  	mutex_lock(&imgld->lock);
>>  
>> @@ -219,6 +241,17 @@ static long fpga_image_load_ioctl(struct file *filp, unsigned int cmd,
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
>> @@ -249,6 +282,9 @@ static int fpga_image_load_release(struct inode *inode, struct file *filp)
>>  		goto close_exit;
>>  	}
>>  
>> +	if (imgld->progress != FPGA_IMAGE_PROG_PROGRAMMING)
>> +		imgld->request_cancel = true;
>> +
>>  	mutex_unlock(&imgld->lock);
>>  	flush_work(&imgld->work);
>>  
>> @@ -363,6 +399,9 @@ void fpga_image_load_unregister(struct fpga_image_load *imgld)
>>  		goto unregister;
>>  	}
>>  
>> +	if (imgld->progress != FPGA_IMAGE_PROG_PROGRAMMING)
>> +		imgld->request_cancel = true;
>> +
>>  	mutex_unlock(&imgld->lock);
>>  	flush_work(&imgld->work);
>>  
>> diff --git a/include/linux/fpga/fpga-image-load.h b/include/linux/fpga/fpga-image-load.h
>> index 8b58365893fc..8ba39d3299d9 100644
>> --- a/include/linux/fpga/fpga-image-load.h
>> +++ b/include/linux/fpga/fpga-image-load.h
>> @@ -53,6 +53,7 @@ struct fpga_image_load {
>>  	u32 progress;
>>  	u32 err_progress;		/* progress at time of error */
>>  	u32 err_code;			/* image load error code */
>> +	bool request_cancel;
>>  	bool driver_unload;
>>  	struct eventfd_ctx *finished;
>>  	void *priv;
>> diff --git a/include/uapi/linux/fpga-image-load.h b/include/uapi/linux/fpga-image-load.h
>> index dc0c9f1d78b1..da8a7452c29a 100644
>> --- a/include/uapi/linux/fpga-image-load.h
>> +++ b/include/uapi/linux/fpga-image-load.h
>> @@ -70,4 +70,6 @@ struct fpga_image_status {
>>  
>>  #define FPGA_IMAGE_LOAD_STATUS	_IOR(FPGA_IMAGE_LOAD_MAGIC, 1, struct fpga_image_status)
>>  
>> +#define FPGA_IMAGE_LOAD_CANCEL	_IO(FPGA_IMAGE_LOAD_MAGIC, 2)
>> +
>>  #endif /* _UAPI_LINUX_FPGA_IMAGE_LOAD_H */
>> -- 
>> 2.25.1

