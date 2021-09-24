Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1583417D0A
	for <lists+linux-fpga@lfdr.de>; Fri, 24 Sep 2021 23:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347645AbhIXVeO (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 24 Sep 2021 17:34:14 -0400
Received: from mga09.intel.com ([134.134.136.24]:49288 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347526AbhIXVeO (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 24 Sep 2021 17:34:14 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10117"; a="224201461"
X-IronPort-AV: E=Sophos;i="5.85,321,1624345200"; 
   d="scan'208";a="224201461"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2021 14:32:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,321,1624345200"; 
   d="scan'208";a="516217074"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by fmsmga008.fm.intel.com with ESMTP; 24 Sep 2021 14:32:34 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Fri, 24 Sep 2021 14:32:34 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Fri, 24 Sep 2021 14:32:33 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Fri, 24 Sep 2021 14:32:33 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Fri, 24 Sep 2021 14:32:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kQ0VZtkAxGR2XUTuVXvJq1W9h+IOVGugjl+e0TIJIwfpr+p3b3qXW4QlMV+ZuiCJPaQrFpN6rI3lfRNJLkBZzIoHGGnlRTucNJ6fQzLk0ym+yGBRd3aEWSiIDQ7zU5JVXs8Rr952SucXoJUQgj3Ihk+kas5S4TGDOFdhBePcKygdsWttA2Cg9DRwgexE2V9P7FMmnJe73JtyZX2mCifpMlv8la1dn4WMkasg+KSG9nBtn1ZSjxskxNspTQ/bPrsm1Oy/2w11195sYgtMu7pKT6Mn1nnGLBTMW2orvGf5onI+RggYKPgqcyppNVNWf72rP7NOqaaAsJzZ8XNpDq+dng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=9sUwXO/TY/D4KEnEfMVcD64AUgPexqSU4HGTeekwaeI=;
 b=J5My5GF16ePthD1Z0eX4zj9n0mRjuDpJIje5rA5smnuASoKQpBFUOJ7crMSZqr4wiYa+TAZB9RpZQvUhhfmoLqsPptDC22ExkfSMx15le0oltr587SOwLplw8ZyPEQWxBgY1GVi8JtJeA7hFqFs5ZSMaFBSi77QvMLRqL08TMqPczZRVSqAGQpLeAnU+osRPY5SogRo5Fn96tLdsVkttuURkPKc1FHMTGNHiHeNVOHGZzwR28DR8NgpfT4otciltFWrdYrXGJr3gQRnmTGydtF7zKu5wPtoe1bELWYTu+O3nzczgeA4ZXevAQIDaZizzspWJcRDv80AegOTF9856hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9sUwXO/TY/D4KEnEfMVcD64AUgPexqSU4HGTeekwaeI=;
 b=mhYO31N4gQFr3VqMFwZcdfyztsFBtLRUtHr0rdai49RndTdSptOPGzxfoW0W9UDPwKo1Ef+wTnHeIicLtVNbkkHSrFISYVhKeeoHvWpF2nGgcsOqwD+wrcvzLiM0SHo9k8FYML6lc8oTLYfKqY2mgrVo/6Gb1DzGLjbIBK7JfS8=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
Received: from SA2PR11MB5163.namprd11.prod.outlook.com (2603:10b6:806:113::20)
 by SN6PR11MB3118.namprd11.prod.outlook.com (2603:10b6:805:dc::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Fri, 24 Sep
 2021 21:32:28 +0000
Received: from SA2PR11MB5163.namprd11.prod.outlook.com
 ([fe80::90de:46c1:4d23:5c8c]) by SA2PR11MB5163.namprd11.prod.outlook.com
 ([fe80::90de:46c1:4d23:5c8c%5]) with mapi id 15.20.4544.018; Fri, 24 Sep 2021
 21:32:28 +0000
Subject: Re: [PATCH v16 2/5] fpga: image-load: enable image uploads
To:     Xu Yilun <yilun.xu@intel.com>
CC:     <mdf@kernel.org>, <linux-fpga@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <trix@redhat.com>,
        <lgoncalv@redhat.com>, <hao.wu@intel.com>,
        <matthew.gerlach@intel.com>
References: <20210923001056.282790-1-russell.h.weight@intel.com>
 <20210923001056.282790-3-russell.h.weight@intel.com>
 <20210924081220.GB806603@yilunxu-OptiPlex-7050>
From:   Russ Weight <russell.h.weight@intel.com>
Message-ID: <6e4a8236-c0c8-d688-d3bd-4ea9cb88fa5b@intel.com>
Date:   Fri, 24 Sep 2021 14:32:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
In-Reply-To: <20210924081220.GB806603@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: MWHPR08CA0052.namprd08.prod.outlook.com
 (2603:10b6:300:c0::26) To SA2PR11MB5163.namprd11.prod.outlook.com
 (2603:10b6:806:113::20)
MIME-Version: 1.0
Received: from [10.0.2.4] (50.43.42.212) by MWHPR08CA0052.namprd08.prod.outlook.com (2603:10b6:300:c0::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend Transport; Fri, 24 Sep 2021 21:32:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cff8bc64-dd0d-461f-50a2-08d97fa2cebf
X-MS-TrafficTypeDiagnostic: SN6PR11MB3118:
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR11MB3118C0A12AFCB4AB8F448297C5A49@SN6PR11MB3118.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AmNaJn9AO+a8DQQVsRk+oNm4lJAhHLcbKgmGLvECDU2gZB0EnCeJDyHAGHPS/YDfjltpNeyno/6haFY0awoN2YEhICkKUVxu2RveHQmqSo2U0JPjNix8L8Q6TWdkcLC9/PHYZEfRQu8jMN6Wqgt7IpbTUQji639kyTBKD3Z8k7DL8Mn2KKR851zxVPR7RUBtx88FIGynvld8WyzXz1pHqgBFnot8oUs7al3C6HvepFUgvj/WQeMCd1tsSZ8NweylGDv0LoKij6TijNTe8hPFbpg7uCYeu63bN3+fFtYj58xq+0U8g2i0bj1ooH1f1+7sgIFoVxjRALIbl8NaWqwAqJQ7OB25FZxjnQtBuzP5kV0xLi5uzL++xajMxfzblv1511A54dIMW/I+FBlMZbnralWW09jObQRMk8/GU+gPC8hh3OD6nxby+4/nEv/KQoYcmRBDpqd+GnurjBRoeNr3eWvF4fDcCLSgRMkPkkJwPSiugrpSNESiiz4ZDkBbmh7QSCQUBMCQ0o+4e2GZUeErkXocIgeNXKX2EafFNTBXaEly4a1OSt1azbhndhD39qZgsfY0rc0XA61zQu3YELXrE3x7bDwHieR/fBLZe5x38iUQ0aX42/sy3IBQv4UpxDvzVXStpPNhnP/f3UuYr+9nmR8Cd92I8Rn8aKl6SKYiCiJryz/Id8PhlvI0ele93XZkYPvvn+1KzMXEVy0/KhsZYFXFrnT+vpM9GCJl2uqC+xI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB5163.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6486002)(66946007)(316002)(36756003)(16576012)(37006003)(66556008)(8936002)(53546011)(38100700002)(83380400001)(2906002)(66476007)(4326008)(26005)(31696002)(5660300002)(956004)(31686004)(6636002)(186003)(508600001)(107886003)(30864003)(8676002)(86362001)(2616005)(6862004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?emRYeHpNcE8yVXg2YXF1bmxRYm1WKzRIVXNYSSt5ejZRa3dTQ2JZOXRDTFAr?=
 =?utf-8?B?RHJ6Tm9UaCtiWGtYT3ZkTHY2TmNmTno3QXEvTHlScU1ES1dJR1FoWU9iVGRF?=
 =?utf-8?B?bE9SbmluWUNWL3hYNUYvSFNhSHJreDZmdWFBUnVwbkR0enhLMkthUTJUNVdM?=
 =?utf-8?B?U3J3YUROS2txdmduMFFHQmRUbllnN3FLM0treVA3NW5sa3I1UnlMMHZoSncy?=
 =?utf-8?B?QmpiU0FzL3dSc3RSdHdmSkl5S1RCZGNiRGttWm52dVl0SXkzeWpmSHBpb0dJ?=
 =?utf-8?B?dWZjQkczV2pxQ1AzbTJDOU8yYzJMVllHSDQ4SUZ1Ry9BWUE4Tm5sTU9QeGUr?=
 =?utf-8?B?RXhpNGdLLzFESHVmZTVpQllZQkdxS3Y1cnJ3dmhUQXM1WENHZXREYmpCK0tn?=
 =?utf-8?B?TG1FU2xXUThPdE52MjRtSHQyRXdZM3JmTGJzUEJZZUNyWmp1eW1DeFlrYmo2?=
 =?utf-8?B?MFl1b0JpWSt0MWxmd0w1UlJRSktHdUV3Y3hEMTdobGYyejY4Y0hYeXk3eUNF?=
 =?utf-8?B?L0t0QjZESzN3THE1VzVmWk9DZStEdlZrbUVnRmMwZit3ckwzTW9kRDU4S3pI?=
 =?utf-8?B?QXpBL0NReFM2RDRGUHFiZDk0RUpQNW5BUXNhYVVmYmU1LzNJUGwyaHpoTWFa?=
 =?utf-8?B?U1BNbVo5dm90S1hvS2FGYzhXWDhrMkFlUGJZTFNibU8zdk42YnJKdzJleE1J?=
 =?utf-8?B?bmlMeHRGVm4xSzRKMnYvWCszMUJRZmtmeFp1Rzd6R0NYQVdmYXhtZk13aHZ5?=
 =?utf-8?B?WWJ6d0Jtc0VQeFVLS3dMVWlrNGptcDdTNzZaY2ZjelMrNm83aU1NY3JhRTRQ?=
 =?utf-8?B?aGR4emtNL0YzcCs5aWs2OUt3OU1iZnFMVXVibVpYaXRXUHJmNjViYVNtOHFD?=
 =?utf-8?B?WGI1Zm42d1BrelpublJVOEhrNGtPTU91MTRoN1JyVlR6Q251WkhFRmE3TElW?=
 =?utf-8?B?UDFCM28rY2ZiUjZVcVMvd1J3RWdVKzZpUmNleTVIMUdVZHNYWU8zaDhJZ3Y0?=
 =?utf-8?B?cUFPMmVYQlAwS0RPWDFORC8rRnlDUytMdnlLaFluUHlJNjRlbTN1bGFPSkxk?=
 =?utf-8?B?a0ZRZnJROGtSQXc1NmxNTVcrN25JUTFLeFBveEdqQjdjVU15RHZYcDM1VFRr?=
 =?utf-8?B?M1lSa1NicFJsOHk5eGJjWUNMVHVTaHU4Mm1NcE9XcC8zeUsvNXJiUElTd1Q1?=
 =?utf-8?B?WGd3MElRMFUycSthU1hwQmxNQ3BZREU0dUdXZFFGazhzVEZ0VG8zWEpUcFVU?=
 =?utf-8?B?cmhIQUdVUlhiMWdPbFVFeUZvRFc4blE4Y2dWazl4S0crL2Z1UTBRb0swajdn?=
 =?utf-8?B?TjhtbGJueVovSnZYOWsxbm5nc21ZZlFJcnBXTHUzNVRGTVJJTmQ1QnFCdW9l?=
 =?utf-8?B?dWdIaEpHRE5US09MbnVBYkk5VndpMjV0SnVtZ2grSGU3bG8zZUJPUWNhNVpv?=
 =?utf-8?B?Z0d0ODZ2Q0VVbUR2cFBiSmxHVlRjZ1JhSWdOa3htblNBM2xZYnJuSkZZL0ti?=
 =?utf-8?B?K2s2UjdkdXVyMjdLNGlCR3Yva3BlUUlrNlM4dnY0N2VKK0NjV09oRGFSTkhl?=
 =?utf-8?B?YjJMTlJ2eVFXcUU0VmlIb2dTQWtiU3F0U2JtSGh4eGhSam1yS1NaVWhWUXNu?=
 =?utf-8?B?WFNRblhMb2VqWVB4ZnBtWXZWNEdsRlFMeU5hWnVQV013ajd1WGFoUk9vU2Nx?=
 =?utf-8?B?RlM5aWx3eENmR2VIaFVPc0dwVXhVY2dWZ3JMMENWcUk2SmdYWG1pQ0lTbmtV?=
 =?utf-8?Q?WWFYi27V/YzHyV/9J2qSD0aXF2cpaobFZxHBlqz?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cff8bc64-dd0d-461f-50a2-08d97fa2cebf
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB5163.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2021 21:32:28.2935
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fm/csMbFSevgcImwdcoz+rbvr/J05YdbhmAIjs2k4ABwYpICpPTI3+DDf+DhklcfpSXODuoiVU21QsAp9YzJYlYYf5XrNL++HK5ZTD1jHQU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3118
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On 9/24/21 1:12 AM, Xu Yilun wrote:
> On Wed, Sep 22, 2021 at 05:10:53PM -0700, Russ Weight wrote:
>> Extend the FPGA Image Load framework to include IOCTL support
>> (FPGA_IMAGE_LOAD_WRITE) for initiating an upload of an image to a device.
>> The IOCTL will return immediately, and the update will begin in the
>> context of a kernel worker thread.
>>
>> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
>> ---
>> v16:
>>  - Shift from "Driver" terminology to "Framework" in comments and
>>    documentation
>>  - Rename lops to ops for structure member and local variables
>>  - Change the write_blk() definition to pass in *blk_size (a pointer to
>>    a default block size of WRITE_BLOCK_SIZE=0x4000) and max_size (the
>>    the maximum block size to stay within the limit of the data buffer).
>>    The write_blk() op may use the default *blk_size or modify it to a
>>    more optimal number for the given device, subject to the max_size limit.
>>  - All enum values for progress and errors are changed to macros, because
>>    they are included in the uapi header. This is done to maintain consistency
>>    amongst the DFL related IOCTL header files. All references to the enum
>>    types are changed to u32.
>>  - Bail out early in fpga_image_do_load() if imgld->driver_unload is true.
>>  - Add a call to cond_resched() in the write_blk() loop to ensure that
>>    we yield to higher priority tasks during long data transfers.
>>  - Switch to the system_unbound_wq to enable calls to cond_resched().
>>  - Switch from test_and_set_bit() to atomic_cmpxchg() to manage
>>    imgld->opened.
>>  - Change fpga_image_load_release() to block until the image upload is
>>    complete.
>>  - Remove the completion object, imgld->update_done, in favor of calling
>>    flush_work(&imgld->work);
>> v15:
>>  - Compare to previous patch:
>>      [PATCH v14 2/6] fpga: sec-mgr: enable secure updates
>>  - Changed file, symbol, and config names to reflect the new driver name
>>  - Removed update/filename sysfs file and added the FPGA_IMAGE_LOAD_WRITE
>>    IOCTL for writing the image data to the FPGA card. The driver no longer
>>    uses the request_firmware framework.
>>  - Fixed some error return values in fpga_image_load_register()
>>  - Removed signed-off/reviewed-by tags
>> v14:
>>  - Added MAINTAINERS reference for
>>    Documentation/ABI/testing/sysfs-class-fpga-sec-mgr
>>  - Updated ABI documentation date and kernel version
>>  - Updated copyright to 2021
>> v13:
>>   - Change "if (count == 0 || " to "if (!count || "
>>   - Improve error message: "Attempt to register without all required ops\n"
>> v12:
>>   - Updated Date and KernelVersion fields in ABI documentation
>>   - Removed size parameter from write_blk() op - it is now up to
>>     the lower-level driver to determine the appropriate size and
>>     to update smgr->remaining_size accordingly.
>> v11:
>>   - Fixed a spelling error in a comment
>>   - Initialize smgr->err_code and smgr->progress explicitly in
>>     fpga_sec_mgr_create() instead of accepting the default 0 value.
>> v10:
>>   - Rebased to 5.12-rc2 next
>>   - Updated Date and KernelVersion in ABI documentation
>> v9:
>>   - Updated Date and KernelVersion in ABI documentation
>> v8:
>>   - No change
>> v7:
>>   - Changed Date in documentation file to December 2020
>>   - Changed filename_store() to use kmemdup_nul() instead of
>>     kstrndup() and changed the count to not assume a line-return.
>> v6:
>>   - Changed "security update" to "secure update" in commit message
>> v5:
>>   - When checking the return values for functions of type enum
>>     fpga_sec_err err_code, test for FPGA_SEC_ERR_NONE instead of 0
>> v4:
>>   - Changed from "Intel FPGA Security Manager" to FPGA Security Manager"
>>     and removed unnecessary references to "Intel".
>>   - Changed: iops -> sops, imgr -> smgr, IFPGA_ -> FPGA_, ifpga_ to fpga_
>> v3:
>>   - Removed unnecessary "goto done"
>>   - Added a comment to explain imgr->driver_unload in
>>     ifpga_sec_mgr_unregister()
>> v2:
>>   - Bumped documentation date and version
>>   - Removed explicit value assignments in enums
>>   - Other minor code cleanup per review comments
>> ---
>>  Documentation/fpga/fpga-image-load.rst |  26 ++-
>>  MAINTAINERS                            |   1 +
>>  drivers/fpga/fpga-image-load.c         | 238 ++++++++++++++++++++++++-
>>  include/linux/fpga/fpga-image-load.h   |  29 +++
>>  include/uapi/linux/fpga-image-load.h   |  54 ++++++
>>  5 files changed, 346 insertions(+), 2 deletions(-)
>>  create mode 100644 include/uapi/linux/fpga-image-load.h
>>
>> diff --git a/Documentation/fpga/fpga-image-load.rst b/Documentation/fpga/fpga-image-load.rst
>> index dda9283ef1c7..ba371c7c0ca0 100644
>> --- a/Documentation/fpga/fpga-image-load.rst
>> +++ b/Documentation/fpga/fpga-image-load.rst
>> @@ -7,4 +7,28 @@ FPGA Image Load Framework
>>  The FPGA Image Load framework provides a common API for user-space
>>  tools to manage image uploads to FPGA devices. Device drivers that
>>  instantiate the FPGA Image Load framework will interact with the
>> -target device to transfer and authenticate the image data.
>> +target device to transfer and authenticate the image data. Image uploads
>> +are processed in the context of a kernel worker thread.
>> +
>> +User API
>> +========
>> +
>> +open
>> +----
>> +
>> +An fpga_image_load device is opened exclusively to control an image upload.
>> +The device must remain open throughout the duration of the image upload.
>> +An attempt to close the device while an upload is in progress will cause
>> +the upload to be cancelled. If unable to cancel the image upload, the close
>> +system call will block until the image upload is complete.
>> +
>> +ioctl
>> +-----
>> +
>> +FPGA_IMAGE_LOAD_WRITE:
>> +
>> +Start an image upload with the provided image buffer. This IOCTL returns
>> +immediately after starting a kernel worker thread to process the image
>> +upload which could take as long a 40 minutes depending on the actual device
>> +being updated. This is an exclusive operation; an attempt to start
>> +concurrent image uploads for the same device will fail with EBUSY.
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 6e312d0ddeb6..4e44f62eef33 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -7372,6 +7372,7 @@ S:	Maintained
>>  F:	Documentation/fpga/fpga-image-load.rst
>>  F:	drivers/fpga/fpga-image-load.c
>>  F:	include/linux/fpga/fpga-image-load.h
>> +F:	include/uapi/linux/fpga-image-load.h
>>  
>>  FPU EMULATOR
>>  M:	Bill Metzenthen <billm@melbpc.org.au>
>> diff --git a/drivers/fpga/fpga-image-load.c b/drivers/fpga/fpga-image-load.c
>> index 799d18444f7c..65f553b59011 100644
>> --- a/drivers/fpga/fpga-image-load.c
>> +++ b/drivers/fpga/fpga-image-load.c
>> @@ -5,18 +5,210 @@
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
>> +#define WRITE_BLOCK_SIZE 0x4000	/* Default write-block size is 0x4000 bytes */
>> +
>> +static void fpga_image_dev_error(struct fpga_image_load *imgld, u32 err_code)
>> +{
>> +	imgld->err_code = err_code;
>> +	imgld->ops->cancel(imgld);
> Do we need the cancel here? Or cleanup is just fine.
>
> I see the description below:
>
>  * @cancel:              Required: Signal HW to cancel update
>  * @cleanup:             Optional: Complements the prepare()
>  *                       function and is called at the completion
>  *                       of the update, whether success or failure,
>  *                       if the prepare function succeeded.
>
> My understanding is when error happens, the HW is already stopped,
> and may optionally needs a cleanup to become normal again.
>
> And cancel() is like interrupting an ongoing HW progress, which could
> be called when other callback is running.
>
> We can discuss on this.
Yes - I understand what you are saying I'll experiment with it.
In this context, cancel() is being called as a cleanup step.

>> +}
>> +
>> +static void fpga_image_prog_complete(struct fpga_image_load *imgld)
>> +{
>> +	mutex_lock(&imgld->lock);
>> +	imgld->progress = FPGA_IMAGE_PROG_IDLE;
>> +	mutex_unlock(&imgld->lock);
>> +}
>> +
>> +static void fpga_image_do_load(struct work_struct *work)
>> +{
>> +	struct fpga_image_load *imgld;
>> +	u32 ret, blk_size, offset = 0;
>> +
>> +	imgld = container_of(work, struct fpga_image_load, work);
>> +
>> +	if (imgld->driver_unload) {
>> +		imgld->err_code = FPGA_IMAGE_ERR_CANCELED;
>> +		goto idle_exit;
>> +	}
>> +
>> +	get_device(&imgld->dev);
>> +	if (!try_module_get(imgld->dev.parent->driver->owner)) {
>> +		imgld->err_code = FPGA_IMAGE_ERR_BUSY;
>> +		goto putdev_exit;
>> +	}
>> +
>> +	imgld->progress = FPGA_IMAGE_PROG_PREPARING;
>> +	ret = imgld->ops->prepare(imgld);
>> +	if (ret != FPGA_IMAGE_ERR_NONE) {
>> +		fpga_image_dev_error(imgld, ret);
>> +		goto modput_exit;
>> +	}
>> +
>> +	imgld->progress = FPGA_IMAGE_PROG_WRITING;
>> +	while (imgld->remaining_size) {
>> +		/*
>> +		 * The write_blk() op has the option to use the blk_size
>> +		 * value provided here, or to modify it to something more
>> +		 * optimal for the given device.
>> +		 */
>> +		blk_size = min_t(u32, WRITE_BLOCK_SIZE, imgld->remaining_size);
>> +		ret = imgld->ops->write_blk(imgld, offset, &blk_size,
>> +					    imgld->remaining_size);
>> +		if (ret != FPGA_IMAGE_ERR_NONE) {
>> +			fpga_image_dev_error(imgld, ret);
>> +			goto done;
>> +		}
>> +
>> +		imgld->remaining_size -= blk_size;
>> +		offset += blk_size;
>> +
>> +		/*
>> +		 * The class driver does not have control of the overall
>> +		 * size or the actual implementation of the write. Allow
>> +		 * for scheduling out.
>> +		 */
>> +		cond_resched();
>> +	}
>> +
>> +	imgld->progress = FPGA_IMAGE_PROG_PROGRAMMING;
>> +	ret = imgld->ops->poll_complete(imgld);
>> +	if (ret != FPGA_IMAGE_ERR_NONE)
>> +		fpga_image_dev_error(imgld, ret);
>> +
>> +done:
>> +	if (imgld->ops->cleanup)
>> +		imgld->ops->cleanup(imgld);
>> +
>> +modput_exit:
>> +	module_put(imgld->dev.parent->driver->owner);
>> +
>> +putdev_exit:
>> +	put_device(&imgld->dev);
>> +
>> +idle_exit:
>> +	/*
>> +	 * Note: imgld->remaining_size is left unmodified here to provide
>> +	 * additional information on errors. It will be reinitialized when
>> +	 * the next image load begins.
>> +	 */
>> +	vfree(imgld->data);
>> +	imgld->data = NULL;
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
> Why we enforce the alignment? It seems to be the requirement of the
> low level driver. We may handle it there.
Sure - I can move this to the lower level driver.

Thanks,
- Russ
>
> Thanks,
> Yilun
>
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
>> +	queue_work(system_unbound_wq, &imgld->work);
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
>> +	if (atomic_cmpxchg(&imgld->opened, 0, 1))
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
>> +	mutex_lock(&imgld->lock);
>> +	if (imgld->progress == FPGA_IMAGE_PROG_IDLE) {
>> +		mutex_unlock(&imgld->lock);
>> +		goto close_exit;
>> +	}
>> +
>> +	mutex_unlock(&imgld->lock);
>> +	flush_work(&imgld->work);
>> +
>> +close_exit:
>> +	atomic_set(&imgld->opened, 0);
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
>> @@ -35,6 +227,12 @@ fpga_image_load_register(struct device *parent,
>>  	struct fpga_image_load *imgld;
>>  	int ret;
>>  
>> +	if (!ops || !ops->cancel || !ops->prepare ||
>> +	    !ops->write_blk || !ops->poll_complete) {
>> +		dev_err(parent, "Attempt to register without all required ops\n");
>> +		return ERR_PTR(-ENOMEM);
>> +	}
>> +
>>  	imgld = kzalloc(sizeof(*imgld), GFP_KERNEL);
>>  	if (!imgld)
>>  		return ERR_PTR(-ENOMEM);
>> @@ -48,9 +246,13 @@ fpga_image_load_register(struct device *parent,
>>  
>>  	imgld->priv = priv;
>>  	imgld->ops = ops;
>> +	imgld->err_code = FPGA_IMAGE_ERR_NONE;
>> +	imgld->progress = FPGA_IMAGE_PROG_IDLE;
>> +	INIT_WORK(&imgld->work, fpga_image_do_load);
>>  
>>  	imgld->dev.class = fpga_image_load_class;
>>  	imgld->dev.parent = parent;
>> +	imgld->dev.devt = MKDEV(MAJOR(fpga_image_devt), imgld->dev.id);
>>  
>>  	ret = dev_set_name(&imgld->dev, "fpga_image_load%d", imgld->dev.id);
>>  	if (ret) {
>> @@ -65,6 +267,16 @@ fpga_image_load_register(struct device *parent,
>>  		return ERR_PTR(ret);
>>  	}
>>  
>> +	cdev_init(&imgld->cdev, &fpga_image_load_fops);
>> +	imgld->cdev.owner = parent->driver->owner;
>> +	imgld->cdev.kobj.parent = &imgld->dev.kobj;
> Could be replaced by cdev_set_parent()
>
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
>> @@ -83,10 +295,23 @@ EXPORT_SYMBOL_GPL(fpga_image_load_register);
>>   * @imgld: pointer to struct fpga_image_load
>>   *
>>   * This function is intended for use in the parent driver's remove()
>> - * function.
>> + * function. The driver_unload flag prevents new updates from starting
>> + * once the unregister process has begun.
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
>> +	flush_work(&imgld->work);
>> +
>> +unregister:
>> +	cdev_del(&imgld->cdev);
>>  	device_unregister(&imgld->dev);
>>  }
>>  EXPORT_SYMBOL_GPL(fpga_image_load_unregister);
>> @@ -101,19 +326,30 @@ static void fpga_image_load_dev_release(struct device *dev)
>>  
>>  static int __init fpga_image_load_class_init(void)
>>  {
>> +	int ret;
>>  	pr_info("FPGA Image Load Framework\n");
>>  
>>  	fpga_image_load_class = class_create(THIS_MODULE, "fpga_image_load");
>>  	if (IS_ERR(fpga_image_load_class))
>>  		return PTR_ERR(fpga_image_load_class);
>>  
>> +	ret = alloc_chrdev_region(&fpga_image_devt, 0, MINORMASK,
>> +				  "fpga_image_load");
>> +	if (ret)
>> +		goto exit_destroy_class;
>> +
>>  	fpga_image_load_class->dev_release = fpga_image_load_dev_release;
>>  
>>  	return 0;
>> +
>> +exit_destroy_class:
>> +	class_destroy(fpga_image_load_class);
>> +	return ret;
>>  }
>>  
>>  static void __exit fpga_image_load_class_exit(void)
>>  {
>> +	unregister_chrdev_region(fpga_image_devt, MINORMASK);
>>  	class_destroy(fpga_image_load_class);
>>  	WARN_ON(!xa_empty(&fpga_image_load_xa));
>>  }
>> diff --git a/include/linux/fpga/fpga-image-load.h b/include/linux/fpga/fpga-image-load.h
>> index 8b051c82ef5f..41ab63cf7b20 100644
>> --- a/include/linux/fpga/fpga-image-load.h
>> +++ b/include/linux/fpga/fpga-image-load.h
>> @@ -7,22 +7,51 @@
>>  #ifndef _LINUX_FPGA_IMAGE_LOAD_H
>>  #define _LINUX_FPGA_IMAGE_LOAD_H
>>  
>> +#include <linux/cdev.h>
>>  #include <linux/device.h>
>>  #include <linux/mutex.h>
>>  #include <linux/types.h>
>> +#include <uapi/linux/fpga-image-load.h>
>>  
>>  struct fpga_image_load;
>>  
>>  /**
>>   * struct fpga_image_load_ops - device specific operations
>> + * @prepare:		    Required: Prepare secure update
>> + * @write_blk:		    Required: Write a block of data. The class driver
>> + *			    provides a default block size. The write_blk() op
>> + *			    may choose to modify *blk_size to something more
>> + *			    optimal for the given device. *blk_size must be
>> + *			    less than or equal to max_size.
>> + * @poll_complete:	    Required: Check for the completion of the
>> + *			    HW authentication/programming process.
>> + * @cancel:		    Required: Signal HW to cancel update
>> + * @cleanup:		    Optional: Complements the prepare()
>> + *			    function and is called at the completion
>> + *			    of the update, whether success or failure,
>> + *			    if the prepare function succeeded.
>>   */
>>  struct fpga_image_load_ops {
>> +	u32 (*prepare)(struct fpga_image_load *imgld);
>> +	u32 (*write_blk)(struct fpga_image_load *imgld, u32 offset,
>> +			 u32 *blk_size, u32 max_size);
>> +	u32 (*poll_complete)(struct fpga_image_load *imgld);
>> +	u32 (*cancel)(struct fpga_image_load *imgld);
>> +	void (*cleanup)(struct fpga_image_load *imgld);
>>  };
>>  
>>  struct fpga_image_load {
>>  	struct device dev;
>> +	struct cdev cdev;
>>  	const struct fpga_image_load_ops *ops;
>>  	struct mutex lock;		/* protect data structure contents */
>> +	atomic_t opened;
>> +	struct work_struct work;
>> +	const u8 *data;			/* pointer to update data */
>> +	u32 remaining_size;		/* size remaining to transfer */
>> +	u32 progress;
>> +	u32 err_code;			/* image load error code */
>> +	bool driver_unload;
>>  	void *priv;
>>  };
>>  
>> diff --git a/include/uapi/linux/fpga-image-load.h b/include/uapi/linux/fpga-image-load.h
>> new file mode 100644
>> index 000000000000..0382078c5a6c
>> --- /dev/null
>> +++ b/include/uapi/linux/fpga-image-load.h
>> @@ -0,0 +1,54 @@
>> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
>> +/*
>> + * Header File for FPGA Image Load User API
>> + *
>> + * Copyright (C) 2019-2021 Intel Corporation, Inc.
>> + *
>> + */
>> +
>> +#ifndef _UAPI_LINUX_FPGA_IMAGE_LOAD_H
>> +#define _UAPI_LINUX_FPGA_IMAGE_LOAD_H
>> +
>> +#include <linux/types.h>
>> +#include <linux/ioctl.h>
>> +
>> +#define FPGA_IMAGE_LOAD_MAGIC 0xB9
>> +
>> +/* Image load progress codes */
>> +#define FPGA_IMAGE_PROG_IDLE		0
>> +#define FPGA_IMAGE_PROG_STARTING	1
>> +#define FPGA_IMAGE_PROG_PREPARING	2
>> +#define FPGA_IMAGE_PROG_WRITING		3
>> +#define FPGA_IMAGE_PROG_PROGRAMMING	4
>> +#define FPGA_IMAGE_PROG_MAX		5
>> +
>> +/* Image error progress codes */
>> +#define FPGA_IMAGE_ERR_NONE		0
>> +#define FPGA_IMAGE_ERR_HW_ERROR		1
>> +#define FPGA_IMAGE_ERR_TIMEOUT		2
>> +#define FPGA_IMAGE_ERR_CANCELED		3
>> +#define FPGA_IMAGE_ERR_BUSY		4
>> +#define FPGA_IMAGE_ERR_INVALID_SIZE	5
>> +#define FPGA_IMAGE_ERR_RW_ERROR		6
>> +#define FPGA_IMAGE_ERR_WEAROUT		7
>> +#define FPGA_IMAGE_ERR_MAX		8
>> +
>> +/**
>> + * FPGA_IMAGE_LOAD_WRITE - _IOW(FPGA_IMAGE_LOAD_MAGIC, 0,
>> + *				struct fpga_image_write)
>> + *
>> + * Upload a data buffer to the target device. The user must provide the
>> + * data buffer and size.
>> + *
>> + * Return: 0 on success, -errno on failure.
>> + */
>> +struct fpga_image_write {
>> +	/* Input */
>> +	__u32 flags;		/* Zero for now */
>> +	__u32 size;		/* Data size (in bytes) to be written */
>> +	__u64 buf;		/* User space address of source data */
>> +};
>> +
>> +#define FPGA_IMAGE_LOAD_WRITE	_IOW(FPGA_IMAGE_LOAD_MAGIC, 0, struct fpga_image_write)
>> +
>> +#endif /* _UAPI_LINUX_FPGA_IMAGE_LOAD_H */
>> -- 
>> 2.25.1

