Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC5384245CD
	for <lists+linux-fpga@lfdr.de>; Wed,  6 Oct 2021 20:13:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbhJFSPk (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 6 Oct 2021 14:15:40 -0400
Received: from mga06.intel.com ([134.134.136.31]:49357 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229633AbhJFSPj (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 6 Oct 2021 14:15:39 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10129"; a="286950102"
X-IronPort-AV: E=Sophos;i="5.85,352,1624345200"; 
   d="scan'208";a="286950102"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2021 11:13:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,352,1624345200"; 
   d="scan'208";a="560275974"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by FMSMGA003.fm.intel.com with ESMTP; 06 Oct 2021 11:13:45 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Wed, 6 Oct 2021 11:13:44 -0700
Received: from orsmsx605.amr.corp.intel.com (10.22.229.18) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Wed, 6 Oct 2021 11:13:44 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Wed, 6 Oct 2021 11:13:44 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.173)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Wed, 6 Oct 2021 11:13:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d+eRAiV2cNnl/4eF3u9LnVkoyiWpCvVwkM2Rfl/LM70Y+wuvZYtUbp1fk1RCK49XXVQ+bHga64XBandm8uFMBpIJRcehE2wN2b8sQlAN+WFGwj4yEbDuWZj3FwFS64ESdE1UW3EFLg9MxGI1NXV0ech1posbOT7EAI9QDTt0jKMGK4BHVZ0er9NsJNZ+wlcObeTGLrnF13b7cb8Vn0bk+Joy6YeonYc6XjdaGlsQ3qfXqgvdw5WjnUVllGB5zdqoHuAaNV6t4C2mtMXvdVhuKjgex5vIhpP2stn1FwcBCQrNzjvIeEfcixHlamKNcSzidUDKIVGVsRy0Jtk1BjF+2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6WcBUihAwg0NcAZB45Ick73tfqcVp05uLK6Ct3n/dMU=;
 b=bqupXEvGov8m641S7Hd8/fg6ouWsO6Vr4n8qdXkdJFPJgL18/hx67qu4cgI73SFqlNTTH4fztKjwW9vE7VKSRlY56YvrW40yslqHdyJW3TVcMMAY0gSIHU7t3M8ZAttuKp9cJwZX3HEk5xC3u72THGW8lINwMBxS1XQjUedmBa8qx3cxKpewC7FqbSjssq3Ykhdm3v7vBALtHqhAPDeSJ0XX2wqoQbhpjPvkA6bLcyjUM+si1Bm7WfjuPgcmyVMYPREVbKrTGFPozE28SCD7MESRi7yVjzLH17MoZiFFZ4S8kWhNEvlkugqXZW5f3WnFxfvwbBYRtijyXjQFDZ7OBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6WcBUihAwg0NcAZB45Ick73tfqcVp05uLK6Ct3n/dMU=;
 b=pObTleRJ/iV8zoaECVY1b7Nnr6RRozCh+8Wv7DtXqUUr0K2I5prTaU6zmp6EEL1UtGOq9KoPbV+A7AlzGmQnSdK/NNr9JP24b+q1KNdMlu/4sndlZvZ2BTJcaEdu34TmLyq8mo2Ze0i8q9aFS8+25C6sYeN3rVZVgJuUhZfbD4c=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
Received: from SA2PR11MB5163.namprd11.prod.outlook.com (2603:10b6:806:113::20)
 by SA2PR11MB4889.namprd11.prod.outlook.com (2603:10b6:806:110::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.16; Wed, 6 Oct
 2021 18:13:40 +0000
Received: from SA2PR11MB5163.namprd11.prod.outlook.com
 ([fe80::a039:c121:4dce:5def]) by SA2PR11MB5163.namprd11.prod.outlook.com
 ([fe80::a039:c121:4dce:5def%7]) with mapi id 15.20.4566.022; Wed, 6 Oct 2021
 18:13:40 +0000
Subject: Re: [PATCH v17 2/5] fpga: image-load: enable image uploads
To:     <mdf@kernel.org>, <linux-fpga@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <trix@redhat.com>, <lgoncalv@redhat.com>, <yilun.xu@intel.com>,
        <hao.wu@intel.com>, <matthew.gerlach@intel.com>
References: <20210929230025.68961-1-russell.h.weight@intel.com>
 <20210929230025.68961-3-russell.h.weight@intel.com>
From:   Russ Weight <russell.h.weight@intel.com>
Message-ID: <3dee738d-e10f-2e19-480a-f6423996bd9b@intel.com>
Date:   Wed, 6 Oct 2021 11:13:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
In-Reply-To: <20210929230025.68961-3-russell.h.weight@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: MW4PR04CA0189.namprd04.prod.outlook.com
 (2603:10b6:303:86::14) To SA2PR11MB5163.namprd11.prod.outlook.com
 (2603:10b6:806:113::20)
MIME-Version: 1.0
Received: from [10.0.2.4] (50.43.42.212) by MW4PR04CA0189.namprd04.prod.outlook.com (2603:10b6:303:86::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.22 via Frontend Transport; Wed, 6 Oct 2021 18:13:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8b63deb2-c3e6-4284-4a20-08d988f50632
X-MS-TrafficTypeDiagnostic: SA2PR11MB4889:
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA2PR11MB4889184DB9308A7C228E463AC5B09@SA2PR11MB4889.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c1puOrlcX8l2BbN8yCGNabS/JThtf/KwOE+K5VcKwT7cUZnsI+yXnCS+W5Fv3v0pM4DbHoOJy0CCWRHWP73Ulk7RDXVUxT0t6PYcE689yZV2rhZTorJHe33G3SVJeWhWcqe0v2r1yhxPG6MU+iwE6TiXHlFTxLZbB4f03abQR2FWz7fbCCUKLYdY0Ux4eIMoQMnUjgabjxNSkbGp8qmc1ttzYdKz1JVal45eq6K28Ys8GclpwwPAO9Ny55aqzOhgUt2EYpjfC0iy5B5avrmdHdc9JhBJF0sFDJBiYOvnt0CKKne5zJ5xcJi1v3GCD9conc9OH+ogABakaug8CsR6ww6Wb2l0ZTI+h1ZgPYUL58bdsR8siKEjmKR6MwmdFp8Uz0IWqB3m4+lxBiiBCPdcp0sIIl7TJbzaAWil7bFBf4Zigo7oDbz7qrv+GA0sppicqqe7aFEHQ4GPwnA204PuxXGHR8j1Wpv4Jy9q0fAd2c/vK/tZJH2Z6GsB7TlUnPx2JaAz/g8Tsip7/0j+lMdSSXL8ic2fLHs6TGd81KofDMKC41APZ7FSnKrGwxmjjulRjv/4eWN34En5MYsUmQV5qzWczOjWG3yodkZh3jkHFoPTiFf2rA1xYnH8eGR2dtEsCa8t9j4TbsUwlkd6S6H5a5WcrypflfSk6pw2oMaqnQqhE8U1xqp8vMPjr+fcuriU7UGk2KDL2K5fq26qUNKslf4GU7pOPDw23UfOZskZz7I=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB5163.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(186003)(83380400001)(316002)(956004)(30864003)(4326008)(8676002)(26005)(86362001)(16576012)(2616005)(31686004)(5660300002)(36756003)(38100700002)(6486002)(107886003)(66946007)(508600001)(2906002)(66476007)(6666004)(8936002)(31696002)(53546011)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cHAySTZkRTh2MndRcEtuY3pLVVFxNE9Tb2IxWUN6U3JtanhscTRTSGZXWHM4?=
 =?utf-8?B?RlFCYlprZlpmK3Qra01hbDQxazBjc3ZEdVBqREFsUXd5WTlaeHdhN2JiUFh3?=
 =?utf-8?B?VWY4Q2tlOUFFMHhrbnVTVWhyQlFzZjZMNHNjSmJ6b0h6VTRDVUh3SjByb0Rs?=
 =?utf-8?B?UzFMMXhHTWs2bXg5MU5uaDJpdS9mVWZzT2VQTi84b0lzQTBZWnA0L1dPQ2Ro?=
 =?utf-8?B?ODF6T1hsM2l3VWtiL0I1Qk1qVjlEeURURUpYRXJtcTI5cTFWaFlpR29RMm1K?=
 =?utf-8?B?bmt1WlJ3SDlWODhNaGdtK2tQa3I3NENua1J5WXJvcHhMTFl0UEw2a3ZtNkY3?=
 =?utf-8?B?S2NReG5OQ1pJYlNWaXBjdjZzRnNIaytUOHRuMm9yL3AwbVVhRnBwdE9SRVB2?=
 =?utf-8?B?Q0w2WFhsWWMvQ0R1WVo2OWVTUHo2M2JIdkdGa3ZZbXhpQmtFRE52R0JhcjBY?=
 =?utf-8?B?M2FQclVKNncwYisxY0lwVG81VjJDSlBwU2dNd3N4OEZWR2hRM0FqcEpLcERs?=
 =?utf-8?B?LzR4d013OE1VcUdpK1R5ME14SUlLMU5ZMW83b0RJeFd1VG1QWHVrSTd5bUg4?=
 =?utf-8?B?Wk0yZUREZjlEeTl0bHRnemlQS0g4VmVTcVY3QWZXNFE2MHZVV0gveVh0QjZW?=
 =?utf-8?B?ZWFSWjl6RzVkYlF6QVNlSFZxbTh6cnE3emMxTXR1SHlmU2x2TjFKbUpOZHRB?=
 =?utf-8?B?bXJ5amhaUGpKRzBjNllTTFVqVk44Wi9OamtUYWdwUGdqN0g1dXdGOTZTWEt3?=
 =?utf-8?B?OEhiRVU5cW9DVDdENnpOeDhrdmRkcDRDRUJYTG9IckJKWkdTMzZGNlgvZVpD?=
 =?utf-8?B?dlVBZWdoK1hjVmdBcjcvZEhUREIxck5Sd0U5eUhiUTQ5bXUxbmE3YXRSSnRL?=
 =?utf-8?B?WW95MWRuclpjS3o4MVF4N1FacW9YSndGMVB6WnhSbU5ObWNqaXVuV29JODRP?=
 =?utf-8?B?QTdQMWtkODZCTzJITHl1R3A5UjNud2tJNnVVMHpQTUwveFAzWTRGZFlpZUpt?=
 =?utf-8?B?YWpBd2dvY3pPTkNKY0xwQXpaTGhweG0raWwxZ0dXZXdCRFgwU0RFMHpnV3ZV?=
 =?utf-8?B?MHVMRjJSeFhUeTYxZk10UVRWWGhaanVURXlYMnNtZUhBRVA0S1RhRUJPeHR3?=
 =?utf-8?B?N1R2anlvK2srdisvR0g2VEh1aGZxVm9QTzdsSnoraFoyL2xub1NnRzJ3WElS?=
 =?utf-8?B?NWNBSXIzZ2lWVTVNc3JsUTJYbHU4V05zMXE1RjAybDcrRjluemQ1WEJHdjgw?=
 =?utf-8?B?MEsybHJyUi9yK2lFMnRqenNxVTcrWEJFOE9GdG1LWjJiWUFDNXNxMjBlbjZ2?=
 =?utf-8?B?em1icDc0WHJJNGpXVnJnbHkvbjYwMjJEZEdncmhFNXBaSkh1amxxckY3NmtS?=
 =?utf-8?B?NklQR0NXTFVWdER6Y3VjdVlTRTM2RmFnYTRJM2laMC9qYnl3YnVsZFFVdUlw?=
 =?utf-8?B?dHNxSzdTUnpQZlhGbzhianQ2MDNrQlMzMml1eW52OW1vT1ZUUkVBc3NlYTJX?=
 =?utf-8?B?NHRqYjUvVFlCVzd1d2xHdGE3SENLcm05ZzA0Ukc4OFJMUjM2eGxJSzA5d2Va?=
 =?utf-8?B?cmwxTlJvK00wRDJoNnVUbGNDT3lEenhlakR1anBBblFjc1o5THNTMnRFeTAw?=
 =?utf-8?B?WGQ5ZHNSM3V3aU1OZHV3dSs2eDdaeUdXSnhITTFPOElsNE05YWsyRklHRmxa?=
 =?utf-8?B?UFA5UFlZdkVWRjg2MWlhbk82MWxNR0t6Q1hoWUFUR05ocEJ6OHpwQ0N5U0lj?=
 =?utf-8?Q?9W26zgRSsrXvFmaCXESrF8hAksC11Dr4XPY1m2f?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b63deb2-c3e6-4284-4a20-08d988f50632
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB5163.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2021 18:13:40.3821
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J6oUf28ucKpI8luiepdfhpysQnFEIbdN4LQbeG+kWhR4gMPJ1F9zcMAEK7EiX+S4qbyqS3022cNrgtb4fCl+ssdE8oPQOeRFxG1DhBIJaTY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4889
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On 9/29/21 4:00 PM, Russ Weight wrote:
> Extend the FPGA Image Load framework to include IOCTL support
> (FPGA_IMAGE_LOAD_WRITE) for initiating an upload of an image to a device.
> The IOCTL will return immediately, and the update will begin in the
> context of a kernel worker thread.
>
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> ---
> v17:
>  - Minor documentation cleanup and references to cancellation are moved
>    to a later patch.
>  - We no longer send a "just in case" cancel on HW errors. The cleanup()
>    op can and should be used to manage the HW state on an error.
>  - Removed the FPGA_IMAGE_ERR_NONE macro in favor of returning zero. The
>    constant name made sense when we were using enum data types, but is no
>    longer necessary.
>  - Changed the syntax of the write_blk() function and renamed it to write().
>    It now returns a positive size or a negative error number.
>  - Changed the prepare() and write() ops to pass in elements of the
>    fpga_image_load data structure instead of having the op functions access
>    them directly via imgld.
>  - Removed the default block size. The lower-level driver must choose a
>    block size.
>  - Changed work queue from system_unbound_wq to system_long_wq.
>  - Removed calls to cond_resched(). The lower-level driver must manage
>    any scheduler issues.
>  - Use the cdev_set_parent() macro.
> v16:
>  - Shift from "Driver" terminology to "Framework" in comments and
>    documentation
>  - Rename lops to ops for structure member and local variables
>  - Change the write_blk() definition to pass in *blk_size (a pointer to
>    a default block size of WRITE_BLOCK_SIZE=0x4000) and max_size (the
>    the maximum block size to stay within the limit of the data buffer).
>    The write_blk() op may use the default *blk_size or modify it to a
>    more optimal number for the given device, subject to the max_size limit.
>  - All enum values for progress and errors are changed to macros, because
>    they are included in the uapi header. This is done to maintain consistency
>    amongst the DFL related IOCTL header files. All references to the enum
>    types are changed to u32.
>  - Bail out early in fpga_image_do_load() if imgld->driver_unload is true.
>  - Add a call to cond_resched() in the write_blk() loop to ensure that
>    we yield to higher priority tasks during long data transfers.
>  - Switch to the system_unbound_wq to enable calls to cond_resched().
>  - Switch from test_and_set_bit() to atomic_cmpxchg() to manage
>    imgld->opened.
>  - Change fpga_image_load_release() to block until the image upload is
>    complete.
>  - Remove the completion object, imgld->update_done, in favor of calling
>    flush_work(&imgld->work);
> v15:
>  - Compare to previous patch:
>      [PATCH v14 2/6] fpga: sec-mgr: enable secure updates
>  - Changed file, symbol, and config names to reflect the new driver name
>  - Removed update/filename sysfs file and added the FPGA_IMAGE_LOAD_WRITE
>    IOCTL for writing the image data to the FPGA card. The driver no longer
>    uses the request_firmware framework.
>  - Fixed some error return values in fpga_image_load_register()
>  - Removed signed-off/reviewed-by tags
> v14:
>  - Added MAINTAINERS reference for
>    Documentation/ABI/testing/sysfs-class-fpga-sec-mgr
>  - Updated ABI documentation date and kernel version
>  - Updated copyright to 2021
> v13:
>   - Change "if (count == 0 || " to "if (!count || "
>   - Improve error message: "Attempt to register without all required ops\n"
> v12:
>   - Updated Date and KernelVersion fields in ABI documentation
>   - Removed size parameter from write_blk() op - it is now up to
>     the lower-level driver to determine the appropriate size and
>     to update smgr->remaining_size accordingly.
> v11:
>   - Fixed a spelling error in a comment
>   - Initialize smgr->err_code and smgr->progress explicitly in
>     fpga_sec_mgr_create() instead of accepting the default 0 value.
> v10:
>   - Rebased to 5.12-rc2 next
>   - Updated Date and KernelVersion in ABI documentation
> v9:
>   - Updated Date and KernelVersion in ABI documentation
> v8:
>   - No change
> v7:
>   - Changed Date in documentation file to December 2020
>   - Changed filename_store() to use kmemdup_nul() instead of
>     kstrndup() and changed the count to not assume a line-return.
> v6:
>   - Changed "security update" to "secure update" in commit message
> v5:
>   - When checking the return values for functions of type enum
>     fpga_sec_err err_code, test for FPGA_SEC_ERR_NONE instead of 0
> v4:
>   - Changed from "Intel FPGA Security Manager" to FPGA Security Manager"
>     and removed unnecessary references to "Intel".
>   - Changed: iops -> sops, imgr -> smgr, IFPGA_ -> FPGA_, ifpga_ to fpga_
> v3:
>   - Removed unnecessary "goto done"
>   - Added a comment to explain imgr->driver_unload in
>     ifpga_sec_mgr_unregister()
> v2:
>   - Bumped documentation date and version
>   - Removed explicit value assignments in enums
>   - Other minor code cleanup per review comments
> ---
>  Documentation/fpga/fpga-image-load.rst |  25 ++-
>  MAINTAINERS                            |   1 +
>  drivers/fpga/fpga-image-load.c         | 217 ++++++++++++++++++++++++-
>  include/linux/fpga/fpga-image-load.h   |  27 +++
>  include/uapi/linux/fpga-image-load.h   |  53 ++++++
>  5 files changed, 321 insertions(+), 2 deletions(-)
>  create mode 100644 include/uapi/linux/fpga-image-load.h
>
> diff --git a/Documentation/fpga/fpga-image-load.rst b/Documentation/fpga/fpga-image-load.rst
> index dda9283ef1c7..f6b0e1624a05 100644
> --- a/Documentation/fpga/fpga-image-load.rst
> +++ b/Documentation/fpga/fpga-image-load.rst
> @@ -7,4 +7,27 @@ FPGA Image Load Framework
>  The FPGA Image Load framework provides a common API for user-space
>  tools to manage image uploads to FPGA devices. Device drivers that
>  instantiate the FPGA Image Load framework will interact with the
> -target device to transfer and authenticate the image data.
> +target device to transfer and authenticate the image data. Image uploads
> +are processed in the context of a kernel worker thread.
> +
> +User API
> +========
> +
> +open
> +----
> +
> +An fpga_image_load device is opened exclusively to control an image upload.
> +The device must remain open throughout the duration of the image upload.
> +An attempt to close the device while an upload is in progress will block
> +until the image upload is complete.
> +
> +ioctl
> +-----
> +
> +FPGA_IMAGE_LOAD_WRITE:
> +
> +Start an image upload with the provided image buffer. This IOCTL returns
> +immediately after starting a kernel worker thread to process the image
> +upload which could take as long as 40 minutes depending on the actual
> +device being updated. This is an exclusive operation; an attempt to start
> +concurrent image uploads for the same device will fail with EBUSY.
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a99622eebbff..e3b5c555ecbd 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7415,6 +7415,7 @@ S:	Maintained
>  F:	Documentation/fpga/fpga-image-load.rst
>  F:	drivers/fpga/fpga-image-load.c
>  F:	include/linux/fpga/fpga-image-load.h
> +F:	include/uapi/linux/fpga-image-load.h
>  
>  FPU EMULATOR
>  M:	Bill Metzenthen <billm@melbpc.org.au>
> diff --git a/drivers/fpga/fpga-image-load.c b/drivers/fpga/fpga-image-load.c
> index 799d18444f7c..4c2571e3b26f 100644
> --- a/drivers/fpga/fpga-image-load.c
> +++ b/drivers/fpga/fpga-image-load.c
> @@ -5,18 +5,190 @@
>   * Copyright (C) 2019-2021 Intel Corporation, Inc.
>   */
>  
> +#include <linux/delay.h>
>  #include <linux/fpga/fpga-image-load.h>
> +#include <linux/fs.h>
> +#include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/slab.h>
> +#include <linux/uaccess.h>
>  #include <linux/vmalloc.h>
>  
>  #define IMAGE_LOAD_XA_LIMIT	XA_LIMIT(0, INT_MAX)
>  static DEFINE_XARRAY_ALLOC(fpga_image_load_xa);
>  
>  static struct class *fpga_image_load_class;
> +static dev_t fpga_image_devt;
>  
>  #define to_image_load(d) container_of(d, struct fpga_image_load, dev)
>  
> +static void fpga_image_prog_complete(struct fpga_image_load *imgld)
> +{
> +	mutex_lock(&imgld->lock);
> +	imgld->progress = FPGA_IMAGE_PROG_IDLE;
> +	mutex_unlock(&imgld->lock);
> +}
> +
> +static void fpga_image_do_load(struct work_struct *work)
> +{
> +	struct fpga_image_load *imgld;
> +	s32 ret, offset = 0;
> +
> +	imgld = container_of(work, struct fpga_image_load, work);
> +
> +	if (imgld->driver_unload) {
> +		imgld->err_code = FPGA_IMAGE_ERR_CANCELED;
> +		goto idle_exit;
> +	}
> +
> +	get_device(&imgld->dev);
> +	if (!try_module_get(imgld->dev.parent->driver->owner)) {
> +		imgld->err_code = FPGA_IMAGE_ERR_BUSY;
> +		goto putdev_exit;
> +	}
> +
> +	imgld->progress = FPGA_IMAGE_PROG_PREPARING;
> +	ret = imgld->ops->prepare(imgld, imgld->data, imgld->remaining_size);
> +	if (ret) {
> +		imgld->err_code = ret;
> +		goto modput_exit;
> +	}
> +
> +	imgld->progress = FPGA_IMAGE_PROG_WRITING;
> +	while (imgld->remaining_size) {
> +		ret = imgld->ops->write(imgld, imgld->data, offset,
> +					imgld->remaining_size);
> +		if (ret <= 0) {
> +			if (!ret) {
> +				dev_warn(&imgld->dev,
> +					 "write-op wrote zero data\n");
> +				ret = -FPGA_IMAGE_ERR_RW_ERROR;
> +			}
> +			imgld->err_code = -ret;
> +			goto done;
> +		}
> +
> +		imgld->remaining_size -= ret;
> +		offset += ret;
> +	}
> +
> +	imgld->progress = FPGA_IMAGE_PROG_PROGRAMMING;
> +	ret = imgld->ops->poll_complete(imgld);
> +	if (ret)
> +		imgld->err_code = ret;
> +
> +done:
> +	if (imgld->ops->cleanup)
> +		imgld->ops->cleanup(imgld);
> +
> +modput_exit:
> +	module_put(imgld->dev.parent->driver->owner);
> +
> +putdev_exit:
> +	put_device(&imgld->dev);
> +
> +idle_exit:
> +	/*
> +	 * Note: imgld->remaining_size is left unmodified here to provide
> +	 * additional information on errors. It will be reinitialized when
> +	 * the next image load begins.
> +	 */
> +	vfree(imgld->data);
> +	imgld->data = NULL;
> +	fpga_image_prog_complete(imgld);
> +}
> +
> +static int fpga_image_load_ioctl_write(struct fpga_image_load *imgld,
> +				       unsigned long arg)
> +{
> +	struct fpga_image_write wb;
> +	unsigned long minsz;
> +	u8 *buf;
> +
> +	if (imgld->driver_unload || imgld->progress != FPGA_IMAGE_PROG_IDLE)
> +		return -EBUSY;
> +
> +	minsz = offsetofend(struct fpga_image_write, buf);
> +	if (copy_from_user(&wb, (void __user *)arg, minsz))
> +		return -EFAULT;
> +
> +	if (wb.flags)
> +		return -EINVAL;
FYI: Static analysis flagged that wb.size is not being validated
before being used by vzalloc. It is a 32-bit unsigned value, so
size is probably not a concern. If there are size or alignment
constraints, they belong to the lower-level driver and should
be checked there. I propose to add a null check here:

+       if (!wb.size)
+               return -EINVAL;
+

I'll await more comments before I re-roll the patch set.

- Russ

> +
> +	buf = vzalloc(wb.size);
> +	if (!buf)
> +		return -ENOMEM;
> +
> +	if (copy_from_user(buf, u64_to_user_ptr(wb.buf), wb.size)) {
> +		vfree(buf);
> +		return -EFAULT;
> +	}
> +
> +	imgld->data = buf;
> +	imgld->remaining_size = wb.size;
> +	imgld->err_code = 0;
> +	imgld->progress = FPGA_IMAGE_PROG_STARTING;
> +	queue_work(system_long_wq, &imgld->work);
> +
> +	return 0;
> +}
> +
> +static long fpga_image_load_ioctl(struct file *filp, unsigned int cmd,
> +				  unsigned long arg)
> +{
> +	struct fpga_image_load *imgld = filp->private_data;
> +	int ret = -ENOTTY;
> +
> +	switch (cmd) {
> +	case FPGA_IMAGE_LOAD_WRITE:
> +		mutex_lock(&imgld->lock);
> +		ret = fpga_image_load_ioctl_write(imgld, arg);
> +		mutex_unlock(&imgld->lock);
> +		break;
> +	}
> +
> +	return ret;
> +}
> +
> +static int fpga_image_load_open(struct inode *inode, struct file *filp)
> +{
> +	struct fpga_image_load *imgld = container_of(inode->i_cdev,
> +						     struct fpga_image_load, cdev);
> +
> +	if (atomic_cmpxchg(&imgld->opened, 0, 1))
> +		return -EBUSY;
> +
> +	filp->private_data = imgld;
> +
> +	return 0;
> +}
> +
> +static int fpga_image_load_release(struct inode *inode, struct file *filp)
> +{
> +	struct fpga_image_load *imgld = filp->private_data;
> +
> +	mutex_lock(&imgld->lock);
> +	if (imgld->progress == FPGA_IMAGE_PROG_IDLE) {
> +		mutex_unlock(&imgld->lock);
> +		goto close_exit;
> +	}
> +
> +	mutex_unlock(&imgld->lock);
> +	flush_work(&imgld->work);
> +
> +close_exit:
> +	atomic_set(&imgld->opened, 0);
> +
> +	return 0;
> +}
> +
> +static const struct file_operations fpga_image_load_fops = {
> +	.owner = THIS_MODULE,
> +	.open = fpga_image_load_open,
> +	.release = fpga_image_load_release,
> +	.unlocked_ioctl = fpga_image_load_ioctl,
> +};
> +
>  /**
>   * fpga_image_load_register - create and register an FPGA Image Load Device
>   *
> @@ -35,6 +207,11 @@ fpga_image_load_register(struct device *parent,
>  	struct fpga_image_load *imgld;
>  	int ret;
>  
> +	if (!ops || !ops->prepare || !ops->write || !ops->poll_complete) {
> +		dev_err(parent, "Attempt to register without all required ops\n");
> +		return ERR_PTR(-ENOMEM);
> +	}
> +
>  	imgld = kzalloc(sizeof(*imgld), GFP_KERNEL);
>  	if (!imgld)
>  		return ERR_PTR(-ENOMEM);
> @@ -48,9 +225,13 @@ fpga_image_load_register(struct device *parent,
>  
>  	imgld->priv = priv;
>  	imgld->ops = ops;
> +	imgld->err_code = 0;
> +	imgld->progress = FPGA_IMAGE_PROG_IDLE;
> +	INIT_WORK(&imgld->work, fpga_image_do_load);
>  
>  	imgld->dev.class = fpga_image_load_class;
>  	imgld->dev.parent = parent;
> +	imgld->dev.devt = MKDEV(MAJOR(fpga_image_devt), imgld->dev.id);
>  
>  	ret = dev_set_name(&imgld->dev, "fpga_image_load%d", imgld->dev.id);
>  	if (ret) {
> @@ -65,6 +246,16 @@ fpga_image_load_register(struct device *parent,
>  		return ERR_PTR(ret);
>  	}
>  
> +	cdev_init(&imgld->cdev, &fpga_image_load_fops);
> +	imgld->cdev.owner = parent->driver->owner;
> +	cdev_set_parent(&imgld->cdev, &imgld->dev.kobj);
> +
> +	ret = cdev_add(&imgld->cdev, imgld->dev.devt, 1);
> +	if (ret) {
> +		put_device(&imgld->dev);
> +		return ERR_PTR(ret);
> +	}
> +
>  	return imgld;
>  
>  error_device:
> @@ -83,10 +274,23 @@ EXPORT_SYMBOL_GPL(fpga_image_load_register);
>   * @imgld: pointer to struct fpga_image_load
>   *
>   * This function is intended for use in the parent driver's remove()
> - * function.
> + * function. The driver_unload flag prevents new updates from starting
> + * once the unregister process has begun.
>   */
>  void fpga_image_load_unregister(struct fpga_image_load *imgld)
>  {
> +	mutex_lock(&imgld->lock);
> +	imgld->driver_unload = true;
> +	if (imgld->progress == FPGA_IMAGE_PROG_IDLE) {
> +		mutex_unlock(&imgld->lock);
> +		goto unregister;
> +	}
> +
> +	mutex_unlock(&imgld->lock);
> +	flush_work(&imgld->work);
> +
> +unregister:
> +	cdev_del(&imgld->cdev);
>  	device_unregister(&imgld->dev);
>  }
>  EXPORT_SYMBOL_GPL(fpga_image_load_unregister);
> @@ -101,19 +305,30 @@ static void fpga_image_load_dev_release(struct device *dev)
>  
>  static int __init fpga_image_load_class_init(void)
>  {
> +	int ret;
>  	pr_info("FPGA Image Load Framework\n");
>  
>  	fpga_image_load_class = class_create(THIS_MODULE, "fpga_image_load");
>  	if (IS_ERR(fpga_image_load_class))
>  		return PTR_ERR(fpga_image_load_class);
>  
> +	ret = alloc_chrdev_region(&fpga_image_devt, 0, MINORMASK,
> +				  "fpga_image_load");
> +	if (ret)
> +		goto exit_destroy_class;
> +
>  	fpga_image_load_class->dev_release = fpga_image_load_dev_release;
>  
>  	return 0;
> +
> +exit_destroy_class:
> +	class_destroy(fpga_image_load_class);
> +	return ret;
>  }
>  
>  static void __exit fpga_image_load_class_exit(void)
>  {
> +	unregister_chrdev_region(fpga_image_devt, MINORMASK);
>  	class_destroy(fpga_image_load_class);
>  	WARN_ON(!xa_empty(&fpga_image_load_xa));
>  }
> diff --git a/include/linux/fpga/fpga-image-load.h b/include/linux/fpga/fpga-image-load.h
> index 8b051c82ef5f..7b445f489644 100644
> --- a/include/linux/fpga/fpga-image-load.h
> +++ b/include/linux/fpga/fpga-image-load.h
> @@ -7,22 +7,49 @@
>  #ifndef _LINUX_FPGA_IMAGE_LOAD_H
>  #define _LINUX_FPGA_IMAGE_LOAD_H
>  
> +#include <linux/cdev.h>
>  #include <linux/device.h>
>  #include <linux/mutex.h>
>  #include <linux/types.h>
> +#include <uapi/linux/fpga-image-load.h>
>  
>  struct fpga_image_load;
>  
>  /**
>   * struct fpga_image_load_ops - device specific operations
> + * @prepare:		    Required: Prepare secure update
> + * @write:		    Required: The write() op receives the remaining
> + *			    size to be written and must return the actual
> + *			    size written or a negative error code. The write()
> + *			    op will be called repeatedly until all data is
> + *			    written.
> + * @poll_complete:	    Required: Check for the completion of the
> + *			    HW authentication/programming process.
> + * @cleanup:		    Optional: Complements the prepare()
> + *			    function and is called at the completion
> + *			    of the update, whether success or failure,
> + *			    if the prepare function succeeded.
>   */
>  struct fpga_image_load_ops {
> +	u32 (*prepare)(struct fpga_image_load *imgld, const u8 *data, u32 size);
> +	s32 (*write)(struct fpga_image_load *imgld, const u8 *data,
> +		     u32 offset, u32 size);
> +	u32 (*poll_complete)(struct fpga_image_load *imgld);
> +	void (*cleanup)(struct fpga_image_load *imgld);
>  };
>  
>  struct fpga_image_load {
>  	struct device dev;
> +	struct cdev cdev;
>  	const struct fpga_image_load_ops *ops;
>  	struct mutex lock;		/* protect data structure contents */
> +	atomic_t opened;
> +	struct work_struct work;
> +	const u8 *data;			/* pointer to update data */
> +	u32 remaining_size;		/* size remaining to transfer */
> +	u32 progress;
> +	u32 err_code;			/* image load error code */
> +	bool driver_unload;
>  	void *priv;
>  };
>  
> diff --git a/include/uapi/linux/fpga-image-load.h b/include/uapi/linux/fpga-image-load.h
> new file mode 100644
> index 000000000000..20eae3bb10d8
> --- /dev/null
> +++ b/include/uapi/linux/fpga-image-load.h
> @@ -0,0 +1,53 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +/*
> + * Header File for FPGA Image Load User API
> + *
> + * Copyright (C) 2019-2021 Intel Corporation, Inc.
> + *
> + */
> +
> +#ifndef _UAPI_LINUX_FPGA_IMAGE_LOAD_H
> +#define _UAPI_LINUX_FPGA_IMAGE_LOAD_H
> +
> +#include <linux/types.h>
> +#include <linux/ioctl.h>
> +
> +#define FPGA_IMAGE_LOAD_MAGIC 0xB9
> +
> +/* Image load progress codes */
> +#define FPGA_IMAGE_PROG_IDLE		0
> +#define FPGA_IMAGE_PROG_STARTING	1
> +#define FPGA_IMAGE_PROG_PREPARING	2
> +#define FPGA_IMAGE_PROG_WRITING		3
> +#define FPGA_IMAGE_PROG_PROGRAMMING	4
> +#define FPGA_IMAGE_PROG_MAX		5
> +
> +/* Image error progress codes */
> +#define FPGA_IMAGE_ERR_HW_ERROR		1
> +#define FPGA_IMAGE_ERR_TIMEOUT		2
> +#define FPGA_IMAGE_ERR_CANCELED		3
> +#define FPGA_IMAGE_ERR_BUSY		4
> +#define FPGA_IMAGE_ERR_INVALID_SIZE	5
> +#define FPGA_IMAGE_ERR_RW_ERROR		6
> +#define FPGA_IMAGE_ERR_WEAROUT		7
> +#define FPGA_IMAGE_ERR_MAX		8
> +
> +/**
> + * FPGA_IMAGE_LOAD_WRITE - _IOW(FPGA_IMAGE_LOAD_MAGIC, 0,
> + *				struct fpga_image_write)
> + *
> + * Upload a data buffer to the target device. The user must provide the
> + * data buffer and size.
> + *
> + * Return: 0 on success, -errno on failure.
> + */
> +struct fpga_image_write {
> +	/* Input */
> +	__u32 flags;		/* Zero for now */
> +	__u32 size;		/* Data size (in bytes) to be written */
> +	__u64 buf;		/* User space address of source data */
> +};
> +
> +#define FPGA_IMAGE_LOAD_WRITE	_IOW(FPGA_IMAGE_LOAD_MAGIC, 0, struct fpga_image_write)
> +
> +#endif /* _UAPI_LINUX_FPGA_IMAGE_LOAD_H */

