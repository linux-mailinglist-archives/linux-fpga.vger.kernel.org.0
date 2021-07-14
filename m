Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F8323C87FD
	for <lists+linux-fpga@lfdr.de>; Wed, 14 Jul 2021 17:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232399AbhGNPxU (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 14 Jul 2021 11:53:20 -0400
Received: from mga18.intel.com ([134.134.136.126]:58872 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239625AbhGNPxU (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 14 Jul 2021 11:53:20 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10045"; a="197643404"
X-IronPort-AV: E=Sophos;i="5.84,239,1620716400"; 
   d="scan'208";a="197643404"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2021 08:50:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,239,1620716400"; 
   d="scan'208";a="651062398"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by fmsmga006.fm.intel.com with ESMTP; 14 Jul 2021 08:50:27 -0700
Received: from orsmsx604.amr.corp.intel.com (10.22.229.17) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Wed, 14 Jul 2021 08:50:26 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Wed, 14 Jul 2021 08:50:26 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Wed, 14 Jul 2021 08:50:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AkLH9upVgaWmlpOtcZsuw/It72s8NTSngY2WGoF1clft9V3dBno/dAHrQHGYXaJ9MfwFSZMDgVhNunawjsJyMZdV0CT7lu5s8ofm60NAe7ON7U3DTQf7rt0kxgFMJD2Jfsz+BPrm0WPkmYTSayE02eSCzFRN7eVWPymWV0YN/myc9EpqCsiE/0oF1yD/kAPg+bS0c7ocKl8QaBgiB+WGl35gLb9TRMS91QQOKWP0flU/pC1GrZVbAGqSGkH3QdQdtWzduC9Mfo4SLWB7lSiB/ir6VWKIQ4JwTqa/6pzkMmASh4rmp0PVIvtRZkLuk94QvtFAuze9LvqE86mq3c68/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6HF7XdIpPoJSOYTkpZsADMUJGzg6Gkcn5m3YEOK5nvA=;
 b=kdNenf/bDBN8uP+mAuXjmjM8nXjG5bTbs9gY+o0H+6LaDRAZvSrj+Ijqwpw5Fo8cSIcafU+66R813FGUvQq8gIp3s5LustL2cdC6Pv5o7tB0eQnfHh+oitW2FAG5L9qDUGWFQU/l7jCncGTzBgSuIBmRWqm8hzwV1kLPRHY3hPyKZ6qBhKUCQJFSoQlSYlAFxCo4MaJrpahqQBN/SLzLoEW/QZpZRJ6LPBh+Ynr4Q6+a7WwKUUoza7C1uZzt9Uf+6BfRYZ4lyekGl2QhUWCB/iDg93jY9nqd0TFnufiBcj6OSGiNp5i4BpEkO0Togr1mJlgcMGkdlno78lR1OEd+gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6HF7XdIpPoJSOYTkpZsADMUJGzg6Gkcn5m3YEOK5nvA=;
 b=YQ3lnynIJhB7k1l3H1AIxWM11YUN/ZPwm9JM5sLouuvE8CHm8ojUnrm5Xh1VIxM3Ld1/055vdEqnM3zEt2t2ecbpYoj9TMONsknebYnUFlPtTFNnZrDuL6xo7ie37z+65DVNn+D/W/1eFIclfBb/8k59ffc4ZuQHwCBFN2LE5sI=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5156.namprd11.prod.outlook.com (2603:10b6:303:95::9)
 by MWHPR11MB0078.namprd11.prod.outlook.com (2603:10b6:301:67::38) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.23; Wed, 14 Jul
 2021 15:50:23 +0000
Received: from CO1PR11MB5156.namprd11.prod.outlook.com
 ([fe80::c17c:41b3:7c0d:c72a]) by CO1PR11MB5156.namprd11.prod.outlook.com
 ([fe80::c17c:41b3:7c0d:c72a%5]) with mapi id 15.20.4331.022; Wed, 14 Jul 2021
 15:50:23 +0000
Subject: Re: [PATCH v10 0/3] fpga: Use standard class dev_release function
To:     <mdf@kernel.org>, <linux-fpga@vger.kernel.org>
CC:     <trix@redhat.com>, <lgoncalv@redhat.com>, <yilun.xu@intel.com>,
        <hao.wu@intel.com>, <matthew.gerlach@intel.com>,
        <richard.gong@intel.com>
References: <20210709004206.244607-1-russell.h.weight@intel.com>
From:   Russ Weight <russell.h.weight@intel.com>
Message-ID: <347fc4ab-8749-045f-5e07-80ca76aa6925@intel.com>
Date:   Wed, 14 Jul 2021 08:50:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.8.1
In-Reply-To: <20210709004206.244607-1-russell.h.weight@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: MWHPR13CA0028.namprd13.prod.outlook.com
 (2603:10b6:300:95::14) To CO1PR11MB5156.namprd11.prod.outlook.com
 (2603:10b6:303:95::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.0.2.4] (50.43.42.212) by MWHPR13CA0028.namprd13.prod.outlook.com (2603:10b6:300:95::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.11 via Frontend Transport; Wed, 14 Jul 2021 15:50:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9801643b-efac-4e64-29aa-08d946df1771
X-MS-TrafficTypeDiagnostic: MWHPR11MB0078:
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR11MB00781EE15D485F6578C22E84C5139@MWHPR11MB0078.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iHF9qfFyRH5MA7kUUkM8OmeYeHDfphdaX3ikycumab3baDIkVRwawwd4NN7x03ZIeg7fXaIB4yModK2/mgFGQUY1ebh+ipJzMx0YExn3h75LCroyDh5SqmtV4HuZuNsUnby3UFsl5JoZkXTt1H+kMCabbRfe1oabQmaVlzelT2HGONr+hXLAwJJ6oGBxYjf9QOjE6YIt1YL+WrcHxe2R0Mo+cfvbed3coj5ZMTqCvfOoVToOFgS14G6+1FKPjUaQJVEW9T+pzFHJnSPPBdhAELVbq9JcDdp/k29HTb2CVDeBViUeRJYXR+BdFRdFU13dKt32eUaTkKeQi7KgqE9NXHQ8xTD0KcjzCd8a70vZhssqKr/lVdZSJfnC/tkZ5cK69CRXR2Nt06uBhEZ6GkddhgQ3DuZUlJQtt8uXKcEXatGA9mFGUkfDI5788nYGZBF2KLgMyr0pFc6yXL0ccsyRXL/OE3NmRme3Pv26D6639gCbdQkOZTg8a9OzkipmQ6BhUmvw5VMoulD56xwCSmJeyy9vaNiOEaNfZ6VfsysqgMI9r55Vf3UENPe3n2hp7NVHEN+zHROEgGKBfTKEs+H7CHeApDGPsm64ne6OEZYiUPQuMPNxOebsgOpGzqGC+dnBPNaQ2Qw+n7jp6u+B/oY0J4AJkURpbnSGinl+DaGt+YcIQWDXfkGLp5yaEmfStQjg8fllRTbVh0qnIhcsFoLOh7iV2syTkEtP06wM9F8AlDJsQQpCpw5ZDLaR3aGHj91LwXrPUa9sxAMb+MVEyvAp648F6W4U+jz/X9XQQWaq38gd0o/6EjfQe/A6Lt6+ck2j
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5156.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(366004)(376002)(39860400002)(396003)(5660300002)(956004)(2906002)(36756003)(66946007)(2616005)(31686004)(66476007)(8676002)(8936002)(66556008)(186003)(26005)(31696002)(478600001)(966005)(6486002)(86362001)(107886003)(316002)(83380400001)(38100700002)(4326008)(16576012)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Qmx2SkZpQ1prd0loajFPZkpEVHV3b3JPWnB6N2paejFxMmZzY1VBRDBQSjhl?=
 =?utf-8?B?ZjYrYjlwZHJJdVJYZVJhT084MXhQN0lwZzc3QmJlM2xKcWQ4UHlib3AxZFc4?=
 =?utf-8?B?TEYrdlQ1R0FFTjRTNmJzOGxOMGpRZzFEYjhpRFdLdklISVlLdXQ5RVV1dlpm?=
 =?utf-8?B?SnVBYVJDclgyMzk2ZFphOGtoaHk3bzhUaG1nVFRZcjJYRUZxMWY5bGVKdERG?=
 =?utf-8?B?V05GVGRhRVg3azFIMXdEVFltQWZRRGJFaEdKTXlrdkhDdGkzaTk0VWVtRHFi?=
 =?utf-8?B?cHBqeWk3MXVoQkx6M1N2d0E1TVhVS0J3ckM5VDUyY21ZK2N5ZlpzYTVIbGlQ?=
 =?utf-8?B?VStKVkdiaE1qYUNOYXhXYzB4aFF0TTVWQTFySEJIQ3MvVmRNWWxjWEZPWmJT?=
 =?utf-8?B?NTVuQTM5R2xmM0paeHp5MnlmSjhDYlNCVzB5OWdwSzFVaUJ3Q3RwQ3BSYmNH?=
 =?utf-8?B?WWd5QjVuNE5ZL2NtRGJ3UW5YNnJpNy9PM0JnZ2FCUUZQc0IxWEZGQXE3MmlS?=
 =?utf-8?B?dWcyY2tCeVFjODltRTNhN3NZU3JhdTlSb0l1QU42cDlqY2RLRjJieklhZzVV?=
 =?utf-8?B?dEJnS24rdTRQZUpmRjZuTnExMG4vMWpYcEpSUWtBaUN6UGlnTXVwWDV2SmhF?=
 =?utf-8?B?R084YzcyekxJR1NQVGYzNVBSQWYwcHFnYUxBL2hQbmJpS1J6Ty8xWWlFL0sr?=
 =?utf-8?B?Tmx0YmphYU9oOVM2REV6dEdoVVlONEREQmpHaWExWVF1bnRtVVBONzhlTHk0?=
 =?utf-8?B?OUZmeTBzcWZyUlgrbXN4OFB0TTdaQkpqRDNZYS8wa3RncXJJSmF5YW9KMnRC?=
 =?utf-8?B?RjRnTzJSTmdvM09BNnlwZHVEb292VlFoOWJsTFZHYzA3U09TZCtGQlMzVUJM?=
 =?utf-8?B?MytXd0VqNWI3eU5Ba09PaXVseGhsdUNublRoMVQ2L1FGa3FodHcvRTZ2UGMw?=
 =?utf-8?B?NURxU3RHNXQrSkpjc20vS0sza1h2OWluVENZWEQzQWJndVpVWFpWbllaNGV2?=
 =?utf-8?B?VHJQYjdLUmpGOE1zOVlvVDVZM2IvTnYydDJRZlJNZlVkRnVtbklxSWRyc3Ns?=
 =?utf-8?B?RktlaUU4ZXZiL21rR3Y1anFUS2hwTzNLWGRFU0k3TkZvTVV1MGhESVYvd1ZC?=
 =?utf-8?B?RTFMSm9sdk9zQU0zOHowd0M4MUdheVhGQmZPS0hoYWVVZms4bmg4bGN0Q0tT?=
 =?utf-8?B?dW5CU1ArcWV4Ym15aVV1YjZERnZFdGd1Vng1cGF6bVh3enJDMTVZZVFIMlpj?=
 =?utf-8?B?azJaWFl1ZDJHUkIvdjFIRzBJWnM0bEtnb3dDUXFrNmJEenpoRm9hMVdqRmJX?=
 =?utf-8?B?VnhHdEFFc2NmNWdCWnBLdEM1dENTMzdXcVhwaERheCtuRVlzQUdrZVhWQUdE?=
 =?utf-8?B?d2FWYWs0NXREYmw2NnhFeUpHMnA3N3FzQVhRbU9ySGhFWmhZWS9yNXBqdTlS?=
 =?utf-8?B?dHFNcGlRUWpTVVJoaUtPQzcwdWMrTFZ4Q3NFdEoxQTMwaWhKa3h2QkV5NmpG?=
 =?utf-8?B?ZktsS3NBV1g5emZUMmc4dEsrUmRVeUxkUHlnZGpjV2RPdmZjbGJheDRMQ1Ax?=
 =?utf-8?B?enVjcFZzN2poMDRnVmJPVlJWN01aSm5lZkZwams1S1JXM2E1aHBWWWxFZ2RN?=
 =?utf-8?B?RU1RNUVtazJoaWxocGZGeVVWOGJZSEwyZzlWdW83bmZNV3JDMHJHcERiNjNq?=
 =?utf-8?B?V08zd014d3hxcmlUME50REIwQ1VJS08rUTgrbmNGUk9RazhVUS83L2V2MFc2?=
 =?utf-8?Q?CIggQMTW7bppkjVrJH14PzXX8Fg8DwYcmsZMwtg?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9801643b-efac-4e64-29aa-08d946df1771
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5156.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2021 15:50:23.5963
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dt1ehqEUMih7/V38ZvbpKvu1FNX6kh3Fy7Rvmo5V7xRJSdlEaE23VDQ7Ku6Ecqdrlnx2KhXWftO/3S+6ltlE/jaHqnk9gPWrBhZ8qtEFf6k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB0078
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

It seems like these patches are stalled on the compat_id question (in other emails). My
two-cents: I don't see an issue with having two versions of the register functions, and
I don't consider the issue important enough to force a move of the compat_id field. I
think the compat_id issue should be considered separately.

Are there any other concers for these patches?

- Russ

On 7/8/21 5:42 PM, Russ Weight wrote:
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

