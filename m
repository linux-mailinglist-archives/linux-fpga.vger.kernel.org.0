Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 835634168E0
	for <lists+linux-fpga@lfdr.de>; Fri, 24 Sep 2021 02:21:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243599AbhIXAXZ (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 23 Sep 2021 20:23:25 -0400
Received: from mga01.intel.com ([192.55.52.88]:64425 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243602AbhIXAXY (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 23 Sep 2021 20:23:24 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10116"; a="246433717"
X-IronPort-AV: E=Sophos;i="5.85,318,1624345200"; 
   d="scan'208";a="246433717"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2021 17:21:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,318,1624345200"; 
   d="scan'208";a="519147201"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by orsmga001.jf.intel.com with ESMTP; 23 Sep 2021 17:21:50 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Thu, 23 Sep 2021 17:21:50 -0700
Received: from fmsmsx605.amr.corp.intel.com (10.18.126.85) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Thu, 23 Sep 2021 17:21:49 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Thu, 23 Sep 2021 17:21:49 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Thu, 23 Sep 2021 17:21:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DL+VyKZHB1q1worokPC4Y9F9S6Bk7MpsInHs+2RBb8ou9idhRaiI8p8F29VYPNEag4aPs8ZVatJNbsGosQTR3Mpx9P80CoHZKh8SHhsPPqfgLXvkRQYMDhEJQVzn2tude1Hglb/kxs5dMttnymWvTmTw1DM2vqxidcUpBhdffBN9FN60c+gFR8/gVLBZ1wRXYM9XnrKwezkdDt5MhpjuFOGkIBrA8M3Jn7L8jlPvOK3mbfQOcSKUaUN/p0vDLMx4+AhpJS+buu9HK2UQvuYLqTfj4CcHCJEjbihYslXKIkhDRp6otNjsbR/m//LoHiM2tBKR3R+13xbMFAnYtCZWaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=KSKSVeCwae3DRkJ96g8PvLiLZvFkX43Os0bNPckYLtk=;
 b=LAUQ+rhlksDz8kH85XO0CHhwmAFf/+7gc1Q7kmy2YN6OnTAdBiHGTgVHmZxLgD4kMb4qY8yweA3y5phcAAvjAAKnYG92IEnL8AQ/58tc6YUQgeoVz5WfXWaSqks5WoUqqdumlOLKsGSyIKpWpc5+BP1N9EjIH/yOZ9S9bkq3LHdFC62E8GRerfDhtbpLGd1FWsPgaVnMTbe2Lw+1EgV+baRMx51txFHttaWFLCiWZs5hy8V5fkwc5Boe0fMutdJ47CYQg67gPX5YnOh4r+RcuZ9wBFtYenDhE3gKXidcNTXMcCebhaDFG74Ogsm57BJvJt9vfTdK/YUWo81W4/La5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KSKSVeCwae3DRkJ96g8PvLiLZvFkX43Os0bNPckYLtk=;
 b=y13wdVX/Jw5R5/5EjY2E3EAClNEi+V1484iRvMUo9rd0XI3qJw+GwJdUVDCdNurcp+BzQjJZSgbrY8MyJbjia1Nrv8dHCl6sPRtjnFUZ58cuj/HzbKBRYBPwSCpevwzc1H5nEYJw35NxETLHGGMp/1RZyEPF/rSD/ok4etgdCp0=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
Received: from SA2PR11MB5163.namprd11.prod.outlook.com (2603:10b6:806:113::20)
 by SN6PR11MB2909.namprd11.prod.outlook.com (2603:10b6:805:d5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.14; Fri, 24 Sep
 2021 00:21:42 +0000
Received: from SA2PR11MB5163.namprd11.prod.outlook.com
 ([fe80::90de:46c1:4d23:5c8c]) by SA2PR11MB5163.namprd11.prod.outlook.com
 ([fe80::90de:46c1:4d23:5c8c%5]) with mapi id 15.20.4544.015; Fri, 24 Sep 2021
 00:21:42 +0000
Subject: Re: [PATCH v16 2/5] fpga: image-load: enable image uploads
To:     Xu Yilun <yilun.xu@intel.com>
CC:     <mdf@kernel.org>, <linux-fpga@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <trix@redhat.com>,
        <lgoncalv@redhat.com>, <hao.wu@intel.com>,
        <matthew.gerlach@intel.com>
References: <20210923001056.282790-1-russell.h.weight@intel.com>
 <20210923001056.282790-3-russell.h.weight@intel.com>
 <20210923085448.GA806603@yilunxu-OptiPlex-7050>
From:   Russ Weight <russell.h.weight@intel.com>
Message-ID: <ccf4433f-2239-f702-ee52-4a82035249cc@intel.com>
Date:   Thu, 23 Sep 2021 17:21:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
In-Reply-To: <20210923085448.GA806603@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: MW4PR04CA0067.namprd04.prod.outlook.com
 (2603:10b6:303:6b::12) To SA2PR11MB5163.namprd11.prod.outlook.com
 (2603:10b6:806:113::20)
MIME-Version: 1.0
Received: from [10.0.2.4] (50.43.42.212) by MW4PR04CA0067.namprd04.prod.outlook.com (2603:10b6:303:6b::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.14 via Frontend Transport; Fri, 24 Sep 2021 00:21:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cfaf9e61-d313-4758-e13d-08d97ef148b9
X-MS-TrafficTypeDiagnostic: SN6PR11MB2909:
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR11MB2909E2AE5BDCC33715C11822C5A49@SN6PR11MB2909.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qeQPvBBc9zDFRakGeTa5aZLldHFZZZyrgKGzvc8P5gXTOZpHDS/iQkiAwbQlAVnBC5dEokyfUeYFFVUDeqeSPjfsmcRQVGZ2vZezxfrODUwpWSj4DMdEPajdxIJ23G4Xy09aUOXK67mNIDDGenMAp8pa4sfguBh7pNGB8TFGYDMpgjaHmsOhxXwBnIkega90OIkIl2oxJeg75gossnAFpyNXSw7pa01PmsWgRK1MtfGPIH81qAUxrRr4i/iV6vXmorrLE6WvivSJZ27r6HwCnwv9P9BgrQPzMC1Mb9b4pSK33QLehYb3wDMNqCBhAzfw2Pb6TcoD4Sv+244cGQWz7/uFxjBMqb4VahSP4edAIOu63/6xWKfhpGQDWvpuasdfoNu/AjszntfzSFUzhPiwJiW9JBWgb38wBaxvgOF1mQB9/bZC/2bO+xjbkkhC5U3EuDOKqXksbk/gkKfOjLI1FZgX8F3q3gFbYe8OZDxMM3covZjbyVQLPqCgtMzAOGpDp/IFMh3OI98CG8j9ClB6RTwDN/j/8wC/2IhSEHOa/LEuxIqbkahf/vfSGtiS6h/zXjArotyYqDdGmpefyQMOh1J7TZIKN1q5HIr66z5CYM++LznMZW2+LFbejsiaqWoormCwpUMstmVb+0X2Zs9uPBqsaiQ2SOzqxNjjJDkZFo5eMM0S61aSGWFhOiwnFap8TuBBneQwuWxVaKUltdIaInc8COlKS+pGUbSp5cz06AQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB5163.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(37006003)(53546011)(107886003)(956004)(6666004)(186003)(66946007)(66556008)(4326008)(8676002)(31686004)(6862004)(508600001)(5660300002)(6636002)(2616005)(36756003)(66476007)(8936002)(83380400001)(30864003)(316002)(86362001)(6486002)(26005)(38100700002)(31696002)(16576012)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b1QwMEVRTnZzSVlPeGFNQU5VeXRCVGY1NWV1T3haU3kxbEU4YXptUU53aCtK?=
 =?utf-8?B?SG5ucytNdnZDS2JSc2NMQUlSVmR4VW1JWUc3UVJSaTJHclhlT3RYU0RmU0x4?=
 =?utf-8?B?bUx3RkUzN01MY3IrZUgzMWNVTDNlT0JlZjhiSkFtSFovRlJ2TnAyQkU1Z1pY?=
 =?utf-8?B?ZFd0Wm42ejNqTDZld2NwRlc3ZEoxcXBFMXlUTmg2N1NuTno4azBiUXVVaU5Y?=
 =?utf-8?B?NWN2aklTTGdIdlZKaWFheHhvc0ZEOUlUdVpOZzc0dWQ1bkVCWjZJYlNkdlR3?=
 =?utf-8?B?bS8rSlBxUXQrTGpEdGd5N1ovMDV3ZGRsZ0NBZVpESi82cVFVVG9tL1ZzUGV0?=
 =?utf-8?B?Y0ZXOWpYb0o5V3IzNnFUallXMk5ScUhVRnF1bG85ZWpRczdOODM5clpRWUdB?=
 =?utf-8?B?NEZYUk9kSTlCVDlXenBqVDVNZXpWY3JsYVRXV2JYQlVDR2tIS2tZc3VIQ3VE?=
 =?utf-8?B?bjhmL0pXTDRjdnY3QmYvNi9rTGpWeTZVY0tZTG42MnNQVVdmUHlLbzVxSXBW?=
 =?utf-8?B?eEd1ZGV1WFZaUXRtTnRhN3g1RUkvbDRvTlRaTWtqbG1WZVBtUjYwNUtmd1dl?=
 =?utf-8?B?ODNHcEk5M0JVY1FmdGkwR3R2R04yL0ZHdkdqU3NGbW9kREhZVUZUK2IrYkVm?=
 =?utf-8?B?SzZoODMvK1FtUW9sV3BZQ0xnOVp4S0VNSlpwZG5JdE05RDI2czNyMmY1N2Uv?=
 =?utf-8?B?Y2Y4NXRVMGxGVC9yM0lZWC9SaHJXOW5aL2hYVkljb2J0STIyakNOVFdLbm5v?=
 =?utf-8?B?VkJ2Ymd6bEtNLzBmVWlZLy9iVWdoTEltZVc1R3FhLy9GSlpCMzRyWlB3T25D?=
 =?utf-8?B?eTExQlg1YTJDMjRaZHJvN3A4QXdLZGY3dmM3THJpMVM4bm5KVzQwNjJNY3dh?=
 =?utf-8?B?VkxWeW9XZ0tVRWV1eGwrZHVwdjBINWpvdWxvcFgyUWtjRDdiVmdaZGxUV0NX?=
 =?utf-8?B?VGVjMWV0SWtqL0t3NXl1Ryt2YXVETFUwSmtydHBLek5RMGorUW9DenhiUGg4?=
 =?utf-8?B?eWRWVW9pMlNicHhCdWlBZFEwZ1psRHBvYlNyclNwQm9WNE43WGNMbDJnNzVT?=
 =?utf-8?B?K0h4NGhheG8zcUhHaEsxRUJxWC81NTJOODBPaFV3dFlqNGtUaWkwYUp2RXNM?=
 =?utf-8?B?V2IrM1M2R0VoNFlUdmpZeXVja1VrU3hrL3BmZUhsYnlFaVlJYk9oUDFkeDBG?=
 =?utf-8?B?a0NTK1BXenhQa21ub3d4UWw1SEhPRjA3RlkzNWt2WUVUeXM3bFRsOHFRaFBa?=
 =?utf-8?B?ODBJalhqZXh5UGZVZi9UdVY0aXo1TVNtRmZXVHNFU0pUUjJTTmp4bURpSHVq?=
 =?utf-8?B?ZzBhWlAvNE8vVk1ERWRSczNZeW4rT0xxUXl6RnlTdEpiZDZBYWRvUG91RG8x?=
 =?utf-8?B?Y09WQUMzQjFDNVZrOVhZSWFLREYrSkN1V1d6eVFhMytLY1dLdi8vMmlXQVh5?=
 =?utf-8?B?cUlNdjZOK2ZYV1ZncGdlZzhoc2JaT1BPYnNhVDZWZ2VDNGtlTzlwblI0dWEz?=
 =?utf-8?B?eEY0SU5uM1Q1U0xUMHRlL1JNNjBLUzVyV3FoeCt4VnhnNnhLSlR1Zy8yRlov?=
 =?utf-8?B?Q3NQZHpudy9iQ3ppZi9PbDNXbEVKeC85Y29VRVdTcitIZE9DaXp4SVpKcWVP?=
 =?utf-8?B?TzU4aHozR1JOOFgzU2Y1ZmwrQ3R3eUp2YTVScUZIcndnM3Z4RjZlVlRESlU5?=
 =?utf-8?B?akZDK2lsYUlKTk91cmJ4ZzhkNitxdGoybXZEZWRPeEF0alc0cG41VnBTMzFl?=
 =?utf-8?Q?d7MdOdpnHVHU8vxM3Ttwkr6WkJx1kHa28D7lQjD?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cfaf9e61-d313-4758-e13d-08d97ef148b9
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB5163.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2021 00:21:42.3767
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KR71LY+5ml3/RY/mbGDWeEZr4D4kxmBUjl0SaGqNPlxY13pavo9qN/eKKY5x6p1cTfwZcPTtWSkiouST9ehz4LqeTpRFp0SetE3stAVOVJo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2909
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On 9/23/21 1:54 AM, Xu Yilun wrote:
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
> 			   as long as?
Thanks, I'll fix it.
>
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
> I don't suggest we must have a default block size. I just prefer a more
> common API definition for this case.
>
> How about we define like this:
>
> 	u32 (*write_blk)(struct fpga_image_load *imgld, const char *buf, u32 size, u32 *written_size);
> 	 The return value indicates error type.
> 	
> 	or
>
> 	u32 (*write_blk)(struct fpga_image_load *imgld, const char *buf, u32 size);
> 	 The positive return value indicates the written size. The
> 	 negative values indicates error type.
>
> then we could call it in framework like:
>
> 	ret = imgld->ops->write_blk(imgld, imgld->data + offset, imgld->remaining_size, &written_size);
Sure - I'll drop the default size and change the interface so that the write_blk
op does not need to access imgld structure elements unnecessarily.

>
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
> I'm not quite sure about this. We only reschedule during block write but
> not in other phases. Actually they may also be time consuming, such as
> programming phase.

Yes, I've been trying to research this more. We can't really do anything
about the other phases, because they are managed completely by the parent
driver. I think it is OK to leave scheduling considerations to the parent
driver.

In our case, the parent driver does plenty of sleeps as part of the
polling handshakes with hardware, so I don't think we need to be concerned
about being friendly to the scheduler. Would you agree?

>
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
> I have little experience about the queue type, is it the best choice? I
> see there are system_unbound_wq & system_long_wq, and according to the
> workqueue.rst for system_unbound_wq use case:
>
> 	1. Wide fluctuation in the concurrency level requirement.
> 	2. Long running CPU intensive workloads.
>
> Our case may not fit in.

If we remove the cond_resched() call, then I don't think we need this
queue. It seems like the system_long_wq is probably right for our use.

- Russ

>
> Thanks,
> Yilun
>
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

