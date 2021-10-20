Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 856FB435020
	for <lists+linux-fpga@lfdr.de>; Wed, 20 Oct 2021 18:27:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbhJTQ3k (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 20 Oct 2021 12:29:40 -0400
Received: from mga09.intel.com ([134.134.136.24]:38205 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229943AbhJTQ3h (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 20 Oct 2021 12:29:37 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10143"; a="228697415"
X-IronPort-AV: E=Sophos;i="5.87,167,1631602800"; 
   d="scan'208";a="228697415"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2021 09:27:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,167,1631602800"; 
   d="scan'208";a="594726300"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga004.jf.intel.com with ESMTP; 20 Oct 2021 09:27:22 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Wed, 20 Oct 2021 09:27:22 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Wed, 20 Oct 2021 09:27:22 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.102)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Wed, 20 Oct 2021 09:27:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eoPkl7rAdWWXPItfdZnnialXvie8TNZy3JF7n/tZg9LfykpSGeyDXFMLvq53va8WAwm8X0u5DKJSB4EQtZXVqxS0GPebbfaI1bUTIDDkToeA7LfrKy+Ryoe8Ym0EDvE5AtNVfIxfSHeFeMaKinOT9ZIvgBhFwtrfM2EUzhfAHa43lii+uccva6F20HfI4TE/nA09LBNntS4SiubXeMozbODBhAE8DEOtKnVjbUZbg8iiKkBYPRrkdkgeWXsh4Cx37keL1brjl1Dcnn07tZ230rbb1FYEipEOHef7IEpgFvfxg8pfG9UTyO83gBmm55EuE1qVtrNXWlOFpmjcQE0pLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IVMMAzHqtpw2lXJHuto403CNKr7uB3rQBooVUc2oFYk=;
 b=hi0sKKJvRUqLBmferNVHoazIwj/nFHL6+ehW7sz3fw8tsDrXr0Bg37n8Qh6wqkEeGcxfHGL/xsHHqi+YK8VNCwZ6/VTZKsJh3t9kbgsFQn4xtpAAlEjtCBZOMquLVS1y1IE2skXqzRITtPZ7RwowqueMhhM3sYQZFJdU1uNn+dePEf1djNJCdFu4faQHSFg9LfKA9ZfGeYs3/k5jRPLPem8QMMB75Qh62CzmTf3LuzLcGNt0TuM55oFx2TSNkhVKZHE8URF2wU8uC4zp8HkHQP0hvrk5ovmxxNWeBDHwy5aQvrdGGDT5pDgoamBXx2UnruV+lWe9gbgQcLXCxwlt7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IVMMAzHqtpw2lXJHuto403CNKr7uB3rQBooVUc2oFYk=;
 b=EokZsg7S37jrDU153Kb7LiRhf39yFlrqyewdOcWH6l0cWg9icO4WuznbzRNLEvr8LiR1BDZM/TOrEHP01fUa2yL1Sf/eaqXrrwCb7JDZwh3UFJ/RvJONg2NcsE8hVMs/xSPyBBwpdGofX1vGHATe9fA7HRgJzYJa/0cxryhAaKM=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
Received: from SA2PR11MB5163.namprd11.prod.outlook.com (2603:10b6:806:113::20)
 by SN6PR11MB2893.namprd11.prod.outlook.com (2603:10b6:805:dc::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.17; Wed, 20 Oct
 2021 16:27:11 +0000
Received: from SA2PR11MB5163.namprd11.prod.outlook.com
 ([fe80::a039:c121:4dce:5def]) by SA2PR11MB5163.namprd11.prod.outlook.com
 ([fe80::a039:c121:4dce:5def%7]) with mapi id 15.20.4608.018; Wed, 20 Oct 2021
 16:27:11 +0000
Subject: Re: [PATCH v17 0/5] FPGA Image Load (previously Security Manager)
To:     Xu Yilun <yilun.xu@intel.com>
CC:     Tom Rix <trix@redhat.com>, <mdf@kernel.org>,
        <linux-fpga@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lgoncalv@redhat.com>, <hao.wu@intel.com>,
        <matthew.gerlach@intel.com>
References: <20211013010617.GE95330@yilunxu-OptiPlex-7050>
 <58036b2d-ca8f-2deb-f1b4-0301d633714b@intel.com>
 <20211014014947.GF95330@yilunxu-OptiPlex-7050>
 <7d1971d0-b50b-077f-2a82-83d822cd2ad7@intel.com>
 <20211015025140.GH95330@yilunxu-OptiPlex-7050>
 <2b26bea5-60d3-6763-00e8-9a94fa0bf45b@intel.com>
 <20211018081356.GB40070@yilunxu-OptiPlex-7050>
 <301850cf-9f34-530b-bd9c-fbe9bf9feee5@intel.com>
 <20211019025356.GC40070@yilunxu-OptiPlex-7050>
 <85d56e4b-5bed-693d-4f76-027173a6e7a0@intel.com>
 <20211020011608.GA145760@yilunxu-OptiPlex-7050>
From:   Russ Weight <russell.h.weight@intel.com>
Message-ID: <38cfb530-8826-7890-da59-c1dd33b9cc7d@intel.com>
Date:   Wed, 20 Oct 2021 09:27:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
In-Reply-To: <20211020011608.GA145760@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: TYAPR01CA0053.jpnprd01.prod.outlook.com
 (2603:1096:404:2b::17) To SA2PR11MB5163.namprd11.prod.outlook.com
 (2603:10b6:806:113::20)
MIME-Version: 1.0
Received: from [10.0.2.4] (50.43.42.212) by TYAPR01CA0053.jpnprd01.prod.outlook.com (2603:1096:404:2b::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.15 via Frontend Transport; Wed, 20 Oct 2021 16:27:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 87ce3000-5683-454d-71b2-08d993e6780b
X-MS-TrafficTypeDiagnostic: SN6PR11MB2893:
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <SN6PR11MB2893D30470E8D3807F6F2F1EC5BE9@SN6PR11MB2893.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Zj8chnvGTAWWuaQGRo1W7XQilQulOmMP2Kwqs9SwPzHqL0U10NmMrtw4DSk1qnyBuFHtPVg/q6fJEQVqGZpbRYrk1LYDmuTDpvk1k2RQ4FhL/Wd04FjCA7eLW1jPTovRJt2n/XtdLiVD2JLfnDfr1R41qqzaaJ3U8R4rS7Hcr9J9gIIh2WLCcyhf1Jdfl/zhB3JW5t7GE9RoDcBMqi15JEiHOu83gZN7LEsRUiBvhlhWBndz8tO3J6a0J4ZZjWwU+x0xhDDDp1YPyNB3Ygqw4Fr045vd/fG6tmiMJbcN8nBRHiwxQa0cz9vEgsEkPixEkJ0uuymU8+nD+dynUl6pUVzWO/UrpQ6uMW9Mnfbtl9o0Y644U91/JAqfQkgqigtsuRgRjJ588x87BmM4Y33NfnIEbYmPuxA3WrDS616FW10YUrq4Ts4nXAnhmxcs6hz0R455Kf28VbMfkVESttWt40fEFtIMYAsJo+RVGHkgB4TUM2PQl+W58pjeRBwwjclKSPwA3kIQ2slV6tMu3VhOCE5KXdCqPmm7qnjafxfRWXdWV2o78lvZHiZsLONvMp+Aq0hvaVz5kJjSO3rUaLqdzSwROgLUi5ItkdOA5bMl1pAsUUAMM3OxQH/gGrB6PYgFfmX3sFp6fGYpos2Sk/JTfYtyNJNtaAvqtyzNVJSVsE5ReK7T2fadItbdg7VOvES7zZZ6Jlm9YUVHZw6LNJSpHUPIOWmzVy/76dDrSAC0ursoCGinSfhJGKlC/JFK6/y3oW9qRsUSs+GP2JzAUeDOBp7teIuKdBfmfoS75virQUzwcuFaZWaozbdiLtkAAOpWgCs3irap+wyDTR5RMJbHwJ4BQCl1Zn5kKvj/KERF3xU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB5163.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(53546011)(30864003)(38100700002)(8676002)(15650500001)(2616005)(2906002)(66556008)(4326008)(6862004)(966005)(8936002)(6666004)(956004)(5660300002)(6636002)(66476007)(66946007)(6486002)(508600001)(107886003)(37006003)(16576012)(31686004)(31696002)(26005)(316002)(86362001)(186003)(83380400001)(36756003)(82960400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SXN4SUFYc0dKMHkwdS9NZThmQXZVN3I1UDdLRytjNitrY0h5UTNmU1c5c1Fi?=
 =?utf-8?B?OFExRXZFdnQ4UlRGSWNYOGlJNXYxZGh1amlJbXRLQW04VzQwVDJkZUI5b21M?=
 =?utf-8?B?UGt0eHdGQ2RJQy95aG9SckdDM1h6Sy9nSXNoUW0vYW9lTE5GNzF2dndXTHA0?=
 =?utf-8?B?eFFTYjEvME1pMDFmYWNnT0t2WWlKNWorbmJkTzVkSFNqZHVqTUZGMyt5VGps?=
 =?utf-8?B?UlNIMDMzSkpGb2pUdVh4THFjSVJvcmJjcjZ4SUJyemNjSGU2UW1PMUt6ZUtV?=
 =?utf-8?B?NGpEMXVqbUIvNUV2VXhIYlBreWJJKzVLRUNYZ2JydjJhb0I1WU9tTkVEaE4w?=
 =?utf-8?B?RnZhV0lXQ2d0MW82VmYwZFVLTCtkam1LMWZWOTlHUjczSEhoa1dsNkVQTW1N?=
 =?utf-8?B?MWUwRi9mVWp4cTVlaW95dmJwVEYwWGJOMGFMUXE1VlV2OHFPUk5GdmNpUXhv?=
 =?utf-8?B?ZTFnNDg5MUdPYzNqSjdQM0RvdnEwOWg1S2NHd2lNWC9SRVdUU3NUM25HTVF5?=
 =?utf-8?B?MEoyL3pWN1VsNUpvam04MkVJZXpqbzN0MDRyZHVNUENYeitxaWVMVUUyOFU4?=
 =?utf-8?B?QmtZTThTenhCMDRWbVlOOHU0SWxkUEliemlLWTBOdGs0UEg2MEJxWlhZTUkv?=
 =?utf-8?B?WmlHSFZES29tYkdrY0s3M3BrNklFcjY1Q0lFQ3hlZlBXbkpxVHgwd0p6c3VB?=
 =?utf-8?B?cm5UL3A1V2hmYlVYZUJDWkx4ZDJnUXRsVldwLzlBc2tzbUYxT3lHajRGcDdG?=
 =?utf-8?B?Mmx0RHIwZkdvekQyZ3VVWXpHWEg4b0xRblVhR3U4QzNxd0g2Q0xhbURXUzRT?=
 =?utf-8?B?N1VneVJZMWZMTGFBWGlZUGxoekkwVlBOam8yeWZvb25jSHZhRDhiSHZBVGtO?=
 =?utf-8?B?a0VtWm0wZmQxcHdxVmxWMDNhVzJoanREcXJMV21IWXBCQnVFTFA2MnYxcldv?=
 =?utf-8?B?NE5qaGttUGl1YkV4K3dlS0pIQU1Ga05BTjc3dDg5TE8yNVZJeGlCQzNSU2Ft?=
 =?utf-8?B?ZmtsSDNIMkVLbkdSeXpIL1JjSHVnVnlZUTB5UmYyOUZTa3RJcDFoQ2JNRjBZ?=
 =?utf-8?B?UWd4WmVMUWlGSUoxbGVHcUQwdU1OS0xzVVIwRUE2SUNGT1Z0UnhKTGw0d0RG?=
 =?utf-8?B?dnlnalBZZUZmOVlUTDRMdWIrOVN4cmxVcUlIMjVVYTFxOC9ESXJiM0hpNWdW?=
 =?utf-8?B?L085TTdod3ZBczZneCt2cU5nWmU1alNzRCt5NVJ2RzJVd2J0KzNGek5vc2da?=
 =?utf-8?B?WHNLcGFwSE5oSEk1T08yS2RPbk9aa2YxOWg5N1RGcXVhdGhNU3JiUmJ5bXhP?=
 =?utf-8?B?ajB0eHI0NDlUQjBkMGFuWVovV1c3WmdVVjNZTUtXSTdEbFo5V2h3WVhBY1lQ?=
 =?utf-8?B?R2d0K3Z2a1FzaTNnNWpDeGhQcEdvaWwraUd1SjZGN2hkNDRxMjlQdWgxN0Vp?=
 =?utf-8?B?NzB1eXczOHBiSSttYzdUeDA0b3VwR3g5dEJ1N2FhMXJET3pXenRJSTNPOGkx?=
 =?utf-8?B?Rm5QWTdiWCtpR2JsSXo5bmRBMFFWNkVya0ZydWhVdHBOTFVkQjRqTkk3OHla?=
 =?utf-8?B?b3QzZFNidVFOd3JFdmVocGRneXNBb2R4YVRzdm1ETkh3S2JKOEdSYmZrN05O?=
 =?utf-8?B?ZkQ3RzRZMHF4dUdZZHl0cENwcXRaN0tCL1E4RFM5TmtTQzhVbXR6NnNJMjVt?=
 =?utf-8?B?djhlSUMzTXZEMVcvZk9sK3F0dVZrUmFweWRDTCtDWElVRnR6YVR5bzBCUUZW?=
 =?utf-8?Q?2dqjy/8Tbn/NQ9h5PhUgGojblQ1Ap2VlVXEVNxn?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 87ce3000-5683-454d-71b2-08d993e6780b
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB5163.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2021 16:27:11.8031
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: russell.h.weight@intel.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2893
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On 10/19/21 6:16 PM, Xu Yilun wrote:
> On Tue, Oct 19, 2021 at 08:09:46AM -0700, Russ Weight wrote:
>>
>> On 10/18/21 7:53 PM, Xu Yilun wrote:
>>> On Mon, Oct 18, 2021 at 09:24:08AM -0700, Russ Weight wrote:
>>>> On 10/18/21 1:13 AM, Xu Yilun wrote:
>>>>> On Fri, Oct 15, 2021 at 10:34:23AM -0700, Russ Weight wrote:
>>>>>> On 10/14/21 7:51 PM, Xu Yilun wrote:
>>>>>>> On Thu, Oct 14, 2021 at 09:32:53AM -0700, Russ Weight wrote:
>>>>>>>> On 10/13/21 6:49 PM, Xu Yilun wrote:
>>>>>>>>> On Wed, Oct 13, 2021 at 11:09:08AM -0700, Russ Weight wrote:
>>>>>>>>>> On 10/12/21 6:06 PM, Xu Yilun wrote:
>>>>>>>>>>> On Tue, Oct 12, 2021 at 10:20:15AM -0700, Russ Weight wrote:
>>>>>>>>>>>> On 10/12/21 12:47 AM, Xu Yilun wrote:
>>>>>>>>>>>>> On Mon, Oct 11, 2021 at 06:00:16PM -0700, Russ Weight wrote:
>>>>>>>>>>>>>> On 10/11/21 5:35 AM, Tom Rix wrote:
>>>>>>>>>>>>>>> On 10/10/21 6:41 PM, Xu Yilun wrote:
>>>>>>>>>>>>>>>> On Sat, Oct 09, 2021 at 05:11:20AM -0700, Tom Rix wrote:
>>>>>>>>>>>>>>>>> On 10/9/21 1:08 AM, Xu Yilun wrote:
>>>>>>>>>>>>>>>>>> On Wed, Sep 29, 2021 at 04:00:20PM -0700, Russ Weight wrote:
>>>>>>>>>>>>>>>>>>> The FPGA Image Load framework provides an API to upload image
>>>>>>>>>>>>>>>>>>> files to an FPGA device. Image files are self-describing. They could
>>>>>>>>>>>>>>>>>>> contain FPGA images, BMC images, Root Entry Hashes, or other device
>>>>>>>>>>>>>>>>>>> specific files. It is up to the lower-level device driver and the
>>>>>>>>>>>>>>>>>>> target device to authenticate and disposition the file data.
>>>>>>>>>>>>>>>>>> I've reconsider the FPGA persistent image update again, and think we
>>>>>>>>>>>>>>>>>> may include it in FPGA manager framework.
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>> Sorry I raised this topic again when it is already at patch v17, but now
>>>>>>>>>>>>>>>>>> I need to consider more seriously than before.
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>> We have consensus the FPGA persistent image update is just like a normal
>>>>>>>>>>>>>>>>>> firmware update which finally writes the nvmem like flash or eeprom,
>>>>>>>>>>>>>>>>>> while the current FPGA manager deals with the active FPGA region update
>>>>>>>>>>>>>>>>>> and re-activation. Could we just expand the FPGA manager and let it handle
>>>>>>>>>>>>>>>>>> the nvmem update as well? Many FPGA cards have nvmem and downloaders
>>>>>>>>>>>>>>>>>> supports updating both FPGA region and nvmem.
>>>>>>>>>>>>>> The fpga-image-load driver is actually just a data transfer. The class
>>>>>>>>>>>>> IMHO, The fpga-mgr dev is also a data transfer. The fpga-region dev is
>>>>>>>>>>>>> acting as the FPGA region admin responsible for gating, transfering and
>>>>>>>>>>>>> re-enumerating.
>>>>>>>>>>>>>
>>>>>>>>>>>>> So my opinion is to add a new data transfer type and keep a unified process.
>>>>>>>>>>>>>
>>>>>>>>>>>>>> driver has no knowledge about what the data is or where/if the data will
>>>>>>>>>>>>>> be stored.
>>>>>>>>>>>>> The fpga-image-load driver knows the data will be stored in nvmem,
>>>>>>>>>>>> FYI: This is not strictly correct. In a coming product there is a
>>>>>>>>>>>> case where the data will be stored in RAM. Richard Gong was also
>>>>>>>>>>>> looking to use this driver to validate an image without programming
>>>>>>>>>>>> or storing it. The fpga-image-load driver has no expectation that
>>>>>>>>>>>> the data will be stored in nvmem, or even that it will be stored
>>>>>>>>>>>> at all.
>>>>>>>>>>> OK, we can discuss that use case then. But fundamentally a driver should
>>>>>>>>>>> be clear what it is doing.
>>>>>>>>>> The lower-level driver is, of course, clear what it is doing. And the
>>>>>>>>>> FPGA Image Load Framework simply provides a consistent API and manages
>>>>>>>>>> a potentially long-running data transfer in the context of a kernel
>>>>>>>>>> worker thread.
>>>>>>>>>>
>>>>>>>>>> It sounds like you are saying that that is not "clear enough" in the
>>>>>>>>>> context of the FPGA Manager?
>>>>>>>>>>
>>>>>>>>>> The files that are used with Intel PAC devices are self-describing. The
>>>>>>>>>> user-space tools, the class driver and the lower-level driver just pass
>>>>>>>>>> the data through to the card BMC without any knowledge of the content,
>>>>>>>>>> purpose or final destination of the data.
>>>>>>>>>>
>>>>>>>>>> The card BMC will receive signed data, validate it, and process it as a
>>>>>>>>>> BMC image, an FPGA image, a Root Entry Hash, or a key cancellation. In
>>>>>>>>> I category all these actions as firmware update fully or partially on
>>>>>>>>> persistent storage. The FPGA Manager don't have to know the meaning of
>>>>>>>>> every byte on flash, but it should be aware the firmware is updated and
>>>>>>>>> the card may acts differently with a new firmware. This is the common
>>>>>>>>> working model for most of the FPGA cards so that we implement it in FPGA
>>>>>>>>> manager class. 
>>>>>>>>>
>>>>>>>>>> the n6000, it could also be part of a multi-step process for programming
>>>>>>>>>> SDM keys and the data may not be stored permanently.
>>>>>>>>> This is new to me, but seems to be different from firmware update, so lets
>>>>>>>>> think about it again.
>>>>>>>>>
>>>>>>>>>>> You may try to extend the FPGA framework to
>>>>>>>>>>> support nvmem storage, or image validation, but cannot say we feed the
>>>>>>>>>>> data to any engine undefined by the framework.
>>>>>>>>>> I'm not sure what you mean by "feed the data to any engine undefined by the
>>>>>>>>>> framework". I think the "engine" is the lower level driver/device that invokes
>>>>>>>>>> the fpga_mgr. The lower level driver, of course, is clear what it is doing.
>>>>>>>>>> The fpga_mgr cannot control what driver invokes it.
>>>>>>>>>>
>>>>>>>>>> Are saying that when invoking the fpga-mgr, that it _must_ also pass descriptive
>>>>>>>>>> data. Meaning that a self-describing file alone is not acceptable?
>>>>>>>>> The class driver should define a reasonable working model and APIs.
>>>>>>>>> Updating the FPGA backup storage is good to me. But receiving a mystery
>>>>>>>>> box and do whatever it requires is not.
>>>>>>>>>
>>>>>>>>> Self-describing file is OK, encryption is OK, but either the class
>>>>>>>>> driver itself, or with the help of the low level driver, should make
>>>>>>>>> sure it works within its scope.
>>>>>>>> In our secure update process, the card BMC firmware authenticates
>>>>>>>> the data using the root entry hashes and will either reject the
>>>>>>>> data or perform some function based on the contents. Neither the
>>>>>>>> user-space, the class driver, nor the lower level driver know
>>>>>>>> what the contents are. It _is_ a "mystery box" to them. How do we
>>>>>>>> verify scope in this model?
>>>>>>> I think we need to find out how. One case is, the HW is designed to have
>>>>>>> one single function, such as firmware update, then any image input
>>>>>>> through firmware update API is within expectation, and the driver
>>>>>>> should only serve the firmware update API. I think this is how the
>>>>>>> N3000 is working now. If the HW is for another function, register itself
>>>>>>> to serve another API, or another class driver.
>>>>>>>
>>>>>>> Another case is, the HW could do multiple types of tasks depending on
>>>>>>> the content of the image, such as firmware update, image verification,
>>>>>>> or assumably power off the card ... There should be some mechanism for
>>>>>>> the driver to only accept the right image according to what API is called.
>>>>>>> Or the user may input an image named update_the_card.img through
>>>>>>> firmware update API and finally get the card off. Having some headers
>>>>>>> readable by host for the operation type? Or, some HW interface for host
>>>>>>> to apply the operation type as well as the image, let the HW verify?
>>>>>>> Let's think about it.
>>>>>> I'm not sure if I am following your thinking here. The HW, of course,
>>>>>> verifies authentication of the image and acts according to the image
>>>>>> type. I don't think it is reasonable to require the class driver to
>>>>>> interpret the data to determine what it is. That implies that the
>>>>>> class driver would have to know the header format and possible values.
>>>>>> It also means that changes to the header format would require patches
>>>>>> to the class driver.
>>>>>>
>>>>>> The FPGA card is trusted by virtue of the fact that the customer
>>>>>> purchased it and physically placed it in the machine. If the FPGA card
>>>>>> (or the lower level driver) validates the image, then why does the
>>>>>> Class driver need to be concerned about the file type? I think the
>>>>>> purpose of the class driver is primarily to provide a common API and
>>>>>> perform common functions so that they don't have to be replicated
>>>>>> among similar low-level drivers. It is up to the low-level driver
>>>>>> or the device itself to ensure that the data received is acceptable.
>>>>>>
>>>>>> If the card receives data through the fpga-mgr upload facility that
>>>>>> isn't strictly a firmware update, and if the lower-level driver or
>>>>>> the card handles it and returns appropriate status - is that really
>>>>>> a problem?
>>>>>>>> As you have noted, most current cases result in a change to the
>>>>>>>> card, and I suspect that it will remain that way. But that can't be
>>>>>>>> guaranteed, and I'm not convinced that a host driver needs to be
>>>>>>>> concerned about it.
>>>>>>> A host driver should know what is done, in some abstraction level.
>>>>>>> I think updating the persistent storage is an acceptable abstraction
>>>>>>> in FPGA domain, so I'd like to extend it in FPGA manager. But doing
>>>>>>> anything according to the image is not.
>>>>>> By host driver, do you mean the class driver? Or the lower-level device
>>>>>> driver?
>>>>> The class driver.
>>>>>
>>>>>> It seems to me that you are saying that self-describing images are not
>>>>>> acceptable? Or at least they are not acceptable payload for an FPGA
>>>>>> Manager firmware-update API?
>>>>> For N3000, we are working on the persistent storage update APIs, which is
>>>>> a much simpler working model, no runtime device change, and needs no
>>>>> device removal & re-enumeration.
>>>>>
>>>>> But if you need to extend something more that would potentially changes
>>>>> the behavior of the running devices on FPGA, device removal &
>>>>> re-enumeration are needed so that the system knows what devices are
>>>>> changed.
>>>>>
>>>>>> The FPGA Image Load Framework was designed with the concept of
>>>>>> transferring data to a device without imposing a purpose on the data.
>>>>>> The expectation is that the lower-level driver or the device will
>>>>>> validate the data. Is there something fundamentally wrong with that
>>>>> I think there is something wrong here. As I said before, persistent
>>>>> storage updating has different software process from some runtime
>>>>> updating, so the class driver should be aware of what the HW engine
>>>>> is doing.
>>>> So far, there are no self-describing images that cause a
>>>> change in run-time behavior, and I don't think that will
>>>> happen for the very reason that the class-driver would
>>>> need to know about it.
>>> Again, the class driver needs to know what is happening, at some
>>> abstraction level, to ensure the system is aligned with the HW state.
>>>
>>> If the class driver cannot tell the detail, it has to assume the
>>> whole FPGA region will be changed, and removal & re-enumeration is
>>> needed.
>> So we make it a requirement that the self-describing files
>> cannot make changes that require the class driver to manage
>> state.
> The API should not only define what it won't do, but also define what
> it will do. But the "image load" just specifies the top half of the
> process. So I don't think this API would be accepted.
So what is the path forward. It seems like you are saying
that the self-describing files do not fit in the fpga-mgr.
Can we reconsider the FPGA Image Load Framework, which does
not make any assumptions about the contents of the image
files?

>
>>>> When I asserted that not all self-describing images are
>>>> changing firmware, I did not mean to imply that they change
>>>> run-time behavior; they do not. They are part of a multi-
>>>> step update of firmware. However, looking at each part of
>>>> the sequence independently, there is at least one instance
>>>> where a certificate is stored in RAM for temporary use.
>>>> When the driver exits from this call, there is no firmware
>>>> change. There is also no change in run-time behavior.
>>>>
>>>> I'm thinking we could have different IOCTLs:
>>>>
>>>> (1) firmware  update (address, size, purpose provided
>>>>     with the image)
>>> Will the firmware update use the self-describing files?
>> The firmware update option would be for files that
>> are not self-describing.
>>>> (2) image upload (self-describing files)
>>> If both 1 & 2 use self-describing files, how the class driver verifies
>>> the type of the file without looking into the file?
>> Only 2 would use self-describing files.
> Which IOCTL the N3000 flash secure update will use?
It would use 2. All of our image update files are self-describing.

- Russ
>
> Thanks,
> Yilun
>
>> - Russ
>>> For example, if a user calls a firmware update API but inputs an image
>>> upload file, will the class driver block the call? How?
>>>
>>>> (3) image validation
>>>>
>>>> These would all use most of the same code, but the FPGA
>>>> Manager flags and structure fields would be set differently.
>>> This is good to me.
>>>
>>> Thanks,
>>> Yilun
>>>
>>>> - Russ
>>>>> Thanks,
>>>>> Yilun
>>>>>
>>>>>> approach? And if not, why couldn't we incorporate a similar image_load
>>>>>> API into the FPGA Manager?
>>>>>>
>>>>>> - Russ
>>>>>>
>>>>>>> Thanks,
>>>>>>> Yilun
>>>>>>>
>>>>>>>> - Russ
>>>>>>>>
>>>>>>>>> Thanks,
>>>>>>>>> Yilun
>>>>>>>>>
>>>>>>>>>> Thanks,
>>>>>>>>>> - Russ
>>>>>>>>>>
>>>>>>>>>>> Thanks,
>>>>>>>>>>> Yilun
>>>>>>>>>>>
>>>>>>>>>>>>> while
>>>>>>>>>>>>> the fpga-mgr knows the data will be stored in FPGA cells. They may need
>>>>>>>>>>>>> to know the exact physical position to store, may not, depends on what the
>>>>>>>>>>>>> HW engines are.
>>>>>>>>>>>>>
>>>>>>>>>>>>>> This functionality could, of course, be merged into the fpga-mgr. I did
>>>>>>>>>>>>>> a proof of concept of this a while back and we discussed the pros and cons.
>>>>>>>>>>>>>> See this email for a recap:
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> https://marc.info/?l=linux-fpga&m=161998085507374&w=2
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Things have changed some with the evolution of the driver. The IOCTL
>>>>>>>>>>>>>> approach probably fits better than the sysfs implementation. At the time
>>>>>>>>>>>>>> it seemed that a merge would add unnecessary complexity without adding value.
>>>>>>>>>>>>> I think at least developers don't have to go through 2 sets of software
>>>>>>>>>>>>> stacks which are of the same concept. And adding some new features like
>>>>>>>>>>>>> optionally threading or canceling data transfer are also good to FPGA
>>>>>>>>>>>>> region update. And the nvmem update could also be benifit from exsiting
>>>>>>>>>>>>> implementations like scatter-gather buffers, in-kernel firmware loading.
>>>>>>>>>>>>>
>>>>>>>>>>>>> I try to explain myself according to each of your concern from that mail
>>>>>>>>>>>>> thread:
>>>>>>>>>>>>>
>>>>>>>>>>>>> Purpose of the 2 updates
>>>>>>>>>>>>> ========================
>>>>>>>>>>>>>
>>>>>>>>>>>>>   As I said before, I think they are both data transfer devices. FPGA
>>>>>>>>>>>>> region update gets extra support from fpga-region & fpga-bridge, and
>>>>>>>>>>>>> FPGA nvmem update could be a standalone fpga-mgr.
>>>>>>>>>>>>>
>>>>>>>>>>>>> Extra APIs that are unique to nvmem update
>>>>>>>>>>>>> ==========================================
>>>>>>>>>>>>>
>>>>>>>>>>>>>   cdev APIs for nvmem update:
>>>>>>>>>>>>>     Yes we need to expand the functionality so we need them.
>>>>>>>>>>>>>
>>>>>>>>>>>>>   available_images, image_load APIs for loading nvmem content to FPGA
>>>>>>>>>>>>>   region:
>>>>>>>>>>>>>     These are features in later patchsets which are not submitted, but we
>>>>>>>>>>>>>     could talk about it in advance. I think this is actually a FPGA region
>>>>>>>>>>>>>     update from nvmem, it also requires gating, data loading (no SW transfer)
>>>>>>>>>>>>>     and re-enumeration, or a single command to image_load HW may result system
>>>>>>>>>>>>>     disordered. The FPGA framework now only supports update from in-kernel
>>>>>>>>>>>>>     user data, maybe we add support for update from nvmem later.
>>>>>>>>>>>>>
>>>>>>>>>>>>>   fpga-mgr state extend:
>>>>>>>>>>>>>     I think it could be extended, The current states are not perfect,
>>>>>>>>>>>>>     adding something like IDLE or READY is just fine.
>>>>>>>>>>>>>
>>>>>>>>>>>>>   fpga-mgr status extend:
>>>>>>>>>>>>>     Add general error definitions as needed. If there is some status
>>>>>>>>>>>>>     that is quite vendor specific, expose it in low-level driver.
>>>>>>>>>>>>>
>>>>>>>>>>>>>   remaining-size:
>>>>>>>>>>>>>     Nice to have for all.
>>>>>>>>>>>>>
>>>>>>>>>>>>> Threading the update
>>>>>>>>>>>>> ====================
>>>>>>>>>>>>>
>>>>>>>>>>>>>   Also a good option for FPGA region update, maybe we also have a slow FPGA
>>>>>>>>>>>>>   reprogrammer?
>>>>>>>>>>>>>
>>>>>>>>>>>>> Cancelling the update
>>>>>>>>>>>>> ====================
>>>>>>>>>>>>>
>>>>>>>>>>>>>   Also a good option for FPGA region update if HW engine supports.
>>>>>>>>>>>> These are all good points.
>>>>>>>>>>>>
>>>>>>>>>>>> Thanks,
>>>>>>>>>>>> - Russ
>>>>>>>>>>>>> Thanks,
>>>>>>>>>>>>> Yilun
>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>> According to the patchset, the basic workflow of the 2 update types are
>>>>>>>>>>>>>>>>>> quite similar, get the data, prepare for the HW, write and complete.
>>>>>>>>>>>>>>>>>> They are already implemented in FPGA manager. We've discussed some
>>>>>>>>>>>>>>>>>> differences like threading or canceling the update, which are
>>>>>>>>>>>>>>>>>> not provided by FPGA manager but they may also nice to have for FPGA
>>>>>>>>>>>>>>>>>> region update. An FPGA region update may also last for a long time??
>>>>>>>>>>>>>>>>>> So I think having 2 sets of similar frameworks in FPGA is unnecessary.
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>> My quick mind is that we add some flags in struct fpga_mgr & struct
>>>>>>>>>>>>>>>>>> fpga_image_info to indicate the HW capability (support FPGA region
>>>>>>>>>>>>>>>>>> update or nvmem update or both) of the download engine and the provided
>>>>>>>>>>>>>>>>>> image type. Then the low-level driver knows how to download if it
>>>>>>>>>>>>>>>>>> supports both image types.An char device could be added for each fpga manager dev, providing the
>>>>>>>>>>>>>>>>>> user APIs for nvmem update. We may not use the char dev for FPGA region
>>>>>>>>>>>>>>>>>> update cause it changes the system HW devices and needs device hotplug
>>>>>>>>>>>>>>>>>> in FPGA region. We'd better leave it to FPGA region class, this is
>>>>>>>>>>>>>>>>>> another topic.
>>>>>>>>>>>>>> I'll give this some more thought and see if I can come up with some RFC
>>>>>>>>>>>>>> patches.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> - Russ
>>>>>>>>>>>>>>>>>> More discussion is appreciated.
>>>>>>>>>>>>>>>>> I also think fpga_mgr could be extended.
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> In this patchset,
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> https://lore.kernel.org/linux-fpga/20210625195849.837976-1-trix@redhat.com/
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> A second, similar set of write ops was added to fpga_manger_ops,
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> new bit/flag was added to fpga_image_info
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> The intent was for dfl to add their specific ops to cover what is done in
>>>>>>>>>>>>>>>>> this patchset.
>>>>>>>>>>>>>>>> I think we don't have to add 2 ops for reconfig & reimage in framework,
>>>>>>>>>>>>>>>> the 2 processes are almost the same.
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> Just add the _REIMAGE (or something else, NVMEM?) flag for
>>>>>>>>>>>>>>>> fpga_image_info, and low level drivers handle it as they do for other
>>>>>>>>>>>>>>>> flags.
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> How do you think?
>>>>>>>>>>>>>>> A single set is fine.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> A difficult part of is the length of  time to do the write. The existing write should be improved to use a worker thread.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> Tom
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> Thanks,
>>>>>>>>>>>>>>>> Yilun
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> Any other driver would do similar.
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> Is this close to what you are thinking ?
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> Tom
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>> Thanks,
>>>>>>>>>>>>>>>>>> Yilun
>>>>>>>>>>>>>>>>>>

