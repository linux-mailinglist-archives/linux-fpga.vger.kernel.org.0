Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9969A3CBBB2
	for <lists+linux-fpga@lfdr.de>; Fri, 16 Jul 2021 20:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbhGPSMk (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 16 Jul 2021 14:12:40 -0400
Received: from mga17.intel.com ([192.55.52.151]:54570 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229462AbhGPSMj (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 16 Jul 2021 14:12:39 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10047"; a="191140849"
X-IronPort-AV: E=Sophos;i="5.84,245,1620716400"; 
   d="scan'208";a="191140849"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2021 11:09:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,245,1620716400"; 
   d="scan'208";a="429333052"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by fmsmga007.fm.intel.com with ESMTP; 16 Jul 2021 11:09:43 -0700
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Fri, 16 Jul 2021 11:09:43 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Fri, 16 Jul 2021 11:09:43 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.108)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Fri, 16 Jul 2021 11:09:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jnhcAfxGFZNLaQSClLM32sLZTU4wo/fxhVs7a4LMNzBH2vsBfnUNTy02QiFxzDjsj4/OxYLN7qcIod0zLQi41SiTcKzPHtNMpJ4J7+Vy7uIck9SNLw46g5Jdudj3QkAFepAhwQ6CFnvAH/X8lq37rJhJOahn2iPI2Jk+aMlmMVe4QPfRdDgKIubkqWugTx54vHKECUnBA+7qdYu3QKfB8OQfPn3wq4K/5OGe+BfgvBF6ifkxx1rKftiqFv5l1EcpgTKjOmr/NF+xJwc0XRoLBg+04eSnPp/YYhiji1L6wLW73P/uvlpZxf0ykBUrd4vmrk8CmQlyuMr0zjZj8WEYjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9WcDNiLm9JRDSo9S7G0qltAZDSCJmhwaeV0gWmphEZc=;
 b=GSaxsmJ1HogS+7pzIH9WrjVXkrIP6q9ZR6yMnhvCCbrbdiPKw07SvWjkw1Mdd9rhL1xvFolOnRnztYb35UdSe+KPgt8jM0IiAXxyy+nNKkGnavqa5xJZ/ScoSa7Ddx+rgw7MSEm22Sv0pELAv4OtkCXZB902eatC4keDEbytgGC6Q8j3UAEyTgWXiX3861TwrJylBNJaofCml8DwRfFiwJ8Zjz2KMxPld/QNWGAw6iBOOg2pr/7utW56MKhVcSFMIMdUETL7VIBqZMgV8stJn9Z8Y8YNeVW9/5AO1JcpjIOnxSvqOZkmiqt+krDmO6R5AVmeqSlYbrXJ1BdrHVFQTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9WcDNiLm9JRDSo9S7G0qltAZDSCJmhwaeV0gWmphEZc=;
 b=ThsaLc39Bzz1R1oN0sjh3JdrOD/OdG8dTrOheRJcsjm2fhSmuPz+KC4ZTybj6fum2OKFbwYfVBwOe3f1/Nqh5hBrMeaEqQKg23UIhWz25KQ3nBtpKHDjaeidrwJDFjhlp6/k9QleZ7T3uKh/+awhq5QjIBLTVN0EgUDSBSIB5dM=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
Received: from SA2PR11MB5163.namprd11.prod.outlook.com (2603:10b6:806:113::20)
 by SN6PR11MB2911.namprd11.prod.outlook.com (2603:10b6:805:d2::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.26; Fri, 16 Jul
 2021 18:09:41 +0000
Received: from SA2PR11MB5163.namprd11.prod.outlook.com
 ([fe80::51db:698d:e2e3:7fc8]) by SA2PR11MB5163.namprd11.prod.outlook.com
 ([fe80::51db:698d:e2e3:7fc8%4]) with mapi id 15.20.4331.026; Fri, 16 Jul 2021
 18:09:41 +0000
Subject: Re: [PATCH v10 0/3] fpga: Use standard class dev_release function
To:     Tom Rix <trix@redhat.com>, <mdf@kernel.org>,
        <linux-fpga@vger.kernel.org>
CC:     <lgoncalv@redhat.com>, <yilun.xu@intel.com>, <hao.wu@intel.com>,
        <matthew.gerlach@intel.com>, <richard.gong@intel.com>
References: <20210709004206.244607-1-russell.h.weight@intel.com>
 <347fc4ab-8749-045f-5e07-80ca76aa6925@intel.com>
 <b9999736-3921-4574-032b-36126a2b4913@redhat.com>
 <9d0a8c33-66c6-b7da-3dc2-25f7daa5241e@redhat.com>
From:   Russ Weight <russell.h.weight@intel.com>
Message-ID: <cc0cb866-9fed-553d-980b-70d6fb50f09f@intel.com>
Date:   Fri, 16 Jul 2021 11:09:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.8.1
In-Reply-To: <9d0a8c33-66c6-b7da-3dc2-25f7daa5241e@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: MWHPR17CA0066.namprd17.prod.outlook.com
 (2603:10b6:300:93::28) To SA2PR11MB5163.namprd11.prod.outlook.com
 (2603:10b6:806:113::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.0.2.4] (50.39.241.28) by MWHPR17CA0066.namprd17.prod.outlook.com (2603:10b6:300:93::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend Transport; Fri, 16 Jul 2021 18:09:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 427e907a-f880-4caf-1518-08d94884e1a6
X-MS-TrafficTypeDiagnostic: SN6PR11MB2911:
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR11MB2911E024D58EC8B983F0A8F4C5119@SN6PR11MB2911.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q1j0Zw50wridy6KovDKu97nNixZIzoDfMTZx0MmWDGmzpwUEPvRD9IPxYGG1LO74K9IQ7zZH840JAAoAO42Hzbz7sx1zYr8mEV+CTlUddgr5T71gc5PZH4RitW8eRl0luprOfYsu5lO9aAth6HwnyW4XgaDzSNpfHZuIVGfZinAPha2tLFXC62y/dRivrXhV5LTyS9YU/4yh7oEBMANgqlbbGPHTqaclWq0xetVkxDFJ1Dvpy0xkA282R4699zhoBtOXA0pQRyzGanlHmaTqkVq6wjKLWMrdQB0GN76ben05RC8o5NxI8NnyP4JWODODwE6kF00iN2qQClynoVpojsKM9j6JMMZuCrJVeUYmVBYsHZHXq2oUprnsqiHk58ijitdp0t2//wqQ/qmyB6/70kH6D/sOCD9UCkj0/2wV5sJL7lfeO3JEBgOPwl6tfFDjZLhkhNj4+odab0nfKWkYDxfl7cOEoRpEsHTvv8JOveA8CbIy9v4w0XgU/zPxQrPSHPrCHuJtHHdp43fB+YTN4pQj/W8Yhj3s0oOaoc2xMQNtQ35BD4hzOQQmDJvW8bAPSsSZX6A++QbnlzbWUKcG/4mSA9Od/Zj2p0t7A58672EMn7rBUjFl/dtg/Sxl3AFelLX9DG6rNPiWpFqthI16d8lWwKgoOlRI6pJMZnk1ozqoyZNsedaB9vTP+mMJKE/LRa4fhMtKg9Oa9gwt/ZhspFPr1/DoWszQSIbXFswXpeBv2eZu5LH4aHgEqeUCzgeV/6y/rUom3D0CKxdCZHxwViq/XLy+VBIebFQ3U9uByRXSFNtZeXMYhubgkJpFEBFu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB5163.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(136003)(346002)(376002)(396003)(186003)(478600001)(38100700002)(2906002)(107886003)(8676002)(31696002)(316002)(4326008)(8936002)(86362001)(66476007)(66946007)(53546011)(966005)(2616005)(16576012)(6486002)(31686004)(5660300002)(66556008)(956004)(36756003)(83380400001)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QmN6T09xdjh1U0d4VlZTVm11aDhKclQvNk9hT3lVbVFTU2cyazRPWlNHSkhK?=
 =?utf-8?B?MUFNak5ZeXJxSnpvSXRTamR0RzVxZENpNkl0MW5kaTc2cHdCclVNMy8rNGFD?=
 =?utf-8?B?SWNQYzNzdzJCMlJoUUQ2MUg5MmI2RnlmeENOR2xDQW94aTNlNmM3ajZvdzVE?=
 =?utf-8?B?Zi9qV21uQ3ArSm4zRzQzTVprTDA3VE1ETm5qU0FTR3QvVEN5V0swNkZCRXAy?=
 =?utf-8?B?QmhIVE9CM3BSL1VLbFUwRXNnVU9abHJTZ3Yzdms5cXFVRGN3djF2MkRPOTM4?=
 =?utf-8?B?Q0N3RldFbUFaMytxWFNvak5iQWl6VDVTZVV2MERjdm02VWErM1pDdDFaQktq?=
 =?utf-8?B?WE1WUFBXWFZ3ZzZXZDRMSkVZV3FhTC9PUkRSVGNyWG4rWXlmTGwzbFFBamNs?=
 =?utf-8?B?VmdSVTNSeGcvYUt6ay81SlRRRW52UzdzNmNrVTlSU1BRRnlHemhzajJFdkxs?=
 =?utf-8?B?MndpampHWlFQc0NPaUdScm9oQ1hkOHdkeHJVN1JKS3RaQmRqaEVmcHhYVmcw?=
 =?utf-8?B?U0FPQ3BqZlU1L0pDdjdXWHRqcmdnQ0hnNXZScS9BeEthc2FCWFZBQm0wUnRs?=
 =?utf-8?B?TWlyTG1KWm5MblBnMFVnTXc4TFZOcncxbDV1dVIzeEpLdVkrbWk1WGhLcXlX?=
 =?utf-8?B?UEEraDRtQXVRVTV2ZWw5a01RRXRSNjhtb0RyQU1MWHJXUmNBK2VCcVVRd0FR?=
 =?utf-8?B?L3hjbjhZWXQxQ3YwVDZTNnZ2UjBscnorSVp4Skc4UUZWN3I3dVRtNS9sejVz?=
 =?utf-8?B?SjlodStrV1NpZmpYVVR4bXJJS0pjaVI3QmsvY1QwOFRqTEZhYWFZTXlkK2RI?=
 =?utf-8?B?R0VyTVZuSW1FQjZnSy83dERvRDBQNjcrdFpEVVdUb0F3MUZ3VlgyQ21vL3Mr?=
 =?utf-8?B?NE16M3dZaEd4M0lCOFo5dFdLUWRibUhlTmw1R0tYUHRsNThzWXE1T2t4ZW9n?=
 =?utf-8?B?Mml3TXZzQUt4Yys2V2IvTWl1RW9WWDIwVkYzZkV5akNDOVhMdjNtbVk4QTdz?=
 =?utf-8?B?aVRZdi92emJhdHU5a3k3WDVOTTB5czlsVTlhRm5RWG5oT05saWtaVnVnNXRx?=
 =?utf-8?B?YTcrZXNvZ1M3aE94QS9GSjFIWndmTUVjLzlneW9tSHVGZFRZQXgzL2R1ZnFB?=
 =?utf-8?B?cFo0eW5IS2hsLzMzTG00M3didVdGNHJ3YW15NWVIY2xBaTZ4R1JmRGpWZlNl?=
 =?utf-8?B?RkozOXNpbHM1QTF2MGk5dGVyc1dDMUhtdTFtR0VVUmk5bXhJeXFFdWZud2dJ?=
 =?utf-8?B?SXNrejBWb1kyUllKdTdBWTViNkpLWmZzMzFFbHNneEZLZGFXNnIyYTh0clc4?=
 =?utf-8?B?RWttNWRaZnNwL3JONHpENEFQbldoQkl1ekRQUW1NakdrSUZTWE1sTUZkbXJQ?=
 =?utf-8?B?aStvN3QzM3FtS0JzS0FMLzdmTlJxT0pyODVwdTFKQkNJNU5XQ1l4OUVUR3Mz?=
 =?utf-8?B?THBJUnpYdCtmeHRrS2RXeC9qQURqanpLSS9yNCt2VS9vcWU4cTAwT3U5VG5J?=
 =?utf-8?B?ODJNVkI2UDhwZDlKQlNoKzM0RHBpaklmRkhaZ1lmQzdYTEx6dGRTTmh2RG1P?=
 =?utf-8?B?dlZuZDVVUElDZzlXSlpBL21EaTJ0YW9lSFdNV2xsMnp2K3NVenVlWnF2WGlt?=
 =?utf-8?B?em5QZEhpNlA2dHFqMEhNR2M5VWpGU1Z2NDBibVpqL1BVUTB4TDk3Q1RzS0Rm?=
 =?utf-8?B?ZmJiZVpDdkdFWU0wY2s0VWhDTXUycjBRUGY3NjJ4UVlDMFdLckV5bjcxYTdv?=
 =?utf-8?Q?Ytn6gCCZ5y/a5lYZPZ+yjNsKhYKJhHXl016KH5L?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 427e907a-f880-4caf-1518-08d94884e1a6
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB5163.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2021 18:09:40.9640
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OsX+xeNNRuDQJ1XbtuIDfU50Ws5ZNuwFSyOj4MF/afq/3hz27IeHgT2zj7YrdG2Kr4NUR8nehO5wrVgzIVXBORsp06wqUOcHJvy5xvQMv38=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2911
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 7/16/21 5:58 AM, Tom Rix wrote:
>
> On 7/14/21 9:56 AM, Tom Rix wrote:
>>
>> On 7/14/21 8:50 AM, Russ Weight wrote:
>>> It seems like these patches are stalled on the compat_id question (in other emails). My
>>> two-cents: I don't see an issue with having two versions of the register functions, and
>>> I don't consider the issue important enough to force a move of the compat_id field. I
>>> think the compat_id issue should be considered separately.
>>>
>>> Are there any other concers for these patches?
>>
>> I am fine with it other than the two register functions.
>>
>> To compat_id or not and which order, I believe is Moritz's call.
>>
>> I'm ok with doing compat_id later.
>
> Russ,
>
> Though it seems like this patchset has stalled.  Either way it is stable enough to build on.
>
> I am _really_ interested in the sec-mgr as it will make several cards usable.
>
> Could you refresh it ?
>
> Tom

Hi Tom,

I'll refresh the patch-set next week. There are several issues that Greg raised that won't
be fully addressed in the first refresh, but I can address the registration and the functions
and update dates in the documentation.

- Russ

>
>>
>> Tom
>>
>>>
>>> - Russ
>>>
>>> On 7/8/21 5:42 PM, Russ Weight wrote:
>>>> The FPGA framework has a convention of using managed resource functions
>>>> to allow parent drivers to manage the data structures allocated by the
>>>> class drivers. They use an empty *_dev_release() function to satisfy the
>>>> class driver.
>>>>
>>>> This is inconsistent with linux driver model.
>>>>
>>>> These changes remove the managed resource functions and populate the class
>>>> dev_release callback functions. They also merge the create() and register()
>>>> functions into a single register() or register_full() function for each of
>>>> the fpga-mgr, fpga-region, and fpga-bridge class drivers.
>>>>
>>>> The new *register_full() functions accept an info data structure to provide
>>>> flexibility in passing optional parameters. The *register() functions
>>>> support the legacy parameter list for users that don't require the use of
>>>> optional parameters.
>>>>
>>>> For more context, refer to this email thread:
>>>>
>>>> https://marc.info/?l=linux-fpga&m=162127412218557&w=2
>>>>
>>>> I turned on the configs assocated with each of the modified files, but I
>>>> must have been missing some dependencies, because not all of them compiled.
>>>> I did a run-time test specifically with the dfl-fme infrastructure. This
>>>> would have exercised the region, bridge, and fpga-mgr frameworks.
>>>>
>>>> Changelog v9 -> v10:
>>>>    - Fixed commit messages to reference register_full() instead of
>>>>      register_simple().
>>>>    - Removed the fpga_bridge_register_full() function, because there is
>>>>      not need for it yet. Updated the documentation and commit message
>>>>      accordingly.
>>>>    - Updated documentation to reference the fpga_manager_info and
>>>>      fpga_region_info structures.
>>>>
>>>> Changelog v8 -> v9:
>>>>    - Cleaned up documentation for the FPGA Manager, Bridge, and Region
>>>>      register functions
>>>>    - Renamed fpga_*_register() to fpga_*_register_full()
>>>>    - Renamed fpga_*_register_simple() to fpga_*_register()
>>>>    - Renamed devm_fpga_mgr_register() to devm_fpga_mgr_register_full()
>>>>    - Renamed devm_fpga_mgr_register_simple() to devm_fpga_mgr_register()
>>>>
>>>> Changelog v7 -> v8:
>>>>    - Added reviewed-by tags.
>>>>    - Updated Documentation/driver-api/fpga/ files: fpga-mgr.rst,
>>>>      fpga-bridge.rst, and fpga-region.rst.
>>>>
>>>> Changelog v6 -> v7:
>>>>    - Update the commit messages to describe the new parameters for the
>>>>      *register() functions and to mention the *register_simple() functions.
>>>>    - Fix function prototypes in header file to rename dev to parent.
>>>>    - Make use of the PTR_ERR_OR_ZERO() macro when possible.
>>>>    - Some cleanup of comments.
>>>>    - Update function definitions/prototypes to apply const to the new info
>>>>      parameter.
>>>>    - Verify that info->br_ops is non-null in the fpga_bridge_register()
>>>>      function.
>>>>    - Verify a non-null info pointer in the fpga_region_register() function.
>>>>
>>>> Changelog v5 -> v6:
>>>>    - Moved FPGA manager/bridge/region optional parameters out of the ops
>>>>      structure and back into the FPGA class driver structure.
>>>>    - Changed fpga_*_register() function parameters to accept an info data
>>>>      structure to provide flexibility in passing optional parameters.
>>>>    - Added fpga_*_register_simple() functions to support current parameters
>>>>      for users that don't require use of optional parameters.
>>>>
>>>> Changelog v4 -> v5:
>>>>    - Rebased on top of recently accepted patches.
>>>>    - Removed compat_id from the fpga_mgr_register() parameter list
>>>>      and added it to the fpga_manager_ops structure. This also required
>>>>      dynamically allocating the dfl-fme-ops structure in order to add
>>>>      the appropriate compat_id.
>>>>    - Created the fpga_region_ops data structure which is optionally passed
>>>>      to fpga_region_register(). compat_id, the get_bridges() pointer, and
>>>>      the priv pointer are included in the fpga_region_ops structure.
>>>>
>>>> Changelog v3 -> v4:
>>>>    - Added the compat_id parameter to fpga_mgr_register() and
>>>>      devm_fpga_mgr_register() to ensure that the compat_id is set before
>>>>      the device_register() call.
>>>>    - Added the compat_id parameter to fpga_region_register() to ensure
>>>>      that the compat_id is set before the device_register() call.
>>>>    - Modified the dfl_fpga_feature_devs_enumerate() function to restore
>>>>      the fpga_region_register() call to the correct location.
>>>>
>>>> Changelog v2 -> v3:
>>>>    - Cleaned up comment headers for fpga_mgr_register(), fpga_bridge_register(),
>>>>      and fpga_region_register().
>>>>    - Fixed error return on ida_simple_get() failure for fpga_mgr_register(),
>>>>      fpga_bridge_register(), and fpga_region_register().
>>>>    - Fixed error return value for fpga_bridge_register(): ERR_PTR(ret) instead
>>>>      of NULL.
>>>>
>>>> Changelog v1 -> v2:
>>>>    - Restored devm_fpga_mgr_register() functionality to the fpga-mgr
>>>>      class driver, adapted for the combined create/register functionality.
>>>>    - All previous callers of devm_fpga_mgr_register() will continue to call
>>>>      devm_fpga_mgr_register().
>>>>    - replaced unnecessary ternary operators in return statements with
>>>>      standard if conditions.
>>>>
>>>> Russ Weight (3):
>>>>    fpga: mgr: Use standard dev_release for class driver
>>>>    fpga: bridge: Use standard dev_release for class driver
>>>>    fpga: region: Use standard dev_release for class driver
>>>>
>>>>   Documentation/driver-api/fpga/fpga-bridge.rst |   6 +-
>>>>   Documentation/driver-api/fpga/fpga-mgr.rst    |  38 +++-
>>>>   Documentation/driver-api/fpga/fpga-region.rst |  12 +-
>>>>   drivers/fpga/altera-cvp.c                     |  12 +-
>>>>   drivers/fpga/altera-fpga2sdram.c              |  12 +-
>>>>   drivers/fpga/altera-freeze-bridge.c           |  10 +-
>>>>   drivers/fpga/altera-hps2fpga.c                |  12 +-
>>>>   drivers/fpga/altera-pr-ip-core.c              |   7 +-
>>>>   drivers/fpga/altera-ps-spi.c                  |   9 +-
>>>>   drivers/fpga/dfl-fme-br.c                     |  10 +-
>>>>   drivers/fpga/dfl-fme-mgr.c                    |  22 +-
>>>>   drivers/fpga/dfl-fme-region.c                 |  17 +-
>>>>   drivers/fpga/dfl.c                            |  12 +-
>>>>   drivers/fpga/fpga-bridge.c                    | 122 +++-------
>>>>   drivers/fpga/fpga-mgr.c                       | 215 ++++++++----------
>>>>   drivers/fpga/fpga-region.c                    | 119 ++++------
>>>>   drivers/fpga/ice40-spi.c                      |   9 +-
>>>>   drivers/fpga/machxo2-spi.c                    |   9 +-
>>>>   drivers/fpga/of-fpga-region.c                 |  10 +-
>>>>   drivers/fpga/socfpga-a10.c                    |  16 +-
>>>>   drivers/fpga/socfpga.c                        |   9 +-
>>>>   drivers/fpga/stratix10-soc.c                  |  16 +-
>>>>   drivers/fpga/ts73xx-fpga.c                    |   9 +-
>>>>   drivers/fpga/xilinx-pr-decoupler.c            |  17 +-
>>>>   drivers/fpga/xilinx-spi.c                     |  11 +-
>>>>   drivers/fpga/zynq-fpga.c                      |  16 +-
>>>>   drivers/fpga/zynqmp-fpga.c                    |   9 +-
>>>>   include/linux/fpga/fpga-bridge.h              |  30 ++-
>>>>   include/linux/fpga/fpga-mgr.h                 |  62 +++--
>>>>   include/linux/fpga/fpga-region.h              |  36 ++-
>>>>   30 files changed, 383 insertions(+), 511 deletions(-)
>>>>
>

