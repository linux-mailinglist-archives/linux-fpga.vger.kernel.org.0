Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D952B42C85F
	for <lists+linux-fpga@lfdr.de>; Wed, 13 Oct 2021 20:09:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbhJMSL5 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 13 Oct 2021 14:11:57 -0400
Received: from mga18.intel.com ([134.134.136.126]:15236 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229967AbhJMSL4 (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 13 Oct 2021 14:11:56 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10136"; a="214439398"
X-IronPort-AV: E=Sophos;i="5.85,371,1624345200"; 
   d="scan'208";a="214439398"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2021 11:09:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,371,1624345200"; 
   d="scan'208";a="527123061"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by fmsmga008.fm.intel.com with ESMTP; 13 Oct 2021 11:09:51 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Wed, 13 Oct 2021 11:09:51 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Wed, 13 Oct 2021 11:09:51 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.47) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Wed, 13 Oct 2021 11:09:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LVLajRnpg6IyLR3k9NBPxVOX28823cknLkqlrZbTHOIfAk0PPVwVciG37LRC/Q6vuttPMLrw6I0U2CuYXVRBlxkIdyt95T1vmO+CTxznmTfxrjQkPyhNKXC9CbuAZYmJL25WKzhZnGuTmaYKE9+FOnurTl5x6DjqTNaqFeQUaytpjdZy6BQeSEhOwtZuqgX8PKxjOkAzluqQUi0+Hf4ax0GQUp/KLmuQ9LJXkWUh7ZPm9xnrlGpxMbGf57W6H/pV267QsBCXdho9c3egv+AZiqQ5e3K7cbEFOgSAIKKoGFLCJQ5msoBafMEfHIumVzCbQqfasYqoV9NOR1KuNfcnog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S0Jp+d62v4g0ZojmSbTA5xLsvvT95jwZXV9SEjGzYGE=;
 b=kRt48FoMm49BjaMaB+GezPtt8kZAL70q46Qg71yoHyj1WZibIpMdTrNllFLcWMH4sOi9+rbEif0OHPBCG0MSZIuo5uKngTZwQgOmbUEhwScOBy6wwZPyk2H6EwPM6KPJqabZNOOHh2+tExoox3aWCt6dihwlKI1fZo/Nj9D+YlT5Nw63EfVSlE55dR2ujhnB/PtGhtmoIoZfwwNvd1YyPze4L5RVsOpZ1UHRC/2aozCpan3Eek7yMJN5qf4IhR+AnVcd9Cz+jMDp4SpuGmoYNXla3+C5zIZHNyueu0a0Sd407H1pFr0DRoslQR+12woMKOqz2bJ0ISk1eSTsksqw2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S0Jp+d62v4g0ZojmSbTA5xLsvvT95jwZXV9SEjGzYGE=;
 b=F6vr7c3MjWWm6pdyY2fYVfW77cf/GwECg1pbDhn9CY25IxnJsvlCNtJcmgx2JYF8IkQ4upLSUy7U2eMgJxC4brKGIZ2nPIcFoBOfobLSZgo8iILvlmpePiuTR2qLfmLt6fn1SumoWVg8qkkm7wAsl7xfTLfQHcMO9JrdSR494n8=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
Received: from SA2PR11MB5163.namprd11.prod.outlook.com (2603:10b6:806:113::20)
 by SN6PR11MB2894.namprd11.prod.outlook.com (2603:10b6:805:d7::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.25; Wed, 13 Oct
 2021 18:09:46 +0000
Received: from SA2PR11MB5163.namprd11.prod.outlook.com
 ([fe80::a039:c121:4dce:5def]) by SA2PR11MB5163.namprd11.prod.outlook.com
 ([fe80::a039:c121:4dce:5def%8]) with mapi id 15.20.4587.026; Wed, 13 Oct 2021
 18:09:46 +0000
Subject: Re: [PATCH v17 0/5] FPGA Image Load (previously Security Manager)
To:     Xu Yilun <yilun.xu@intel.com>
CC:     Tom Rix <trix@redhat.com>, <mdf@kernel.org>,
        <linux-fpga@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lgoncalv@redhat.com>, <hao.wu@intel.com>,
        <matthew.gerlach@intel.com>
References: <20210929230025.68961-1-russell.h.weight@intel.com>
 <20211009080859.GA85181@yilunxu-OptiPlex-7050>
 <450ed897-f726-9671-26b7-2a24bb046e89@redhat.com>
 <20211011014154.GA82360@yilunxu-OptiPlex-7050>
 <79350773-3629-2734-21c0-0314a762e722@redhat.com>
 <336e4827-b09a-e1ab-b67d-d8755012d71c@intel.com>
 <20211012074752.GB95330@yilunxu-OptiPlex-7050>
 <e629eca0-a86c-4028-7bbf-65185699137b@intel.com>
 <20211013010617.GE95330@yilunxu-OptiPlex-7050>
From:   Russ Weight <russell.h.weight@intel.com>
Message-ID: <58036b2d-ca8f-2deb-f1b4-0301d633714b@intel.com>
Date:   Wed, 13 Oct 2021 11:09:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
In-Reply-To: <20211013010617.GE95330@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: SJ0PR03CA0239.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::34) To SA2PR11MB5163.namprd11.prod.outlook.com
 (2603:10b6:806:113::20)
MIME-Version: 1.0
Received: from [10.0.2.4] (50.43.42.212) by SJ0PR03CA0239.namprd03.prod.outlook.com (2603:10b6:a03:39f::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16 via Frontend Transport; Wed, 13 Oct 2021 18:09:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a17bbb66-2501-4fa0-31c6-08d98e74a364
X-MS-TrafficTypeDiagnostic: SN6PR11MB2894:
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR11MB2894FE13DEB3C5B0D8A11442C5B79@SN6PR11MB2894.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rSFYahCiLSBr69xMkGVs6U8eOOiXuA0fjq9FO6t0AxBdSSJiGCgCJqZYc3XtgBYkM9gErd8qxy7PBodLiuLneBZQogANcCgtRcT1PCaV+4ZehB3c15fqjO+PVotejsku10nQ52ZVa7OixzuuUTT7weitQERf+eqqFhVJuLXPdwmUVKXzhgtwqE20YeqIVEk7Eau9pvHNg3dc0+Uw03KMXgbyszpBp2RrH5/bWRG0WF+es5y7sZ05QQTWjaqhzTJYsHIXcEJCccSrALB0wx4BZjL/X/gUhV/rn57OEM834lN3K7l/dGOwC0yOI1FvXXzPqak3ubBWbebdHZsMtiqcZEsQvCBbJophNx/1J6qHAcY0JNMeSn2xh3iLyYhpokg+NwWqxxUpXxSirU2Dsrvk0d5vXUOCw8O+ngD0Es+sGOoZHr/v7j1zG1tnEyDFmSasMqXKneZw49ze+5TGEVef8Fp7Hjr/UEf/+QieZhY24P6L6z28WtEo0uFwuif+mDxJxESr9X3biME6wkpnKPpjmbzU8m7hsBmKtzrkePo8ZRSbSCzFcaL7kgfoymH3Iooiwr0M6OWCisotLlHFMKHK+Kotdr/Offsnup9/Tut3dLsawS/ci7/kAUL9lAUnIKb6lfvvkRvr8p4ZRBBNqEl4KlaQZmr6a3vKWeyj5QUE85GXNzGL/j2du1D07ECapEAur/8S03LR5U2ZWZczmxuoZYbg2SUnJYA5b3gb4KifKRBkn68AkCoWBn+Gb2StJ2B9aEZDidTtBsgm0LnD56qyYoIiSsw8nYwL9FvPzH9dk3XdMeL78wcmqkF7UP3YJ/tADTVkb8Nfl6NOoIHOcUJRG6LetMWd3QAanlgIK4a5Zu8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB5163.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66476007)(66556008)(6486002)(508600001)(6636002)(38100700002)(8676002)(86362001)(8936002)(31696002)(66946007)(16576012)(316002)(31686004)(82960400001)(26005)(36756003)(6666004)(15650500001)(107886003)(53546011)(83380400001)(37006003)(2616005)(6862004)(2906002)(966005)(956004)(4326008)(5660300002)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M2szbGtXNzI1M3hIVEhiQ2s3cGdjdW9pYm80U3BRaDJlUXR3T3FhVXU1OWVH?=
 =?utf-8?B?RE92VTJBV3l4NVh0REFsUnZRVWNMa2c1QjBpL0JoNys4WDh6SmhNR2t4NWtT?=
 =?utf-8?B?L01VTWloUnM2TUlPUkQxRUJVM09tM2dPaVVCeXNuUE1kUlNHdG9kUTRWK1BJ?=
 =?utf-8?B?OGdvQmRhVEVqVHlpa0E2UUtZeklkMllIZzVJQ1RBQkFNYlpKUzVzZjlqd2VS?=
 =?utf-8?B?elpHc05HNGRpWHZxN3JrOXdTQnRiMlI2T3NkWXZYL0tFSS8xdGlkRHNvVHAx?=
 =?utf-8?B?eHpzdXRyYmlwdWkwckJ4dU9naGwvSmhBV3kvZURDa1l5T0F6eHcxNHFPVldE?=
 =?utf-8?B?WERkZUhIUWc0L2NpTXlCeGFiWm1tT3QrcGp0dUtIc0JVeXVjcTVsbGxLajZN?=
 =?utf-8?B?QVBQMnVmN3Y5WlVuYnpZK1FBNENOMWJET0xKeXExcWR1K0VQY3UxMHU3bVNT?=
 =?utf-8?B?bkhTTjVMaTRHUjBPWWppalVXL1ZLYnpMNTdvWVpGMmtGRXdDMEp3WVc1OSt3?=
 =?utf-8?B?d3BJUTExYzhSSEdYQTFIbG0vT1hSVGVOdXVJZGNDblJKZ0lkbEtyM3ZIR3R0?=
 =?utf-8?B?ckdqSklFWUtvakFHaHUvZGtRb1M0Q3RYK09idU9EVWtBZjBMWjVnWHBOcTJD?=
 =?utf-8?B?SGdQOHJPT1pad2hoUWJOV1dwUkhPYnNtM2U3Ymo3Y2VPSjg2cDdZdUJKTXlx?=
 =?utf-8?B?ZGhQNENLdml0OWliN1FnNXlCUXRMY0w4dTErZ1RyRUQ4M3o0TTd3RlpyRVNl?=
 =?utf-8?B?engxUzBQMXBJZm43YWY0S2ZJbmJvOUhyODFVSmJFUERCT0hNWmFXWUFmUjd1?=
 =?utf-8?B?M3hGMkg4eks3Z3lCUTBVb2VzWmJPUXFnK0syQWpKTitvTVlBYXpQMCtIbGt5?=
 =?utf-8?B?SXdFMXQ4Z3NwL1hEYjA0R2pib3VJdURCbmZXTGlSeUhZL3VmWW83K3VNMXky?=
 =?utf-8?B?ZDAxVTFTcW9YNTJ3MDVGcTM2eXRzR0pkVFJxUUgzUHZvc3BTZzhCYTByZTFY?=
 =?utf-8?B?cFZiZzJnRldQTHB5ZWhEZ0lleC8wME5hcXN3ZTRNNDc5ZjZOS0pHOHcxbnRZ?=
 =?utf-8?B?NllEY3lZaDY1b2htZmpLOVNVRzdtaXBzTEFGTnU0T3Nmb2JBR0FteFA5SkJu?=
 =?utf-8?B?RkVVQ2tUN2N5ZitMU2pmMEdON0xGMlFzb1ZLZEFtL1p3L0VpbGxMMVhtNjhO?=
 =?utf-8?B?dDNJLzhwMGtucGJrdU9SdDQ0VkI1NHAwRDdqYS9LZmtTYWZSdFE4cEFkV3BQ?=
 =?utf-8?B?SklybUxDSzExZThrUnpjUVhXRitkL1BwWVR1NjJFZWcxVEU3UGkxQ0tScjRP?=
 =?utf-8?B?R0VyQUw2MGFmTmVPbjQyN0ZLa24zUmlzSEpucU9mRGxKYk1vUHE2ck40VFNt?=
 =?utf-8?B?N2xyYmtIQ2d6UU0vSWxXRld6VHFCSnlPT0VsckUwWXZSaTEwdVNxVEZ1NzQv?=
 =?utf-8?B?WUxrTllTZFlWd3JJU2U4SGgzNTJGeDF0Nm5UM3RvRE5UcXB3KzB6YVZaYUFh?=
 =?utf-8?B?U2l3VGJrdHlYSW5Xc1hLZnZ3ZW5HaUhKTEFmeElobVoyTVNidVZlcS9vNitv?=
 =?utf-8?B?RHY1ME1uSG1XVVRYQ0dTdVRyaGJ4ckxTOWR4UzBBMUJQU1FYZTltY3QydFlQ?=
 =?utf-8?B?KzFGZEtEay9Namk1N2lWdHk1WnR2R0RwV3AyNW9XVGplckFCbWZYTUE0OVRz?=
 =?utf-8?B?eEJYMEdXNk92MEwvSW9sQmRpTjVEb3hTcVBGVzZwNmxvUGlYd1I3aXFFNDln?=
 =?utf-8?Q?AaAtU+yLLryKzLFw44F+KYRHW67Q++9tMwFtxuW?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a17bbb66-2501-4fa0-31c6-08d98e74a364
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB5163.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2021 18:09:45.9891
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5FScSEjnbD9GE+C7X6t/mTA1PKJ1vhDvpcCdXKF1DweW0YjxB6BmM36sevit8XdxW9nWu8bdv02LVJt8vFzXlOVZ4iZklv7JsHswppdt578=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2894
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On 10/12/21 6:06 PM, Xu Yilun wrote:
> On Tue, Oct 12, 2021 at 10:20:15AM -0700, Russ Weight wrote:
>>
>> On 10/12/21 12:47 AM, Xu Yilun wrote:
>>> On Mon, Oct 11, 2021 at 06:00:16PM -0700, Russ Weight wrote:
>>>> On 10/11/21 5:35 AM, Tom Rix wrote:
>>>>> On 10/10/21 6:41 PM, Xu Yilun wrote:
>>>>>> On Sat, Oct 09, 2021 at 05:11:20AM -0700, Tom Rix wrote:
>>>>>>> On 10/9/21 1:08 AM, Xu Yilun wrote:
>>>>>>>> On Wed, Sep 29, 2021 at 04:00:20PM -0700, Russ Weight wrote:
>>>>>>>>> The FPGA Image Load framework provides an API to upload image
>>>>>>>>> files to an FPGA device. Image files are self-describing. They could
>>>>>>>>> contain FPGA images, BMC images, Root Entry Hashes, or other device
>>>>>>>>> specific files. It is up to the lower-level device driver and the
>>>>>>>>> target device to authenticate and disposition the file data.
>>>>>>>> I've reconsider the FPGA persistent image update again, and think we
>>>>>>>> may include it in FPGA manager framework.
>>>>>>>>
>>>>>>>> Sorry I raised this topic again when it is already at patch v17, but now
>>>>>>>> I need to consider more seriously than before.
>>>>>>>>
>>>>>>>> We have consensus the FPGA persistent image update is just like a normal
>>>>>>>> firmware update which finally writes the nvmem like flash or eeprom,
>>>>>>>> while the current FPGA manager deals with the active FPGA region update
>>>>>>>> and re-activation. Could we just expand the FPGA manager and let it handle
>>>>>>>> the nvmem update as well? Many FPGA cards have nvmem and downloaders
>>>>>>>> supports updating both FPGA region and nvmem.
>>>> The fpga-image-load driver is actually just a data transfer. The class
>>> IMHO, The fpga-mgr dev is also a data transfer. The fpga-region dev is
>>> acting as the FPGA region admin responsible for gating, transfering and
>>> re-enumerating.
>>>
>>> So my opinion is to add a new data transfer type and keep a unified process.
>>>
>>>> driver has no knowledge about what the data is or where/if the data will
>>>> be stored.
>>> The fpga-image-load driver knows the data will be stored in nvmem,
>> FYI: This is not strictly correct. In a coming product there is a
>> case where the data will be stored in RAM. Richard Gong was also
>> looking to use this driver to validate an image without programming
>> or storing it. The fpga-image-load driver has no expectation that
>> the data will be stored in nvmem, or even that it will be stored
>> at all.
> OK, we can discuss that use case then. But fundamentally a driver should
> be clear what it is doing.

The lower-level driver is, of course, clear what it is doing. And the
FPGA Image Load Framework simply provides a consistent API and manages
a potentially long-running data transfer in the context of a kernel
worker thread.

It sounds like you are saying that that is not "clear enough" in the
context of the FPGA Manager?

The files that are used with Intel PAC devices are self-describing. The
user-space tools, the class driver and the lower-level driver just pass
the data through to the card BMC without any knowledge of the content,
purpose or final destination of the data.

The card BMC will receive signed data, validate it, and process it as a
BMC image, an FPGA image, a Root Entry Hash, or a key cancellation. In
the n6000, it could also be part of a multi-step process for programming
SDM keys and the data may not be stored permanently.

> You may try to extend the FPGA framework to
> support nvmem storage, or image validation, but cannot say we feed the
> data to any engine undefined by the framework.

I'm not sure what you mean by "feed the data to any engine undefined by the
framework". I think the "engine" is the lower level driver/device that invokes
the fpga_mgr. The lower level driver, of course, is clear what it is doing.
The fpga_mgr cannot control what driver invokes it.

Are saying that when invoking the fpga-mgr, that it _must_ also pass descriptive
data. Meaning that a self-describing file alone is not acceptable?

Thanks,
- Russ

> Thanks,
> Yilun
>
>>> while
>>> the fpga-mgr knows the data will be stored in FPGA cells. They may need
>>> to know the exact physical position to store, may not, depends on what the
>>> HW engines are.
>>>
>>>> This functionality could, of course, be merged into the fpga-mgr. I did
>>>> a proof of concept of this a while back and we discussed the pros and cons.
>>>> See this email for a recap:
>>>>
>>>> https://marc.info/?l=linux-fpga&m=161998085507374&w=2
>>>>
>>>> Things have changed some with the evolution of the driver. The IOCTL
>>>> approach probably fits better than the sysfs implementation. At the time
>>>> it seemed that a merge would add unnecessary complexity without adding value.
>>> I think at least developers don't have to go through 2 sets of software
>>> stacks which are of the same concept. And adding some new features like
>>> optionally threading or canceling data transfer are also good to FPGA
>>> region update. And the nvmem update could also be benifit from exsiting
>>> implementations like scatter-gather buffers, in-kernel firmware loading.
>>>
>>> I try to explain myself according to each of your concern from that mail
>>> thread:
>>>
>>> Purpose of the 2 updates
>>> ========================
>>>
>>>   As I said before, I think they are both data transfer devices. FPGA
>>> region update gets extra support from fpga-region & fpga-bridge, and
>>> FPGA nvmem update could be a standalone fpga-mgr.
>>>
>>> Extra APIs that are unique to nvmem update
>>> ==========================================
>>>
>>>   cdev APIs for nvmem update:
>>>     Yes we need to expand the functionality so we need them.
>>>
>>>   available_images, image_load APIs for loading nvmem content to FPGA
>>>   region:
>>>     These are features in later patchsets which are not submitted, but we
>>>     could talk about it in advance. I think this is actually a FPGA region
>>>     update from nvmem, it also requires gating, data loading (no SW transfer)
>>>     and re-enumeration, or a single command to image_load HW may result system
>>>     disordered. The FPGA framework now only supports update from in-kernel
>>>     user data, maybe we add support for update from nvmem later.
>>>
>>>   fpga-mgr state extend:
>>>     I think it could be extended, The current states are not perfect,
>>>     adding something like IDLE or READY is just fine.
>>>
>>>   fpga-mgr status extend:
>>>     Add general error definitions as needed. If there is some status
>>>     that is quite vendor specific, expose it in low-level driver.
>>>
>>>   remaining-size:
>>>     Nice to have for all.
>>>
>>> Threading the update
>>> ====================
>>>
>>>   Also a good option for FPGA region update, maybe we also have a slow FPGA
>>>   reprogrammer?
>>>
>>> Cancelling the update
>>> ====================
>>>
>>>   Also a good option for FPGA region update if HW engine supports.
>> These are all good points.
>>
>> Thanks,
>> - Russ
>>> Thanks,
>>> Yilun
>>>
>>>>>>>> According to the patchset, the basic workflow of the 2 update types are
>>>>>>>> quite similar, get the data, prepare for the HW, write and complete.
>>>>>>>> They are already implemented in FPGA manager. We've discussed some
>>>>>>>> differences like threading or canceling the update, which are
>>>>>>>> not provided by FPGA manager but they may also nice to have for FPGA
>>>>>>>> region update. An FPGA region update may also last for a long time??
>>>>>>>> So I think having 2 sets of similar frameworks in FPGA is unnecessary.
>>>>>>>>
>>>>>>>> My quick mind is that we add some flags in struct fpga_mgr & struct
>>>>>>>> fpga_image_info to indicate the HW capability (support FPGA region
>>>>>>>> update or nvmem update or both) of the download engine and the provided
>>>>>>>> image type. Then the low-level driver knows how to download if it
>>>>>>>> supports both image types.An char device could be added for each fpga manager dev, providing the
>>>>>>>> user APIs for nvmem update. We may not use the char dev for FPGA region
>>>>>>>> update cause it changes the system HW devices and needs device hotplug
>>>>>>>> in FPGA region. We'd better leave it to FPGA region class, this is
>>>>>>>> another topic.
>>>> I'll give this some more thought and see if I can come up with some RFC
>>>> patches.
>>>>
>>>> - Russ
>>>>>>>> More discussion is appreciated.
>>>>>>> I also think fpga_mgr could be extended.
>>>>>>>
>>>>>>> In this patchset,
>>>>>>>
>>>>>>> https://lore.kernel.org/linux-fpga/20210625195849.837976-1-trix@redhat.com/
>>>>>>>
>>>>>>> A second, similar set of write ops was added to fpga_manger_ops,
>>>>>>>
>>>>>>> new bit/flag was added to fpga_image_info
>>>>>>>
>>>>>>> The intent was for dfl to add their specific ops to cover what is done in
>>>>>>> this patchset.
>>>>>> I think we don't have to add 2 ops for reconfig & reimage in framework,
>>>>>> the 2 processes are almost the same.
>>>>>>
>>>>>> Just add the _REIMAGE (or something else, NVMEM?) flag for
>>>>>> fpga_image_info, and low level drivers handle it as they do for other
>>>>>> flags.
>>>>>>
>>>>>> How do you think?
>>>>> A single set is fine.
>>>>>
>>>>> A difficult part of is the length of  time to do the write. The existing write should be improved to use a worker thread.
>>>>>
>>>>> Tom
>>>>>
>>>>>> Thanks,
>>>>>> Yilun
>>>>>>
>>>>>>> Any other driver would do similar.
>>>>>>>
>>>>>>> Is this close to what you are thinking ?
>>>>>>>
>>>>>>> Tom
>>>>>>>
>>>>>>>> Thanks,
>>>>>>>> Yilun
>>>>>>>>

