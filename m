Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 096F23D80D0
	for <lists+linux-fpga@lfdr.de>; Tue, 27 Jul 2021 23:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233618AbhG0VHu (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 27 Jul 2021 17:07:50 -0400
Received: from mga04.intel.com ([192.55.52.120]:57142 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233774AbhG0VHN (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 27 Jul 2021 17:07:13 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10058"; a="210642796"
X-IronPort-AV: E=Sophos;i="5.84,274,1620716400"; 
   d="scan'208";a="210642796"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2021 14:07:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,274,1620716400"; 
   d="scan'208";a="498951023"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga004.fm.intel.com with ESMTP; 27 Jul 2021 14:07:12 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Tue, 27 Jul 2021 14:07:12 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Tue, 27 Jul 2021 14:07:12 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Tue, 27 Jul 2021 14:07:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oWc24eN6u/h1+WBTciRWfCEm0ypU6wHsnp8gWHygOtL8HyP0Q89HjclDuY0qD/Hmn+/ichzi6/+BAAElydMSQt8Ab3OdOheuRHF0Am8APPZ8CXR/4NyjdAeP3JLYMWaLTNKeY/6DE6GN0r9TzUnUfwBlDpqOztR1aVkubCOX8NYIHfwyExi3czR9LoMnLRD5ZMvMHb/AdGExNyZ9vYMv7OS7r4bcSe/EkjlKd15r6PJIG1GeK7L2YpoIHHuvhJ2sMypxbQj7tUNUBrpDuq1UYjKooW14f70dbUX/3Yk5qpi3YSa8Z2UHPt9UHqB8Rs919X3ZZ0LGhtVwebmrRWQKLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MnOB3dcLYKT5TnUZq9kX/UrunwXNjuXfN9CWHBPogKk=;
 b=BKawhUywCkn5zolNXJJsscNwuPcLQlPqTHUo6miwf67F2M1C39FLGWwCPv6KmT3eu4LJV9ShKSPwYkNJSbfxfsY812cLACuGQ4ojTnD1XZporp2WTYEKhaCKP8zCgRJNAp0fquGe1kDz+HXuYyrjHeAmtUr/1coPi2ERDFBda9LsRp7iyJSipwUL8h96aVvKTX38ct8Ypn3lc2KMrNigk+70UmpvSKHDxGTrFoFJayrV2eSkCqITwvlugteOkgJZbqzBF0IcLFtrZl6aQm7QOQ59CQbJb7QfxHGT/YI7kpAJpYnZIDcXDNea5bqzEy2JwYAbfO92PiDIHzntZv21oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MnOB3dcLYKT5TnUZq9kX/UrunwXNjuXfN9CWHBPogKk=;
 b=IH+WnVGHplHKKkmM6n6g0IyDxsIL2vMDrVXmSNVXGfSs58/SRjUnewOlT8hJuCDsiKx0tiPJv0TcsVAMDP7MUaLjQ3N3Po+CpxT+p9G0xtlU+wHSgozzCpWJVfwziRhLWGqioEzaYpAWLRtt+wN7BxKMB+OkwA58IZ98ALlMC9Y=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
Received: from SA2PR11MB5163.namprd11.prod.outlook.com (2603:10b6:806:113::20)
 by SN6PR11MB2559.namprd11.prod.outlook.com (2603:10b6:805:57::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.31; Tue, 27 Jul
 2021 21:07:07 +0000
Received: from SA2PR11MB5163.namprd11.prod.outlook.com
 ([fe80::51db:698d:e2e3:7fc8]) by SA2PR11MB5163.namprd11.prod.outlook.com
 ([fe80::51db:698d:e2e3:7fc8%4]) with mapi id 15.20.4352.031; Tue, 27 Jul 2021
 21:07:07 +0000
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
 <b5519458-af01-43ee-2873-2092d552b060@intel.com>
 <61debd50-c75f-2adb-5465-b9525704e0df@redhat.com>
From:   Russ Weight <russell.h.weight@intel.com>
Message-ID: <0837a32b-59d4-2ef2-448f-1350f9011a2c@intel.com>
Date:   Tue, 27 Jul 2021 14:07:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.11.0
In-Reply-To: <61debd50-c75f-2adb-5465-b9525704e0df@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: CO2PR07CA0075.namprd07.prod.outlook.com (2603:10b6:100::43)
 To SA2PR11MB5163.namprd11.prod.outlook.com (2603:10b6:806:113::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.0.2.4] (50.43.42.212) by CO2PR07CA0075.namprd07.prod.outlook.com (2603:10b6:100::43) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.17 via Frontend Transport; Tue, 27 Jul 2021 21:07:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bbd0453b-2bef-47d0-1ff1-08d951427df8
X-MS-TrafficTypeDiagnostic: SN6PR11MB2559:
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR11MB2559332E5C833095C981A251C5E99@SN6PR11MB2559.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tbeMKKnIkzunu/4dTi1zVdCaKs6EYECdK9q3AW5yF9WbMzSLMAChlRsHESgjmbpKgD+tV4ANJfVWfPSYDWT1gq8wLHx9IIsM4NbXbDofYcRy/RtfxwQXzgNUXxyv6b4fz5XT+eo0YHKnRiK1lPK2XGM93ubwAR5bGkeaDzcSEBdYHmnBWUcwF9CTD+rckF2gwx2jhmHy7neShfHBovfaev2ukvwFpwRCQR/BTMIJqlSjOY4JG/dpeOO4VcL8yfFEamosgUgp5jKCGbXBWqGDAcl48bA52W5B5eKinEnM3GwgXp3xXpr4EwIFips1CbDmnv1W/l6AYtICU1GFBR4YQBoF1UZNv6r6qhDqOjuq+O6r0TCKj/iE8veR8XDcMRbRCmaR0iEIGsOBnf3j1A8hYRRdNdm9eWSC8hyRTN5FbUJRsLHl8/LUJ+IBlH86/lDkARWZlez+M4T6DxWLrFGLlTn9sa/FPAtIasWTxqdcY331SVGTIXb19nnCDYmGvn4NTsPXqS1EbxnxJumz2ia6sdRSO9LBb6k9PoTEdG17sPDIsxZeWMFGqwzCiRy0jNn9UpcXHgrOySXbn1aMA3KEoSEGVdI3dzKOybYLt4+Ix7/V785uuf6wOO0nLbVNpAtq0rfO8BfkllmuSIZSUQ8iG6Y7nXOQD1QLa70nPQaSSDePnBUEveX1sQTTqcXimg1gorVnd+Wq4B7eWoFK3UaiPseYlhpZpGd6QyINENTteBoW2n2MRa7IkaRdg6ylHFkwnVA/IFEacEc+CNq29y5H4NF6qtsWthcztDow4XwiO4fomlTe15/kzZ7PL00vbbwafjyVnCXwqEE+o51cHW6wFtA36Pc8/W5jamfnXk80b7M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB5163.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(376002)(39860400002)(136003)(396003)(86362001)(186003)(31686004)(8676002)(6636002)(66476007)(36756003)(2906002)(107886003)(316002)(110136005)(66946007)(5660300002)(38100700002)(956004)(2616005)(53546011)(6486002)(26005)(4326008)(66556008)(83380400001)(31696002)(478600001)(30864003)(45080400002)(8936002)(16576012)(966005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QzRmUGh3MWpQbWFoZlZXVk1JbHExV21qMnNxSnpVdDhxYnVCSk1zZ0lJY1Ju?=
 =?utf-8?B?QUFUV0RMVVBHTjdNdEE0UGdUMFFkNFkzQnlRMk45RUtuNWV2dFRQMzFzbVJP?=
 =?utf-8?B?UkpvNUxFN1RMRDdITDQydFgrQU5vclFlcFJrSWJONndRRTNFOEdSOXBGVkdB?=
 =?utf-8?B?dGJXakpsZVNJZUpyUDAwaE1pUnAyUjFrVy9jQ25WQXdvRU9DbjVPUGYycGJp?=
 =?utf-8?B?d2NydTQ3WmFlNm9Xa3NnMkRud0hHRDFybk16bDRsNUd4Y0gzd0tDM3FFMmRu?=
 =?utf-8?B?Rm5nckgyZVdieFg3Y1p4TW9YeUZVOW50K1ZUWkU0T05ZMVhXdnBZZW82SSs5?=
 =?utf-8?B?ZTZ0M3hMSGZVWExIbHY0K0hzQktDaFQzV25FRkp1MXdqUDVCZk02cHVsSld2?=
 =?utf-8?B?RUY1c0U5WlNBOHBTQkEzT01xZTdkWVNvOU1KLzhHaUhJcjRseSszaWN0NnNm?=
 =?utf-8?B?U3hnYzFkOG9HRHhUamdUVllZazhJOXJ0Mk02bVBGMHIvUHRaZ1pZN3VCUnZk?=
 =?utf-8?B?czhZdjdoQzJ6VGhRaHBSckgxV3pReGFEK3BUQXp0aXo3VEVHZ2J3Y0Q3L0s1?=
 =?utf-8?B?RjRFWk91YklQN3QzMm42MUcydmJoeVlEYkVKUks3RnZ3NlhsS1lacW9KeGNo?=
 =?utf-8?B?TUpZaW8wTmk2Q0JMbHg2NDdWY2JubzBuT1loaXlITnpYd1VuTm1iWGt4M3Ft?=
 =?utf-8?B?YjFSNnBBaDh4cWJIQmRCSHR0aTV3cTRzSWdQNmU2VldQL1hJa3VvNTBJYVpQ?=
 =?utf-8?B?a1haaFNPMFRvdXloRHUrQU0yY0hrZlpxTDVWV0hKTXN3ZGlQVmF4b1E0OUgv?=
 =?utf-8?B?TVZqZThVak1ibW5RbWFxaUlLYzV0NjNNNFl4SUxORlpBUnpxTXpLVHpZaUZa?=
 =?utf-8?B?WU10RWFlQ3NGdWN5bzI0bWp4eXhhZ29BKytsVUhOZk5uTVN2MEY4U1FZU3pi?=
 =?utf-8?B?bHdDN29oT0J2RXlWV2twcC9vSG05U3N3Uk13eXAvcFcyTE8xOXFKY3Z6azc1?=
 =?utf-8?B?eXh3NzcwaG1QS0JiWjV5SWlaTXlzYTlCQWVqR0NxN0xQenNqTVZwUStVN3h3?=
 =?utf-8?B?SGROZ2tTaWg1d0d3VEJaQ0NLMmRmM3dWbjhqTTVrclZiOW5MQlhVcGFUR0s0?=
 =?utf-8?B?Y21zK1ZIV0ZYaCs5TzRraGIvODVXbTZpUHN0VXpUaE5PV1pYZkJhb3hxYWlM?=
 =?utf-8?B?Z2VJeGhWb1VIZng1bXRaUHNWVWlHMVFXQ3d1Ymg2aElkU2tZMjAzQzlMNW1W?=
 =?utf-8?B?TUJBekJxTFpEZmdrL3IvZkRNL0NoTnpKVkpzdGVHWXBGTkFCMGFSTis5QWEy?=
 =?utf-8?B?WG90aXVhaDBmOVFRNUpYLzduMUMxMnM5RXZoeDA0Q3RWa1F1RUpTQWdoTjZL?=
 =?utf-8?B?WThnTkxkdGpVbTZGYXUwUmIvWDF4VThPV3pJTDR2QUFFaStqbXlQWEhIQ2la?=
 =?utf-8?B?TFg4R2s0SHB0QWpqV2ljM1BlTEVoVWNRVHVWTHB2ZHp5T0JiK3JxK2JadTVK?=
 =?utf-8?B?QWFNcGxzQUlPMERaREdLdHJ4TVBGMURkdERpMVJjMFIyVlRUeWNLY3hKNnVz?=
 =?utf-8?B?bnlIbVRZSm5XSFdwMjA5QmpxMmF3OUhEVmRIMk9QVFhwQk5wOEpENXorRjdw?=
 =?utf-8?B?bkpQQWJFQlpGMHEzTUJDMjBNZE9KNkpqNTBZYXFVZEViSkNHbFNGdHZrM0RR?=
 =?utf-8?B?M2RVM1UyS3E1cUF4c2xnbEhPczhiWitGQUt6bUdxUVZhSDNzbGprbmdYNHlk?=
 =?utf-8?Q?HQTSpIbxXNEhPXTyNsLW3+RaXYtsYaIjickOqvG?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bbd0453b-2bef-47d0-1ff1-08d951427df8
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB5163.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2021 21:07:07.4681
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ji5dGN8LWfIULCShlJto0pRPKv90bdxgaM4kh9TTH3ltjwXgZGy9jNMBC3vvyXJyrg/Z0RiMuuwIVgrjV2HHwVIG7EQLOaDI7ODTB2SRbbE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2559
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On 7/27/21 10:44 AM, Tom Rix wrote:
>
> On 7/27/21 10:16 AM, Russ Weight wrote:
>>
>> On 7/27/21 9:55 AM, Tom Rix wrote:
>>> On 7/27/21 9:38 AM, Russ Weight wrote:
>>>> On 7/27/21 9:22 AM, Tom Rix wrote:
>>>>> On 7/27/21 9:15 AM, Russ Weight wrote:
>>>>>> On 7/27/21 6:24 AM, Tom Rix wrote:
>>>>>>> On 7/26/21 2:33 PM, Russ Weight wrote:
>>>>>>>> Hi Moritz,
>>>>>>>>
>>>>>>>> I sent this version of the patchset out on July 8th. The only discussion has
>>>>>>>> been around the compat-id structure. I think there is agreement that this can
>>>>>>>> be treated separately. What are your thoughts? Do you think this patchset is
>>>>>>>> ready?
>>>>>>> While I agree the compat_id can be treated separately, i still have a problem with the 2 register functions.
>>>>>>>
>>>>>>> In this discussion,
>>>>>>>
>>>>>>> https://lore.kernel.org/linux-fpga/DM6PR11MB38194D113950FA4B75C7F2C485E49@DM6PR11MB3819.namprd11.prod.outlook.com/
>>>>>>>
>>>>>>> *register_full(..., *info) becomes
>>>>>>>
>>>>>>> *register(..., *info)
>>>>>>>
>>>>>>> and
>>>>>>>
>>>>>>> *register_simple() is moved out of the public api and becomes private to the subsystem.
>>>>>> Somehow I missed that part of the email. I'm not sure I understand the part about
>>>>>> register_simple() "becomes private to the subsystem". Most users would call the simple
>>>>>> version of the API. Is the proposal to replicate the register_simple() interface
>>>>>> for each driver that calls it?
>>>>> Still use *register_simple() internally, so most of your patchset is unchanged.
>>>>>
>>>>> Move it out the public api. include/linux/fpga-mgr.h into someplace appropriate in drivers/fpga/
>>>> Ok - I'll do another spin of the patch set.
>>>>
>>>> Just to be clear, *register_full() gets renamed back to *register(). The current *register()
>>>> goes back to *register_simple(). *register_simple() is an exported symbol, but the function
>>>> prototype moves out of the public header file into private header file under drivers/fpga.
>>> Mostly.
>>>
>>> If register_simple does not need to be exported, it shouldn't be.
>> If *register_simple() is to reside in the fpga_mgr or fpga_region module and be
>> called by other modules, then it has to be exported... unless it is defined as a
>> static function in a header file. Shall I go that route instead? I could create
>> a new drivers/fpga/fpga.h file and add the *register_simple() functions there.
>> Or I could create separate drivers/fpga/fpga-mgr.h and drivers/fpga/fpga-region.h
>> header files with one static function each.
>
> good point, exporting ok

Before I do this, can I get others to chime in? There was a previous patchset that
used *register_simple() and *register(). It seemed that the consensus at that time
was that it should be *register() and *register_full(). I'm starting to feel like
I'm going in circles...

I personally don't have a problem with two public flavors of the register function
(the way it is now), what do other's think? If it really is a problem to have two
versions of the register function, maybe I should just change all of the callers
to declare a structure and call the same register function?

- Russ


>
> Tom
>
>>
>> - Russ
>>
>>> Tom
>>>
>>>> - Russ
>>>>
>>>>> Tom
>>>>>
>>>>>>> Tom
>>>>>>>
>>>>>>>> Thanks,
>>>>>>>> - Russ
>>>>>>>>
>>>>>>>>
>>>>>>>> On 7/26/21 2:27 PM, Russ Weight wrote:
>>>>>>>>> The FPGA framework has a convention of using managed resource functions
>>>>>>>>> to allow parent drivers to manage the data structures allocated by the
>>>>>>>>> class drivers. They use an empty *_dev_release() function to satisfy the
>>>>>>>>> class driver.
>>>>>>>>>
>>>>>>>>> This is inconsistent with linux driver model.
>>>>>>>>>
>>>>>>>>> These changes remove the managed resource functions and populate the class
>>>>>>>>> dev_release callback functions. They also merge the create() and register()
>>>>>>>>> functions into a single register() or register_full() function for each of
>>>>>>>>> the fpga-mgr, fpga-region, and fpga-bridge class drivers.
>>>>>>>>>
>>>>>>>>> The new *register_full() functions accept an info data structure to provide
>>>>>>>>> flexibility in passing optional parameters. The *register() functions
>>>>>>>>> support the legacy parameter list for users that don't require the use of
>>>>>>>>> optional parameters.
>>>>>>>>>
>>>>>>>>> For more context, refer to this email thread:
>>>>>>>>>
>>>>>>>>> https://marc.info/?l=linux-fpga&m=162127412218557&w=2
>>>>>>>>>
>>>>>>>>> I turned on the configs assocated with each of the modified files, but I
>>>>>>>>> must have been missing some dependencies, because not all of them compiled.
>>>>>>>>> I did a run-time test specifically with the dfl-fme infrastructure. This
>>>>>>>>> would have exercised the region, bridge, and fpga-mgr frameworks.
>>>>>>>>>
>>>>>>>>> Changelog v9 -> v10:
>>>>>>>>>       - Fixed commit messages to reference register_full() instead of
>>>>>>>>>         register_simple().
>>>>>>>>>       - Removed the fpga_bridge_register_full() function, because there is
>>>>>>>>>         not need for it yet. Updated the documentation and commit message
>>>>>>>>>         accordingly.
>>>>>>>>>       - Updated documentation to reference the fpga_manager_info and
>>>>>>>>>         fpga_region_info structures.
>>>>>>>>>
>>>>>>>>> Changelog v8 -> v9:
>>>>>>>>>       - Cleaned up documentation for the FPGA Manager, Bridge, and Region
>>>>>>>>>         register functions
>>>>>>>>>       - Renamed fpga_*_register() to fpga_*_register_full()
>>>>>>>>>       - Renamed fpga_*_register_simple() to fpga_*_register()
>>>>>>>>>       - Renamed devm_fpga_mgr_register() to devm_fpga_mgr_register_full()
>>>>>>>>>       - Renamed devm_fpga_mgr_register_simple() to devm_fpga_mgr_register()
>>>>>>>>>
>>>>>>>>> Changelog v7 -> v8:
>>>>>>>>>       - Added reviewed-by tags.
>>>>>>>>>       - Updated Documentation/driver-api/fpga/ files: fpga-mgr.rst,
>>>>>>>>>         fpga-bridge.rst, and fpga-region.rst.
>>>>>>>>>
>>>>>>>>> Changelog v6 -> v7:
>>>>>>>>>       - Update the commit messages to describe the new parameters for the
>>>>>>>>>         *register() functions and to mention the *register_simple() functions.
>>>>>>>>>       - Fix function prototypes in header file to rename dev to parent.
>>>>>>>>>       - Make use of the PTR_ERR_OR_ZERO() macro when possible.
>>>>>>>>>       - Some cleanup of comments.
>>>>>>>>>       - Update function definitions/prototypes to apply const to the new info
>>>>>>>>>         parameter.
>>>>>>>>>       - Verify that info->br_ops is non-null in the fpga_bridge_register()
>>>>>>>>>         function.
>>>>>>>>>       - Verify a non-null info pointer in the fpga_region_register() function.
>>>>>>>>>
>>>>>>>>> Changelog v5 -> v6:
>>>>>>>>>       - Moved FPGA manager/bridge/region optional parameters out of the ops
>>>>>>>>>         structure and back into the FPGA class driver structure.
>>>>>>>>>       - Changed fpga_*_register() function parameters to accept an info data
>>>>>>>>>         structure to provide flexibility in passing optional parameters.
>>>>>>>>>       - Added fpga_*_register_simple() functions to support current parameters
>>>>>>>>>         for users that don't require use of optional parameters.
>>>>>>>>>
>>>>>>>>> Changelog v4 -> v5:
>>>>>>>>>       - Rebased on top of recently accepted patches.
>>>>>>>>>       - Removed compat_id from the fpga_mgr_register() parameter list
>>>>>>>>>         and added it to the fpga_manager_ops structure. This also required
>>>>>>>>>         dynamically allocating the dfl-fme-ops structure in order to add
>>>>>>>>>         the appropriate compat_id.
>>>>>>>>>       - Created the fpga_region_ops data structure which is optionally passed
>>>>>>>>>         to fpga_region_register(). compat_id, the get_bridges() pointer, and
>>>>>>>>>         the priv pointer are included in the fpga_region_ops structure.
>>>>>>>>>
>>>>>>>>> Changelog v3 -> v4:
>>>>>>>>>       - Added the compat_id parameter to fpga_mgr_register() and
>>>>>>>>>         devm_fpga_mgr_register() to ensure that the compat_id is set before
>>>>>>>>>         the device_register() call.
>>>>>>>>>       - Added the compat_id parameter to fpga_region_register() to ensure
>>>>>>>>>         that the compat_id is set before the device_register() call.
>>>>>>>>>       - Modified the dfl_fpga_feature_devs_enumerate() function to restore
>>>>>>>>>         the fpga_region_register() call to the correct location.
>>>>>>>>>
>>>>>>>>> Changelog v2 -> v3:
>>>>>>>>>       - Cleaned up comment headers for fpga_mgr_register(), fpga_bridge_register(),
>>>>>>>>>         and fpga_region_register().
>>>>>>>>>       - Fixed error return on ida_simple_get() failure for fpga_mgr_register(),
>>>>>>>>>         fpga_bridge_register(), and fpga_region_register().
>>>>>>>>>       - Fixed error return value for fpga_bridge_register(): ERR_PTR(ret) instead
>>>>>>>>>         of NULL.
>>>>>>>>>
>>>>>>>>> Changelog v1 -> v2:
>>>>>>>>>       - Restored devm_fpga_mgr_register() functionality to the fpga-mgr
>>>>>>>>>         class driver, adapted for the combined create/register functionality.
>>>>>>>>>       - All previous callers of devm_fpga_mgr_register() will continue to call
>>>>>>>>>         devm_fpga_mgr_register().
>>>>>>>>>       - replaced unnecessary ternary operators in return statements with
>>>>>>>>>         standard if conditions.
>>>>>>>>>
>>>>>>>>> Russ Weight (3):
>>>>>>>>>       fpga: mgr: Use standard dev_release for class driver
>>>>>>>>>       fpga: bridge: Use standard dev_release for class driver
>>>>>>>>>       fpga: region: Use standard dev_release for class driver
>>>>>>>>>
>>>>>>>>>      Documentation/driver-api/fpga/fpga-bridge.rst |   6 +-
>>>>>>>>>      Documentation/driver-api/fpga/fpga-mgr.rst    |  38 +++-
>>>>>>>>>      Documentation/driver-api/fpga/fpga-region.rst |  12 +-
>>>>>>>>>      drivers/fpga/altera-cvp.c                     |  12 +-
>>>>>>>>>      drivers/fpga/altera-fpga2sdram.c              |  12 +-
>>>>>>>>>      drivers/fpga/altera-freeze-bridge.c           |  10 +-
>>>>>>>>>      drivers/fpga/altera-hps2fpga.c                |  12 +-
>>>>>>>>>      drivers/fpga/altera-pr-ip-core.c              |   7 +-
>>>>>>>>>      drivers/fpga/altera-ps-spi.c                  |   9 +-
>>>>>>>>>      drivers/fpga/dfl-fme-br.c                     |  10 +-
>>>>>>>>>      drivers/fpga/dfl-fme-mgr.c                    |  22 +-
>>>>>>>>>      drivers/fpga/dfl-fme-region.c                 |  17 +-
>>>>>>>>>      drivers/fpga/dfl.c                            |  12 +-
>>>>>>>>>      drivers/fpga/fpga-bridge.c                    | 122 +++-------
>>>>>>>>>      drivers/fpga/fpga-mgr.c                       | 215 ++++++++----------
>>>>>>>>>      drivers/fpga/fpga-region.c                    | 119 ++++------
>>>>>>>>>      drivers/fpga/ice40-spi.c                      |   9 +-
>>>>>>>>>      drivers/fpga/machxo2-spi.c                    |   9 +-
>>>>>>>>>      drivers/fpga/of-fpga-region.c                 |  10 +-
>>>>>>>>>      drivers/fpga/socfpga-a10.c                    |  16 +-
>>>>>>>>>      drivers/fpga/socfpga.c                        |   9 +-
>>>>>>>>>      drivers/fpga/stratix10-soc.c                  |  16 +-
>>>>>>>>>      drivers/fpga/ts73xx-fpga.c                    |   9 +-
>>>>>>>>>      drivers/fpga/xilinx-pr-decoupler.c            |  17 +-
>>>>>>>>>      drivers/fpga/xilinx-spi.c                     |  11 +-
>>>>>>>>>      drivers/fpga/zynq-fpga.c                      |  16 +-
>>>>>>>>>      drivers/fpga/zynqmp-fpga.c                    |   9 +-
>>>>>>>>>      include/linux/fpga/fpga-bridge.h              |  30 ++-
>>>>>>>>>      include/linux/fpga/fpga-mgr.h                 |  62 +++--
>>>>>>>>>      include/linux/fpga/fpga-region.h              |  36 ++-
>>>>>>>>>      30 files changed, 383 insertions(+), 511 deletions(-)
>>>>>>>>>
>

