Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3424A413A86
	for <lists+linux-fpga@lfdr.de>; Tue, 21 Sep 2021 21:08:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233954AbhIUTKI (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 21 Sep 2021 15:10:08 -0400
Received: from mga06.intel.com ([134.134.136.31]:49706 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231325AbhIUTKI (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 21 Sep 2021 15:10:08 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10114"; a="284460485"
X-IronPort-AV: E=Sophos;i="5.85,311,1624345200"; 
   d="scan'208";a="284460485"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2021 12:08:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,311,1624345200"; 
   d="scan'208";a="701800627"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by fmsmga006.fm.intel.com with ESMTP; 21 Sep 2021 12:08:38 -0700
Received: from fmsmsx605.amr.corp.intel.com (10.18.126.85) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Tue, 21 Sep 2021 12:08:35 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Tue, 21 Sep 2021 12:08:35 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.104)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Tue, 21 Sep 2021 12:08:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m/uwJQ7KE8yiZVmvD3Ei4aaBIy1ih8K6HA2TrUekpac+4Yke8PM973uRj9fRjlIr5AO7gce2zgQgbuLQ89DgGs0B/iMHfS1Cj/hnIW5jsOxSN0uR2czq7JAjv8gtaQYxd9Ll3ZYR4xhGVrH1fMk3LgIeRVQP6N8qtKuP1ncf//t7wY9Ozf+5n70LSu6SjGHzXpr4vj5G/6hEfpmj0pczEJHfMppjVqnwv0D48A8RVJVp5rERw4nPZQfgHDe0Uz7w3jg/bfsIhSRhNpxpOkWzd33qL09oCF3JiR4sUig8mBkQyhqx+AQdgohyjWWYTULTxnYsMWdkx60iQY+oplxV2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=BB1LVGCStLPDhB+tQET4dp5D3AuhGm90v20G1EvgCQE=;
 b=OYZzW9uv4Sch+pQ37XaEU6hLI/TZCpf3RE3b1OoDvdUlc28MV1sXbqeP0CTW+K8HCJujgL0aJSY9VGEQQ5I+AABO9KEZkgjvpTJeNqS4BDrDk9Jix8dposvcWkdfAV3w7TrGweS/HONgj0g2MKtBlpd6rQVCeWtPUgNWb/xAFgTS/1JEEf6Bbj7uP5BuEi2SMEwg+xfaplCG8no+Y2rf79SrOWPk+SsKIVkWmimnRFCoqn1a9Tx7h2pcHAcaRncIvAQy08iIwX305WsD3y2vCD2gB10KyTqKU6ggfyYJTdbJPbRMITFQD69An8O6hOSImPrURkPwlwZzIaRPMq1x7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BB1LVGCStLPDhB+tQET4dp5D3AuhGm90v20G1EvgCQE=;
 b=qCDpn7yPHalWsDmHnebiD2Sb7yyJhzbaN1H4UadzPrtbjmGv2OVy3IrPsuBth7yMuETOuZiN1CXNIA7Isdnqrds2PJvsgPvlcBzO815UEBre3rrSZhjDfUpQfCyiuyCQ4lWoZk06CWkLuwTo0OlhpcyI7ntPGoY4eXwGwAf2rAw=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
Received: from SA2PR11MB5163.namprd11.prod.outlook.com (2603:10b6:806:113::20)
 by SN6PR11MB3405.namprd11.prod.outlook.com (2603:10b6:805:c0::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.16; Tue, 21 Sep
 2021 19:08:12 +0000
Received: from SA2PR11MB5163.namprd11.prod.outlook.com
 ([fe80::90de:46c1:4d23:5c8c]) by SA2PR11MB5163.namprd11.prod.outlook.com
 ([fe80::90de:46c1:4d23:5c8c%5]) with mapi id 15.20.4523.018; Tue, 21 Sep 2021
 19:08:12 +0000
Subject: Re: [PATCH v15 2/6] fpga: image-load: enable image loads
To:     Xu Yilun <yilun.xu@intel.com>
CC:     <mdf@kernel.org>, <linux-fpga@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <trix@redhat.com>,
        <lgoncalv@redhat.com>, <hao.wu@intel.com>,
        <matthew.gerlach@intel.com>
References: <20210909021846.681121-1-russell.h.weight@intel.com>
 <20210909021846.681121-3-russell.h.weight@intel.com>
 <20210910082232.GB754505@yilunxu-OptiPlex-7050>
 <7945b45b-2728-2612-dc28-a848be8207ec@intel.com>
 <20210913064845.GF754505@yilunxu-OptiPlex-7050>
 <20210913093632.GC773070@yilunxu-OptiPlex-7050>
From:   Russ Weight <russell.h.weight@intel.com>
Message-ID: <480ec641-5594-e628-1ce3-8a614bc1821c@intel.com>
Date:   Tue, 21 Sep 2021 12:08:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
In-Reply-To: <20210913093632.GC773070@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: MW4P220CA0020.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::25) To SA2PR11MB5163.namprd11.prod.outlook.com
 (2603:10b6:806:113::20)
MIME-Version: 1.0
Received: from [10.0.2.4] (50.43.42.212) by MW4P220CA0020.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend Transport; Tue, 21 Sep 2021 19:08:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 49d82084-ec3e-47d7-d5c9-08d97d332818
X-MS-TrafficTypeDiagnostic: SN6PR11MB3405:
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR11MB34057CD8504160F20F3D7301C5A19@SN6PR11MB3405.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xFMF9zHqyVz3cQ+M3Z5WD4EA6Ph91y/sDGgQgzSG4sj+TvDjFThbV2wj9IzvmnYND9hdKeZEr28vy9Y0c10VgJGW7D6vHEqNHZjMoQTE+1nERkvoA4MTyWQd1sXEIrwdQ+6JeiJZ46HemvHGRt1yz5GSmOCks4g1ZYL0i8/GTGS4M6pYnCmXlI/TtAWbdhRPejMWBnWMuCCy/BhL7x+fglQw5uLUeUT2ATMAv8/REbSiP1mYWVBPdVDITjzWhEu6Y/Xck1DfrYCsAoGLiAWQwnXYusWeJ9wIASX6DZuKHz8uT2xJyqZA/BKbhU5yqV1nq74kWT0ylKQEjVEHix4DajiXgb6ZyBAkoWAKVSe4oW8XpxXWTn0UEQ3ihI2Rz/i3zw9xmd9J2VGuYGox4g8T0ySIXufLK219OWn5XfR9gx/5fFo4NKr20hLOeEQxBsF3DfseAlK61ZNCCz2cy668/7+Nx8V2SxqMNM2pvU2VZ0C4zsEUmFdL2oqR0QMKCMqWPRTHBkj85oTjFqbz0DX45n0FfxboTJNAwtqqgpj6YjxOUVEyQzzc4aiEGv8XYPfsjUBftT0WOelpWFNZuYCtZbBvOxWoVkI1KWIcqcGI0o6nnoicUYY7NIlBoiHWW19wtSml8wd8uij4bDsIDe0ugKap22QeOlL1VVO1T3wzoZwtWKRTwjc/hExlXBaMN3vx4OzmewCyUPYpi4zUUFxQLUfO9jZo1x7FEIFlbI6WmtuHLdp59GAcGi3EhQYXbXGU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB5163.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(508600001)(37006003)(316002)(16576012)(83380400001)(38100700002)(107886003)(66946007)(186003)(2906002)(53546011)(66476007)(86362001)(5660300002)(26005)(6862004)(2616005)(956004)(4326008)(6486002)(6636002)(8936002)(36756003)(8676002)(31686004)(66556008)(31696002)(30864003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MEY5V1R0UTF6MFJiN3Nsb0ozWUl4RFFZMjZHSnNKajA2U0tWVWRsNmlsSW9q?=
 =?utf-8?B?VzlLVkt4c2lob1cvdTVodFJLTnY1VFpPVlVuM1NOOEZhK0FJN25qSlN4SHA3?=
 =?utf-8?B?NnNCZk9NZ25MeHVuMTdINGtBd0szTlU5aUdJRyttd1phTDV3aFJ5TFByQkRy?=
 =?utf-8?B?a1VPeFlTejV4SkcyNEh1ZmRaaUxKUU9tWmJrM3BpKzVrcDBnaXNGREZrN0U4?=
 =?utf-8?B?YnVsZE9FUmpaanRVWFFoVCt1RDVKMDRvbitxb1djeU82YmxSbXZwdTRaZ0RS?=
 =?utf-8?B?YlpEcUVWbXFUU1pTRzRmMzlSSWRBYlRGZ3dDeVhXdGlLTHVnNDlIbFpSUkdQ?=
 =?utf-8?B?cFNEODRacnlOYVZtU3JVbm9NcFFISHFhREtXLzRrWXI5ZnN3WlhmMFVnb1Fw?=
 =?utf-8?B?VCs2Q2ZDbHJnVUxEblhkN1dOQ3MrYVpkSUVaRjVmYnpHcFBwU1k0dkw4cUh3?=
 =?utf-8?B?eldodGdOM1haVndldW8zMHluMXdSeXl6UEpDR1JaKzlLL2h6QnowRDJUdWxK?=
 =?utf-8?B?QXNnWE5XLytKZGhnL2pLNnhOMVJsTzY2aVR6WXZiSTlHTmZIMU5rRmJtYmZt?=
 =?utf-8?B?VHluOXlZeXpjRGRzdkt4akdZOEVxOStIam9EeGdCSy8yeWgvNWlpNW94WEhK?=
 =?utf-8?B?eFNlVys2YWFuS0FxRzQ3QnhzVkpCUnRHK3FvU0FyUGVLejJYUUJ1YURSQjVE?=
 =?utf-8?B?cEJUM0g4cWtGMFc0bk93eUxKNStwdlQxUlE0RTBRQVpqbnNxb1VxTjJoMnBs?=
 =?utf-8?B?cVdSNTZNbjFkeFRSRktpNm9lQ1hCTzhRSVVSN2tOK2Z4djY2NWF4Z2gzREU0?=
 =?utf-8?B?aVhYZjJEcVc3NHFYZVB1d1UzdUFENW90WUxaQXQ5eEYzVEZyS09nU0l1cGds?=
 =?utf-8?B?OXlVVnVpNDdwMkZjMHFGNkpYOTVwYzhwcG5SaXhGNlhHS0szNUtTa1R5Tldu?=
 =?utf-8?B?WXU4UWtkcmVSL1FqeEcydGE0Y0xDcmhRcXEvR1duczJWbUdwS2Q4R2k5bUlp?=
 =?utf-8?B?MmNoZGFTR1lhSDh5WkoyREJmV1hab0ZXVWtPeER4SG85blM5bWFvWk9iMXBy?=
 =?utf-8?B?QkhVZ2xSRGY3T2R4MXBrSU9qUVFad2JCV2xTSWgzcCs0bFpQZFk4NTJVUGp5?=
 =?utf-8?B?MXZWTXZ2M3M2V2xReXh4NXlBTTlkOFJVMld5cDl1S3hoWmoxNFR4ZlUrNE52?=
 =?utf-8?B?eSt4UEpJb3k3Y1FhbW8zZXFsaCtGby9KSGtjeEJLa1BmQ00rejFvMkl2VUY5?=
 =?utf-8?B?Y0U1ZWo3b3I1WTcrTGJvTFZCYnRQaUxJckM1Zm9iMzhrcUdic2c1V2JGMm5l?=
 =?utf-8?B?dmg4a2xoVGViTnV0VHQ3SnUwbktDcUNZMGpEM2VlMWI0d09mdFRZSUJoOUJw?=
 =?utf-8?B?dXl6UTNXQUdic25YKzVaY2owUVVjdlY4Nk40TmtPeDlPOTkxeGc3OUhZckpU?=
 =?utf-8?B?czVjQXZJMHp4Z0J2QTdONjNnNWpVWHhyNlYwR3d2QW1uTzlUbmRRMFdXUWo0?=
 =?utf-8?B?WDQwckFLSFg5bk9vODM0N1JKbFNPQ08rZDRJMEtoRGRSUG1vUEk4UmtmZnBp?=
 =?utf-8?B?dW5ZMkw5QVQ3Vkg2VUpib1FMS25ydTBsaDloMk9menJGOGRuS1ZJQ3NSQVN6?=
 =?utf-8?B?UVBwaGtEUVY1Z3hEOWpjcVY3cGRRd0Zrbnp3UDdQT2NIT2JlMmQrTGM4eCtp?=
 =?utf-8?B?MnMrMFN6V1k2VDdWYm1yVFk0Ylk1YVN3R2RrTzdVWWxES1NWMXUrMmorLzkw?=
 =?utf-8?Q?urKRwkII9/GmuBtgYaYF6U77uOr0rIQ06Zl6Yqo?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 49d82084-ec3e-47d7-d5c9-08d97d332818
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB5163.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2021 19:08:12.1127
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vtGdjhz1Q9YXo5N75YD7BGypt6MvHPXO0CkP3k30CDitg4hq2f8ZsfyPowinKkXvgCjR2a+JX9IQzMJNTDgPTIfBzAvHd9BE2HoAwqBwsck=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3405
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On 9/13/21 2:36 AM, Xu Yilun wrote:
> On Mon, Sep 13, 2021 at 02:48:45PM +0800, Xu Yilun wrote:
>> On Fri, Sep 10, 2021 at 04:18:26PM -0700, Russ Weight wrote:
>>>
>>> On 9/10/21 1:22 AM, Xu Yilun wrote:
>>>> On Wed, Sep 08, 2021 at 07:18:42PM -0700, Russ Weight wrote:
>>>>> Extend the FPGA Image Load class driver to include IOCTL support
>>>>> (FPGA_IMAGE_LOAD_WRITE) for initiating an upload of an image to a device.
>>>>> The IOCTL will return immediately, and the update will begin in the
>>>>> context of a kernel worker thread.
>>>>>
>>>>> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
>>>>> ---
>>>>> v15:
>>>>>  - Compare to previous patch:
>>>>>      [PATCH v14 2/6] fpga: sec-mgr: enable secure updates
>>>>>  - Changed file, symbol, and config names to reflect the new driver name
>>>>>  - Removed update/filename sysfs file and added the FPGA_IMAGE_LOAD_WRITE
>>>>>    IOCTL for writing the image data to the FPGA card. The driver no longer
>>>>>    uses the request_firmware framework.
>>>>>  - Fixed some error return values in fpga_image_load_register()
>>>>>  - Removed signed-off/reviewed-by tags
>>>>> v14:
>>>>>  - Added MAINTAINERS reference for
>>>>>    Documentation/ABI/testing/sysfs-class-fpga-sec-mgr
>>>>>  - Updated ABI documentation date and kernel version
>>>>>  - Updated copyright to 2021
>>>>> v13:
>>>>>   - Change "if (count == 0 || " to "if (!count || "
>>>>>   - Improve error message: "Attempt to register without all required ops\n"
>>>>> v12:
>>>>>   - Updated Date and KernelVersion fields in ABI documentation
>>>>>   - Removed size parameter from write_blk() op - it is now up to
>>>>>     the lower-level driver to determine the appropriate size and
>>>>>     to update smgr->remaining_size accordingly.
>>>>> v11:
>>>>>   - Fixed a spelling error in a comment
>>>>>   - Initialize smgr->err_code and smgr->progress explicitly in
>>>>>     fpga_sec_mgr_create() instead of accepting the default 0 value.
>>>>> v10:
>>>>>   - Rebased to 5.12-rc2 next
>>>>>   - Updated Date and KernelVersion in ABI documentation
>>>>> v9:
>>>>>   - Updated Date and KernelVersion in ABI documentation
>>>>> v8:
>>>>>   - No change
>>>>> v7:
>>>>>   - Changed Date in documentation file to December 2020
>>>>>   - Changed filename_store() to use kmemdup_nul() instead of
>>>>>     kstrndup() and changed the count to not assume a line-return.
>>>>> v6:
>>>>>   - Changed "security update" to "secure update" in commit message
>>>>> v5:
>>>>>   - When checking the return values for functions of type enum
>>>>>     fpga_sec_err err_code, test for FPGA_SEC_ERR_NONE instead of 0
>>>>> v4:
>>>>>   - Changed from "Intel FPGA Security Manager" to FPGA Security Manager"
>>>>>     and removed unnecessary references to "Intel".
>>>>>   - Changed: iops -> sops, imgr -> smgr, IFPGA_ -> FPGA_, ifpga_ to fpga_
>>>>> v3:
>>>>>   - Removed unnecessary "goto done"
>>>>>   - Added a comment to explain imgr->driver_unload in
>>>>>     ifpga_sec_mgr_unregister()
>>>>> v2:
>>>>>   - Bumped documentation date and version
>>>>>   - Removed explicit value assignments in enums
>>>>>   - Other minor code cleanup per review comments
>>>>> ---
>>>>>  Documentation/fpga/fpga-image-load.rst |  21 +++
>>>>>  MAINTAINERS                            |   1 +
>>>>>  drivers/fpga/fpga-image-load.c         | 224 ++++++++++++++++++++++++-
>>>>>  include/linux/fpga/fpga-image-load.h   |  29 ++++
>>>>>  include/uapi/linux/fpga-image-load.h   |  58 +++++++
>>>>>  5 files changed, 329 insertions(+), 4 deletions(-)
>>>>>  create mode 100644 include/uapi/linux/fpga-image-load.h
>>>>>
>>>>> diff --git a/Documentation/fpga/fpga-image-load.rst b/Documentation/fpga/fpga-image-load.rst
>>>>> index a6e53ac66026..2ca8d2f0212d 100644
>>>>> --- a/Documentation/fpga/fpga-image-load.rst
>>>>> +++ b/Documentation/fpga/fpga-image-load.rst
>>>>> @@ -8,3 +8,24 @@ The FPGA Image Load class driver provides a common API for user-space
>>>>>  tools to manage image uploads to FPGA devices. Device drivers that
>>>>>  instantiate the FPGA Image Load class driver will interact with the
>>>>>  target device to transfer and authenticate the image data.
>>>>> +
>>>>> +User API
>>>>> +========
>>>>> +
>>>>> +open
>>>>> +----
>>>>> +
>>>>> +An FPGA Image Load device is opened exclusively to control an image load.
>>>>> +Image loads are processed by a kernel worker thread. A user may choose
>>>>> +close the device while the upload continues.
>>>> Why we allow the user to close the dev while the uploading is ongoing?
>>>> Seems it introduces more checking effort when another user open the dev
>>>> again and try another uploading.
>>> A user could choose to write their own tools. How would we prevent
>>> them from closing the device while an update is in progress? Should
>>> we attempt to cancel the update if they close the device?
>> I think we could try to cancel the update when close(), if we cannot
>> cancel we block on close().
>>
>> The driver should be responsible for the integrity of the update flow,
>> it is not prefered a user starts an update and leaves, but canceled by
>> another user.
OK - I can make those changes for the next version.

>>> Concurrent updates are already prevented by returning EBUSY for the
>>> FPGA_IMAGE_LOAD_WRITE IOCTL if an update is already in progress.
>>>
>>> A single IOCTL is sufficient to do a full update. Maybe a user
>>> would want to have three small tools: update_start, update_status,
>>> update_cancel, each of which would open the device, do an IOCTL,
>>> and then close the device. This is analogous to the sysfs
>>> implementation (no open/close that bounds the entire sequence).
>>>
>>> With the current design, we do an exclusive open. As long as the user
>>> keeps the device open, no other process can open the device to start
>>> a new update, cancel, or collect status.
>>>
>>> Those are my thoughts. What do you think? Is it OK as is? Or should
>>> I make some changes here?
>>>
>>>>> +
>>>>> +ioctl
>>>>> +-----
>>>>> +
>>>>> +FPGA_IMAGE_LOAD_WRITE:
>>>>> +
>>>>> +Start an image load with the provided image buffer. This IOCTL returns
>>>>> +immediately after starting a kernel worker thread to process the image load
>>>>> +which could take as long a 40 minutes depending on the actual device being
>>>>> +updated. This is an exclusive operation; an attempt to start concurrent image
>>>>> +load for the same device will fail with EBUSY.
>>>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>>>> index 4e7f48fa7e5c..637bc003ca81 100644
>>>>> --- a/MAINTAINERS
>>>>> +++ b/MAINTAINERS
>>>>> @@ -7365,6 +7365,7 @@ S:	Maintained
>>>>>  F:	Documentation/fpga/fpga-image-load.rst
>>>>>  F:	drivers/fpga/fpga-image-load.c
>>>>>  F:	include/linux/fpga/fpga-image-load.h
>>>>> +F:	include/uapi/linux/fpga-image-load.h
>>>>>  
>>>>>  FPU EMULATOR
>>>>>  M:	Bill Metzenthen <billm@melbpc.org.au>
>>>>> diff --git a/drivers/fpga/fpga-image-load.c b/drivers/fpga/fpga-image-load.c
>>>>> index 7d75bbcff541..f5ccfa9dd977 100644
>>>>> --- a/drivers/fpga/fpga-image-load.c
>>>>> +++ b/drivers/fpga/fpga-image-load.c
>>>>> @@ -5,18 +5,181 @@
>>>>>   * Copyright (C) 2019-2021 Intel Corporation, Inc.
>>>>>   */
>>>>>  
>>>>> +#include <linux/delay.h>
>>>>>  #include <linux/fpga/fpga-image-load.h>
>>>>> +#include <linux/fs.h>
>>>>> +#include <linux/kernel.h>
>>>>>  #include <linux/module.h>
>>>>>  #include <linux/slab.h>
>>>>> +#include <linux/uaccess.h>
>>>>>  #include <linux/vmalloc.h>
>>>>>  
>>>>>  #define IMAGE_LOAD_XA_LIMIT	XA_LIMIT(0, INT_MAX)
>>>>>  static DEFINE_XARRAY_ALLOC(fpga_image_load_xa);
>>>>>  
>>>>>  static struct class *fpga_image_load_class;
>>>>> +static dev_t fpga_image_devt;
>>>>>  
>>>>>  #define to_image_load(d) container_of(d, struct fpga_image_load, dev)
>>>>>  
>>>>> +static void fpga_image_dev_error(struct fpga_image_load *imgld,
>>>>> +				 enum fpga_image_err err_code)
>>>>> +{
>>>>> +	imgld->err_code = err_code;
>>>>> +	imgld->lops->cancel(imgld);
>>>>> +}
>>>>> +
>>>>> +static void fpga_image_prog_complete(struct fpga_image_load *imgld)
>>>>> +{
>>>>> +	mutex_lock(&imgld->lock);
>>>>> +	imgld->progress = FPGA_IMAGE_PROG_IDLE;
>>>>> +	complete_all(&imgld->update_done);
>>>>> +	mutex_unlock(&imgld->lock);
>>>>> +}
>>>>> +
>>>>> +static void fpga_image_do_load(struct work_struct *work)
>>>>> +{
>>>>> +	struct fpga_image_load *imgld;
>>>>> +	enum fpga_image_err ret;
>>>>> +	u32 size, offset = 0;
>>>>> +
>>>>> +	imgld = container_of(work, struct fpga_image_load, work);
>>>>> +	size = imgld->remaining_size;
>>>>> +
>>>>> +	get_device(&imgld->dev);
>>>>> +	if (!try_module_get(imgld->dev.parent->driver->owner)) {
>>>>> +		imgld->err_code = FPGA_IMAGE_ERR_BUSY;
>>>>> +		goto idle_exit;
>>>>> +	}
>>>>> +
>>>>> +	imgld->progress = FPGA_IMAGE_PROG_PREPARING;
>>>>> +	ret = imgld->lops->prepare(imgld);
>>>>> +	if (ret != FPGA_IMAGE_ERR_NONE) {
>>>>> +		fpga_image_dev_error(imgld, ret);
>>>>> +		goto modput_exit;
>>>>> +	}
>>>>> +
>>>>> +	imgld->progress = FPGA_IMAGE_PROG_WRITING;
>>>>> +	while (imgld->remaining_size) {
>>>>> +		ret = imgld->lops->write_blk(imgld, offset);
>>>>> +		if (ret != FPGA_IMAGE_ERR_NONE) {
>>>>> +			fpga_image_dev_error(imgld, ret);
>>>>> +			goto done;
>>>>> +		}
>>>>> +
>>>>> +		offset = size - imgld->remaining_size;
>>>> The low level driver is required to update the "remaining_size" in
>>>> write_blk ops?
>>>>
>>>> The API seems ambiguous. The framework asks for writing a block of data,
>>>> but no block size is specified.
>>> This change was made two or three iterations ago at Richard Gong's
>>> suggestion. He asserted that the lower level driver should be in
>>> control of the block size (based on write speeds). What do you
>> I think it is reasonable.
>>
>>> think? Should the class driver impose a fixed size? Or allow the
>> But the definition of the API is hard to comprehend, either we input the
>> offset & the blk size, or we record them all in imgld structure, is it
>> better.
>>
>> If the framework provides the blk size, the low level driver could
>> return the written size so it could still control its own batch.
I'll clean up the API for this function in the next version of
the patches.

>>
>>> lower-level driver to determine the size? Is it OK to update
>>> remaining_size in the lower-level driver? Or should there be
>>> another call-back to request the size?
>>>  
>>>>> +	}
>>>>> +
>>>>> +	imgld->progress = FPGA_IMAGE_PROG_PROGRAMMING;
>>>>> +	ret = imgld->lops->poll_complete(imgld);
>>>>> +	if (ret != FPGA_IMAGE_ERR_NONE)
>>>>> +		fpga_image_dev_error(imgld, ret);
>>>>> +
>>>>> +done:
>>>>> +	if (imgld->lops->cleanup)
>>>>> +		imgld->lops->cleanup(imgld);
>>>>> +
>>>>> +modput_exit:
>>>>> +	module_put(imgld->dev.parent->driver->owner);
>>>>> +
>>>>> +idle_exit:
>>>>> +	/*
>>>>> +	 * Note: imgld->remaining_size is left unmodified here to provide
>>>>> +	 * additional information on errors. It will be reinitialized when
>>>>> +	 * the next image load begins.
>>>>> +	 */
>>>>> +	vfree(imgld->data);
>>>>> +	imgld->data = NULL;
>>>>> +	put_device(&imgld->dev);
>>>>> +	fpga_image_prog_complete(imgld);
>>>>> +}
>>>>> +
>>>>> +static int fpga_image_load_ioctl_write(struct fpga_image_load *imgld,
>>>>> +				       unsigned long arg)
>>>>> +{
>>>>> +	struct fpga_image_write wb;
>>>>> +	unsigned long minsz;
>>>>> +	u8 *buf;
>>>>> +
>>>>> +	if (imgld->driver_unload || imgld->progress != FPGA_IMAGE_PROG_IDLE)
>>>>> +		return -EBUSY;
>>>>> +
>>>>> +	minsz = offsetofend(struct fpga_image_write, buf);
>>>>> +	if (copy_from_user(&wb, (void __user *)arg, minsz))
>>>>> +		return -EFAULT;
>>>>> +
>>>>> +	if (wb.flags)
>>>>> +		return -EINVAL;
>>>>> +
>>>>> +	/* Enforce 32-bit alignment on the write data */
>>>>> +	if (wb.size & 0x3)
>>>>> +		return -EINVAL;
>>>>> +
>>>>> +	buf = vzalloc(wb.size);
>>>>> +	if (!buf)
>>>>> +		return -ENOMEM;
>>>>> +
>>>>> +	if (copy_from_user(buf, u64_to_user_ptr(wb.buf), wb.size)) {
>>>>> +		vfree(buf);
>>>>> +		return -EFAULT;
>>>>> +	}
>>>>> +
>>>>> +	imgld->data = buf;
>>>>> +	imgld->remaining_size = wb.size;
>>>>> +	imgld->err_code = FPGA_IMAGE_ERR_NONE;
>>>>> +	imgld->progress = FPGA_IMAGE_PROG_STARTING;
>>>>> +	reinit_completion(&imgld->update_done);
>>>>> +	schedule_work(&imgld->work);
>>>>> +
>>>>> +	return 0;
>>>>> +}
>>>>> +
>>>>> +static long fpga_image_load_ioctl(struct file *filp, unsigned int cmd,
>>>>> +				  unsigned long arg)
>>>>> +{
>>>>> +	struct fpga_image_load *imgld = filp->private_data;
>>>>> +	int ret = -ENOTTY;
>>>>> +
>>>>> +	switch (cmd) {
>>>>> +	case FPGA_IMAGE_LOAD_WRITE:
>>>>> +		mutex_lock(&imgld->lock);
>>>>> +		ret = fpga_image_load_ioctl_write(imgld, arg);
>>>>> +		mutex_unlock(&imgld->lock);
>>>>> +		break;
>>>>> +	}
>>>>> +
>>>>> +	return ret;
>>>>> +}
>>>>> +
>>>>> +static int fpga_image_load_open(struct inode *inode, struct file *filp)
>>>>> +{
>>>>> +	struct fpga_image_load *imgld = container_of(inode->i_cdev,
>>>>> +						     struct fpga_image_load, cdev);
>>>>> +
>>>>> +	if (test_and_set_bit(0, &imgld->opened))
>>>> Some more flags to add for "opened" field? But the field name indicates
>>>> it is a single flag.
>>> Can you explain your comment further? I'm not understanding. What
>>> "more flags" are you referring to?
>>>
>> The test_and_set_bit() makes me feel there are more bits to be
>> controlled in "opened" for other purposes. The name "opened" indicates
>> this is a single state, maybe you don't have to use bitops for it,
>> atomic ops for int maybe better.
OK - I'll use an atomic operation here.
>>
>>> This test_and_set_bit() operation and the "opened" structure member
>>> were borrowed from the production driver implementation. opened is a
>>> single value that is expected to be either 1 or 0.
>>>
>>>>> +		return -EBUSY;
>>>>> +
>>>>> +	filp->private_data = imgld;
>>>>> +
>>>>> +	return 0;
>>>>> +}
>>>>> +
>>>>> +static int fpga_image_load_release(struct inode *inode, struct file *filp)
>>>>> +{
>>>>> +	struct fpga_image_load *imgld = filp->private_data;
>>>>> +
>>>>> +	clear_bit(0, &imgld->opened);
>>>>> +
>>>>> +	return 0;
>>>>> +}
>>>>> +
>>>>> +static const struct file_operations fpga_image_load_fops = {
>>>>> +	.owner = THIS_MODULE,
>>>>> +	.open = fpga_image_load_open,
>>>>> +	.release = fpga_image_load_release,
>>>>> +	.unlocked_ioctl = fpga_image_load_ioctl,
>>>>> +};
>>>>> +
>>>>>  /**
>>>>>   * fpga_image_load_register - create and register an FPGA Image Load Device
>>>>>   *
>>>>> @@ -33,11 +196,17 @@ fpga_image_load_register(struct device *parent,
>>>>>  			 const struct fpga_image_load_ops *lops, void *priv)
>>>>>  {
>>>>>  	struct fpga_image_load *imgld;
>>>>> -	int id, ret;
>>>>> +	int ret;
>>>>> +
>>>>> +	if (!lops || !lops->cancel || !lops->prepare ||
>>>>> +	    !lops->write_blk || !lops->poll_complete) {
>>>>> +		dev_err(parent, "Attempt to register without all required ops\n");
>>>>> +		return ERR_PTR(-ENOMEM);
>>>>> +	}
>>>>>  
>>>>>  	imgld = kzalloc(sizeof(*imgld), GFP_KERNEL);
>>>>>  	if (!imgld)
>>>>> -		return NULL;
>>>>> +		return ERR_PTR(-ENOMEM);
>>>> This is the fix for Patch #1? If yes please merge it to Patch #1.
>>> Good catch. Yes, I'll move it to patch #1.
>>>>>  
>>>>>  	ret = xa_alloc(&fpga_image_load_xa, &imgld->dev.id, imgld, IMAGE_LOAD_XA_LIMIT,
>>>>>  		       GFP_KERNEL);
>>>>> @@ -48,13 +217,19 @@ fpga_image_load_register(struct device *parent,
>>>>>  
>>>>>  	imgld->priv = priv;
>>>>>  	imgld->lops = lops;
>>>>> +	imgld->err_code = FPGA_IMAGE_ERR_NONE;
>>>>> +	imgld->progress = FPGA_IMAGE_PROG_IDLE;
>>>>> +	init_completion(&imgld->update_done);
>>>>> +	INIT_WORK(&imgld->work, fpga_image_do_load);
>>>>>  
>>>>>  	imgld->dev.class = fpga_image_load_class;
>>>>>  	imgld->dev.parent = parent;
>>>>> +	imgld->dev.devt = MKDEV(MAJOR(fpga_image_devt), imgld->dev.id);
>>>>>  
>>>>> -	ret = dev_set_name(&imgld->dev, "fpga_image%d", id);
>>>>> +	ret = dev_set_name(&imgld->dev, "fpga_image%d", imgld->dev.id);
>>>> Another fix? Please merge it to Patch #1.
>>> Yes.
>>>
>>>>>  	if (ret) {
>>>>> -		dev_err(parent, "Failed to set device name: fpga_image%d\n", id);
>>>>> +		dev_err(parent, "Failed to set device name: fpga_image%d\n",
>>>>> +			imgld->dev.id);
>>>> Ditto
>>> Yes.
>>>>>  		goto error_device;
>>>>>  	}
>>>>>  
>>>>> @@ -64,6 +239,16 @@ fpga_image_load_register(struct device *parent,
>>>>>  		return ERR_PTR(ret);
>>>>>  	}
>>>>>  
>>>>> +	cdev_init(&imgld->cdev, &fpga_image_load_fops);
>>>>> +	imgld->cdev.owner = parent->driver->owner;
>>>>> +	imgld->cdev.kobj.parent = &imgld->dev.kobj;
>>>>> +
>>>>> +	ret = cdev_add(&imgld->cdev, imgld->dev.devt, 1);
>>>>> +	if (ret) {
>>>>> +		put_device(&imgld->dev);
>>>>> +		return ERR_PTR(ret);
>>>>> +	}
>>>>> +
>>>>>  	return imgld;
>>>>>  
>>>>>  error_device:
>>>>> @@ -83,9 +268,29 @@ EXPORT_SYMBOL_GPL(fpga_image_load_register);
>>>>>   *
>>>>>   * This function is intended for use in an FPGA Image Load driver's
>>>>>   * remove() function.
>>>>> + *
>>>>> + * For some devices, once authentication of the uploaded image has begun,
>>>>> + * the hardware cannot be signaled to stop, and the driver will not exit
>>>>> + * until the hardware signals completion.  This could be 30+ minutes of
>>>>> + * waiting. The driver_unload flag enables a force-unload of the driver
>>>>> + * (e.g. modprobe -r) by signaling the parent driver to exit even if the
>>>> How does the driver_unload enables the force unload of the parent
>>>> driver? I didn't find the code.
>>> The driver_unload field is tested in the lower-level (parent) driver in
>>> m10bmc_sec_poll_complete(), allowing the kernel worker thread to exit
>>> even if the firmware update is still in progress.
>> I didn't see the signaling implementation here. Maybe you need to move the
>> comments somewhere else, or in another patch.
> I have another concern. the design requires the low level driver poll
> for a field of the input parameter that the framework manages. It is
> unnormal, like an implicit cancel call to the driver.
I'm cleaning up the driver_unload. I'm also changing the release
(close) function to set the request_cancel flag when need. I think
I have addressed all of your concerns for the next version of the
patches.

Thanks,
- Russ
>
> How about the framework explicitly call cancel() when needed? Of cource
> we need to declare the cancel() could be called when other callback is
> in progress.
>
> Thanks,
> Yilun
>
>> Thanks,
>> Yilun
>>
>>>>> + * hardware update is incomplete. The driver_unload flag also prevents
>>>>> + * new updates from starting once the unregister process has begun.
>>>>>   */
>>>>>  void fpga_image_load_unregister(struct fpga_image_load *imgld)
>>>>>  {
>>>>> +	mutex_lock(&imgld->lock);
>>>>> +	imgld->driver_unload = true;
>>>>> +	if (imgld->progress == FPGA_IMAGE_PROG_IDLE) {
>>>>> +		mutex_unlock(&imgld->lock);
>>>>> +		goto unregister;
>>>>> +	}
>>>>> +
>>>>> +	mutex_unlock(&imgld->lock);
>>>>> +	wait_for_completion(&imgld->update_done);
>>>>> +
>>>>> +unregister:
>>>>> +	cdev_del(&imgld->cdev);
>>>>>  	device_unregister(&imgld->dev);
>>>>>  }
>>>>>  EXPORT_SYMBOL_GPL(fpga_image_load_unregister);
>>>>> @@ -100,19 +305,30 @@ static void fpga_image_load_dev_release(struct device *dev)
>>>>>  
>>>>>  static int __init fpga_image_load_class_init(void)
>>>>>  {
>>>>> +	int ret;
>>>>>  	pr_info("FPGA Image Load Driver\n");
>>>>>  
>>>>>  	fpga_image_load_class = class_create(THIS_MODULE, "fpga_image_load");
>>>>>  	if (IS_ERR(fpga_image_load_class))
>>>>>  		return PTR_ERR(fpga_image_load_class);
>>>>>  
>>>>> +	ret = alloc_chrdev_region(&fpga_image_devt, 0, MINORMASK,
>>>>> +				  "fpga_image_load");
>>>>> +	if (ret)
>>>>> +		goto exit_destroy_class;
>>>>> +
>>>>>  	fpga_image_load_class->dev_release = fpga_image_load_dev_release;
>>>>>  
>>>>>  	return 0;
>>>>> +
>>>>> +exit_destroy_class:
>>>>> +	class_destroy(fpga_image_load_class);
>>>>> +	return ret;
>>>>>  }
>>>>>  
>>>>>  static void __exit fpga_image_load_class_exit(void)
>>>>>  {
>>>>> +	unregister_chrdev_region(fpga_image_devt, MINORMASK);
>>>>>  	class_destroy(fpga_image_load_class);
>>>>>  	WARN_ON(!xa_empty(&fpga_image_load_xa));
>>>>>  }
>>>>> diff --git a/include/linux/fpga/fpga-image-load.h b/include/linux/fpga/fpga-image-load.h
>>>>> index a9cef9e1056b..b3d790e5d943 100644
>>>>> --- a/include/linux/fpga/fpga-image-load.h
>>>>> +++ b/include/linux/fpga/fpga-image-load.h
>>>>> @@ -7,22 +7,51 @@
>>>>>  #ifndef _LINUX_FPGA_IMAGE_LOAD_H
>>>>>  #define _LINUX_FPGA_IMAGE_LOAD_H
>>>>>  
>>>>> +#include <linux/cdev.h>
>>>>> +#include <linux/completion.h>
>>>>>  #include <linux/device.h>
>>>>>  #include <linux/mutex.h>
>>>>>  #include <linux/types.h>
>>>>> +#include <uapi/linux/fpga-image-load.h>
>>>>>  
>>>>>  struct fpga_image_load;
>>>>>  
>>>>>  /**
>>>>>   * struct fpga_image_load_ops - device specific operations
>>>>> + * @prepare:		    Required: Prepare secure update
>>>>> + * @write_blk:		    Required: Write a block of data
>>>>> + * @poll_complete:	    Required: Check for the completion of the
>>>>> + *			    HW authentication/programming process. This
>>>>> + *			    function should check for imgld->driver_unload
>>>>> + *			    and abort with FPGA_IMAGE_ERR_CANCELED when true.
>>>>> + * @cancel:		    Required: Signal HW to cancel update
>>>>> + * @cleanup:		    Optional: Complements the prepare()
>>>>> + *			    function and is called at the completion
>>>>> + *			    of the update, whether success or failure,
>>>>> + *			    if the prepare function succeeded.
>>>>>   */
>>>>>  struct fpga_image_load_ops {
>>>>> +	enum fpga_image_err (*prepare)(struct fpga_image_load *imgld);
>>>>> +	enum fpga_image_err (*write_blk)(struct fpga_image_load *imgld, u32 offset);
>>>>> +	enum fpga_image_err (*poll_complete)(struct fpga_image_load *imgld);
>>>>> +	enum fpga_image_err (*cancel)(struct fpga_image_load *imgld);
>>>>> +	void (*cleanup)(struct fpga_image_load *imgld);
>>>>>  };
>>>>>  
>>>>>  struct fpga_image_load {
>>>>>  	struct device dev;
>>>>> +	struct cdev cdev;
>>>>>  	const struct fpga_image_load_ops *lops;
>>>>>  	struct mutex lock;		/* protect data structure contents */
>>>>> +	unsigned long opened;
>>>>> +	struct work_struct work;
>>>>> +	struct completion update_done;
>>>>> +	const u8 *data;				/* pointer to update data */
>>>>> +	u32 remaining_size;			/* size remaining to transfer */
>>>>> +	enum fpga_image_prog progress;
>>>>> +	enum fpga_image_prog err_progress;	/* progress at time of failure */
>>>> This field is not used in this patch? So could you introduce it later?
>>> Yes - I'll move it. Thanks.
>>>>> +	enum fpga_image_err err_code;		/* image load error code */
>>>>> +	bool driver_unload;
>>>>>  	void *priv;
>>>>>  };
>>>>>  
>>>>> diff --git a/include/uapi/linux/fpga-image-load.h b/include/uapi/linux/fpga-image-load.h
>>>>> new file mode 100644
>>>>> index 000000000000..4146a0a9e408
>>>>> --- /dev/null
>>>>> +++ b/include/uapi/linux/fpga-image-load.h
>>>>> @@ -0,0 +1,58 @@
>>>>> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
>>>>> +/*
>>>>> + * Header File for FPGA Image Load User API
>>>>> + *
>>>>> + * Copyright (C) 2019-2021 Intel Corporation, Inc.
>>>>> + *
>>>>> + */
>>>>> +
>>>>> +#ifndef _UAPI_LINUX_FPGA_IMAGE_LOAD_H
>>>>> +#define _UAPI_LINUX_FPGA_IMAGE_LOAD_H
>>>>> +
>>>>> +#include <linux/types.h>
>>>>> +#include <linux/ioctl.h>
>>>>> +
>>>>> +#define FPGA_IMAGE_LOAD_MAGIC 0xB9
>>>>> +
>>>>> +/* Image load progress codes */
>>>>> +enum fpga_image_prog {
>>>>> +	FPGA_IMAGE_PROG_IDLE,
>>>>> +	FPGA_IMAGE_PROG_STARTING,
>>>>> +	FPGA_IMAGE_PROG_PREPARING,
>>>>> +	FPGA_IMAGE_PROG_WRITING,
>>>>> +	FPGA_IMAGE_PROG_PROGRAMMING,
>>>>> +	FPGA_IMAGE_PROG_MAX
>>>>> +};
>>>>> +
>>>>> +/* Image error progress codes */
>>>>> +enum fpga_image_err {
>>>>> +	FPGA_IMAGE_ERR_NONE,
>>>>> +	FPGA_IMAGE_ERR_HW_ERROR,
>>>>> +	FPGA_IMAGE_ERR_TIMEOUT,
>>>>> +	FPGA_IMAGE_ERR_CANCELED,
>>>>> +	FPGA_IMAGE_ERR_BUSY,
>>>>> +	FPGA_IMAGE_ERR_INVALID_SIZE,
>>>>> +	FPGA_IMAGE_ERR_RW_ERROR,
>>>>> +	FPGA_IMAGE_ERR_WEAROUT,
>>>>> +	FPGA_IMAGE_ERR_MAX
>>>>> +};
>>>>> +
>>>>> +#define FPGA_IMAGE_LOAD_WRITE	_IOW(FPGA_IMAGE_LOAD_MAGIC, 0, struct fpga_image_write)
>>>> Put the cmd word definition under the comments and parameter definition.
>>> OK
>>>>> +
>>>>> +/**
>>>>> + * FPGA_IMAGE_LOAD_WRITE - _IOW(FPGA_IMAGE_LOAD_MAGIC, 0,
>>>>> + *				struct fpga_image_write)
>>>>> + *
>>>>> + * Upload a data buffer to the target device. The user must provide the
>>>>> + * data buffer, size, and an eventfd file descriptor.
>>>> I didn't find the eventfd.
>>> It is added in a later patch. I'll change the comment accordingly.
>>>
>>> Thanks,
>>> - Russ
>>>> Thanks,
>>>> Yilun
>>>>
>>>>> + *
>>>>> + * Return: 0 on success, -errno on failure.
>>>>> + */
>>>>> +struct fpga_image_write {
>>>>> +	/* Input */
>>>>> +	__u32 flags;		/* Zero for now */
>>>>> +	__u32 size;		/* Data size (in bytes) to be written */
>>>>> +	__u64 buf;		/* User space address of source data */
>>>>> +};
>>>>> +
>>>>> +#endif /* _UAPI_LINUX_FPGA_IMAGE_LOAD_H */
>>>>> -- 
>>>>> 2.25.1

