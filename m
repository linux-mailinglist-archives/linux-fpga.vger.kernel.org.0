Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C75242FA62
	for <lists+linux-fpga@lfdr.de>; Fri, 15 Oct 2021 19:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241440AbhJORhQ (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 15 Oct 2021 13:37:16 -0400
Received: from mga02.intel.com ([134.134.136.20]:10438 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238060AbhJORhL (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 15 Oct 2021 13:37:11 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10138"; a="215121574"
X-IronPort-AV: E=Sophos;i="5.85,376,1624345200"; 
   d="scan'208";a="215121574"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2021 10:35:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,376,1624345200"; 
   d="scan'208";a="593043410"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by orsmga004.jf.intel.com with ESMTP; 15 Oct 2021 10:35:04 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Fri, 15 Oct 2021 10:35:04 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Fri, 15 Oct 2021 10:35:04 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Fri, 15 Oct 2021 10:35:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SHUvSIYHkfumk5gS07bw3CkDic7FLiIFDeDKvk0QPvQAwUbuepvJ+QQPzqthu3G9o2LOtmRtB0APg69K7u/JDt4eGSHMOTekfA7vC/RCtvp8HZ6HR8Zv1cK4qL/V8o1BL2oFnyK3GhUppQhzX+UeWf00YQhCm7F5SwWgYLZd/fHRvYXS/LCx2S1kZxwIaAY3zlH/MdS2voKZkvDk/5JGHfDWCmQHoovbaKmRb3wI43PsKUNcCHZzR1EW4Rm+yq75x/wROV9WPJUNz4PlBTvsUeLYMlMIGt9RkDjnfQsJARDVmDKo/omYdjgMNY9ldMIgFc07GydrmpvcxzjT0hUVCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uWVm3wtVWvD1jmuO6AG/8YGuvyTP4UART9GkfC/WRAI=;
 b=Ot6NcXyZnQp8FQBb4CgO3DmrXR7RbUy5YJzDeKD33IanyDNqaKi/BuPmIraGDBbsE45rrR1cVetx3Cby+cxD2RCgayh1I46dzcDt44QDCAYFzKnz98r2AiKqhSGm4WTQopvlXCXffxxfkMgD6wRmWOTgxkcElMOI+utT3QXX94mC+Hz+t74kt7fe4aWKeNbsiW2P0XR8q0ICCpombiyFC+VmMeCY2ptY3Jf9SudzqWctI+aVLqVG3jKdI0JvfCT6NlXeNDt9NZpkcB9McOLrg9C3sdVFNkOwM/uMQ/POD8lTM+oLbf1Bq2Zv8bwChPtSqcsIgb+JZIgMDiUBe31BFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uWVm3wtVWvD1jmuO6AG/8YGuvyTP4UART9GkfC/WRAI=;
 b=S8hEf1V2C9eN8LmQOZG8hj136SwV/pbXq5VwwHyDzK8RXWmN4rHP2NF2H3OdprSDwYZpGBr81OkXqAgmhahZ9Yf8ViLyN2uydHqUgA8OHY//kxNAoDj9Qh5FNNx71GGFRKSjFDfsOOnVDKZb2CNP1e+BisnlJV2kZhDNA3NSjJ8=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
Received: from SA2PR11MB5163.namprd11.prod.outlook.com (2603:10b6:806:113::20)
 by SA2PR11MB4777.namprd11.prod.outlook.com (2603:10b6:806:115::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.17; Fri, 15 Oct
 2021 17:35:01 +0000
Received: from SA2PR11MB5163.namprd11.prod.outlook.com
 ([fe80::a039:c121:4dce:5def]) by SA2PR11MB5163.namprd11.prod.outlook.com
 ([fe80::a039:c121:4dce:5def%8]) with mapi id 15.20.4587.026; Fri, 15 Oct 2021
 17:35:01 +0000
Subject: Re: [PATCH v17 0/5] FPGA Image Load (previously Security Manager)
To:     Xu Yilun <yilun.xu@intel.com>
CC:     Tom Rix <trix@redhat.com>, <mdf@kernel.org>,
        <linux-fpga@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lgoncalv@redhat.com>, <hao.wu@intel.com>,
        <matthew.gerlach@intel.com>
References: <450ed897-f726-9671-26b7-2a24bb046e89@redhat.com>
 <20211011014154.GA82360@yilunxu-OptiPlex-7050>
 <79350773-3629-2734-21c0-0314a762e722@redhat.com>
 <336e4827-b09a-e1ab-b67d-d8755012d71c@intel.com>
 <20211012074752.GB95330@yilunxu-OptiPlex-7050>
 <e629eca0-a86c-4028-7bbf-65185699137b@intel.com>
 <20211013010617.GE95330@yilunxu-OptiPlex-7050>
 <58036b2d-ca8f-2deb-f1b4-0301d633714b@intel.com>
 <20211014014947.GF95330@yilunxu-OptiPlex-7050>
 <7d1971d0-b50b-077f-2a82-83d822cd2ad7@intel.com>
 <20211015025140.GH95330@yilunxu-OptiPlex-7050>
From:   Russ Weight <russell.h.weight@intel.com>
Message-ID: <2b26bea5-60d3-6763-00e8-9a94fa0bf45b@intel.com>
Date:   Fri, 15 Oct 2021 10:34:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
In-Reply-To: <20211015025140.GH95330@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: BY3PR05CA0001.namprd05.prod.outlook.com
 (2603:10b6:a03:254::6) To SA2PR11MB5163.namprd11.prod.outlook.com
 (2603:10b6:806:113::20)
MIME-Version: 1.0
Received: from [10.0.2.4] (50.43.42.212) by BY3PR05CA0001.namprd05.prod.outlook.com (2603:10b6:a03:254::6) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.10 via Frontend Transport; Fri, 15 Oct 2021 17:35:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 37f9c55c-4602-4039-1abc-08d990021d7c
X-MS-TrafficTypeDiagnostic: SA2PR11MB4777:
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA2PR11MB4777FA2D4C7B163F68ED8723C5B99@SA2PR11MB4777.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oVkN9j/K/WiQmXoivcoWJnNU9V8xe7q1RCJJZv8soUoJBYOPyO2UeqQtSLzzeDtfrvnkg0B1mGKiCEPmiDxe+e+CH6sk6bHbYLxq1djBLjfg1RtoSFokOyMUNWK8268zuZKFzIoyL/9KPHfylhIwRCe8gbuO6ysMc6w1yq9fVUDvP3XFDiahe9xIk1f4u07VKqOCZlxW3In9FxXp6B64IFZF0ACeXB8tqrAfdMfJR0HlyRsRXI8wrX6QIExR4MFIxN2sKTbagRFrKnz+NttkMXAlwbGu+Gn3tf9L1zCtpUixxI/RlW3kiBMDBsqUWe+JH37XZjc2cznRA1vDjQLPqGAF9qnBYaLRiMpfxuWw6CqAPTXrdfNTnpfF7ni2sMQVD/vK6fJbGgiea15fTYrS58fUie0rj3FEfvLxzY2KaJpAQ5LIa9wY7H8b3Rqgz1neJ0/vvjhzkiUOWGZLf6qvq1aw9Mo+X8UY/oiN9EgcYAOXorDHHquoRfN98WjDx80LNYPQ+WF9vy6/cSKfuIuged4UE3zsffWCpm8APengkLOFE5alRjXrGTYAMaHq4qCSHO9k1Ey7IGgZ1PfXii3Jv/GDZ2jRf4CrkPsjwuY++37NsfYEExi2B+i4W0YuI4VIS2CgKiEK7xnS7O3pIp2Rc1eBI8z0mX0ROL7ba+ziv4dH2hqI4VO4ggyIuUWXAOjzb8DT5UL19HoH10bag053UDQ0XKkC33SF8Kte6BHmrzMeb1VlaNqjD1mbwh7Tv0oaG/fT50jmboKbSdgRaap8ClejZupcQkBnTj2y7vAC/rsgTTMyTB2J5eVBKMe3f0W0Z2FkXmlL8O454p7lGZxkmeQ7K3+QDYRYe8J8B3/lOg0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB5163.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(31686004)(37006003)(316002)(15650500001)(36756003)(6636002)(16576012)(86362001)(508600001)(26005)(5660300002)(53546011)(8936002)(31696002)(8676002)(966005)(66476007)(66556008)(66946007)(186003)(6862004)(30864003)(2616005)(83380400001)(956004)(6666004)(2906002)(4326008)(82960400001)(6486002)(107886003)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L1U3bnhHRERnakdvNEZ2ckowNEYxeE1xOGpyczZpWUovUTNtSlUrSU9BV1Zv?=
 =?utf-8?B?UHJEZEZkalhoTktFSnFSZUxVcWY2UXY4V05yc2tvMUp0d0pBUjZtWS9qSzZu?=
 =?utf-8?B?Smx5ajRjcHR5WUMwVGEvcnVwQWI2dTVHbmtjeEJVTG5WOHFuUmxPbDJyT09h?=
 =?utf-8?B?VHV0SmVnUkJhUzZqbERsejc3NWhYZkw5blNBZjhBaEI5L2NER2JZLzNGTG95?=
 =?utf-8?B?TUJDR1E3a2JqWVJ4eDcyM1YvUEs1QUVpbWUrMXRNSFJuTlVUdmpNYXVXSGhL?=
 =?utf-8?B?RWE4QXVrYzJtM1BOeVFrbDhNa0czWHU2ell1aHAvcWVZYUZGRTV2dUVjb1No?=
 =?utf-8?B?enNrVW85bEV1MG5SQUNqQ0lSVnlVdm1XTHEzamRJMFZGNWZteVcrMmpTWW5r?=
 =?utf-8?B?RzFXMG5oN2hnbGt2cnFVdzFEaXVIMldEV3dTT0ViaVJ1OVFSNmZWcVJzUTBV?=
 =?utf-8?B?Yk5ZcHQ0UVdodmc4MUVaazBwcU80ZzM4UmgrM3o3Wmd3SzBwdHc2TGNFTTRX?=
 =?utf-8?B?aVA0TGxGbHFvR3dQcW1lRElIR3E0UzNjNzV2OGJnMTloZmhHUmZNeURLRjBL?=
 =?utf-8?B?dGY0dlNnbXNxZ2VRQjh4dTFDRjhvTjdkVEp2Nk9TUEt2d2kwMzVRandwSVFM?=
 =?utf-8?B?anhEV25aSTE4amMxK1g4RkczWnVoL21wM1p2dm03WkY3akNweVJHNzhDay9k?=
 =?utf-8?B?TWRZRVE5Q0owaUNtZmcyc1d2a01Cazl6K2ZHWjlNY0xacnlhd2krN3JFd3h5?=
 =?utf-8?B?L2l5eEt4WHdqVktXS3VmREFPTm1VS3l4SnhpM3hacGU1WGhmcEdGQWFVcXk0?=
 =?utf-8?B?MkNIbmo4NVU5UU4vNlREQzg3cXdKY3dqRmJETDFvMjVyUFFJQkF2OURZL3Js?=
 =?utf-8?B?U2VpSUZlL3ZwWWR4M3RyTGU0WlpnTU1BSUd0dFN1Q2JBbGl0d3JkanFheFdR?=
 =?utf-8?B?c3gvaTB6dnQ5ellzRGY5RUtHZllJS3c5YWRBUmdQc3loTFNmbDVBaXl1ZVhT?=
 =?utf-8?B?a3IzYzIxT3BIOU5MbGhEYnpWbGFOTGJJa1MwMkhxZ0JDSXc4a05CcGRlMWNM?=
 =?utf-8?B?N1lVbzlVYndWbGRmTHpDTk5ITmpVbGVhM3h2U2lvT2g1UjRDNEo1ellPbFlU?=
 =?utf-8?B?LzhyVDVpNXJWaklyc01oLzlyZzA4UUFxbXI4dGFJa0IxWEkwTFdSUnJNUkk1?=
 =?utf-8?B?RGUyb0RHL0V2YjBvYXQzMnRrUmY5M2lSNC9qYVp1MTU4QlBZaC9RRVlVYTYz?=
 =?utf-8?B?VEczZ2g0NzRZTGNCZ2dGcTVyRDdvd00rcFY1T05PcDZXVTNTeE9Tb0lrUG82?=
 =?utf-8?B?eVJCNlNVRUd6ZzVCWjZWeVVkN1NPMnA4VG0vSWhYY1lkQ05QNU4vbEdWaU1n?=
 =?utf-8?B?d2E1OU1RdzVYcXpkR1ZIUmhmQXoybjVkaENSTXIwa1pmRzRJa00zS2ozcG1k?=
 =?utf-8?B?clZOaTB4K1ZCeklPdklMc2dXZWpMOVF4Sm1zN3ZzSmRDV01EYW8wcURjM2lP?=
 =?utf-8?B?cFNlTFd2b1FEdTNGa3dDNXE2OWdUL3dBcmN0OCt4VGhJa2tNNUcrRVhPYzhD?=
 =?utf-8?B?d2lDTnc5WmxkNHpyNHY3YmJ5VUVHY29XbmJTTVB2OEdEM1ArRzlFMzBuclQx?=
 =?utf-8?B?dC9NY1d0ZkVVakxLQmJyUDVsdVFRQy8xdDNBRmd5S1JOODF4WVg4alFMaWtG?=
 =?utf-8?B?RkpVSS8rdUdzNm13czZGenk4RjNVSVRwQ1FTbkFFRVFadUFkNVRPYnpYSVBM?=
 =?utf-8?Q?qUNdwKDhB5cKAXf1AW7hH3rjXlKEF/+1wyRWEaj?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 37f9c55c-4602-4039-1abc-08d990021d7c
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB5163.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2021 17:35:01.0733
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yeOrcvfuD+dSwa7Uqi6pwlvX7T9CHdYeoZYA6zshpMJwp/jOLd3cD0dkTThlXTSJbclNAXyFH2mvLdEr2hxQQZzOER3pzD3EY62HmgG5GCQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4777
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On 10/14/21 7:51 PM, Xu Yilun wrote:
> On Thu, Oct 14, 2021 at 09:32:53AM -0700, Russ Weight wrote:
>>
>> On 10/13/21 6:49 PM, Xu Yilun wrote:
>>> On Wed, Oct 13, 2021 at 11:09:08AM -0700, Russ Weight wrote:
>>>> On 10/12/21 6:06 PM, Xu Yilun wrote:
>>>>> On Tue, Oct 12, 2021 at 10:20:15AM -0700, Russ Weight wrote:
>>>>>> On 10/12/21 12:47 AM, Xu Yilun wrote:
>>>>>>> On Mon, Oct 11, 2021 at 06:00:16PM -0700, Russ Weight wrote:
>>>>>>>> On 10/11/21 5:35 AM, Tom Rix wrote:
>>>>>>>>> On 10/10/21 6:41 PM, Xu Yilun wrote:
>>>>>>>>>> On Sat, Oct 09, 2021 at 05:11:20AM -0700, Tom Rix wrote:
>>>>>>>>>>> On 10/9/21 1:08 AM, Xu Yilun wrote:
>>>>>>>>>>>> On Wed, Sep 29, 2021 at 04:00:20PM -0700, Russ Weight wrote:
>>>>>>>>>>>>> The FPGA Image Load framework provides an API to upload image
>>>>>>>>>>>>> files to an FPGA device. Image files are self-describing. They could
>>>>>>>>>>>>> contain FPGA images, BMC images, Root Entry Hashes, or other device
>>>>>>>>>>>>> specific files. It is up to the lower-level device driver and the
>>>>>>>>>>>>> target device to authenticate and disposition the file data.
>>>>>>>>>>>> I've reconsider the FPGA persistent image update again, and think we
>>>>>>>>>>>> may include it in FPGA manager framework.
>>>>>>>>>>>>
>>>>>>>>>>>> Sorry I raised this topic again when it is already at patch v17, but now
>>>>>>>>>>>> I need to consider more seriously than before.
>>>>>>>>>>>>
>>>>>>>>>>>> We have consensus the FPGA persistent image update is just like a normal
>>>>>>>>>>>> firmware update which finally writes the nvmem like flash or eeprom,
>>>>>>>>>>>> while the current FPGA manager deals with the active FPGA region update
>>>>>>>>>>>> and re-activation. Could we just expand the FPGA manager and let it handle
>>>>>>>>>>>> the nvmem update as well? Many FPGA cards have nvmem and downloaders
>>>>>>>>>>>> supports updating both FPGA region and nvmem.
>>>>>>>> The fpga-image-load driver is actually just a data transfer. The class
>>>>>>> IMHO, The fpga-mgr dev is also a data transfer. The fpga-region dev is
>>>>>>> acting as the FPGA region admin responsible for gating, transfering and
>>>>>>> re-enumerating.
>>>>>>>
>>>>>>> So my opinion is to add a new data transfer type and keep a unified process.
>>>>>>>
>>>>>>>> driver has no knowledge about what the data is or where/if the data will
>>>>>>>> be stored.
>>>>>>> The fpga-image-load driver knows the data will be stored in nvmem,
>>>>>> FYI: This is not strictly correct. In a coming product there is a
>>>>>> case where the data will be stored in RAM. Richard Gong was also
>>>>>> looking to use this driver to validate an image without programming
>>>>>> or storing it. The fpga-image-load driver has no expectation that
>>>>>> the data will be stored in nvmem, or even that it will be stored
>>>>>> at all.
>>>>> OK, we can discuss that use case then. But fundamentally a driver should
>>>>> be clear what it is doing.
>>>> The lower-level driver is, of course, clear what it is doing. And the
>>>> FPGA Image Load Framework simply provides a consistent API and manages
>>>> a potentially long-running data transfer in the context of a kernel
>>>> worker thread.
>>>>
>>>> It sounds like you are saying that that is not "clear enough" in the
>>>> context of the FPGA Manager?
>>>>
>>>> The files that are used with Intel PAC devices are self-describing. The
>>>> user-space tools, the class driver and the lower-level driver just pass
>>>> the data through to the card BMC without any knowledge of the content,
>>>> purpose or final destination of the data.
>>>>
>>>> The card BMC will receive signed data, validate it, and process it as a
>>>> BMC image, an FPGA image, a Root Entry Hash, or a key cancellation. In
>>> I category all these actions as firmware update fully or partially on
>>> persistent storage. The FPGA Manager don't have to know the meaning of
>>> every byte on flash, but it should be aware the firmware is updated and
>>> the card may acts differently with a new firmware. This is the common
>>> working model for most of the FPGA cards so that we implement it in FPGA
>>> manager class. 
>>>
>>>> the n6000, it could also be part of a multi-step process for programming
>>>> SDM keys and the data may not be stored permanently.
>>> This is new to me, but seems to be different from firmware update, so lets
>>> think about it again.
>>>
>>>>> You may try to extend the FPGA framework to
>>>>> support nvmem storage, or image validation, but cannot say we feed the
>>>>> data to any engine undefined by the framework.
>>>> I'm not sure what you mean by "feed the data to any engine undefined by the
>>>> framework". I think the "engine" is the lower level driver/device that invokes
>>>> the fpga_mgr. The lower level driver, of course, is clear what it is doing.
>>>> The fpga_mgr cannot control what driver invokes it.
>>>>
>>>> Are saying that when invoking the fpga-mgr, that it _must_ also pass descriptive
>>>> data. Meaning that a self-describing file alone is not acceptable?
>>> The class driver should define a reasonable working model and APIs.
>>> Updating the FPGA backup storage is good to me. But receiving a mystery
>>> box and do whatever it requires is not.
>>>
>>> Self-describing file is OK, encryption is OK, but either the class
>>> driver itself, or with the help of the low level driver, should make
>>> sure it works within its scope.
>> In our secure update process, the card BMC firmware authenticates
>> the data using the root entry hashes and will either reject the
>> data or perform some function based on the contents. Neither the
>> user-space, the class driver, nor the lower level driver know
>> what the contents are. It _is_ a "mystery box" to them. How do we
>> verify scope in this model?
> I think we need to find out how. One case is, the HW is designed to have
> one single function, such as firmware update, then any image input
> through firmware update API is within expectation, and the driver
> should only serve the firmware update API. I think this is how the
> N3000 is working now. If the HW is for another function, register itself
> to serve another API, or another class driver.
>
> Another case is, the HW could do multiple types of tasks depending on
> the content of the image, such as firmware update, image verification,
> or assumably power off the card ... There should be some mechanism for
> the driver to only accept the right image according to what API is called.
> Or the user may input an image named update_the_card.img through
> firmware update API and finally get the card off. Having some headers
> readable by host for the operation type? Or, some HW interface for host
> to apply the operation type as well as the image, let the HW verify?
> Let's think about it.
I'm not sure if I am following your thinking here. The HW, of course,
verifies authentication of the image and acts according to the image
type. I don't think it is reasonable to require the class driver to
interpret the data to determine what it is. That implies that the
class driver would have to know the header format and possible values.
It also means that changes to the header format would require patches
to the class driver.

The FPGA card is trusted by virtue of the fact that the customer
purchased it and physically placed it in the machine. If the FPGA card
(or the lower level driver) validates the image, then why does the
Class driver need to be concerned about the file type? I think the
purpose of the class driver is primarily to provide a common API and
perform common functions so that they don't have to be replicated
among similar low-level drivers. It is up to the low-level driver
or the device itself to ensure that the data received is acceptable.

If the card receives data through the fpga-mgr upload facility that
isn't strictly a firmware update, and if the lower-level driver or
the card handles it and returns appropriate status - is that really
a problem?
>> As you have noted, most current cases result in a change to the
>> card, and I suspect that it will remain that way. But that can't be
>> guaranteed, and I'm not convinced that a host driver needs to be
>> concerned about it.
> A host driver should know what is done, in some abstraction level.
> I think updating the persistent storage is an acceptable abstraction
> in FPGA domain, so I'd like to extend it in FPGA manager. But doing
> anything according to the image is not.
By host driver, do you mean the class driver? Or the lower-level device
driver?

It seems to me that you are saying that self-describing images are not
acceptable? Or at least they are not acceptable payload for an FPGA
Manager firmware-update API?

The FPGA Image Load Framework was designed with the concept of
transferring data to a device without imposing a purpose on the data.
The expectation is that the lower-level driver or the device will
validate the data. Is there something fundamentally wrong with that
approach? And if not, why couldn't we incorporate a similar image_load
API into the FPGA Manager?

- Russ

>
> Thanks,
> Yilun
>
>> - Russ
>>
>>> Thanks,
>>> Yilun
>>>
>>>> Thanks,
>>>> - Russ
>>>>
>>>>> Thanks,
>>>>> Yilun
>>>>>
>>>>>>> while
>>>>>>> the fpga-mgr knows the data will be stored in FPGA cells. They may need
>>>>>>> to know the exact physical position to store, may not, depends on what the
>>>>>>> HW engines are.
>>>>>>>
>>>>>>>> This functionality could, of course, be merged into the fpga-mgr. I did
>>>>>>>> a proof of concept of this a while back and we discussed the pros and cons.
>>>>>>>> See this email for a recap:
>>>>>>>>
>>>>>>>> https://marc.info/?l=linux-fpga&m=161998085507374&w=2
>>>>>>>>
>>>>>>>> Things have changed some with the evolution of the driver. The IOCTL
>>>>>>>> approach probably fits better than the sysfs implementation. At the time
>>>>>>>> it seemed that a merge would add unnecessary complexity without adding value.
>>>>>>> I think at least developers don't have to go through 2 sets of software
>>>>>>> stacks which are of the same concept. And adding some new features like
>>>>>>> optionally threading or canceling data transfer are also good to FPGA
>>>>>>> region update. And the nvmem update could also be benifit from exsiting
>>>>>>> implementations like scatter-gather buffers, in-kernel firmware loading.
>>>>>>>
>>>>>>> I try to explain myself according to each of your concern from that mail
>>>>>>> thread:
>>>>>>>
>>>>>>> Purpose of the 2 updates
>>>>>>> ========================
>>>>>>>
>>>>>>>   As I said before, I think they are both data transfer devices. FPGA
>>>>>>> region update gets extra support from fpga-region & fpga-bridge, and
>>>>>>> FPGA nvmem update could be a standalone fpga-mgr.
>>>>>>>
>>>>>>> Extra APIs that are unique to nvmem update
>>>>>>> ==========================================
>>>>>>>
>>>>>>>   cdev APIs for nvmem update:
>>>>>>>     Yes we need to expand the functionality so we need them.
>>>>>>>
>>>>>>>   available_images, image_load APIs for loading nvmem content to FPGA
>>>>>>>   region:
>>>>>>>     These are features in later patchsets which are not submitted, but we
>>>>>>>     could talk about it in advance. I think this is actually a FPGA region
>>>>>>>     update from nvmem, it also requires gating, data loading (no SW transfer)
>>>>>>>     and re-enumeration, or a single command to image_load HW may result system
>>>>>>>     disordered. The FPGA framework now only supports update from in-kernel
>>>>>>>     user data, maybe we add support for update from nvmem later.
>>>>>>>
>>>>>>>   fpga-mgr state extend:
>>>>>>>     I think it could be extended, The current states are not perfect,
>>>>>>>     adding something like IDLE or READY is just fine.
>>>>>>>
>>>>>>>   fpga-mgr status extend:
>>>>>>>     Add general error definitions as needed. If there is some status
>>>>>>>     that is quite vendor specific, expose it in low-level driver.
>>>>>>>
>>>>>>>   remaining-size:
>>>>>>>     Nice to have for all.
>>>>>>>
>>>>>>> Threading the update
>>>>>>> ====================
>>>>>>>
>>>>>>>   Also a good option for FPGA region update, maybe we also have a slow FPGA
>>>>>>>   reprogrammer?
>>>>>>>
>>>>>>> Cancelling the update
>>>>>>> ====================
>>>>>>>
>>>>>>>   Also a good option for FPGA region update if HW engine supports.
>>>>>> These are all good points.
>>>>>>
>>>>>> Thanks,
>>>>>> - Russ
>>>>>>> Thanks,
>>>>>>> Yilun
>>>>>>>
>>>>>>>>>>>> According to the patchset, the basic workflow of the 2 update types are
>>>>>>>>>>>> quite similar, get the data, prepare for the HW, write and complete.
>>>>>>>>>>>> They are already implemented in FPGA manager. We've discussed some
>>>>>>>>>>>> differences like threading or canceling the update, which are
>>>>>>>>>>>> not provided by FPGA manager but they may also nice to have for FPGA
>>>>>>>>>>>> region update. An FPGA region update may also last for a long time??
>>>>>>>>>>>> So I think having 2 sets of similar frameworks in FPGA is unnecessary.
>>>>>>>>>>>>
>>>>>>>>>>>> My quick mind is that we add some flags in struct fpga_mgr & struct
>>>>>>>>>>>> fpga_image_info to indicate the HW capability (support FPGA region
>>>>>>>>>>>> update or nvmem update or both) of the download engine and the provided
>>>>>>>>>>>> image type. Then the low-level driver knows how to download if it
>>>>>>>>>>>> supports both image types.An char device could be added for each fpga manager dev, providing the
>>>>>>>>>>>> user APIs for nvmem update. We may not use the char dev for FPGA region
>>>>>>>>>>>> update cause it changes the system HW devices and needs device hotplug
>>>>>>>>>>>> in FPGA region. We'd better leave it to FPGA region class, this is
>>>>>>>>>>>> another topic.
>>>>>>>> I'll give this some more thought and see if I can come up with some RFC
>>>>>>>> patches.
>>>>>>>>
>>>>>>>> - Russ
>>>>>>>>>>>> More discussion is appreciated.
>>>>>>>>>>> I also think fpga_mgr could be extended.
>>>>>>>>>>>
>>>>>>>>>>> In this patchset,
>>>>>>>>>>>
>>>>>>>>>>> https://lore.kernel.org/linux-fpga/20210625195849.837976-1-trix@redhat.com/
>>>>>>>>>>>
>>>>>>>>>>> A second, similar set of write ops was added to fpga_manger_ops,
>>>>>>>>>>>
>>>>>>>>>>> new bit/flag was added to fpga_image_info
>>>>>>>>>>>
>>>>>>>>>>> The intent was for dfl to add their specific ops to cover what is done in
>>>>>>>>>>> this patchset.
>>>>>>>>>> I think we don't have to add 2 ops for reconfig & reimage in framework,
>>>>>>>>>> the 2 processes are almost the same.
>>>>>>>>>>
>>>>>>>>>> Just add the _REIMAGE (or something else, NVMEM?) flag for
>>>>>>>>>> fpga_image_info, and low level drivers handle it as they do for other
>>>>>>>>>> flags.
>>>>>>>>>>
>>>>>>>>>> How do you think?
>>>>>>>>> A single set is fine.
>>>>>>>>>
>>>>>>>>> A difficult part of is the length of  time to do the write. The existing write should be improved to use a worker thread.
>>>>>>>>>
>>>>>>>>> Tom
>>>>>>>>>
>>>>>>>>>> Thanks,
>>>>>>>>>> Yilun
>>>>>>>>>>
>>>>>>>>>>> Any other driver would do similar.
>>>>>>>>>>>
>>>>>>>>>>> Is this close to what you are thinking ?
>>>>>>>>>>>
>>>>>>>>>>> Tom
>>>>>>>>>>>
>>>>>>>>>>>> Thanks,
>>>>>>>>>>>> Yilun
>>>>>>>>>>>>

