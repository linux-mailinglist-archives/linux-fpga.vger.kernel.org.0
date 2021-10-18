Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E51904323C5
	for <lists+linux-fpga@lfdr.de>; Mon, 18 Oct 2021 18:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233679AbhJRQ0e (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 18 Oct 2021 12:26:34 -0400
Received: from mga17.intel.com ([192.55.52.151]:22515 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233671AbhJRQ0d (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 18 Oct 2021 12:26:33 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10141"; a="209079870"
X-IronPort-AV: E=Sophos;i="5.85,382,1624345200"; 
   d="scan'208";a="209079870"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2021 09:24:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,382,1624345200"; 
   d="scan'208";a="629251769"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga001.fm.intel.com with ESMTP; 18 Oct 2021 09:24:21 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Mon, 18 Oct 2021 09:24:20 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Mon, 18 Oct 2021 09:24:20 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.177)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Mon, 18 Oct 2021 09:24:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V+2mHUd3JYl3JRalTNEijrMaQD6CznzAMtgcZR6kdABzIP9+wrPDdWZcEUQVEINgzWe7e1Ndres7rkpkA88lczOGhoOsZayIR4W6vBzIfF5eve7qwHMqw5y8lZCh/YDRh8PWc9NP3Yn4Q5l/Ydvk3dVcjgiqzxdj0ejyqe41m7KTnKGNNtmEL7QKxIXxD+HoOexdrQfa7fSLe+RXaA1Rn7as2mRr4+ehYVBY8FnV147o+1eDOPdK5USJXjiye4HbFl58PGtZ0+nb49ue67IjD39nGCH7f8lsCFzemQfpXf9M3+74Y6B+d8XCGIBWlpxl6OUG11oYU8L5IEfQQ50yUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7q3e99k2UmZRnW/nKsoQnXhEL84rbnJEqRrKC4oTOnw=;
 b=W5XogWLLXu5vk8jpcIRURfWVziCjJRxiwhhkGgUliNyPngGUsl2/Rrr+/LOq50ZHikNJ8fYxoqiQKFboT3yXQo4ShSK5dJqAjCedHUyBedzxiqzrpD9OFZcKDuqEMlgs/I7oqGBo9c1Ux5IgS+5tFCP75Zv0oiChFUKTbFylHqpDvKyqBtkYe1gesUQOWkKvc8LLE5QO3fElZCIw7lKqh9G8X9nchFGjfFAtng/v23dpy0RlawZYBRBv4hDOtv9KKu3uub3oDeIowYkem9E6Z/fX0r3oq2c3UoLa3aXuABa/nj2cal+xKJhPfzAsLGN+/9DH7KKeMAgqaGbJ1YXOrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7q3e99k2UmZRnW/nKsoQnXhEL84rbnJEqRrKC4oTOnw=;
 b=zMDvSp1YoQ6+JcRvLS96tsYHqM/P3AEoVw/D5K6O3Uc2812Az2+CQPG5x2TRc1sdQAAIn1/atP8XVOCr/NQd8ndzgTvbEzg2Zm+N4eR5RREuGGaZl4rlzEHLuo9uCzIp1vcAzoQapwPqamlwCw85cfh8cV0PIPhBKLFRLl7neh0=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
Received: from SA2PR11MB5163.namprd11.prod.outlook.com (2603:10b6:806:113::20)
 by SA0PR11MB4576.namprd11.prod.outlook.com (2603:10b6:806:97::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Mon, 18 Oct
 2021 16:24:12 +0000
Received: from SA2PR11MB5163.namprd11.prod.outlook.com
 ([fe80::a039:c121:4dce:5def]) by SA2PR11MB5163.namprd11.prod.outlook.com
 ([fe80::a039:c121:4dce:5def%7]) with mapi id 15.20.4608.018; Mon, 18 Oct 2021
 16:24:12 +0000
Subject: Re: [PATCH v17 0/5] FPGA Image Load (previously Security Manager)
To:     Xu Yilun <yilun.xu@intel.com>
CC:     Tom Rix <trix@redhat.com>, <mdf@kernel.org>,
        <linux-fpga@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lgoncalv@redhat.com>, <hao.wu@intel.com>,
        <matthew.gerlach@intel.com>
References: <79350773-3629-2734-21c0-0314a762e722@redhat.com>
 <336e4827-b09a-e1ab-b67d-d8755012d71c@intel.com>
 <20211012074752.GB95330@yilunxu-OptiPlex-7050>
 <e629eca0-a86c-4028-7bbf-65185699137b@intel.com>
 <20211013010617.GE95330@yilunxu-OptiPlex-7050>
 <58036b2d-ca8f-2deb-f1b4-0301d633714b@intel.com>
 <20211014014947.GF95330@yilunxu-OptiPlex-7050>
 <7d1971d0-b50b-077f-2a82-83d822cd2ad7@intel.com>
 <20211015025140.GH95330@yilunxu-OptiPlex-7050>
 <2b26bea5-60d3-6763-00e8-9a94fa0bf45b@intel.com>
 <20211018081356.GB40070@yilunxu-OptiPlex-7050>
From:   Russ Weight <russell.h.weight@intel.com>
Message-ID: <301850cf-9f34-530b-bd9c-fbe9bf9feee5@intel.com>
Date:   Mon, 18 Oct 2021 09:24:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
In-Reply-To: <20211018081356.GB40070@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: BYAPR02CA0012.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::25) To SA2PR11MB5163.namprd11.prod.outlook.com
 (2603:10b6:806:113::20)
MIME-Version: 1.0
Received: from [10.0.2.4] (50.43.42.212) by BYAPR02CA0012.namprd02.prod.outlook.com (2603:10b6:a02:ee::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.14 via Frontend Transport; Mon, 18 Oct 2021 16:24:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3b24dcdc-5164-4a24-3207-08d99253b829
X-MS-TrafficTypeDiagnostic: SA0PR11MB4576:
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR11MB4576F0F01A22CEB0FC389DC2C5BC9@SA0PR11MB4576.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Gg3w9exILVefS9+1DW0aMqZXrDGGAhisbZg1BITRSCTeOBBNc54vFAC38IG/eqARtEEl9QyOfngUCctviY8qBsxYZgXuhy8CExusbew9HTnNZMIrL65qRJ5TSRBonIq+SoieoBkCNx8QWFoDa5G/bXeNKrik33H6vZnQf7AMhrcZ694I9mLQxJsK40Wf6ed6luXggyhJrMtyq/6w6EFa5a/U9X29Br0dFsHNw7vbQqMxiUFKUb5ZOAVEIGx1QHMJoXOgcEYyEpQ5qANXLt+c11upDf2N8Dub8WomIE6hQjHbhryN2+UCFOHzFF3LV3Xe5zeBTQ23sfq8tu6yTUmcJifI7zTGVr0rKcuHL9uGEDRyM5QZisqoYu7jih8wZ3FGyBOO8Vj7niyuR21M50idLqBjGY0Y0TjfYl54No7jVQmyZefTDfICCIkQM66Pj8V+2RzkyW9wuANQaXTkRKWHBVlFeS0N1x7Jfm27ulPU6nfCe2kkgaoHcZiNF40p0JOPlLdQAkWoxz4cnyqqZRBGZLV3UyR9xNwNSyApTs9PkwgsTFtak0uE8LR4HvzMhtTGY3bzxHt1BZtjHQqpdUits7qGyERCmYpJq3oWQJ52MDECnXsyX8TL9tos8Kucj7mG8aMItvfQSYYXZgd4mzm6O49V28yPLzAHJoP3RzCxYrEwGNelOQoYvc5mAQ/qcgliH3Vbi4fYOaqks8+QlkYFIukpxQULZCnZKEdWRgxaa2pDam8EnSVSiMt63wH5cSmwp/3261asfofHTMdWd5AoOBPYLDH4CuyC2yCK8M5bB1fc9HK1voS8x5crHDjcpq+kJBpOi8v4eiBXhsu7tgWiJ6bdqhJVEHOKcR7YSToTxdA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB5163.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(107886003)(966005)(37006003)(6666004)(66946007)(6636002)(4326008)(83380400001)(53546011)(6486002)(82960400001)(26005)(38100700002)(8676002)(16576012)(36756003)(5660300002)(2906002)(6862004)(86362001)(8936002)(316002)(30864003)(31696002)(66476007)(66556008)(2616005)(15650500001)(31686004)(956004)(508600001)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K2VZdytaWDR0YUIxZjhEa2VlOUJtbytYeFFKN0ZxQTNma29kS2dQUFhKR3p0?=
 =?utf-8?B?TnJGd3lyeDJzL0I0WjIvdjE4bjFMd0ZuZUx3ZkhzNjhvaDdkUmNyakVlMkpP?=
 =?utf-8?B?WVpZQU0rL1NsakY1dmp3SVZ4TjRzK3VJM0hRR0FuZUJoRXVGWnlBMWxsckJv?=
 =?utf-8?B?bVQ5R0trZDd3MTJReENwUlBtTU1nRHU1c0E4WGFYaU5WbXF1U3Bwc0FXdjEx?=
 =?utf-8?B?QXlvRWVFb3lZUUxzbUJneEtteVpoNEVFNjFZSjFNM01DSGcyOG8raTMrQytD?=
 =?utf-8?B?dk9oMlVVNXNLNUI2VDRhZkVBelFZRWxsRGc3WVZLVXU2eXlTVUVKNU1pOHQy?=
 =?utf-8?B?OFlSN0t0b0JHek9Bd2dCMzdUTFJQVVUwZTd3VXdxWVJTWit2eVpNNlNwb3hP?=
 =?utf-8?B?SFB4bHVhUjh4eUc2NDNVdWVHQTh5cmwzQlBwK3dTODN5TjlvcEpGZmpESWVJ?=
 =?utf-8?B?WWQxSlIvYVNFd1ZkaWVtRUljWk96Mml2ZVQrMTZtdFFYS3M4ME1CK3FsTXhh?=
 =?utf-8?B?VWkvYmxNWCs4NFV1S0tHTk1VRm5FWjhkbllWYzlPdzZBRDA1S1B0SXEzK3cr?=
 =?utf-8?B?Umg4dlQraHlyME1qZGNxZ1ZsUlRML3Q5Qmc1d3FTckhZRXYyQThHZnZaaGNG?=
 =?utf-8?B?L3FDVWtlREQ2Q0VoZ3dUUjZ2YXgzdXRCS29vRDM0YzRRclozU1FLa3hGTkR3?=
 =?utf-8?B?TzJBK3RBM25GUG4waGtJMTVIa0czUVg1a28xd3IzWDVWZkZJR0RUUTdYOVU0?=
 =?utf-8?B?VUM4WTF5M051cmkrWUhtdkNiZE41aVhtUUJJQnd5VEZTUW5yWmFxeHp0QjlZ?=
 =?utf-8?B?RWM3RVVpVTFHWmpwRldKSzBLanV1QTJVN2tPWVROQUZyKytzazBuZDh6ajBE?=
 =?utf-8?B?WXh6Zk9mcExZTzBYeTVVU01nUVFZMXhNbUhBVHUzN25zUFB4akE2NnZ6L01y?=
 =?utf-8?B?OFJOUnQ5QUVCak41djVSZlpzYk56cmI1T01uTkVxUkhvTUpDWU9qeHliM3NW?=
 =?utf-8?B?RHB4b2NmS1BWWE84V3NqSGI2dkljbWFQTkR4TUlVRTlOKzFlbEZoY2ZCRmgr?=
 =?utf-8?B?Qmp0bm85eVZuT1hwWDVrcHp2Zit2RFdUM0RpZWk0NkJRRnN5RnZ1MDJSalZ3?=
 =?utf-8?B?T2kyWWJWaVhBMGtnSm5Hd2VKYmN0cWhLV1FXd3pKWnFmRnUyZW5UUXh6RmIw?=
 =?utf-8?B?RmlaQ3NGUWRiMzNJeFI3dTBxMFJoNnVGOU5BbXNhdnkzWlNITE1NMjZGNVVT?=
 =?utf-8?B?MjlqczZ1TzFNUWNlY0Y2eG9ocityd1kva1NzNXNyT1hDZGZiZkMvTTZWQXRp?=
 =?utf-8?B?UHJBUzZ4ZVVxNnhWeDl2K2V6Z09Ja05iYVgxRDl5bTVnQWVoNFNvVzcrWVhT?=
 =?utf-8?B?VzZMVU81YXJTckRjUi9EWmd1QzNsWWtzalV4VGlqRFNyeEwvTktJSkJlU080?=
 =?utf-8?B?NkU2N041bGtmR1c3V3MzTmJOd0VVMGxlZzQ5QWlYNzU1NmFkZUJJSXluUTJJ?=
 =?utf-8?B?Umt1c0hQSEdJa3oyV0VqMXIrT0hlQ1JjcmJFOHY5bHZ5UVR6SndzaFUydHpi?=
 =?utf-8?B?VHBkRFNpUm9iWE43dXhkV3NqanErWG5SRmc4b1FZekFOaWFZeDRQRkFNWTN4?=
 =?utf-8?B?LzA1TzdzekIwR0xsRklZaVgreDZkeklPZ1JUY3V2anZhMlJybk5xUkxWZXJV?=
 =?utf-8?B?SXBzVGxHS241S2lCRC9BL2M4QU1Yc1B6dDMwR2hyOVhsWjBSR0p5c2VrSE9z?=
 =?utf-8?Q?53vTNbJQCxFiaOHSCb6s7idMIJZ87vGhk4njPdf?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b24dcdc-5164-4a24-3207-08d99253b829
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB5163.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2021 16:24:12.0907
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mn6e1loOsWAj6oMK/FysIqj55VqvWAwht78Gw2bx/NUoiX0iJQRNO0AzOFZltphuJ5d4bYzVZNsvlOwmpAUJxIs/hIsqdsIEwCIJBF14zfc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4576
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On 10/18/21 1:13 AM, Xu Yilun wrote:
> On Fri, Oct 15, 2021 at 10:34:23AM -0700, Russ Weight wrote:
>>
>> On 10/14/21 7:51 PM, Xu Yilun wrote:
>>> On Thu, Oct 14, 2021 at 09:32:53AM -0700, Russ Weight wrote:
>>>> On 10/13/21 6:49 PM, Xu Yilun wrote:
>>>>> On Wed, Oct 13, 2021 at 11:09:08AM -0700, Russ Weight wrote:
>>>>>> On 10/12/21 6:06 PM, Xu Yilun wrote:
>>>>>>> On Tue, Oct 12, 2021 at 10:20:15AM -0700, Russ Weight wrote:
>>>>>>>> On 10/12/21 12:47 AM, Xu Yilun wrote:
>>>>>>>>> On Mon, Oct 11, 2021 at 06:00:16PM -0700, Russ Weight wrote:
>>>>>>>>>> On 10/11/21 5:35 AM, Tom Rix wrote:
>>>>>>>>>>> On 10/10/21 6:41 PM, Xu Yilun wrote:
>>>>>>>>>>>> On Sat, Oct 09, 2021 at 05:11:20AM -0700, Tom Rix wrote:
>>>>>>>>>>>>> On 10/9/21 1:08 AM, Xu Yilun wrote:
>>>>>>>>>>>>>> On Wed, Sep 29, 2021 at 04:00:20PM -0700, Russ Weight wrote:
>>>>>>>>>>>>>>> The FPGA Image Load framework provides an API to upload image
>>>>>>>>>>>>>>> files to an FPGA device. Image files are self-describing. They could
>>>>>>>>>>>>>>> contain FPGA images, BMC images, Root Entry Hashes, or other device
>>>>>>>>>>>>>>> specific files. It is up to the lower-level device driver and the
>>>>>>>>>>>>>>> target device to authenticate and disposition the file data.
>>>>>>>>>>>>>> I've reconsider the FPGA persistent image update again, and think we
>>>>>>>>>>>>>> may include it in FPGA manager framework.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Sorry I raised this topic again when it is already at patch v17, but now
>>>>>>>>>>>>>> I need to consider more seriously than before.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> We have consensus the FPGA persistent image update is just like a normal
>>>>>>>>>>>>>> firmware update which finally writes the nvmem like flash or eeprom,
>>>>>>>>>>>>>> while the current FPGA manager deals with the active FPGA region update
>>>>>>>>>>>>>> and re-activation. Could we just expand the FPGA manager and let it handle
>>>>>>>>>>>>>> the nvmem update as well? Many FPGA cards have nvmem and downloaders
>>>>>>>>>>>>>> supports updating both FPGA region and nvmem.
>>>>>>>>>> The fpga-image-load driver is actually just a data transfer. The class
>>>>>>>>> IMHO, The fpga-mgr dev is also a data transfer. The fpga-region dev is
>>>>>>>>> acting as the FPGA region admin responsible for gating, transfering and
>>>>>>>>> re-enumerating.
>>>>>>>>>
>>>>>>>>> So my opinion is to add a new data transfer type and keep a unified process.
>>>>>>>>>
>>>>>>>>>> driver has no knowledge about what the data is or where/if the data will
>>>>>>>>>> be stored.
>>>>>>>>> The fpga-image-load driver knows the data will be stored in nvmem,
>>>>>>>> FYI: This is not strictly correct. In a coming product there is a
>>>>>>>> case where the data will be stored in RAM. Richard Gong was also
>>>>>>>> looking to use this driver to validate an image without programming
>>>>>>>> or storing it. The fpga-image-load driver has no expectation that
>>>>>>>> the data will be stored in nvmem, or even that it will be stored
>>>>>>>> at all.
>>>>>>> OK, we can discuss that use case then. But fundamentally a driver should
>>>>>>> be clear what it is doing.
>>>>>> The lower-level driver is, of course, clear what it is doing. And the
>>>>>> FPGA Image Load Framework simply provides a consistent API and manages
>>>>>> a potentially long-running data transfer in the context of a kernel
>>>>>> worker thread.
>>>>>>
>>>>>> It sounds like you are saying that that is not "clear enough" in the
>>>>>> context of the FPGA Manager?
>>>>>>
>>>>>> The files that are used with Intel PAC devices are self-describing. The
>>>>>> user-space tools, the class driver and the lower-level driver just pass
>>>>>> the data through to the card BMC without any knowledge of the content,
>>>>>> purpose or final destination of the data.
>>>>>>
>>>>>> The card BMC will receive signed data, validate it, and process it as a
>>>>>> BMC image, an FPGA image, a Root Entry Hash, or a key cancellation. In
>>>>> I category all these actions as firmware update fully or partially on
>>>>> persistent storage. The FPGA Manager don't have to know the meaning of
>>>>> every byte on flash, but it should be aware the firmware is updated and
>>>>> the card may acts differently with a new firmware. This is the common
>>>>> working model for most of the FPGA cards so that we implement it in FPGA
>>>>> manager class. 
>>>>>
>>>>>> the n6000, it could also be part of a multi-step process for programming
>>>>>> SDM keys and the data may not be stored permanently.
>>>>> This is new to me, but seems to be different from firmware update, so lets
>>>>> think about it again.
>>>>>
>>>>>>> You may try to extend the FPGA framework to
>>>>>>> support nvmem storage, or image validation, but cannot say we feed the
>>>>>>> data to any engine undefined by the framework.
>>>>>> I'm not sure what you mean by "feed the data to any engine undefined by the
>>>>>> framework". I think the "engine" is the lower level driver/device that invokes
>>>>>> the fpga_mgr. The lower level driver, of course, is clear what it is doing.
>>>>>> The fpga_mgr cannot control what driver invokes it.
>>>>>>
>>>>>> Are saying that when invoking the fpga-mgr, that it _must_ also pass descriptive
>>>>>> data. Meaning that a self-describing file alone is not acceptable?
>>>>> The class driver should define a reasonable working model and APIs.
>>>>> Updating the FPGA backup storage is good to me. But receiving a mystery
>>>>> box and do whatever it requires is not.
>>>>>
>>>>> Self-describing file is OK, encryption is OK, but either the class
>>>>> driver itself, or with the help of the low level driver, should make
>>>>> sure it works within its scope.
>>>> In our secure update process, the card BMC firmware authenticates
>>>> the data using the root entry hashes and will either reject the
>>>> data or perform some function based on the contents. Neither the
>>>> user-space, the class driver, nor the lower level driver know
>>>> what the contents are. It _is_ a "mystery box" to them. How do we
>>>> verify scope in this model?
>>> I think we need to find out how. One case is, the HW is designed to have
>>> one single function, such as firmware update, then any image input
>>> through firmware update API is within expectation, and the driver
>>> should only serve the firmware update API. I think this is how the
>>> N3000 is working now. If the HW is for another function, register itself
>>> to serve another API, or another class driver.
>>>
>>> Another case is, the HW could do multiple types of tasks depending on
>>> the content of the image, such as firmware update, image verification,
>>> or assumably power off the card ... There should be some mechanism for
>>> the driver to only accept the right image according to what API is called.
>>> Or the user may input an image named update_the_card.img through
>>> firmware update API and finally get the card off. Having some headers
>>> readable by host for the operation type? Or, some HW interface for host
>>> to apply the operation type as well as the image, let the HW verify?
>>> Let's think about it.
>> I'm not sure if I am following your thinking here. The HW, of course,
>> verifies authentication of the image and acts according to the image
>> type. I don't think it is reasonable to require the class driver to
>> interpret the data to determine what it is. That implies that the
>> class driver would have to know the header format and possible values.
>> It also means that changes to the header format would require patches
>> to the class driver.
>>
>> The FPGA card is trusted by virtue of the fact that the customer
>> purchased it and physically placed it in the machine. If the FPGA card
>> (or the lower level driver) validates the image, then why does the
>> Class driver need to be concerned about the file type? I think the
>> purpose of the class driver is primarily to provide a common API and
>> perform common functions so that they don't have to be replicated
>> among similar low-level drivers. It is up to the low-level driver
>> or the device itself to ensure that the data received is acceptable.
>>
>> If the card receives data through the fpga-mgr upload facility that
>> isn't strictly a firmware update, and if the lower-level driver or
>> the card handles it and returns appropriate status - is that really
>> a problem?
>>>> As you have noted, most current cases result in a change to the
>>>> card, and I suspect that it will remain that way. But that can't be
>>>> guaranteed, and I'm not convinced that a host driver needs to be
>>>> concerned about it.
>>> A host driver should know what is done, in some abstraction level.
>>> I think updating the persistent storage is an acceptable abstraction
>>> in FPGA domain, so I'd like to extend it in FPGA manager. But doing
>>> anything according to the image is not.
>> By host driver, do you mean the class driver? Or the lower-level device
>> driver?
> The class driver.
>
>> It seems to me that you are saying that self-describing images are not
>> acceptable? Or at least they are not acceptable payload for an FPGA
>> Manager firmware-update API?
> For N3000, we are working on the persistent storage update APIs, which is
> a much simpler working model, no runtime device change, and needs no
> device removal & re-enumeration.
>
> But if you need to extend something more that would potentially changes
> the behavior of the running devices on FPGA, device removal &
> re-enumeration are needed so that the system knows what devices are
> changed.
>
>> The FPGA Image Load Framework was designed with the concept of
>> transferring data to a device without imposing a purpose on the data.
>> The expectation is that the lower-level driver or the device will
>> validate the data. Is there something fundamentally wrong with that
> I think there is something wrong here. As I said before, persistent
> storage updating has different software process from some runtime
> updating, so the class driver should be aware of what the HW engine
> is doing.
So far, there are no self-describing images that cause a
change in run-time behavior, and I don't think that will
happen for the very reason that the class-driver would
need to know about it.

When I asserted that not all self-describing images are
changing firmware, I did not mean to imply that they change
run-time behavior; they do not. They are part of a multi-
step update of firmware. However, looking at each part of
the sequence independently, there is at least one instance
where a certificate is stored in RAM for temporary use.
When the driver exits from this call, there is no firmware
change. There is also no change in run-time behavior.

I'm thinking we could have different IOCTLs:

(1) firmware  update (address, size, purpose provided
    with the image)
(2) image upload (self-describing files)
(3) image validation

These would all use most of the same code, but the FPGA
Manager flags and structure fields would be set differently.

- Russ
>
> Thanks,
> Yilun
>
>> approach? And if not, why couldn't we incorporate a similar image_load
>> API into the FPGA Manager?
>>
>> - Russ
>>
>>> Thanks,
>>> Yilun
>>>
>>>> - Russ
>>>>
>>>>> Thanks,
>>>>> Yilun
>>>>>
>>>>>> Thanks,
>>>>>> - Russ
>>>>>>
>>>>>>> Thanks,
>>>>>>> Yilun
>>>>>>>
>>>>>>>>> while
>>>>>>>>> the fpga-mgr knows the data will be stored in FPGA cells. They may need
>>>>>>>>> to know the exact physical position to store, may not, depends on what the
>>>>>>>>> HW engines are.
>>>>>>>>>
>>>>>>>>>> This functionality could, of course, be merged into the fpga-mgr. I did
>>>>>>>>>> a proof of concept of this a while back and we discussed the pros and cons.
>>>>>>>>>> See this email for a recap:
>>>>>>>>>>
>>>>>>>>>> https://marc.info/?l=linux-fpga&m=161998085507374&w=2
>>>>>>>>>>
>>>>>>>>>> Things have changed some with the evolution of the driver. The IOCTL
>>>>>>>>>> approach probably fits better than the sysfs implementation. At the time
>>>>>>>>>> it seemed that a merge would add unnecessary complexity without adding value.
>>>>>>>>> I think at least developers don't have to go through 2 sets of software
>>>>>>>>> stacks which are of the same concept. And adding some new features like
>>>>>>>>> optionally threading or canceling data transfer are also good to FPGA
>>>>>>>>> region update. And the nvmem update could also be benifit from exsiting
>>>>>>>>> implementations like scatter-gather buffers, in-kernel firmware loading.
>>>>>>>>>
>>>>>>>>> I try to explain myself according to each of your concern from that mail
>>>>>>>>> thread:
>>>>>>>>>
>>>>>>>>> Purpose of the 2 updates
>>>>>>>>> ========================
>>>>>>>>>
>>>>>>>>>   As I said before, I think they are both data transfer devices. FPGA
>>>>>>>>> region update gets extra support from fpga-region & fpga-bridge, and
>>>>>>>>> FPGA nvmem update could be a standalone fpga-mgr.
>>>>>>>>>
>>>>>>>>> Extra APIs that are unique to nvmem update
>>>>>>>>> ==========================================
>>>>>>>>>
>>>>>>>>>   cdev APIs for nvmem update:
>>>>>>>>>     Yes we need to expand the functionality so we need them.
>>>>>>>>>
>>>>>>>>>   available_images, image_load APIs for loading nvmem content to FPGA
>>>>>>>>>   region:
>>>>>>>>>     These are features in later patchsets which are not submitted, but we
>>>>>>>>>     could talk about it in advance. I think this is actually a FPGA region
>>>>>>>>>     update from nvmem, it also requires gating, data loading (no SW transfer)
>>>>>>>>>     and re-enumeration, or a single command to image_load HW may result system
>>>>>>>>>     disordered. The FPGA framework now only supports update from in-kernel
>>>>>>>>>     user data, maybe we add support for update from nvmem later.
>>>>>>>>>
>>>>>>>>>   fpga-mgr state extend:
>>>>>>>>>     I think it could be extended, The current states are not perfect,
>>>>>>>>>     adding something like IDLE or READY is just fine.
>>>>>>>>>
>>>>>>>>>   fpga-mgr status extend:
>>>>>>>>>     Add general error definitions as needed. If there is some status
>>>>>>>>>     that is quite vendor specific, expose it in low-level driver.
>>>>>>>>>
>>>>>>>>>   remaining-size:
>>>>>>>>>     Nice to have for all.
>>>>>>>>>
>>>>>>>>> Threading the update
>>>>>>>>> ====================
>>>>>>>>>
>>>>>>>>>   Also a good option for FPGA region update, maybe we also have a slow FPGA
>>>>>>>>>   reprogrammer?
>>>>>>>>>
>>>>>>>>> Cancelling the update
>>>>>>>>> ====================
>>>>>>>>>
>>>>>>>>>   Also a good option for FPGA region update if HW engine supports.
>>>>>>>> These are all good points.
>>>>>>>>
>>>>>>>> Thanks,
>>>>>>>> - Russ
>>>>>>>>> Thanks,
>>>>>>>>> Yilun
>>>>>>>>>
>>>>>>>>>>>>>> According to the patchset, the basic workflow of the 2 update types are
>>>>>>>>>>>>>> quite similar, get the data, prepare for the HW, write and complete.
>>>>>>>>>>>>>> They are already implemented in FPGA manager. We've discussed some
>>>>>>>>>>>>>> differences like threading or canceling the update, which are
>>>>>>>>>>>>>> not provided by FPGA manager but they may also nice to have for FPGA
>>>>>>>>>>>>>> region update. An FPGA region update may also last for a long time??
>>>>>>>>>>>>>> So I think having 2 sets of similar frameworks in FPGA is unnecessary.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> My quick mind is that we add some flags in struct fpga_mgr & struct
>>>>>>>>>>>>>> fpga_image_info to indicate the HW capability (support FPGA region
>>>>>>>>>>>>>> update or nvmem update or both) of the download engine and the provided
>>>>>>>>>>>>>> image type. Then the low-level driver knows how to download if it
>>>>>>>>>>>>>> supports both image types.An char device could be added for each fpga manager dev, providing the
>>>>>>>>>>>>>> user APIs for nvmem update. We may not use the char dev for FPGA region
>>>>>>>>>>>>>> update cause it changes the system HW devices and needs device hotplug
>>>>>>>>>>>>>> in FPGA region. We'd better leave it to FPGA region class, this is
>>>>>>>>>>>>>> another topic.
>>>>>>>>>> I'll give this some more thought and see if I can come up with some RFC
>>>>>>>>>> patches.
>>>>>>>>>>
>>>>>>>>>> - Russ
>>>>>>>>>>>>>> More discussion is appreciated.
>>>>>>>>>>>>> I also think fpga_mgr could be extended.
>>>>>>>>>>>>>
>>>>>>>>>>>>> In this patchset,
>>>>>>>>>>>>>
>>>>>>>>>>>>> https://lore.kernel.org/linux-fpga/20210625195849.837976-1-trix@redhat.com/
>>>>>>>>>>>>>
>>>>>>>>>>>>> A second, similar set of write ops was added to fpga_manger_ops,
>>>>>>>>>>>>>
>>>>>>>>>>>>> new bit/flag was added to fpga_image_info
>>>>>>>>>>>>>
>>>>>>>>>>>>> The intent was for dfl to add their specific ops to cover what is done in
>>>>>>>>>>>>> this patchset.
>>>>>>>>>>>> I think we don't have to add 2 ops for reconfig & reimage in framework,
>>>>>>>>>>>> the 2 processes are almost the same.
>>>>>>>>>>>>
>>>>>>>>>>>> Just add the _REIMAGE (or something else, NVMEM?) flag for
>>>>>>>>>>>> fpga_image_info, and low level drivers handle it as they do for other
>>>>>>>>>>>> flags.
>>>>>>>>>>>>
>>>>>>>>>>>> How do you think?
>>>>>>>>>>> A single set is fine.
>>>>>>>>>>>
>>>>>>>>>>> A difficult part of is the length of  time to do the write. The existing write should be improved to use a worker thread.
>>>>>>>>>>>
>>>>>>>>>>> Tom
>>>>>>>>>>>
>>>>>>>>>>>> Thanks,
>>>>>>>>>>>> Yilun
>>>>>>>>>>>>
>>>>>>>>>>>>> Any other driver would do similar.
>>>>>>>>>>>>>
>>>>>>>>>>>>> Is this close to what you are thinking ?
>>>>>>>>>>>>>
>>>>>>>>>>>>> Tom
>>>>>>>>>>>>>
>>>>>>>>>>>>>> Thanks,
>>>>>>>>>>>>>> Yilun
>>>>>>>>>>>>>>

