Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD1DE40A1A9
	for <lists+linux-fpga@lfdr.de>; Tue, 14 Sep 2021 01:42:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236793AbhIMXn0 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 13 Sep 2021 19:43:26 -0400
Received: from mga12.intel.com ([192.55.52.136]:26797 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236079AbhIMXnZ (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 13 Sep 2021 19:43:25 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10106"; a="201329895"
X-IronPort-AV: E=Sophos;i="5.85,291,1624345200"; 
   d="scan'208";a="201329895"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2021 16:42:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,291,1624345200"; 
   d="scan'208";a="528420565"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga004.fm.intel.com with ESMTP; 13 Sep 2021 16:42:06 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Mon, 13 Sep 2021 16:42:05 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Mon, 13 Sep 2021 16:42:05 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Mon, 13 Sep 2021 16:42:05 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Mon, 13 Sep 2021 16:42:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ADxKinBWmsO2fJuok0yK7PfJFy4H86lVqcFz3G/0cIdTLWbeIpktzZ/XgX+k9EtTKrRJIU9XW/aurLvxVTN5xnZeAK0daQKYUQFfQbe0mSV2biahkka5o0CzEH4tuubu9BH8OpJiAI1BZlMS7caVJGLm9NcUZgrSPWvOzVwb/s+A8M7hw0hEU2JnGeh4ZNOV4X3nAouQpD+h53ILOJrHc5wmypfXh4BDXfhGFcM+/OOZUOVHorPQZ3sLKDgQbLAl5xIboJhpoflIlkcWTUsGB4m1nsjisZvokq6+brvW6TdQxc+O2et+ve617DUsYzDLmNMxxLI9D2rVJTkqpvlEuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=opSzFIOYlF37Ty7VkXJI6so2yMeXzQsF6UJzUoBkg+Q=;
 b=W9lqIYijRRxWPUNaLFX8esemsbe6y9k57seOP1FEDmUW4nit+39y6lv7acV5tMbpPkm7GXXKeGQp1cWNvG51pPilMV4DVn/fNx37fmCFsofab6WBBWR4qWPyw+e0xJxzLvlAB41ZXG7Qs8Fv49U+SM0o3kgHSk0Siy2M0XJIUpKocrJzl0LcIwpstUeJsrr24fkpSyIEp/i3eZT5wN26Rvh+uF8OyorzIdyaVOsIWDG1pDcYuE1Kw5nm4Zg8EJErlc46nT9VuvJVPSlcAWHQQ9eLBl4KimrWx/2nnxw+uDJ9QGmzNpsiMKaolth0OGhDCfyhUuBz/1RFMGwoGRaZ3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=opSzFIOYlF37Ty7VkXJI6so2yMeXzQsF6UJzUoBkg+Q=;
 b=Hpzt5bsh0g9dSf0+4MUhRRVFdPnJNgMTz3sV2VdULvIIqn1arc1PUJqOzl3An6SEak2vdExHWAYK074vDFqCcTIJDVPyPkcqplGKLGaE/k6GnxCRIauA9etbDFnobZzCgnHicTTWvWuesP4+IHH74OnJeXtL9tTJspBsxxqRhAA=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
Received: from SA2PR11MB5163.namprd11.prod.outlook.com (2603:10b6:806:113::20)
 by SN6PR11MB3038.namprd11.prod.outlook.com (2603:10b6:805:cd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.24; Mon, 13 Sep
 2021 23:42:02 +0000
Received: from SA2PR11MB5163.namprd11.prod.outlook.com
 ([fe80::90de:46c1:4d23:5c8c]) by SA2PR11MB5163.namprd11.prod.outlook.com
 ([fe80::90de:46c1:4d23:5c8c%6]) with mapi id 15.20.4500.019; Mon, 13 Sep 2021
 23:42:02 +0000
Subject: Re: [PATCH v11 0/3] fpga: Use standard class dev_release function
To:     <mdf@kernel.org>, <linux-fpga@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <trix@redhat.com>, <lgoncalv@redhat.com>, <yilun.xu@intel.com>,
        <hao.wu@intel.com>, <matthew.gerlach@intel.com>,
        <richard.gong@intel.com>
References: <20210913231232.65944-1-russell.h.weight@intel.com>
From:   Russ Weight <russell.h.weight@intel.com>
Message-ID: <49498bbe-f3ae-4882-e3bc-aea3ce550cb5@intel.com>
Date:   Mon, 13 Sep 2021 16:41:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
In-Reply-To: <20210913231232.65944-1-russell.h.weight@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: MWHPR2001CA0022.namprd20.prod.outlook.com
 (2603:10b6:301:15::32) To SA2PR11MB5163.namprd11.prod.outlook.com
 (2603:10b6:806:113::20)
MIME-Version: 1.0
Received: from [10.0.2.4] (50.43.42.212) by MWHPR2001CA0022.namprd20.prod.outlook.com (2603:10b6:301:15::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend Transport; Mon, 13 Sep 2021 23:42:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3d24c9e3-8344-471e-cbf2-08d977101656
X-MS-TrafficTypeDiagnostic: SN6PR11MB3038:
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR11MB30385B1EF4779A8491892F0EC5D99@SN6PR11MB3038.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KBB6sxte7OWryJ/kS5v65R4RtLfzQHNC3ra5M3bVdjbIKlw8kwEKOLUq8P64KCo5sVnhO92fVYCdP4qRa2rP1b0WqExvQH50XP4sCmilNzwbP39WqQfuIMC3UQgU+cn3ciNnLdsiVqcout1WpUw4wYPOe+7TX4uLetfo0YeeHbS9T3t/EkIcKmhjth4L1hpyrxKFCg+zhZ2Wjy0qAUfmznT439TIVj3J34G/ZZUhi7/c+dUWK0wTeiss3/AVsZsAz/WOU18Y8k0q27AZsfEyzLKYiPl3cyf5AmGXBBA1PNsxnMyQo+DxlsSlFwtJh3/LFmzD3ijXmawxeUngNnN2P31KFNHuGwxJl4DCydjJwyGfKaTzYsj5MnU2E/sZu0lnTBGUmLOPnF9M9SuKGL2r3yaSkS4gg5Ik/J31cHsor4ogFLcLoygZtVPFrNdjjEx0uP2KdVAmEemPnmWh4lrjeqMXH34L3HEHznRdS1Pb4t9Hv0vgK6inXlDzSDPlWossyBDNPdA7MVqhXqSeuqtkyDl31GmxoP75LeVeaWOHG//Ldg2icAjTtRUUJvaExXmhCx2E1eOShxa9CqPphua4Ilo6wUhuR6lQBEYZLD2ZnLkCLraH/22WEuXQI8bPRv7z3lTUpN+R2GZ+uiwspNv3W7rk2x8QgkwAnbJuG1Q0HYlNiQWGnOjc9un1o7J8x2mndWPZaciISmK1KaEOFMpxqX3bGufEu1CHWq/4q7gucbbZpJKz+u3X+AJPz5AWkDendW+AbzM5HwEEemSpNO9KrxWzXOU6xjf1cJNgr4aKRu5rXyW8zakpgGAW7BHY9SyuEhO0ALockH/KMrZ6kVWE+5V86KQNf8J4t6EuEuLN1i0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB5163.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(396003)(39860400002)(136003)(346002)(478600001)(38100700002)(66476007)(66946007)(6666004)(66556008)(31686004)(316002)(2906002)(5660300002)(6486002)(8936002)(956004)(26005)(8676002)(966005)(83380400001)(86362001)(31696002)(53546011)(2616005)(4326008)(107886003)(16576012)(36756003)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QmpiclZGYkVtY3gwSHBNTVZ2Q2paWktqSFlWVy9aR0NibTRCVG1wVHhjUFhn?=
 =?utf-8?B?N2g5cEpDS2xLdk9sTTdoYUVwYnRFODdGa2crT2lZdkpNK0IrN0F1NVFvbWJR?=
 =?utf-8?B?UzZ6K3VSSjFIV1IyMW41L0VHTUlRVGZwZ0tkTE11aU13ZFpQcEZNUG5ZQ1Fh?=
 =?utf-8?B?aGxmQWFDUWJBZXNDdi9sTlJLS2hJWXdrVzQ4cXhha3Rkci8ycXFhV2pGR3Nm?=
 =?utf-8?B?b2xjKzRwUEZXdTY5SGRKOG1VeEhaTWoxY0hJNzIyRVJxZW5FVlB1K3JreUlq?=
 =?utf-8?B?UU1GcjQwWGdON2NxWDV6Wk1YWTNBaEFWbGxYVElJNFpZeUhpdFRGUzJZSjJo?=
 =?utf-8?B?UTlDQ3N5bHI4RnpUT1hNWG1vTEFwdXhRcU85M1FXNGlkUnA0bmJQMk91QWNP?=
 =?utf-8?B?dzVBRVZCdGR2LytkbTF3ZGE1NytWMTlGTnI3NGl4cGhxTUtsUzZaTllkRGo4?=
 =?utf-8?B?THpjeEFoNWFDV3p4akVzd3ExSUZFNVcxOURGY1hXVzZ5TVpVYlN4VHdPWk9C?=
 =?utf-8?B?K0xCVFozNFJvYy9Ga1NrRzh2Z1RnaE5FWkVxYzFvN0liSXlJWmM0RzdGbWRi?=
 =?utf-8?B?bmlRM1FuVmNkZmdIa3FSWHY3MGI5dEVvOHpwNzMzRzFLM05zdVBsY3VUcjBM?=
 =?utf-8?B?TmxUTG9ZZmpGYldHckw3bERFTDd3OFgrYzRVSjZha09xTGljQ0d1akV2VkRh?=
 =?utf-8?B?ZnFPd0w3VHNCWUx2YlpHU3pXcmdQQzkybjBKUGNUYUlyNHZtdmZwVWhuc1Jy?=
 =?utf-8?B?VU9lT2Q5MWpQNUZwTS9EYkVzK0pOelZZU01UdVpCK0M5T3ZidEpIOU1LcWZj?=
 =?utf-8?B?MllkdzdRV1VqN0J1V1pvTWg2K2FDOTRiREljTWwwUHJYTUkyOXhNd0d4Wnhr?=
 =?utf-8?B?Y21wcklqdVI2OXA3TW9LTmY2dTc5b2ZNNGg1S01FZWp5dGJReGhaaWdvQ3dL?=
 =?utf-8?B?cG9nVEJsbGo3Z3ZaV1A5RlpiQWRqQ2s2d1BwOXJ5aHNpUlp1UkwvOU81VHZF?=
 =?utf-8?B?d1ZYVzZSYzNmSjVrWTNUUWlzQnZ1V1RMbEswY2tVN2dqa0ZuVXRQQ01TOGNp?=
 =?utf-8?B?SUtndktvTHpWaXc0MXBHT2loejg0eFNCTVRNMkxlamd6TEhFYTVPWUNndGx1?=
 =?utf-8?B?b3VZd1FHNzRjT2QzV2xlcUhjdTBLMGFPYzU2LzREaGNiVlB6TWNkaFQ1V2Fp?=
 =?utf-8?B?SXlsaXQwSExYdFhHcmZLVy9WVk1QdXUzYXFDcHdLT3JyS3Nkd1hSZytMNjF5?=
 =?utf-8?B?bGYxR3ErcjJZblpKTlEyNXJOdHRjOUxhQlVxK3J4WWlMR3puTzluTCtET3hH?=
 =?utf-8?B?VDFjT0RLVUpYRlpQbXlNK0tSZFdhZVNOUlBDSWVHYnRGbnA5QUx4OWZrTWFp?=
 =?utf-8?B?YWdNQU1JSjNoRTM2WVdWTFdGbVdtNkY3RThwUW0wUGlzSE9nK1V2T20ycHVx?=
 =?utf-8?B?WUtBM3BaV1NZTytIYWJIZWFERTRNSkN4VGJtSlRNV2tBMWdkdTFGcDdETWhL?=
 =?utf-8?B?bVpFajFVWVdEem1EY0l5ZTFkdVpuVmt2RFUzRzBhWEpVMVpJSlVBM25jTVRv?=
 =?utf-8?B?UlBjTGNDamNlejhYRUtqQStHYU9RQWZGSVlwUTByOUJGeHFaZ21PbTBlMjUy?=
 =?utf-8?B?VW4xM2RBWHdKVWQwRVRwbG5ZT1RiZGdmSGVad2pzQWx1MjBlVy90aXdTN29H?=
 =?utf-8?B?RDQwUEk5NHIwQm5Cem1HL1BQQ1ZUcUN2OXZQQXY4V1VVRFJ4NmtQRERFS2JO?=
 =?utf-8?Q?tCQz9L5yJUx2DxUtzliHAm8aWsCpHH+3+9sKkEu?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d24c9e3-8344-471e-cbf2-08d977101656
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB5163.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2021 23:42:02.8968
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZEu8aHM6i3n/UX0SfCnijuazrUKXfpDcIYnSt6HtWTJhXo3+iCF83hl6NDnvqy3GX0gTZvP9CdBieGDA/+WvuiN/FTRzq0b0syI81Po4Zrk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3038
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Moritz,

This is a simple rebase onto the latest linux-next. There was one conflict
in the fpga-mgr code, but otherwise everything applied cleanly. There are
still some differences of opinion on having two flavors of the API (simple
and full). I'm happy to do things either way. I don't think we are going
to arrive at a consensus. Do you want to make a call on this? Are you OK
with the patches as they are? Or should I change to a single register()
function that receives the info structure pointer as a parameter?

Here is a link to the first relevant email in the unresolved discussion.

https://marc.info/?l=linux-fpga&m=162733756310598&w=2

Please let me know if you would like me to make additional changes.

- Russ

On 9/13/21 4:12 PM, Russ Weight wrote:
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
> Changelog v10 -> v11:
>   - Rebased to latest linux-next
>   - Resolved a single conflict in fpga-mgr.c with associated with  wrapper
>     function: fpga_mgr_state(mgr)
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

