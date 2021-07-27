Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47E643D7BFE
	for <lists+linux-fpga@lfdr.de>; Tue, 27 Jul 2021 19:16:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbhG0RQZ (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 27 Jul 2021 13:16:25 -0400
Received: from mga09.intel.com ([134.134.136.24]:33321 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229981AbhG0RQY (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 27 Jul 2021 13:16:24 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10058"; a="212481027"
X-IronPort-AV: E=Sophos;i="5.84,274,1620716400"; 
   d="scan'208";a="212481027"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2021 10:16:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,274,1620716400"; 
   d="scan'208";a="505976125"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by FMSMGA003.fm.intel.com with ESMTP; 27 Jul 2021 10:16:21 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Tue, 27 Jul 2021 10:16:21 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Tue, 27 Jul 2021 10:16:21 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Tue, 27 Jul 2021 10:16:21 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.174)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Tue, 27 Jul 2021 10:16:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lWiJr/bw0vXW35cAv8Ur6RLVWo13gHzdP8I/43JHN5azEyTgBEgxrcrSJuzvU+I56k0QXZVe9irnBrCIGredtJ2YkwZwlsXBZfu+GCSkio0kguanDy8DnBCDccBKdFaHBgAUqdPyJ4r0+TrTdwpuVUOhdRr0LB6iFPpcFhRqdToHYjEZSBZioATlLkGY9aOilG9tdCWljeD4Wg+k0m4CJEVGd3iN9DtEVKg0WbcFffARmJayPdmOYlE8r+apBiIx8GO32qO/peITaH4KAmGh5KMIEEg3U3BAU5XuNoZlrvEJO9kiRADH1ZXkT2V2Ch74Fp2jF6J8veOq+DCbBgm4sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4kEJPVTW0M5kR4djCOhS9P9qUgOO5gjDFrjIH+Ju9ko=;
 b=DXWqnxPca6RM2P4duE80MMiBtDo2JrjHCfFjBKuubW8TaNmtIOOphtnVXO/LYiluy4SM7FODq9ZPhUE7T3zsOXJDXFBk/YHggFpKHFGLMouYcE8fQmH3X9a5kxPC7YkBjxf6rLyHGtHxUzKoA8Dy0XOrmBF/LRjLN6DaSivp5xRkhYHlIvU7oT6+9j1/VWBTvfGcNWzglI1IY4obGsrTQEVXReUKbURE8gCz2cxgYYQu2EEM3IaP3Rdwvn1OR8mwuCiP3H1qosqPgp8x5c/zD8QEAuL02q+rqZ8EDlgmFM6SL/89u81mWD888/enAFzhRiUFNqlh14lkbYyl6JhgBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4kEJPVTW0M5kR4djCOhS9P9qUgOO5gjDFrjIH+Ju9ko=;
 b=YKKc5Hje5Yd22ntEeVIC48CVBWHb+Pbffmx/P+PhGjnFWwzm19wbmrJ/vuLrgneQKvXa+Qz+dOM+kQPNFX7azacT3z2BBMvQQPwj8A9ufZQPmflSSlcxQnDNcNLqkkgDDoMRrMl7+1Yt/8AfJqP+DRGp9YBWSFvumk5ywlo35V4=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
Received: from SA2PR11MB5163.namprd11.prod.outlook.com (2603:10b6:806:113::20)
 by SA2PR11MB5148.namprd11.prod.outlook.com (2603:10b6:806:11e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.17; Tue, 27 Jul
 2021 17:16:14 +0000
Received: from SA2PR11MB5163.namprd11.prod.outlook.com
 ([fe80::51db:698d:e2e3:7fc8]) by SA2PR11MB5163.namprd11.prod.outlook.com
 ([fe80::51db:698d:e2e3:7fc8%4]) with mapi id 15.20.4352.031; Tue, 27 Jul 2021
 17:16:14 +0000
Subject: Re: [RESEND PATCH v10 0/3] fpga: Use standard class dev_release
 function
To:     Tom Rix <trix@redhat.com>, <mdf@kernel.org>,
        <linux-fpga@vger.kernel.org>, "Wu, Hao" <hao.wu@intel.com>
CC:     <lgoncalv@redhat.com>, <yilun.xu@intel.com>,
        <matthew.gerlach@intel.com>, <richard.gong@intel.com>
References: <20210726212750.121293-1-russell.h.weight@intel.com>
 <39607b02-bad3-0f65-c1c8-efd6036ab4f3@intel.com>
 <661d53d0-0ba4-d344-8da0-995a9b612905@redhat.com>
 <f8c391e2-987a-916a-a0e9-7795f71ec76d@intel.com>
 <8584c933-4482-446a-761c-9a5d511a81c5@redhat.com>
 <add87155-6417-fd08-c3c5-b39e7b9662df@intel.com>
 <c3c17e6e-9a57-eb90-fe00-c442c59ad921@redhat.com>
From:   Russ Weight <russell.h.weight@intel.com>
Message-ID: <b5519458-af01-43ee-2873-2092d552b060@intel.com>
Date:   Tue, 27 Jul 2021 10:16:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.11.0
In-Reply-To: <c3c17e6e-9a57-eb90-fe00-c442c59ad921@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: MW4PR04CA0369.namprd04.prod.outlook.com
 (2603:10b6:303:81::14) To SA2PR11MB5163.namprd11.prod.outlook.com
 (2603:10b6:806:113::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.0.2.4] (50.43.42.212) by MW4PR04CA0369.namprd04.prod.outlook.com (2603:10b6:303:81::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.26 via Frontend Transport; Tue, 27 Jul 2021 17:16:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 09272591-ebc9-4fd3-86e8-08d951223d00
X-MS-TrafficTypeDiagnostic: SA2PR11MB5148:
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA2PR11MB5148A0F75E5A6FA729E7E493C5E99@SA2PR11MB5148.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0Igx5qVm2THAq5Lrs5gDq9749Zlf5USO9H/3Qk2n8gUZLXl3ynXGjtGfR40ONt6jw4hoatoX3oXHs6yBBzkR00XFe1SC5/WoxQZwZh7O6hdJUywY+9DzsUOSNIlEYXB8rImvN597AfBL7DvYOwtsN2UtjjuEnLHvcrkA0G6uG4aw1V5mLkCyombAHLe7FicY4wP7NHB5McMARHdwxdofFLOku7EfZHeG28CEil/t9kahi3od/wNas+3VpVjTTjRXdifggF+y+/g4BwaJJ/DC6trb2ED/e1XV5mDN6pWoPPJOLjczlbeUPT2jXq++ASVfCloNT1DojvIbuluoPEKIV2IaqqGxGZoKAphZuESG1hJlKh0pGPG4ifB35BEa9LmUqGNWHhavuLOP/ai8K60XQKJ+VnY76oUhjdNGok6+0xhOMceFJLiD1s6PF7va99GOrg2gruZaiV9PsNG3h4OIBJrkkckfIn7zRZEm17kn/W8yT8fBGLDyjpe3igS1d1CaSa0B0nPfvGA2EoSK8nFMGQyH99wCBVy5AZAdxDEKMIAtFb3BkPRm692nT8lk4LN0KzvCp48ao+cWwRHVQFRDhUjpbw4luEMErqzXBFnj990i8c3dOJDIat7pXHV8JYnBhHkNAlnab+OuleQOZzzw00dI+yc98P86WqYGKKDCjb/CuScpk/X+ozbM5hPSdp6Fq9uYpIN4MXX8IRmGVIAwoaoQTlFZrouXARK+hVcMyPgmUjGMrw8IzSVjQ6dr6KyTXiqvs7kaESTuy52SrLAXQV2KHy182EzUFZWfWy5A1XJjV846zxWrMe7MRC4LwF+qVY8sr9eVmZPX/WYX1JPTUTlOA4fUwX3rKm0cVQSMqLo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB5163.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(5660300002)(86362001)(31686004)(66476007)(2906002)(26005)(31696002)(4326008)(186003)(16576012)(316002)(966005)(6636002)(956004)(110136005)(8676002)(8936002)(45080400002)(66556008)(107886003)(2616005)(83380400001)(508600001)(53546011)(36756003)(66946007)(38100700002)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TkdyanM3elhJV3drK28rUENsQXJSaXZKVWZoclJrcGFjZFhJMFJGMGYvSW52?=
 =?utf-8?B?Y05kRFlXK2lkRkU3MWFaZlRBVUMzbGRjUkNwcGRidzdWbC9tVHlkV09ZRXo2?=
 =?utf-8?B?OVZjR0toM0VJdG14dWplOVdVdVJBbTBMQ21PdnV6WDYzeGxFRUZSdGtvVlAv?=
 =?utf-8?B?dlVuVE1qWHF5UU1nb1NvaHlzR29CYjBBa056RXZoMGtENU8xL1N6a3B1ck94?=
 =?utf-8?B?bnpFYXVTUzZRY3FpS0FrVGxCVnF1TFUrS1NKcWdMM0J0TnplTUdpSVhYWXRj?=
 =?utf-8?B?ZndRWkM2UDljbDZOeDh2V0JKcEdtNmZmbDF6dklla2I1aFhDanl3ZW11YldC?=
 =?utf-8?B?STk5UEtEcHdUWTJUREhoNzh5U0Y2bm9zT1hJTmRaZlM4T2FNSE5acURRK0pj?=
 =?utf-8?B?S3JiWG8rSmwzRjhQSXJaeGV5eDNPK2E1d3h3ZTYwcDEvVnJuNTRrbVlSSVVw?=
 =?utf-8?B?eHIrQXpWK2d5QlRwWitIQmRVZ1NyNlV0dG92QnZZZjY2WW9tNzYrV2twOUpu?=
 =?utf-8?B?aVJBVzUrNUxjb1dYNzMrc2dtMEVJaDdXWmtqM0VDZU9iV052VERwWUlQeUY2?=
 =?utf-8?B?SlhqTUd0Q3c4UUx2aGlzY3hia0FqL1pSNGw2WG45Q04xSlNzZTV0Q2ZBblNU?=
 =?utf-8?B?Tm0wWUE0R1kyMVIzRU1lK21MNGRqQ3hISk43dFhxMWVGNGd4SlBuUjgxWExE?=
 =?utf-8?B?cnMxVW90VDRqV1FNL3FHOXl3UERhY2s3MmJVWlAzNytkL085UEZJQW9ST3Bu?=
 =?utf-8?B?amYxenpZUlU1VFlpTHVoekt0U2ZnNWpIR0NRcmZiemlVWk53YWJCdTdyY3dS?=
 =?utf-8?B?b0lOUWI1Q0RTR2tJTjhMVHdoK2RZUWhOU2k5MWg3WmxjUzlsOThndUxHZGNa?=
 =?utf-8?B?VjZNYjhuMk5leDVCNm5SK3RDN0hXWlFIaS9LK3pidTdxNGc1SHFha0k3bmps?=
 =?utf-8?B?bEV5ZElSNDZ5VEFYMzFWVXlCd3JhR2hTQXJwY1JrVG91VWQvcVdtbDlBRit1?=
 =?utf-8?B?QUZLTHorU2t4TzNpaW9vZkExSUJhdm5QVHo1anJzVjk5cDlUZ2ZocTlXclV3?=
 =?utf-8?B?WDUvNzlLNFlheS9qNXFDNk16RzhZV21nSDkybW80VWtjVitYZGp1U0hjMmlu?=
 =?utf-8?B?cDZQQkFiTDk2VXZIM1JPRTloTDJFZDZFK0RCY1pTaUNSRktaYkhWVWNzdFVj?=
 =?utf-8?B?bEpMalJ5T2VrN3I1eGhhS2NOL2w0THBYNnNFZFpXWS9TK0RWdUlsQUVPS3g5?=
 =?utf-8?B?OGwxeDFtY1dmOHJGWCt5UXlKMSt4YVRad1h6TWJzSzZMY2JFK0VUNFdObDNH?=
 =?utf-8?B?ZkozYXBkNUFYb1F6eGxiUUlycE1CZzF3YmtmVksyOG03Ym45bVBidnBhQ1Jy?=
 =?utf-8?B?b2xWZGdTQzVoUTN1VHNjZUdWSXR4OFc4M09WUUZETjM2WDMvYmo5d1Zxb3di?=
 =?utf-8?B?ZG9YRkk5eWIrUlRkbk13TWhWQm5zYmF3TndWZ0c5Tk1YcGNuT2pTMFEweHFz?=
 =?utf-8?B?eWkwUXlpaURzd2hwbElhd0UveWpUMVJuTFIrSHJkSGhleGpWcVJXZGxIZGsy?=
 =?utf-8?B?TGhtMkZDdmg1Z21nUEd5b29Gc3gxR29NRkhEelpVclg2cW9Qbk8wTkR2dzJw?=
 =?utf-8?B?L3QrVlVXUnBlUjRTa05SY0F6Z05CcUw5MUVML21mczZnRnNBdG9lTmt3SDBk?=
 =?utf-8?B?MWxyYUtpdm02MzZTYmJONmh0UWR3Q2RzdWF6Y2JWSm5JUnZ0cjhIZEgvYWRr?=
 =?utf-8?Q?xYH+tlpfgCPVJX3kOqNNZI0JL37hxzAT2F2cZUZ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 09272591-ebc9-4fd3-86e8-08d951223d00
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB5163.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2021 17:16:14.6168
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tR83QudsBVZF0P0kxfU0ZwMmWW1Clg5oXSTtlZ1fpHeUhpM4Wfy1+XvlmBsVakcK8oaw+3aVuMD3QsEW34su+2tfTdiU248zl05TKfmTdUc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5148
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On 7/27/21 9:55 AM, Tom Rix wrote:
>
> On 7/27/21 9:38 AM, Russ Weight wrote:
>>
>> On 7/27/21 9:22 AM, Tom Rix wrote:
>>> On 7/27/21 9:15 AM, Russ Weight wrote:
>>>> On 7/27/21 6:24 AM, Tom Rix wrote:
>>>>> On 7/26/21 2:33 PM, Russ Weight wrote:
>>>>>> Hi Moritz,
>>>>>>
>>>>>> I sent this version of the patchset out on July 8th. The only discussion has
>>>>>> been around the compat-id structure. I think there is agreement that this can
>>>>>> be treated separately. What are your thoughts? Do you think this patchset is
>>>>>> ready?
>>>>> While I agree the compat_id can be treated separately, i still have a problem with the 2 register functions.
>>>>>
>>>>> In this discussion,
>>>>>
>>>>> https://lore.kernel.org/linux-fpga/DM6PR11MB38194D113950FA4B75C7F2C485E49@DM6PR11MB3819.namprd11.prod.outlook.com/
>>>>>
>>>>> *register_full(..., *info) becomes
>>>>>
>>>>> *register(..., *info)
>>>>>
>>>>> and
>>>>>
>>>>> *register_simple() is moved out of the public api and becomes private to the subsystem.
>>>> Somehow I missed that part of the email. I'm not sure I understand the part about
>>>> register_simple() "becomes private to the subsystem". Most users would call the simple
>>>> version of the API. Is the proposal to replicate the register_simple() interface
>>>> for each driver that calls it?
>>> Still use *register_simple() internally, so most of your patchset is unchanged.
>>>
>>> Move it out the public api. include/linux/fpga-mgr.h into someplace appropriate in drivers/fpga/
>> Ok - I'll do another spin of the patch set.
>>
>> Just to be clear, *register_full() gets renamed back to *register(). The current *register()
>> goes back to *register_simple(). *register_simple() is an exported symbol, but the function
>> prototype moves out of the public header file into private header file under drivers/fpga.
>
> Mostly.
>
> If register_simple does not need to be exported, it shouldn't be.

If *register_simple() is to reside in the fpga_mgr or fpga_region module and be
called by other modules, then it has to be exported... unless it is defined as a
static function in a header file. Shall I go that route instead? I could create
a new drivers/fpga/fpga.h file and add the *register_simple() functions there.
Or I could create separate drivers/fpga/fpga-mgr.h and drivers/fpga/fpga-region.h
header files with one static function each.

- Russ

>
> Tom
>
>>
>> - Russ
>>
>>> Tom
>>>
>>>>> Tom
>>>>>
>>>>>> Thanks,
>>>>>> - Russ
>>>>>>
>>>>>>
>>>>>> On 7/26/21 2:27 PM, Russ Weight wrote:
>>>>>>> The FPGA framework has a convention of using managed resource functions
>>>>>>> to allow parent drivers to manage the data structures allocated by the
>>>>>>> class drivers. They use an empty *_dev_release() function to satisfy the
>>>>>>> class driver.
>>>>>>>
>>>>>>> This is inconsistent with linux driver model.
>>>>>>>
>>>>>>> These changes remove the managed resource functions and populate the class
>>>>>>> dev_release callback functions. They also merge the create() and register()
>>>>>>> functions into a single register() or register_full() function for each of
>>>>>>> the fpga-mgr, fpga-region, and fpga-bridge class drivers.
>>>>>>>
>>>>>>> The new *register_full() functions accept an info data structure to provide
>>>>>>> flexibility in passing optional parameters. The *register() functions
>>>>>>> support the legacy parameter list for users that don't require the use of
>>>>>>> optional parameters.
>>>>>>>
>>>>>>> For more context, refer to this email thread:
>>>>>>>
>>>>>>> https://marc.info/?l=linux-fpga&m=162127412218557&w=2
>>>>>>>
>>>>>>> I turned on the configs assocated with each of the modified files, but I
>>>>>>> must have been missing some dependencies, because not all of them compiled.
>>>>>>> I did a run-time test specifically with the dfl-fme infrastructure. This
>>>>>>> would have exercised the region, bridge, and fpga-mgr frameworks.
>>>>>>>
>>>>>>> Changelog v9 -> v10:
>>>>>>>      - Fixed commit messages to reference register_full() instead of
>>>>>>>        register_simple().
>>>>>>>      - Removed the fpga_bridge_register_full() function, because there is
>>>>>>>        not need for it yet. Updated the documentation and commit message
>>>>>>>        accordingly.
>>>>>>>      - Updated documentation to reference the fpga_manager_info and
>>>>>>>        fpga_region_info structures.
>>>>>>>
>>>>>>> Changelog v8 -> v9:
>>>>>>>      - Cleaned up documentation for the FPGA Manager, Bridge, and Region
>>>>>>>        register functions
>>>>>>>      - Renamed fpga_*_register() to fpga_*_register_full()
>>>>>>>      - Renamed fpga_*_register_simple() to fpga_*_register()
>>>>>>>      - Renamed devm_fpga_mgr_register() to devm_fpga_mgr_register_full()
>>>>>>>      - Renamed devm_fpga_mgr_register_simple() to devm_fpga_mgr_register()
>>>>>>>
>>>>>>> Changelog v7 -> v8:
>>>>>>>      - Added reviewed-by tags.
>>>>>>>      - Updated Documentation/driver-api/fpga/ files: fpga-mgr.rst,
>>>>>>>        fpga-bridge.rst, and fpga-region.rst.
>>>>>>>
>>>>>>> Changelog v6 -> v7:
>>>>>>>      - Update the commit messages to describe the new parameters for the
>>>>>>>        *register() functions and to mention the *register_simple() functions.
>>>>>>>      - Fix function prototypes in header file to rename dev to parent.
>>>>>>>      - Make use of the PTR_ERR_OR_ZERO() macro when possible.
>>>>>>>      - Some cleanup of comments.
>>>>>>>      - Update function definitions/prototypes to apply const to the new info
>>>>>>>        parameter.
>>>>>>>      - Verify that info->br_ops is non-null in the fpga_bridge_register()
>>>>>>>        function.
>>>>>>>      - Verify a non-null info pointer in the fpga_region_register() function.
>>>>>>>
>>>>>>> Changelog v5 -> v6:
>>>>>>>      - Moved FPGA manager/bridge/region optional parameters out of the ops
>>>>>>>        structure and back into the FPGA class driver structure.
>>>>>>>      - Changed fpga_*_register() function parameters to accept an info data
>>>>>>>        structure to provide flexibility in passing optional parameters.
>>>>>>>      - Added fpga_*_register_simple() functions to support current parameters
>>>>>>>        for users that don't require use of optional parameters.
>>>>>>>
>>>>>>> Changelog v4 -> v5:
>>>>>>>      - Rebased on top of recently accepted patches.
>>>>>>>      - Removed compat_id from the fpga_mgr_register() parameter list
>>>>>>>        and added it to the fpga_manager_ops structure. This also required
>>>>>>>        dynamically allocating the dfl-fme-ops structure in order to add
>>>>>>>        the appropriate compat_id.
>>>>>>>      - Created the fpga_region_ops data structure which is optionally passed
>>>>>>>        to fpga_region_register(). compat_id, the get_bridges() pointer, and
>>>>>>>        the priv pointer are included in the fpga_region_ops structure.
>>>>>>>
>>>>>>> Changelog v3 -> v4:
>>>>>>>      - Added the compat_id parameter to fpga_mgr_register() and
>>>>>>>        devm_fpga_mgr_register() to ensure that the compat_id is set before
>>>>>>>        the device_register() call.
>>>>>>>      - Added the compat_id parameter to fpga_region_register() to ensure
>>>>>>>        that the compat_id is set before the device_register() call.
>>>>>>>      - Modified the dfl_fpga_feature_devs_enumerate() function to restore
>>>>>>>        the fpga_region_register() call to the correct location.
>>>>>>>
>>>>>>> Changelog v2 -> v3:
>>>>>>>      - Cleaned up comment headers for fpga_mgr_register(), fpga_bridge_register(),
>>>>>>>        and fpga_region_register().
>>>>>>>      - Fixed error return on ida_simple_get() failure for fpga_mgr_register(),
>>>>>>>        fpga_bridge_register(), and fpga_region_register().
>>>>>>>      - Fixed error return value for fpga_bridge_register(): ERR_PTR(ret) instead
>>>>>>>        of NULL.
>>>>>>>
>>>>>>> Changelog v1 -> v2:
>>>>>>>      - Restored devm_fpga_mgr_register() functionality to the fpga-mgr
>>>>>>>        class driver, adapted for the combined create/register functionality.
>>>>>>>      - All previous callers of devm_fpga_mgr_register() will continue to call
>>>>>>>        devm_fpga_mgr_register().
>>>>>>>      - replaced unnecessary ternary operators in return statements with
>>>>>>>        standard if conditions.
>>>>>>>
>>>>>>> Russ Weight (3):
>>>>>>>      fpga: mgr: Use standard dev_release for class driver
>>>>>>>      fpga: bridge: Use standard dev_release for class driver
>>>>>>>      fpga: region: Use standard dev_release for class driver
>>>>>>>
>>>>>>>     Documentation/driver-api/fpga/fpga-bridge.rst |   6 +-
>>>>>>>     Documentation/driver-api/fpga/fpga-mgr.rst    |  38 +++-
>>>>>>>     Documentation/driver-api/fpga/fpga-region.rst |  12 +-
>>>>>>>     drivers/fpga/altera-cvp.c                     |  12 +-
>>>>>>>     drivers/fpga/altera-fpga2sdram.c              |  12 +-
>>>>>>>     drivers/fpga/altera-freeze-bridge.c           |  10 +-
>>>>>>>     drivers/fpga/altera-hps2fpga.c                |  12 +-
>>>>>>>     drivers/fpga/altera-pr-ip-core.c              |   7 +-
>>>>>>>     drivers/fpga/altera-ps-spi.c                  |   9 +-
>>>>>>>     drivers/fpga/dfl-fme-br.c                     |  10 +-
>>>>>>>     drivers/fpga/dfl-fme-mgr.c                    |  22 +-
>>>>>>>     drivers/fpga/dfl-fme-region.c                 |  17 +-
>>>>>>>     drivers/fpga/dfl.c                            |  12 +-
>>>>>>>     drivers/fpga/fpga-bridge.c                    | 122 +++-------
>>>>>>>     drivers/fpga/fpga-mgr.c                       | 215 ++++++++----------
>>>>>>>     drivers/fpga/fpga-region.c                    | 119 ++++------
>>>>>>>     drivers/fpga/ice40-spi.c                      |   9 +-
>>>>>>>     drivers/fpga/machxo2-spi.c                    |   9 +-
>>>>>>>     drivers/fpga/of-fpga-region.c                 |  10 +-
>>>>>>>     drivers/fpga/socfpga-a10.c                    |  16 +-
>>>>>>>     drivers/fpga/socfpga.c                        |   9 +-
>>>>>>>     drivers/fpga/stratix10-soc.c                  |  16 +-
>>>>>>>     drivers/fpga/ts73xx-fpga.c                    |   9 +-
>>>>>>>     drivers/fpga/xilinx-pr-decoupler.c            |  17 +-
>>>>>>>     drivers/fpga/xilinx-spi.c                     |  11 +-
>>>>>>>     drivers/fpga/zynq-fpga.c                      |  16 +-
>>>>>>>     drivers/fpga/zynqmp-fpga.c                    |   9 +-
>>>>>>>     include/linux/fpga/fpga-bridge.h              |  30 ++-
>>>>>>>     include/linux/fpga/fpga-mgr.h                 |  62 +++--
>>>>>>>     include/linux/fpga/fpga-region.h              |  36 ++-
>>>>>>>     30 files changed, 383 insertions(+), 511 deletions(-)
>>>>>>>
>

