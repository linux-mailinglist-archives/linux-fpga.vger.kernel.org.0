Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 985A4413BA4
	for <lists+linux-fpga@lfdr.de>; Tue, 21 Sep 2021 22:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234240AbhIUUpg (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 21 Sep 2021 16:45:36 -0400
Received: from mga04.intel.com ([192.55.52.120]:56383 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235000AbhIUUpf (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 21 Sep 2021 16:45:35 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10114"; a="221574383"
X-IronPort-AV: E=Sophos;i="5.85,311,1624345200"; 
   d="scan'208";a="221574383"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2021 13:44:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,311,1624345200"; 
   d="scan'208";a="613148359"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by fmsmga001.fm.intel.com with ESMTP; 21 Sep 2021 13:44:05 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Tue, 21 Sep 2021 13:44:05 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Tue, 21 Sep 2021 13:44:04 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Tue, 21 Sep 2021 13:44:04 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Tue, 21 Sep 2021 13:44:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PUf4erKQ6C6fBxiVDN3GSUBm+MJhJZlxwN79+EL+SmE55qceTryYnEBeVFVHJZvSEMALFV0ddicVPed2awlWbQMUonbSHmGUISGVdqOc6JpEw51BLFZ2AOrDS2SuZTFJ8v/MQGl9mzkLGbUBalYQHBrXDKzlYJ3d36dJnH8yAaPDgXRBhfY1dbasUFPlj1aIWbE6RiHZ/Ez2T2HQ8WDkc+kmWlRcuEng+Ipko5xcwmsjha2CyVxdfHTqBdYfoCnkAXPvQvWTZUsmqIIlvL+RCHc1hUowpqGsliLqiMBmZun+JBtotXLeF+ocIvMWs50SR/Q3u7+65AuGMj+v7jXHAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=CTUvu2D5M8BAF8tY1KX7I6bHsUNVl2iuidw9hs9Gu64=;
 b=OaMT62QirHJnQD31oIBw2CzvePg9SfNDDY/+bHcMISndqKYw975frO2HwdmnrI51lmfwpa5qEyEGz1b7WKO5CcvMTosn9Tsg2sn9Jji15fLYT1/qmzyTsDn1qIBhJfHP6C2Eh2dBkzuDbIKdVy9QGRHIaIdLRhGTSnwUkNHB+NuNIttRay4RE5vv326TKFIPXbUizWMDP36KoyGVgf53xg+Wkwl0p2N4zettmb7bw87HB6lW4bTnpiUGSbIUXjfQ2sEVCMEoA1EOKEgJhqeROx8JT3E+BExELDaJtqriQTgkfU/Bqriqr8N5HcDfqRwgespuvpOTu0/SLs/tVV0k9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CTUvu2D5M8BAF8tY1KX7I6bHsUNVl2iuidw9hs9Gu64=;
 b=t7M0nd+2o1ItcanCXROXPQjniNmqzo7yEK74N9TqQLmsEc8oGgspTQTy4LohVFHlFifra+gcLasN4Ln4wT56jqScR58FeH/KgRpym+XLFNBW+sr9NbzCwqWZj6Nw3/fl6/pSS4azv2joWefIEQNAp1585ySn4X0fQM84VnGbx4c=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
Received: from SA2PR11MB5163.namprd11.prod.outlook.com (2603:10b6:806:113::20)
 by SN6PR11MB3039.namprd11.prod.outlook.com (2603:10b6:805:d3::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.16; Tue, 21 Sep
 2021 20:43:59 +0000
Received: from SA2PR11MB5163.namprd11.prod.outlook.com
 ([fe80::90de:46c1:4d23:5c8c]) by SA2PR11MB5163.namprd11.prod.outlook.com
 ([fe80::90de:46c1:4d23:5c8c%5]) with mapi id 15.20.4523.018; Tue, 21 Sep 2021
 20:43:59 +0000
Subject: Re: [PATCH v15 6/6] fpga: image-load: enable cancel of image upload
To:     Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>
CC:     <mdf@kernel.org>, <linux-fpga@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <lgoncalv@redhat.com>,
        <hao.wu@intel.com>, <matthew.gerlach@intel.com>
References: <20210909021846.681121-1-russell.h.weight@intel.com>
 <20210909021846.681121-7-russell.h.weight@intel.com>
 <20210910145545.GA757507@yilunxu-OptiPlex-7050>
 <839aa95e-c3d1-1f60-1b36-20d29445e61f@intel.com>
 <8351febc-2493-89c3-86ea-9e7660b6d3ee@redhat.com>
 <20210913100018.GE773070@yilunxu-OptiPlex-7050>
From:   Russ Weight <russell.h.weight@intel.com>
Message-ID: <5a1b84fa-cc32-ff21-5287-ca9a47fdb166@intel.com>
Date:   Tue, 21 Sep 2021 13:43:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
In-Reply-To: <20210913100018.GE773070@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: MW4PR04CA0095.namprd04.prod.outlook.com
 (2603:10b6:303:83::10) To SA2PR11MB5163.namprd11.prod.outlook.com
 (2603:10b6:806:113::20)
MIME-Version: 1.0
Received: from [10.0.2.4] (50.43.42.212) by MW4PR04CA0095.namprd04.prod.outlook.com (2603:10b6:303:83::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend Transport; Tue, 21 Sep 2021 20:43:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 83597e15-cd23-429a-116e-08d97d4089dd
X-MS-TrafficTypeDiagnostic: SN6PR11MB3039:
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR11MB303970B9FD9DCF5C255D4B11C5A19@SN6PR11MB3039.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z4SXGZ4DRf8jKRnW8fNTH1ipasbNQpFrgb/ih4aYlzCBy1RZRmZcev22rDSmy0nM90jUis5xGQMSz2R+pjDP8v7xMek4IbAJvA83OD63uoJEBhJUizAlOnsPx/fLmPRfn59XS3S650uUDCMuGTtXhS8g5KvYG6BnKHkaF9rsFlaQKEzrf5oZxn59x4BI2bGGSON+4XmO27rMsXghatH4/03Pa13Momuva+o8hTP7Ultc1wTcbCZ5Hr7Y4uwPVRGkZ5BsfaN6QCy3rxrQ3a6I8aEK3J/F9fwY/pxBZP7AMvNNgtF32cX34aL0xvalAmmc7CQAuaT1so++D3m3Bhs61Wt9uCOOq7urszcgdMjkr1GWluwdAddJHXexMGIKWkNCi//Wil0fOjY8UjNFSeLtQNLUwlGZDERRs+NJWPqaMyMabEu8/4zlCyCMXuKMX0iNkZpolF5J3q/p35bXSHB7GPEOZwOToyaze3LPrsaw3H9AiK6h45ZMbDuV3CgGqYJrb3sVJYhtf6OAekRwFVUi3ieJP5F+z03BxRbNdq4xzPIMr+W8bxI8e5CLY+3MMglhv4ic2lGZBlHX7Ma13L9irJ8Lv8bkd8PWuRMAj/NGUQE3ZZrDHprL5znv+V1txuNQ9LHmPFb+TtkNSj4pLOv5OIZUo8xgE2fzy6OT8SsVR0Ppoa9nmsd8rMyujYfXKWidbMzVajugxa+bHMO1zK6HxRvON9csSPSI9xRumBoK7m3j42RfYTO0B0xDDTbNndZH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB5163.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6486002)(66946007)(8676002)(316002)(66476007)(956004)(2616005)(16576012)(4326008)(38100700002)(53546011)(186003)(66556008)(86362001)(83380400001)(107886003)(36756003)(2906002)(508600001)(26005)(31696002)(110136005)(5660300002)(31686004)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dWI3THRXRnpQbi9OcFRCZzQzblAweHFidFozckxzQTJkTFBzNTdwUnQ5UEcv?=
 =?utf-8?B?Y3d2SFJNOFlKQmpERHNHT2t1ay8xMmRxQ096QkJZaUFxaUFyN2FxaGx6OHZ4?=
 =?utf-8?B?TG1QV2FzWm1UTzhKV0lWTkFTZnNQRmVvaVJQZHd0eWpZKzQ0UEZ4ZXlnQnZD?=
 =?utf-8?B?UjZZSldac1dJSGNQTVFJU1JtV1lIdE5jbGEwNTN4djU1YkdiMG0yUkhFUXI4?=
 =?utf-8?B?V0tEa2NtYVoyaXQ1L09OM1BoNFE4d1l1cUZHREFIUXlmT3BaVERNZURKcUFw?=
 =?utf-8?B?SnNyRzhwUlRkNGM3RUtGMWtmZjFtVVBaRklOSFg1WGNPNG5DbWo1UFVENEdV?=
 =?utf-8?B?T1Z2UHp3V0tSNDQxTEt5enNJd0FtYmhwZk1DNjRYeWN2dHZUUU1XU2ZoRzk5?=
 =?utf-8?B?aDFxc1R1djJKOE9McnNFSTRXZXhkYWNpaDlneDc2N3lmSkZHR0lwRENkMFhQ?=
 =?utf-8?B?dmN4MG13ZkNpcFUrZjM2bWxHWDlhemk2bVczY25rQ093VGZFdTZHVjFtZUl6?=
 =?utf-8?B?eThib2E3NmFJMFFVaGNEUGxxS0RScUw0ZUFCQUFvYStMZ1lCWllIRUxkamx2?=
 =?utf-8?B?TUZFcnpTOGl2K2FWRFlIeGVDTzg5ckhlWHRHOFNaNUcwSkllR1JPSlczVFRp?=
 =?utf-8?B?QVNaTGRINWhjMnpSb1Bobnpxa3YzSWt3U2toVWVDcmk0MkZTOHdadUt6S1lT?=
 =?utf-8?B?aG13bTUvNUR6RU1sYXloQ25qYXFCTTlOMmV1R0VCcERZdWhkQSs2VFRnWkdS?=
 =?utf-8?B?ekdUT2xhZ1VCRkdiWEg3RXdQQkh5dHF6RnhzY1ZKMi9aRC9RKzVVL3FNa29S?=
 =?utf-8?B?elJlUUg0NTVPbGZXNzBrV2g4eGl2MUdQcWRPc01GMnRWWjdFcmhYRTE1dlZJ?=
 =?utf-8?B?YnlaaU9UaFR6a3BOb3VHVzcyelRGeFhMQ0NkMktsNWlUaFcwTXFOY0x5MlhV?=
 =?utf-8?B?aUUvRytqUitMbnhMZXg4TlYxdFNMeWxiYWNpN3gvYkcySEd0VmRtbzd6aGNk?=
 =?utf-8?B?VURYemRQaFZENFFpekh3ekRFZ2VjdFVZM0w4U2p1cGpFQUkza3pRSWN4bnAy?=
 =?utf-8?B?bmFlMmlnS3QxZDJ1WmlINmliOGx2eUFpbDFadHh3MGVIcGtLY05BQ09ocy9n?=
 =?utf-8?B?MGlKbDh4cnliKzgza3lxQ2Vpc043cjBaR0RXN2Q1Qm5vdmV2NjBGTHZKdFFL?=
 =?utf-8?B?RzJvZFkwVmJmVm9DaVFVS0xUU2pNMGRMeGNwQXkyZmZYYkI3Z3dUZk1YR21h?=
 =?utf-8?B?RUR6L2oyME9sektVdlkyam1GYUJ1QWoxRjAzRXdQZnV4YUNnL2s5dFJDWWVz?=
 =?utf-8?B?ams2SGEzcFlHdGZKL1RJaThaWFplOGtZVlBYRkZOWGJCZmk5L2lHd0IrQ2gz?=
 =?utf-8?B?dlFld1FuSTI5c1R2b0VMME1vcW0zZVZ2SjVyUzdtbmxQODhnNWNuMktZYWhr?=
 =?utf-8?B?TzJ0Y0lyZndMdE5rWll2MURLVytycUNKQTBFaHlodWhYU202UitEem5Sd1FH?=
 =?utf-8?B?V2ZWaHdScGxBUlc0WERhUzlTejV5cHNPQlBUdm9tbWp0NlNCMzIxeTBlTHJy?=
 =?utf-8?B?QWlTZTgyS1FLN0d0a1lockF1U3kxSW5OblJUOWdHOEFTMW9UNmdqeGN3a2pk?=
 =?utf-8?B?ZlllZENNZENMejBvdGY2UkU5QWJNV3hJdy9SZHA4RUNha2tzdGI1bGtlMjV2?=
 =?utf-8?B?anR4UStaN25mR2ltclVHRFpWdXZjVWFhYnBLUko5VEh1Z1VTVU1EU0VZTFJO?=
 =?utf-8?Q?VxmxSG3ubokqcs7zbw2tOJz9/QL1MN1IVroOg89?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 83597e15-cd23-429a-116e-08d97d4089dd
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB5163.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2021 20:43:59.6062
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jG145hcOayOkhXRt/t/IFdIrTqyam9tT5BjkB4cfcLMLI2o4xwZQpL18O1cydI9Vv98kOUd/sf/PvRzQdccxo0+jyLXYLvrh09u/pD6aTqE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3039
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On 9/13/21 3:00 AM, Xu Yilun wrote:
> On Sat, Sep 11, 2021 at 06:13:08AM -0700, Tom Rix wrote:
>> On 9/10/21 4:38 PM, Russ Weight wrote:
>>> On 9/10/21 7:55 AM, Xu Yilun wrote:
>>>> On Wed, Sep 08, 2021 at 07:18:46PM -0700, Russ Weight wrote:
>>>>> Extend the FPGA Image Load class driver to include a cancel IOCTL that
>>>>> can be used to request that an image upload be canceled. The IOCTL may
>>>>> return EBUSY if it cannot be canceled by software or ENODEV if there
>>>>> is no update in progress.
>>>>>
>>>>> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
>>>>> ---
>>>>> v15:
>>>>>   - Compare to previous patch:
>>>>>       [PATCH v14 6/6] fpga: sec-mgr: enable cancel of secure update
>>>>>   - Changed file, symbol, and config names to reflect the new driver name
>>>>>   - Cancel is now initiated by IOCT instead of sysfs
>>>>>   - Removed signed-off/reviewed-by tags
>>>>> v14:
>>>>>   - Updated ABI documentation date and kernel version
>>>>> v13:
>>>>>    - No change
>>>>> v12:
>>>>>    - Updated Date and KernelVersion fields in ABI documentation
>>>>> v11:
>>>>>    - No change
>>>>> v10:
>>>>>    - Rebased to 5.12-rc2 next
>>>>>    - Updated Date and KernelVersion in ABI documentation
>>>>> v9:
>>>>>    - Updated Date and KernelVersion in ABI documentation
>>>>> v8:
>>>>>    - No change
>>>>> v7:
>>>>>    - Changed Date in documentation file to December 2020
>>>>> v6:
>>>>>    - No change
>>>>> v5:
>>>>>    - No change
>>>>> v4:
>>>>>    - Changed from "Intel FPGA Security Manager" to FPGA Security Manager"
>>>>>      and removed unnecessary references to "Intel".
>>>>>    - Changed: iops -> sops, imgr -> smgr, IFPGA_ -> FPGA_, ifpga_ to fpga_
>>>>> v3:
>>>>>    - No change
>>>>> v2:
>>>>>    - Bumped documentation date and version
>>>>>    - Minor code cleanup per review comments
>>>>> ---
>>>>> ---
>>>>>   Documentation/fpga/fpga-image-load.rst |  6 ++++
>>>>>   drivers/fpga/fpga-image-load.c         | 45 +++++++++++++++++++++++---
>>>>>   include/linux/fpga/fpga-image-load.h   |  1 +
>>>>>   include/uapi/linux/fpga-image-load.h   |  1 +
>>>>>   4 files changed, 49 insertions(+), 4 deletions(-)
>>>>>
>>>>> diff --git a/Documentation/fpga/fpga-image-load.rst b/Documentation/fpga/fpga-image-load.rst
>>>>> index 3d5eb51223e3..763e7833a6ea 100644
>>>>> --- a/Documentation/fpga/fpga-image-load.rst
>>>>> +++ b/Documentation/fpga/fpga-image-load.rst
>>>>> @@ -37,3 +37,9 @@ FPGA_IMAGE_LOAD_STATUS:
>>>>>   Collect status for an on-going image upload. The status returned includes
>>>>>   how much data remains to be transferred, the progress of the image load,
>>>>>   and error information in the case of a failure.
>>>>> +
>>>>> +FPGA_IMAGE_LOAD_CANCEL:
>>>>> +
>>>>> +Request that a on-going image upload be cancelled. This IOCTL may return
>>>>> +EBUSY if it cannot be cancelled by software or ENODEV if there is no update
>>>>> +in progress.
>>>>> diff --git a/drivers/fpga/fpga-image-load.c b/drivers/fpga/fpga-image-load.c
>>>>> index 6ec0a39f07b3..c32e4b1ea35a 100644
>>>>> --- a/drivers/fpga/fpga-image-load.c
>>>>> +++ b/drivers/fpga/fpga-image-load.c
>>>>> @@ -46,6 +46,24 @@ static void fpga_image_dev_error(struct fpga_image_load *imgld,
>>>>>   	imgld->lops->cancel(imgld);
>>>>>   }
>>>>> +static int fpga_image_prog_transition(struct fpga_image_load *imgld,
>>>>> +				      enum fpga_image_prog new_progress)
>>>>> +{
>>>>> +	int ret = 0;
>>>>> +
>>>>> +	mutex_lock(&imgld->lock);
>>>>> +	if (imgld->request_cancel) {
>>>>> +		imgld->err_progress = imgld->progress;
>>>>> +		imgld->err_code = FPGA_IMAGE_ERR_CANCELED;
>>>>> +		imgld->lops->cancel(imgld);
>>>>> +		ret = -ECANCELED;
>>>>> +	} else {
>>>>> +		imgld->progress = new_progress;
>>>>> +	}
>>>>> +	mutex_unlock(&imgld->lock);
>>>>> +	return ret;
>>>>> +}
>>>>> +
>>>>>   static void fpga_image_prog_complete(struct fpga_image_load *imgld)
>>>>>   {
>>>>>   	mutex_lock(&imgld->lock);
>>>>> @@ -77,8 +95,10 @@ static void fpga_image_do_load(struct work_struct *work)
>>>>>   		goto modput_exit;
>>>>>   	}
>>>>> -	fpga_image_update_progress(imgld, FPGA_IMAGE_PROG_WRITING);
>>>>> -	while (imgld->remaining_size) {
>>>>> +	if (fpga_image_prog_transition(imgld, FPGA_IMAGE_PROG_WRITING))
>>>>> +		goto done;
>>>>> +
>>>>> +	while (imgld->remaining_size && !imgld->request_cancel) {
>>>>>   		ret = imgld->lops->write_blk(imgld, offset);
>>>>>   		if (ret != FPGA_IMAGE_ERR_NONE) {
>>>>>   			fpga_image_dev_error(imgld, ret);
>>>>> @@ -88,7 +108,9 @@ static void fpga_image_do_load(struct work_struct *work)
>>>>>   		offset = size - imgld->remaining_size;
>>>>>   	}
>>>>> -	fpga_image_update_progress(imgld, FPGA_IMAGE_PROG_PROGRAMMING);
>>>>> +	if (fpga_image_prog_transition(imgld, FPGA_IMAGE_PROG_PROGRAMMING))
>>>>> +		goto done;
>>>>> +
>>>>>   	ret = imgld->lops->poll_complete(imgld);
>>>>>   	if (ret != FPGA_IMAGE_ERR_NONE)
>>>>>   		fpga_image_dev_error(imgld, ret);
>>>>> @@ -159,6 +181,7 @@ static int fpga_image_load_ioctl_write(struct fpga_image_load *imgld,
>>>>>   	imgld->remaining_size = wb.size;
>>>>>   	imgld->err_code = FPGA_IMAGE_ERR_NONE;
>>>>>   	imgld->progress = FPGA_IMAGE_PROG_STARTING;
>>>>> +	imgld->request_cancel = false;
>>>>>   	reinit_completion(&imgld->update_done);
>>>>>   	schedule_work(&imgld->work);
>>>>>   	return 0;
>>>>> @@ -189,7 +212,7 @@ static long fpga_image_load_ioctl(struct file *filp, unsigned int cmd,
>>>>>   				  unsigned long arg)
>>>>>   {
>>>>>   	struct fpga_image_load *imgld = filp->private_data;
>>>>> -	int ret = -ENOTTY;
>>>>> +	int ret = 0;
>>>>>   	mutex_lock(&imgld->lock);
>>>>> @@ -200,6 +223,17 @@ static long fpga_image_load_ioctl(struct file *filp, unsigned int cmd,
>>>>>   	case FPGA_IMAGE_LOAD_STATUS:
>>>>>   		ret = fpga_image_load_ioctl_status(imgld, arg);
>>>>>   		break;
>>>>> +	case FPGA_IMAGE_LOAD_CANCEL:
>>>>> +		if (imgld->progress == FPGA_IMAGE_PROG_PROGRAMMING)
>>>>> +			ret = -EBUSY;
>>>>> +		else if (imgld->progress == FPGA_IMAGE_PROG_IDLE)
>>>>> +			ret = -ENODEV;
>>>>> +		else
>>>>> +			imgld->request_cancel = true;
>>>>> +		break;
>>>>> +	default:
>>>>> +		ret = -ENOTTY;
>>>>> +		break;
>>>>>   	}
>>>>>   	mutex_unlock(&imgld->lock);
>>>>> @@ -374,6 +408,9 @@ void fpga_image_load_unregister(struct fpga_image_load *imgld)
>>>>>   		goto unregister;
>>>>>   	}
>>>>> +	if (imgld->progress != FPGA_IMAGE_PROG_PROGRAMMING)
>>>>> +		imgld->request_cancel = true;
>>>>> +
>>>> Why we cancel the programing rather than waiting for programing done?
>>> This isn't new - it is the way the security manager was implemented.
>>>
>>> Updates can take up to 40 minutes for the N3000. If a person tries
>>> to unload the driver modules, should we hang for 40 minutes? Or should
>>> we try to cancel the update and allow the module to be unloaded?
>>> I think it is reasonable to cancel the update (if possible) under these
>>> circumstances. What do you think?
>> I do not think stalling a shutdown for 40 minutes is good.
>>
>> Is there a chance that cancelling would brick the card?
> If the cancel cannot be possible, may be we could wait. Or the user
> image would be corrupted with a simple poweroff command.

OK - I'm leaving the above code in for cancelling. The check for
FPGA_IMAGE_PROG_PROGRAMMING ensures that it can be safely canceled.
Once programming begins, then we will block until it is complete.
I'm still using the driver-unload flag to prevent new uploads from
starting, but driver_unload will no longer be used to force an exit
from the lower-level driver.

The maximum wait for programming is less than 40 minutes - probably
more like 20 minutes?

- Russ

>
> Thanks,
> Yilun
>
>> After restarting, can the hw detect an interrupted update ?
>>
>> Tom
>>
>>> - Russ
>>>
>>>> Thanks,
>>>> Yilun
>>>>
>>>>>   	mutex_unlock(&imgld->lock);
>>>>>   	wait_for_completion(&imgld->update_done);
>>>>> diff --git a/include/linux/fpga/fpga-image-load.h b/include/linux/fpga/fpga-image-load.h
>>>>> index 68f3105b51d2..4e51b9fd1724 100644
>>>>> --- a/include/linux/fpga/fpga-image-load.h
>>>>> +++ b/include/linux/fpga/fpga-image-load.h
>>>>> @@ -52,6 +52,7 @@ struct fpga_image_load {
>>>>>   	enum fpga_image_prog progress;
>>>>>   	enum fpga_image_prog err_progress;	/* progress at time of failure */
>>>>>   	enum fpga_image_err err_code;		/* image load error code */
>>>>> +	bool request_cancel;
>>>>>   	bool driver_unload;
>>>>>   	struct eventfd_ctx *finished;
>>>>>   	void *priv;
>>>>> diff --git a/include/uapi/linux/fpga-image-load.h b/include/uapi/linux/fpga-image-load.h
>>>>> index 6a995bcc0fb7..8d0dfa1f9b77 100644
>>>>> --- a/include/uapi/linux/fpga-image-load.h
>>>>> +++ b/include/uapi/linux/fpga-image-load.h
>>>>> @@ -39,6 +39,7 @@ enum fpga_image_err {
>>>>>   #define FPGA_IMAGE_LOAD_WRITE	_IOW(FPGA_IMAGE_LOAD_MAGIC, 0, struct fpga_image_write)
>>>>>   #define FPGA_IMAGE_LOAD_STATUS	_IOR(FPGA_IMAGE_LOAD_MAGIC, 1, struct fpga_image_status)
>>>>> +#define FPGA_IMAGE_LOAD_CANCEL	_IO(FPGA_IMAGE_LOAD_MAGIC, 2)
>>>>>   /**
>>>>>    * FPGA_IMAGE_LOAD_WRITE - _IOW(FPGA_IMAGE_LOAD_MAGIC, 0,
>>>>> -- 
>>>>> 2.25.1

