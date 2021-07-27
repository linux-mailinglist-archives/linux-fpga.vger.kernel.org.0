Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E56AE3D7AC5
	for <lists+linux-fpga@lfdr.de>; Tue, 27 Jul 2021 18:17:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbhG0QRL (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 27 Jul 2021 12:17:11 -0400
Received: from mga12.intel.com ([192.55.52.136]:29244 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230111AbhG0QQD (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 27 Jul 2021 12:16:03 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10057"; a="192073247"
X-IronPort-AV: E=Sophos;i="5.84,274,1620716400"; 
   d="scan'208";a="192073247"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2021 09:16:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,274,1620716400"; 
   d="scan'208";a="434782270"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga002.jf.intel.com with ESMTP; 27 Jul 2021 09:16:01 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Tue, 27 Jul 2021 09:16:00 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Tue, 27 Jul 2021 09:16:00 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.171)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Tue, 27 Jul 2021 09:16:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UpCGf2jjCnHQreu40195SVSOb+0jAW+ap/avwmypFNPGjvv7HjFf3Fjxzxo9FhErLPOjtCOXV/wJ0dxsXGpW+IYuhbWbpjJaPHGZB3ZHwqOp/p2zV5fCoNozqY7SH/jE0MeQwq0/4vjt5KugDgDl+MmeSqN7xnhJHahuB5fyCUleSUP2IGpf0eMsYmxRzTbXpq5G9X5QJLC2An6IfyrTsJMHlktmrQPUlKg/LkRjqpH5KQ+wcDguGzKkP/i9TAYtNXM7O+Eil9JqX/dKHkN5F/hHtewXjCiAfbfZnlFlue4mnloSQ9AcQwt1JsmzaObu4X7zNdaGsoTDEAOClHeqdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uybbt/Cw1RMtV5AcMPeYaOpA5Q8u42hD7ylqy7qfj48=;
 b=K+fWPFeutaRrVUO2cJ5A53r0C0qyHYHwJ/ZI3Z0HL9qWux142YjT+MbNSxgszfgykHBiE3lrYucV0o53Kf44gSbUtn3Tvv1qYuBfutwWZO2IOrqLP1qy4sgzjDmZeGaIrLidFFDnYtIDLYpmz7prs5caCq3HFjFo3ZLMmkAlGK9fLVUhTkBMlLO36jK8khx0rfatzJeJYyCwKEkQsXa2EBK94PErPO9AHWl6RDZ+BpmEH4nzATdnwy8xKJ7APJmeEgUCPl1ynqhcVLRVq31cS+yGSX+UNkEF8xkpjSbPRWGZdVKQs1asZ4kDoCgxmeXUB4XKwWhUhcDknToM9j/4mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uybbt/Cw1RMtV5AcMPeYaOpA5Q8u42hD7ylqy7qfj48=;
 b=ARwpYyA/Dkls7K9mjRakSlU0/2Fz8QVZoB8SqnRAUkPGzv3DyBCRynisoK22fnCxe0fOlmpePK4+MI6qPhI5q8N90Pa8de3Wx75yRcWGZ7zXzqdBDogjhadgHBtF6+RA6ELPfYTPwkQWBHHs8rdIbW0mcuDW7WaPJ2wRLMJYh+U=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
Received: from SA2PR11MB5163.namprd11.prod.outlook.com (2603:10b6:806:113::20)
 by SN6PR11MB2717.namprd11.prod.outlook.com (2603:10b6:805:60::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18; Tue, 27 Jul
 2021 16:15:57 +0000
Received: from SA2PR11MB5163.namprd11.prod.outlook.com
 ([fe80::51db:698d:e2e3:7fc8]) by SA2PR11MB5163.namprd11.prod.outlook.com
 ([fe80::51db:698d:e2e3:7fc8%4]) with mapi id 15.20.4352.031; Tue, 27 Jul 2021
 16:15:57 +0000
Subject: Re: [RESEND PATCH v10 0/3] fpga: Use standard class dev_release
 function
To:     Tom Rix <trix@redhat.com>, <mdf@kernel.org>,
        <linux-fpga@vger.kernel.org>, "Wu, Hao" <hao.wu@intel.com>
CC:     <lgoncalv@redhat.com>, <yilun.xu@intel.com>,
        <matthew.gerlach@intel.com>, <richard.gong@intel.com>
References: <20210726212750.121293-1-russell.h.weight@intel.com>
 <39607b02-bad3-0f65-c1c8-efd6036ab4f3@intel.com>
 <661d53d0-0ba4-d344-8da0-995a9b612905@redhat.com>
From:   Russ Weight <russell.h.weight@intel.com>
Message-ID: <f8c391e2-987a-916a-a0e9-7795f71ec76d@intel.com>
Date:   Tue, 27 Jul 2021 09:15:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.11.0
In-Reply-To: <661d53d0-0ba4-d344-8da0-995a9b612905@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: MW4PR04CA0006.namprd04.prod.outlook.com
 (2603:10b6:303:69::11) To SA2PR11MB5163.namprd11.prod.outlook.com
 (2603:10b6:806:113::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.0.2.4] (50.43.42.212) by MW4PR04CA0006.namprd04.prod.outlook.com (2603:10b6:303:69::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.29 via Frontend Transport; Tue, 27 Jul 2021 16:15:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 64acdb6b-b73f-4d6a-d1ce-08d95119d0ce
X-MS-TrafficTypeDiagnostic: SN6PR11MB2717:
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR11MB27178397E0AFAF5683EF36C1C5E99@SN6PR11MB2717.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kx9Q/ot1d2g8oNUKVusGhADkWZC1owelYZBv/u4+hehfxCC9UOLy3E+H0yogncEpMc8H4YtI5xqFZNWc6ZnG8GvOz1IyXDSZ0ViTkDGPF6bRNP6oZwA5fkjJqms3wuIUSlFx6Qm7ZocVsbs/6IUI37gP+ikxoX2V2VIFGI8VxYJKrIn9cOdummSSUCqzIUJYBmLoz5Rp71V67X4xXdasHpPbpEqX3DHmeoJkjZmTZiZNnW9afmEgUmwpPByVYfyz4tEu5VDFIdSjMxV81e+xeD3VQ98gNtWjKErffXuAHMXw6R4tpmPWC2gTaY6xYOODbn+iRI8qcgY/W9qNeCs49T/SaS5nO0CbvS90ei4at1nBmATeslWMJDkdujZxoa7W5iXnYoniP60JxGv48WKilP/PLPNcGwYutXGaieIxoLE6BN3pd8AnsD0NupzdXKa64tgb/Y9oDU1na2MymdcLpElAXst1+NUMQgAHwWyWaM+zux8LVxcMeG/KAIEcbRXBkfIDQ1NNkm/Iuk1hFiL/duag0O1kW8L2WzJDNQRrjuQH64dByUpmLTzDC9ssjveZjAyaKk/TsFHypxSKSRatvhnI8f96HlFaC8nl6mSPVOngQTYfV1sWLFeUGeUgDB4dEeQwrswsNaN9/Qp0x3vQsdsBpXpuYTokoeQKfWeZalyyeE1rj9ed9OKNPBICTf0byInUiY60WtQg5f+MqXfrohDJXuJfuqZ9MpWfB89UqLZIo4tsve1cCrA/6CGcVeQRvq+ns1De/X0CE1JlXonZEiRizjb5eSyynSRHGcBzOlK+WRy655OZHAtzwFuASEMie38hF46x2SaK7h6N6lvobzG8KB8dHk0oqHfTWJ5nEm8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB5163.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6486002)(5660300002)(8936002)(31696002)(45080400002)(316002)(16576012)(2906002)(66946007)(31686004)(66476007)(66556008)(6636002)(110136005)(508600001)(186003)(83380400001)(26005)(956004)(86362001)(53546011)(4326008)(2616005)(38100700002)(966005)(8676002)(36756003)(107886003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NGpUZW4zMk9XalJ0bGkvMkd1NFBWdzVmejlTWUljcGlFelIrT2JpUVQySVY2?=
 =?utf-8?B?Q1JzUGt1MEs5aW5XdmozVHVUYlZMejVtTStZblRYVWs3Zm5HZjlSWWRaOTd0?=
 =?utf-8?B?WU42dkZDdERCVWQrd05DV2FDS1hHU3lQV1R3RnQ1Zm9TTUR5eDRSVml2U21x?=
 =?utf-8?B?ZkRCcnlYciswMzY5SFZ0UzdUS0lXWjNONTRwbjFOZTFzMlVIVmp5UFk4dDcz?=
 =?utf-8?B?Y3p4UFJKaVkxQ3pUNVBJcXJtQnFESUR6YUhWUW1LdjN0QnAxVkRpc2lOcHdy?=
 =?utf-8?B?Q3hONkUxRjh0eDhseWl6Vm5pY3hEK3pGd2pVMW54ZjlibVpMUUZwaWhOYVZB?=
 =?utf-8?B?RktwbnBwYW9JaVd4Tmo5L09jdmNBQ1pTbWIxQ0JCa3RsUFMyTU5NUnJWZnAw?=
 =?utf-8?B?VjNCTEtXeFh3L016bHpBVk8rVWpsMU1WT1FSMHh1QlZxYnMvM3ZIazVQcnBm?=
 =?utf-8?B?cUZWOG16NHRGK0Z5Y2hzWGttd1RLclR6RTdEMGE0SE9ZdFBSNndNS1g5c0Ur?=
 =?utf-8?B?VlNqdXNSMytVNWkySnpSM25CR0lZZy9CbmdRZlRKOFZlWGczV25CV3hTdzdP?=
 =?utf-8?B?alhSeXdmbFNhZEx3RFZkZVd4bXJnaXM2TndrUVBGai9vNDVGL0RRenQ4VU1o?=
 =?utf-8?B?RXlQUWc1elRNUzhmTU1oRU94dEgxNGR5T2ZYekVoTEVaUjZVaWdEYW5Uem1L?=
 =?utf-8?B?eVZmL2NNaVoxMUY5eHFwRFZra2Y0ZlQ0V0tWaEYzRGlNQUh3N0c2VmQyWGZY?=
 =?utf-8?B?VmZ6T2lyQ0NoTUJtVzFsd0tVUk1BVFIvSXlXdSt3S2ZXUTI1Y3ZBOHAranU4?=
 =?utf-8?B?SENYL2c2ZmlmQ0Z3Q0VscHhnRUh4UUxNZzFWdmRQMkxxYWYySWhBbTFETFpP?=
 =?utf-8?B?ZG9OaDhVdnpIaGdJQUpPZmcvWnMzNE13WFc2WUEvYzFScHdJbTlncGNla2Jx?=
 =?utf-8?B?azBuVGdJZ3pLUnRjeGJING5rMy9SREtSaUtUbnE0eUx6YjhXeFdYdE1aZVg2?=
 =?utf-8?B?eit5MnVIbEt4YUJzQWZ5SXUvdHFzYVlPMGVMbk5FY05STUtPU21LdElhaXVO?=
 =?utf-8?B?SjZIeHBQbUM0azF3c29lZTNnelkyRS9OM0VnRktpWlI2SHVyK3E2YVdrMnAz?=
 =?utf-8?B?Qm5aMU5rcEtGdHM2TlpvVWk3cnNkWDZYTGxiUHFqQVdIbyszYkVGUThPSldE?=
 =?utf-8?B?YXdiUk9NQTEwRERycGVHcDhXOC9IYUhod3g4dHdoanlId0F1aEs5MjNCdU9U?=
 =?utf-8?B?eUxNSWJvZDVsWkhvblYrNlJYUk1McWdzaGx6TjUxS0hRdEptSDRaSmRjdnRN?=
 =?utf-8?B?TmNjYnFIYWgvMU9qdWtPQnc0c3FQMlhGdlloSUlyYko2L0svbzFuUVl6OW1o?=
 =?utf-8?B?Vk9SUXpQY2lGU3U3aENFaXNOdXhlUjdUZ1ZObzc4Z3prWXJXN3NGSm5YV2Js?=
 =?utf-8?B?aFNNVFJCYThhKytMYlc3aEFhNDk1ZnpNUXU0eTBXZmlTZk0wZFFYY2FYQ2JZ?=
 =?utf-8?B?ZW9Xa3lwbHBHWk9BS0VYdU9YZlpWMEpQRHN6bTQ1ZkxqUUNMUVkzczd0cHVs?=
 =?utf-8?B?ZzdqdTRabmFUMTYxM0pXR1V0dklBaEZTYVQzelpjUEVBUVBZdDF6WitNZUsx?=
 =?utf-8?B?R1FOMGhIL1lKUGVtc241ekdiN0FuZXpQL0dkQUJ6RC9XYW96cTFIZUhiamQ0?=
 =?utf-8?B?SG1QSTc1S3J5aU1JcUZVWXQ1ZlI1OG9EaWpiUkFKSTBhRDdFdi9odEUyUmlT?=
 =?utf-8?Q?UkBj8NxBNjeXrALboSsZd+S2zPtUo5xQAQf6AQ/?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 64acdb6b-b73f-4d6a-d1ce-08d95119d0ce
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB5163.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2021 16:15:57.0924
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kyOhC9a9RlkjpahhTPHIK/ycC7qVXxhmPhtCzMV53ObS0A7EvByHzmq0/BlyLCEBRqk3YUdEIja7jcYlx9ryYYb1sWo2iRfwjW/qOhx3O4I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2717
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On 7/27/21 6:24 AM, Tom Rix wrote:
>
> On 7/26/21 2:33 PM, Russ Weight wrote:
>> Hi Moritz,
>>
>> I sent this version of the patchset out on July 8th. The only discussion has
>> been around the compat-id structure. I think there is agreement that this can
>> be treated separately. What are your thoughts? Do you think this patchset is
>> ready?
>
> While I agree the compat_id can be treated separately, i still have a problem with the 2 register functions.
>
> In this discussion,
>
> https://lore.kernel.org/linux-fpga/DM6PR11MB38194D113950FA4B75C7F2C485E49@DM6PR11MB3819.namprd11.prod.outlook.com/
>
> *register_full(..., *info) becomes
>
> *register(..., *info)
>
> and
>
> *register_simple() is moved out of the public api and becomes private to the subsystem.

Somehow I missed that part of the email. I'm not sure I understand the part about
register_simple() "becomes private to the subsystem". Most users would call the simple
version of the API. Is the proposal to replicate the register_simple() interface
for each driver that calls it?

> Tom
>
>>
>> Thanks,
>> - Russ
>>
>>
>> On 7/26/21 2:27 PM, Russ Weight wrote:
>>> The FPGA framework has a convention of using managed resource functions
>>> to allow parent drivers to manage the data structures allocated by the
>>> class drivers. They use an empty *_dev_release() function to satisfy the
>>> class driver.
>>>
>>> This is inconsistent with linux driver model.
>>>
>>> These changes remove the managed resource functions and populate the class
>>> dev_release callback functions. They also merge the create() and register()
>>> functions into a single register() or register_full() function for each of
>>> the fpga-mgr, fpga-region, and fpga-bridge class drivers.
>>>
>>> The new *register_full() functions accept an info data structure to provide
>>> flexibility in passing optional parameters. The *register() functions
>>> support the legacy parameter list for users that don't require the use of
>>> optional parameters.
>>>
>>> For more context, refer to this email thread:
>>>
>>> https://marc.info/?l=linux-fpga&m=162127412218557&w=2
>>>
>>> I turned on the configs assocated with each of the modified files, but I
>>> must have been missing some dependencies, because not all of them compiled.
>>> I did a run-time test specifically with the dfl-fme infrastructure. This
>>> would have exercised the region, bridge, and fpga-mgr frameworks.
>>>
>>> Changelog v9 -> v10:
>>>    - Fixed commit messages to reference register_full() instead of
>>>      register_simple().
>>>    - Removed the fpga_bridge_register_full() function, because there is
>>>      not need for it yet. Updated the documentation and commit message
>>>      accordingly.
>>>    - Updated documentation to reference the fpga_manager_info and
>>>      fpga_region_info structures.
>>>
>>> Changelog v8 -> v9:
>>>    - Cleaned up documentation for the FPGA Manager, Bridge, and Region
>>>      register functions
>>>    - Renamed fpga_*_register() to fpga_*_register_full()
>>>    - Renamed fpga_*_register_simple() to fpga_*_register()
>>>    - Renamed devm_fpga_mgr_register() to devm_fpga_mgr_register_full()
>>>    - Renamed devm_fpga_mgr_register_simple() to devm_fpga_mgr_register()
>>>
>>> Changelog v7 -> v8:
>>>    - Added reviewed-by tags.
>>>    - Updated Documentation/driver-api/fpga/ files: fpga-mgr.rst,
>>>      fpga-bridge.rst, and fpga-region.rst.
>>>
>>> Changelog v6 -> v7:
>>>    - Update the commit messages to describe the new parameters for the
>>>      *register() functions and to mention the *register_simple() functions.
>>>    - Fix function prototypes in header file to rename dev to parent.
>>>    - Make use of the PTR_ERR_OR_ZERO() macro when possible.
>>>    - Some cleanup of comments.
>>>    - Update function definitions/prototypes to apply const to the new info
>>>      parameter.
>>>    - Verify that info->br_ops is non-null in the fpga_bridge_register()
>>>      function.
>>>    - Verify a non-null info pointer in the fpga_region_register() function.
>>>
>>> Changelog v5 -> v6:
>>>    - Moved FPGA manager/bridge/region optional parameters out of the ops
>>>      structure and back into the FPGA class driver structure.
>>>    - Changed fpga_*_register() function parameters to accept an info data
>>>      structure to provide flexibility in passing optional parameters.
>>>    - Added fpga_*_register_simple() functions to support current parameters
>>>      for users that don't require use of optional parameters.
>>>
>>> Changelog v4 -> v5:
>>>    - Rebased on top of recently accepted patches.
>>>    - Removed compat_id from the fpga_mgr_register() parameter list
>>>      and added it to the fpga_manager_ops structure. This also required
>>>      dynamically allocating the dfl-fme-ops structure in order to add
>>>      the appropriate compat_id.
>>>    - Created the fpga_region_ops data structure which is optionally passed
>>>      to fpga_region_register(). compat_id, the get_bridges() pointer, and
>>>      the priv pointer are included in the fpga_region_ops structure.
>>>
>>> Changelog v3 -> v4:
>>>    - Added the compat_id parameter to fpga_mgr_register() and
>>>      devm_fpga_mgr_register() to ensure that the compat_id is set before
>>>      the device_register() call.
>>>    - Added the compat_id parameter to fpga_region_register() to ensure
>>>      that the compat_id is set before the device_register() call.
>>>    - Modified the dfl_fpga_feature_devs_enumerate() function to restore
>>>      the fpga_region_register() call to the correct location.
>>>
>>> Changelog v2 -> v3:
>>>    - Cleaned up comment headers for fpga_mgr_register(), fpga_bridge_register(),
>>>      and fpga_region_register().
>>>    - Fixed error return on ida_simple_get() failure for fpga_mgr_register(),
>>>      fpga_bridge_register(), and fpga_region_register().
>>>    - Fixed error return value for fpga_bridge_register(): ERR_PTR(ret) instead
>>>      of NULL.
>>>
>>> Changelog v1 -> v2:
>>>    - Restored devm_fpga_mgr_register() functionality to the fpga-mgr
>>>      class driver, adapted for the combined create/register functionality.
>>>    - All previous callers of devm_fpga_mgr_register() will continue to call
>>>      devm_fpga_mgr_register().
>>>    - replaced unnecessary ternary operators in return statements with
>>>      standard if conditions.
>>>
>>> Russ Weight (3):
>>>    fpga: mgr: Use standard dev_release for class driver
>>>    fpga: bridge: Use standard dev_release for class driver
>>>    fpga: region: Use standard dev_release for class driver
>>>
>>>   Documentation/driver-api/fpga/fpga-bridge.rst |   6 +-
>>>   Documentation/driver-api/fpga/fpga-mgr.rst    |  38 +++-
>>>   Documentation/driver-api/fpga/fpga-region.rst |  12 +-
>>>   drivers/fpga/altera-cvp.c                     |  12 +-
>>>   drivers/fpga/altera-fpga2sdram.c              |  12 +-
>>>   drivers/fpga/altera-freeze-bridge.c           |  10 +-
>>>   drivers/fpga/altera-hps2fpga.c                |  12 +-
>>>   drivers/fpga/altera-pr-ip-core.c              |   7 +-
>>>   drivers/fpga/altera-ps-spi.c                  |   9 +-
>>>   drivers/fpga/dfl-fme-br.c                     |  10 +-
>>>   drivers/fpga/dfl-fme-mgr.c                    |  22 +-
>>>   drivers/fpga/dfl-fme-region.c                 |  17 +-
>>>   drivers/fpga/dfl.c                            |  12 +-
>>>   drivers/fpga/fpga-bridge.c                    | 122 +++-------
>>>   drivers/fpga/fpga-mgr.c                       | 215 ++++++++----------
>>>   drivers/fpga/fpga-region.c                    | 119 ++++------
>>>   drivers/fpga/ice40-spi.c                      |   9 +-
>>>   drivers/fpga/machxo2-spi.c                    |   9 +-
>>>   drivers/fpga/of-fpga-region.c                 |  10 +-
>>>   drivers/fpga/socfpga-a10.c                    |  16 +-
>>>   drivers/fpga/socfpga.c                        |   9 +-
>>>   drivers/fpga/stratix10-soc.c                  |  16 +-
>>>   drivers/fpga/ts73xx-fpga.c                    |   9 +-
>>>   drivers/fpga/xilinx-pr-decoupler.c            |  17 +-
>>>   drivers/fpga/xilinx-spi.c                     |  11 +-
>>>   drivers/fpga/zynq-fpga.c                      |  16 +-
>>>   drivers/fpga/zynqmp-fpga.c                    |   9 +-
>>>   include/linux/fpga/fpga-bridge.h              |  30 ++-
>>>   include/linux/fpga/fpga-mgr.h                 |  62 +++--
>>>   include/linux/fpga/fpga-region.h              |  36 ++-
>>>   30 files changed, 383 insertions(+), 511 deletions(-)
>>>
>

