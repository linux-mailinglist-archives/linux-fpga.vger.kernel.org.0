Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A519C3D68B5
	for <lists+linux-fpga@lfdr.de>; Mon, 26 Jul 2021 23:33:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbhGZUxK (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 26 Jul 2021 16:53:10 -0400
Received: from mga18.intel.com ([134.134.136.126]:37186 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229489AbhGZUxK (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 26 Jul 2021 16:53:10 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10057"; a="199549585"
X-IronPort-AV: E=Sophos;i="5.84,272,1620716400"; 
   d="scan'208";a="199549585"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2021 14:33:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,272,1620716400"; 
   d="scan'208";a="566312384"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by orsmga004.jf.intel.com with ESMTP; 26 Jul 2021 14:33:37 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Mon, 26 Jul 2021 14:33:37 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Mon, 26 Jul 2021 14:33:36 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Mon, 26 Jul 2021 14:33:36 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.171)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Mon, 26 Jul 2021 14:33:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dwq05vnEXtA4bNQDkA46/BnJ3V1PLQZ/Pu+h7Ctc7uKREQ5ye2q5E/LQfwd9glDoW1ZNbzsykZMZZDGoLiEzdZCdytEaOqaSnhMECkR6LxKReQs6uZ2Q/ZyPMc+jOfSsiwjYcxqgjXtWY7Jzl16RT53fg+MTdaHGGNAjmfnWjA/LNvHDmXDxKiUeC2dAEzJuR0JxensKxhJ5kfYeaOawVBZdbDxsCweVwOwtmzj+BQJxJ4mOB4E8JkySG8scS04dzXwdE/Enuzo0I43q3jVNrJoChe/kCMgdcJSS6SMhXMOnuMZHBYoeIfbYeMwcQy6FIZchqP+OmmHtJI4MmSOa0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tdl3o40kWsQWaYmCAf5/F0sOi/c8LSXOx/mUqq55mnQ=;
 b=PW7XKuf/SOLq3dIqsM3xCsKc27Js0r0NV/gyjTc5CdERo68q/qWYpBgAGuE5ExJed/H7rwxwaQcjyn3xQnvhT03OY9Sdq1NYkSYo61AYxwlw1uN/E0jy4DOz51RMHIhNA8+2U0pUrv0+DefiInLFdejXCWHFssoX4ZqVmq86YsgAbUuF/9ZgZiHfpfGPoybLRf+REMA+reZKlMgKengLg6jILmz1hYOCLrgd/TvSiqvje9Gi/JHpdj/pelhEGtipc6qSk650Q7AHpqyjK3dw2eDXzq5u3tUvRtMWNxq9fEhd7newYSbviisXdgRSxUSEA99M3PP6YaPIk4coIWmUuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tdl3o40kWsQWaYmCAf5/F0sOi/c8LSXOx/mUqq55mnQ=;
 b=qrPoGpbWPBTF85ZlEv/0ebULb8JtndMyCkJJd7+7KpIk//LTPes5kiSeN6/tc58TtO1sHIGRoiI9c71g6OWrjMzKfUUTSNlSIIfAVC9syrLCOP+2FvGbRgpznON8p5T+iJDzciHwuteGn2NoECv6l0r9j2Al/1wNrvG7hsNMXAs=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
Received: from SA2PR11MB5163.namprd11.prod.outlook.com (2603:10b6:806:113::20)
 by SA2PR11MB4825.namprd11.prod.outlook.com (2603:10b6:806:111::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.25; Mon, 26 Jul
 2021 21:33:32 +0000
Received: from SA2PR11MB5163.namprd11.prod.outlook.com
 ([fe80::51db:698d:e2e3:7fc8]) by SA2PR11MB5163.namprd11.prod.outlook.com
 ([fe80::51db:698d:e2e3:7fc8%4]) with mapi id 15.20.4352.031; Mon, 26 Jul 2021
 21:33:32 +0000
Subject: Re: [RESEND PATCH v10 0/3] fpga: Use standard class dev_release
 function
To:     <mdf@kernel.org>, <linux-fpga@vger.kernel.org>
CC:     <trix@redhat.com>, <lgoncalv@redhat.com>, <yilun.xu@intel.com>,
        <hao.wu@intel.com>, <matthew.gerlach@intel.com>,
        <richard.gong@intel.com>
References: <20210726212750.121293-1-russell.h.weight@intel.com>
From:   Russ Weight <russell.h.weight@intel.com>
Message-ID: <39607b02-bad3-0f65-c1c8-efd6036ab4f3@intel.com>
Date:   Mon, 26 Jul 2021 14:33:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.11.0
In-Reply-To: <20210726212750.121293-1-russell.h.weight@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: SJ0PR03CA0175.namprd03.prod.outlook.com
 (2603:10b6:a03:338::30) To SA2PR11MB5163.namprd11.prod.outlook.com
 (2603:10b6:806:113::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.0.2.4] (50.43.42.212) by SJ0PR03CA0175.namprd03.prod.outlook.com (2603:10b6:a03:338::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.26 via Frontend Transport; Mon, 26 Jul 2021 21:33:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ed8bfc53-3db8-4832-7294-08d9507d03f7
X-MS-TrafficTypeDiagnostic: SA2PR11MB4825:
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA2PR11MB48255A908933F744FA465799C5E89@SA2PR11MB4825.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XsH+PXpaz6dB9/DBKRzjjwSvUMAv+gfGX5KDdsAYS5AYOkY8UUVFPuyPofJ2GY2m7bYZvEr+PQn6NSNhkJecyeGWZcKcEIilH+HDNuVTw2ofGAIpxs6Ma5nENLsu/ERcJgOfs7IAZYoyQzaK9ti4hqeWR+j5ZsM99g3SXKfpjGa7/9nvc1FFw9yOafLc6OjnRsY6WmOHQS3oWfN6Y/mbN/1xg8Cpd37WZFvxVVrhW0VhJAXpp1kN4fcRL2UiKHgMUySrgNbl+DGxi6lQ2DvxdcerLLIq0ar2D0jp0K0YsWb/hgVDbsBtNNNh/UAxTxHLgT/i3dZ2PuaM4M3MCEBI0gpABgnGGqlESIa2+qQ0OtrlFea1ArC/rl/vE7Y3Pr50eC+zkQQzaUFvVHvYkBcM4D1EN3dpxdcEQFXdP6VuYbVs8Cw7l/6/APln9G7sStMCgIC21MYegVWuFAl280cNd1Goj7e2Zp4g0hB++U+hbtWbHHt1PpLgA10UMjB7GYQrRlzJKNXjVnxVF6ODhwwa0XMYlV9uV5ggMT3MXi17iuHq/U30sq1SpRe62RVlMwaErnnWB0bdglVxTupi6VlwFnkQzIDXsEZzOFARtTbtIk7d5gf6vY2WZR+M32/wHin74YCE2C6XrwRzuxKjNg58MbYh0I+B2LtgeRObyC4kq0WmEqwjvs+NskEhhDmXF/lKOHbhhSdRRXYuiBxYEQZDS9s5mkKC5+vt9WSZAQMRRB/fzpnoYtdVv3HqLJ+3+3LJ2CFPmWG5vTYHZLiWkEvFIK+k38V7aCwFocuYVSzLeW1rHXQBgsYuY+ut0fSUyr+h
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB5163.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(83380400001)(66946007)(2906002)(8936002)(8676002)(16576012)(38100700002)(31686004)(186003)(4326008)(66556008)(66476007)(6486002)(107886003)(53546011)(36756003)(508600001)(316002)(2616005)(31696002)(966005)(26005)(956004)(86362001)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NEFkQzRCR2RuVktYZXZhdTZoYzdTUVVxTHdsZFRkdWVIajFlbGJ0MnFrdVJs?=
 =?utf-8?B?c09nTmJmVUU4SVFJeEh4YjMvRjVrdTZyTStHSGM2VU1Xb0Ixc2M0Y1RVLzZP?=
 =?utf-8?B?bzIzemp1Z2NzeUlwRndLK1V6TExWQXlrcXpWY0grLzlVM2JFWFd6VndScUVo?=
 =?utf-8?B?c256QzhpUUVTcGFpUmdmVmZ1eXIvcVd2WCtDUEx1VXJFU28xMDRWY2k2WmxH?=
 =?utf-8?B?TDFiZThlVU15TkVxS0xodlMxVUJHWlhyK2xBS1o3cFE5QjhHNVMrYWc4c2Zv?=
 =?utf-8?B?SHdiejdFL1d6UkFwdjUzdzVnZlcybkZMRER1dUgvcTRpV3cxNkdhQ0U3cDJP?=
 =?utf-8?B?aVoyREFEMHl3SUZGbjJ1cExCbkYwRHh3cE5LdzRVN1RCM21GS0twR21mWFJP?=
 =?utf-8?B?cTVkZ093a1RTSzNWNi9nNmI3Zy94M0dOUlduVWtwazVPeURHY0xUZUdwQm1q?=
 =?utf-8?B?aVVpSlpUT1FpQTJRYTRMN1lpbG1Qb1RYcVp4c3hyZVlYWFluQWwzZDBZSzVD?=
 =?utf-8?B?UC9HQm0rNEQyS0M5ZjAwL05TejUyZGJQcXNTVGovOEdKN1MvcXRTZjJ4cGFw?=
 =?utf-8?B?M0h3RzhRVmhSekhZTnZBVnpDaUtsWCtFT2orQVU4bHFJSHRZenlQaVlNd3Rs?=
 =?utf-8?B?M0REV0x3Z2VrZDlueG1iWnF1ektnNmhKaTlHOERVWWhrV0Z6ai9tSUtIQll6?=
 =?utf-8?B?cThhenBVdTc1alVtOU5iV0EvM3JYK3RRa1ZaK0JFNXljbWt6Mksra0ZhSEZ6?=
 =?utf-8?B?enFBWTJxd3JWd3ZrS2ZJbHFjTTUwK1ZXWERBRU9FNDNycngwZGRrRVFUN2NT?=
 =?utf-8?B?eUI3cWxYRkIwNTg5RExETHBuaFVaTDIzYjVKdkdvN1ZabWMxWVMvdy9Fajgw?=
 =?utf-8?B?MCtEUFNnd3VOejVvVUdoaytWOHN2UzNSelMxQStFcXJEdVFjeVhOWmM2S3RF?=
 =?utf-8?B?UWxyanJZcUV0d2w0V1VpQlJRZWYxNkUvWExkVjRqQWZsZmwrazhJcTkvZkgz?=
 =?utf-8?B?bmtqcVBYdE13eERFV0FUOENhNTY3cUc1TXd6VmwrTEtJcnhwdkZiT1JSMmRX?=
 =?utf-8?B?Rlh1YWlIZkR5N0pzYW1TNmlFeXBVczRhL3J3ekh5R20yTnB1Yng1VDkzSkRp?=
 =?utf-8?B?a3dPSG1OZVpBdy91dnU0NEFzZE5rbHdtQ0xZbDJPT3lSYkk1TFNwZzZIMFEv?=
 =?utf-8?B?YWNCdTNzZTRuNFlybXVNZ3BjaEhhZCtJR1F0Y3NDMWl1RDhQR1p4NitDUkdq?=
 =?utf-8?B?SFdYc25EN2RsbnFMM0pBcXdwZ3RGNUhhRmY4Mlo0RTNnR2RBUHRaNjgrM3E3?=
 =?utf-8?B?RlArY0Z4Wkl2MndramRkbkJOREU1SU9JNVRRT0lhMDczcFdnUkVrdTNlY2U3?=
 =?utf-8?B?VFdKNWM1WEFJOTFMdDJ3RVdGbTVwWWlmdkx4Qy9na3poeU1RVFVMQXAyYTNh?=
 =?utf-8?B?Z2lrU2VNVXd3SEsvY1pTdy9md2NYTnF3R3VoUW5mWUJjTU9NcEFIT3p0Vysz?=
 =?utf-8?B?OFdhV05SdzNlVFg0NC9CVDk4V2pJWnBPNmc5UzhSK3cybXVucDYrV1h0aGpP?=
 =?utf-8?B?VE5QbTNqV2pEZ2RiMVpYR0dLRzBGMUJMWnZVVEJVMW9hV3RHYWtyeFRQQzVS?=
 =?utf-8?B?dEdkMHRqdXVYSVFmS3ZleGdjcTVORzFRV25mOFZKMnl0ZVVpODJFVmxpUVE5?=
 =?utf-8?B?aWJkOE1sZ0ZTZTM2eFMvTXZ6ejFVaEhXZk41Qm5pQ1VEY3FXTGw5YUUvSEVS?=
 =?utf-8?Q?BE0/MNbp3q1LNSjSnY7c1X+QqVAoNiiLf51Hw7H?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ed8bfc53-3db8-4832-7294-08d9507d03f7
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB5163.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2021 21:33:31.9080
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PdQJTvHO98itxj3N5RB6ghoDRggx3EVgJ0D9wVePKuk5GDt6NiL8xNN88puvyFgjBMbnmwPxAUNl79r6JBydUrDBAjzrUh8OXUXAN3O0ShI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4825
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Moritz,

I sent this version of the patchset out on July 8th. The only discussion has
been around the compat-id structure. I think there is agreement that this can
be treated separately. What are your thoughts? Do you think this patchset is
ready?

Thanks,
- Russ


On 7/26/21 2:27 PM, Russ Weight wrote:
> The FPGA framework has a convention of using managed resource functions
> to allow parent drivers to manage the data structures allocated by the
> class drivers. They use an empty *_dev_release() function to satisfy the
> class driver.
>
> This is inconsistent with linux driver model.
>
> These changes remove the managed resource functions and populate the class
> dev_release callback functions. They also merge the create() and register()
> functions into a single register() or register_full() function for each of
> the fpga-mgr, fpga-region, and fpga-bridge class drivers.
>
> The new *register_full() functions accept an info data structure to provide
> flexibility in passing optional parameters. The *register() functions
> support the legacy parameter list for users that don't require the use of
> optional parameters.
>
> For more context, refer to this email thread:
>
> https://marc.info/?l=linux-fpga&m=162127412218557&w=2
>
> I turned on the configs assocated with each of the modified files, but I
> must have been missing some dependencies, because not all of them compiled.
> I did a run-time test specifically with the dfl-fme infrastructure. This
> would have exercised the region, bridge, and fpga-mgr frameworks.
>
> Changelog v9 -> v10:
>   - Fixed commit messages to reference register_full() instead of
>     register_simple().
>   - Removed the fpga_bridge_register_full() function, because there is
>     not need for it yet. Updated the documentation and commit message
>     accordingly.
>   - Updated documentation to reference the fpga_manager_info and
>     fpga_region_info structures.
>
> Changelog v8 -> v9:
>   - Cleaned up documentation for the FPGA Manager, Bridge, and Region
>     register functions
>   - Renamed fpga_*_register() to fpga_*_register_full()
>   - Renamed fpga_*_register_simple() to fpga_*_register()
>   - Renamed devm_fpga_mgr_register() to devm_fpga_mgr_register_full()
>   - Renamed devm_fpga_mgr_register_simple() to devm_fpga_mgr_register()
>
> Changelog v7 -> v8:
>   - Added reviewed-by tags.
>   - Updated Documentation/driver-api/fpga/ files: fpga-mgr.rst,
>     fpga-bridge.rst, and fpga-region.rst.
>
> Changelog v6 -> v7:
>   - Update the commit messages to describe the new parameters for the
>     *register() functions and to mention the *register_simple() functions.
>   - Fix function prototypes in header file to rename dev to parent.
>   - Make use of the PTR_ERR_OR_ZERO() macro when possible.
>   - Some cleanup of comments.
>   - Update function definitions/prototypes to apply const to the new info
>     parameter.
>   - Verify that info->br_ops is non-null in the fpga_bridge_register()
>     function.
>   - Verify a non-null info pointer in the fpga_region_register() function.
>
> Changelog v5 -> v6:
>   - Moved FPGA manager/bridge/region optional parameters out of the ops
>     structure and back into the FPGA class driver structure.
>   - Changed fpga_*_register() function parameters to accept an info data
>     structure to provide flexibility in passing optional parameters.
>   - Added fpga_*_register_simple() functions to support current parameters
>     for users that don't require use of optional parameters.
>
> Changelog v4 -> v5:
>   - Rebased on top of recently accepted patches.
>   - Removed compat_id from the fpga_mgr_register() parameter list
>     and added it to the fpga_manager_ops structure. This also required
>     dynamically allocating the dfl-fme-ops structure in order to add
>     the appropriate compat_id.
>   - Created the fpga_region_ops data structure which is optionally passed
>     to fpga_region_register(). compat_id, the get_bridges() pointer, and
>     the priv pointer are included in the fpga_region_ops structure.
>
> Changelog v3 -> v4:
>   - Added the compat_id parameter to fpga_mgr_register() and
>     devm_fpga_mgr_register() to ensure that the compat_id is set before
>     the device_register() call.
>   - Added the compat_id parameter to fpga_region_register() to ensure
>     that the compat_id is set before the device_register() call.
>   - Modified the dfl_fpga_feature_devs_enumerate() function to restore
>     the fpga_region_register() call to the correct location.
>
> Changelog v2 -> v3:
>   - Cleaned up comment headers for fpga_mgr_register(), fpga_bridge_register(),
>     and fpga_region_register().
>   - Fixed error return on ida_simple_get() failure for fpga_mgr_register(),
>     fpga_bridge_register(), and fpga_region_register().
>   - Fixed error return value for fpga_bridge_register(): ERR_PTR(ret) instead
>     of NULL.
>
> Changelog v1 -> v2:
>   - Restored devm_fpga_mgr_register() functionality to the fpga-mgr
>     class driver, adapted for the combined create/register functionality.
>   - All previous callers of devm_fpga_mgr_register() will continue to call
>     devm_fpga_mgr_register().
>   - replaced unnecessary ternary operators in return statements with
>     standard if conditions.
>
> Russ Weight (3):
>   fpga: mgr: Use standard dev_release for class driver
>   fpga: bridge: Use standard dev_release for class driver
>   fpga: region: Use standard dev_release for class driver
>
>  Documentation/driver-api/fpga/fpga-bridge.rst |   6 +-
>  Documentation/driver-api/fpga/fpga-mgr.rst    |  38 +++-
>  Documentation/driver-api/fpga/fpga-region.rst |  12 +-
>  drivers/fpga/altera-cvp.c                     |  12 +-
>  drivers/fpga/altera-fpga2sdram.c              |  12 +-
>  drivers/fpga/altera-freeze-bridge.c           |  10 +-
>  drivers/fpga/altera-hps2fpga.c                |  12 +-
>  drivers/fpga/altera-pr-ip-core.c              |   7 +-
>  drivers/fpga/altera-ps-spi.c                  |   9 +-
>  drivers/fpga/dfl-fme-br.c                     |  10 +-
>  drivers/fpga/dfl-fme-mgr.c                    |  22 +-
>  drivers/fpga/dfl-fme-region.c                 |  17 +-
>  drivers/fpga/dfl.c                            |  12 +-
>  drivers/fpga/fpga-bridge.c                    | 122 +++-------
>  drivers/fpga/fpga-mgr.c                       | 215 ++++++++----------
>  drivers/fpga/fpga-region.c                    | 119 ++++------
>  drivers/fpga/ice40-spi.c                      |   9 +-
>  drivers/fpga/machxo2-spi.c                    |   9 +-
>  drivers/fpga/of-fpga-region.c                 |  10 +-
>  drivers/fpga/socfpga-a10.c                    |  16 +-
>  drivers/fpga/socfpga.c                        |   9 +-
>  drivers/fpga/stratix10-soc.c                  |  16 +-
>  drivers/fpga/ts73xx-fpga.c                    |   9 +-
>  drivers/fpga/xilinx-pr-decoupler.c            |  17 +-
>  drivers/fpga/xilinx-spi.c                     |  11 +-
>  drivers/fpga/zynq-fpga.c                      |  16 +-
>  drivers/fpga/zynqmp-fpga.c                    |   9 +-
>  include/linux/fpga/fpga-bridge.h              |  30 ++-
>  include/linux/fpga/fpga-mgr.h                 |  62 +++--
>  include/linux/fpga/fpga-region.h              |  36 ++-
>  30 files changed, 383 insertions(+), 511 deletions(-)
>

