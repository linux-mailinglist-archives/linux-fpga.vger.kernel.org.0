Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6DA33D7B36
	for <lists+linux-fpga@lfdr.de>; Tue, 27 Jul 2021 18:39:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbhG0QjC (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 27 Jul 2021 12:39:02 -0400
Received: from mga06.intel.com ([134.134.136.31]:59943 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230178AbhG0QjB (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 27 Jul 2021 12:39:01 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10057"; a="273562281"
X-IronPort-AV: E=Sophos;i="5.84,274,1620716400"; 
   d="scan'208";a="273562281"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2021 09:38:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,274,1620716400"; 
   d="scan'208";a="662893926"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga006.fm.intel.com with ESMTP; 27 Jul 2021 09:38:55 -0700
Received: from fmsmsx605.amr.corp.intel.com (10.18.126.85) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Tue, 27 Jul 2021 09:38:55 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4
 via Frontend Transport; Tue, 27 Jul 2021 09:38:55 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.107)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Tue, 27 Jul 2021 09:38:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W3eUIOutMW16uoB3nfZ06uxS84PHrWk4XInQYcESwc6mEKmwfD2QJvTWwn6hYH09ZCPfpd5lxF4QYqia8RDmkdgKddc2OtaD1dUDk9MM4vN7tVhULFkCF1Ee37gxSTX+pUfe/Bb4MLchDfuxHAeD56mQmDSBEXH/TrBVBHefTZUPcnWXUpBYBM7mpuunn9SZy+zJ6O/YUpq3oTpZNR4lXJLvlDJcaki8RVRMghmKvbCY+x79MlFKmGzppGMl+cbU7bq+U+loaorHA4wtjtAeAG1ZZpB51VHy+4TXy5Me46NzNhNzrqSDpPIP9XT8f9GDZlA1Cy6A3lbKFAY8DrrWHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9dETGtj66Okt5p3/1ynJT3iJlA7h9VQOEITOjGhdoZM=;
 b=FTn4ENBjiGPHByJKv2qsiNKXe9ACKhKaxX5LTtuWG7Olrejomx7+4oU2MZK44fflr0oEg4X+ZPpGrXFNGs+yB4A0RSGNmKD1hFlsXZ0l/4JJ9x1B2AgYDwDAIrGUILf0wyunRfDJDHvF8LW9oD01howsB6zQjAVtF8qWd3tS4JLOIGAzE45Q7Nt5FtZ8qXRDlDluc54N3s81ahTycpxkIs0fQbZ060fYydymKs9YhD6ZQ/WGx7zWD0hEXxxyLQht1FY0OEuQ4bEYWnn6VMo/KbQXDjj7fe18cXPoP7HcgrhIu7nTIz4PNI5Ji3JuhW29XnAmopi20YkeDYYvANP92g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9dETGtj66Okt5p3/1ynJT3iJlA7h9VQOEITOjGhdoZM=;
 b=nU2+jfmIqxwQZ+jmCH06Ye7Zf7uO9b2MP50XUqSp7kJfx1hQy+GEaJlMIElHxRtS512xxJ4NHDEmuGrCa8c5HHEdjHdQ5R3OD9hh4fU60ZwmT5B8zjPib9pmZGJ1weDMB55Vnh+e4COQ77VueVdyKu5kDHGyhlmqy2xmTRsPEC8=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
Received: from SA2PR11MB5163.namprd11.prod.outlook.com (2603:10b6:806:113::20)
 by SA2PR11MB5148.namprd11.prod.outlook.com (2603:10b6:806:11e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.17; Tue, 27 Jul
 2021 16:38:53 +0000
Received: from SA2PR11MB5163.namprd11.prod.outlook.com
 ([fe80::51db:698d:e2e3:7fc8]) by SA2PR11MB5163.namprd11.prod.outlook.com
 ([fe80::51db:698d:e2e3:7fc8%4]) with mapi id 15.20.4352.031; Tue, 27 Jul 2021
 16:38:53 +0000
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
From:   Russ Weight <russell.h.weight@intel.com>
Message-ID: <add87155-6417-fd08-c3c5-b39e7b9662df@intel.com>
Date:   Tue, 27 Jul 2021 09:38:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.11.0
In-Reply-To: <8584c933-4482-446a-761c-9a5d511a81c5@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: MW4PR04CA0264.namprd04.prod.outlook.com
 (2603:10b6:303:88::29) To SA2PR11MB5163.namprd11.prod.outlook.com
 (2603:10b6:806:113::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.0.2.4] (50.43.42.212) by MW4PR04CA0264.namprd04.prod.outlook.com (2603:10b6:303:88::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.26 via Frontend Transport; Tue, 27 Jul 2021 16:38:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e906c3af-ee94-4617-1d50-08d9511d04e3
X-MS-TrafficTypeDiagnostic: SA2PR11MB5148:
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA2PR11MB5148EF95C1622C577D20CCABC5E99@SA2PR11MB5148.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v3F2qKJBUhTVBF1Z+i5+tX3ui3Q1sEIoEOr2NX9PxdexmSLFrl3pBQDA/qASLrh1PS0xGtw30zcG7Z5aZMSsXKKlyTec1Us6n1OZRE63DhAjCNnShwJsUbAHBHIjo207zSOdq2xiAMOhsGTVPrsxlURt7Am4+QzrMOr4DoN17qswhgPk4EKFjJcVqx3+MlDN0YlCIIr5/EyCH9cUDQexMbzBO+qFrk2Wq7ROXNiUDP9F4vzdw/k007/Yf9jqmFtwQyK+cc7LPCaNiLqfEOzVLjVlGNsCRNU+8EE6jM1SF2qMm9yU6jAhjXYNSpcokm1M4aZvI7YWm30MWL7u8lIvopNsN98Wb7ylhEnd4I2oHgWL134Me/eiyvOKaWTyxY3XfNl0+f/iwyDC/7voND24NfneKTfP9+X3//iuWzT6ZQ4NLVuKKeZ5uY5dMmVmSjXgZiDec2xTpAUgRO5YtN9oH44oX31bLQUFCy59uJalaWXkUJxKZRgkcq9zngBnW6P/ynTd2bbdlVhJwdLXnBH2zn+YLHOjoo/KFAVHBkgZAfHClxB+ehCi8sBMeWEyW/j1Wt3CKJQlvwzB11hT3kWd/rb6Nh8BSTJ2Ps7YKA/+debhBQcLphs8326U0Etn+v/lE1hBy8FDuJ5Pf8kAG7oQg229mKFLCTD11eo70cENBkhk1xFEgDvZy3UCE8+NPSLwruGFOfn5Fv3wViGrJW93KZXi6SAgAOMG4xjK+OoV3RIOQeFGfxXmCRtOrfoss0XNSdf3g6lOFbLt1hcWIsFLPcYR31NWVis68A4Gy782L87deGvpC3mj7TQiJe6qGrG7w98twQap68lGZTeYu6giUR+wjgLfj5RevYfR703EjEs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB5163.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66556008)(45080400002)(8936002)(956004)(8676002)(53546011)(36756003)(508600001)(66946007)(6486002)(66476007)(38100700002)(107886003)(2616005)(83380400001)(2906002)(26005)(31686004)(86362001)(5660300002)(16576012)(316002)(186003)(6636002)(966005)(4326008)(31696002)(110136005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NlBITnJTdUVwcFE1U00zVS9nd1ZLQlV1UFJpT3pWdVZZU1VVZDhRd2ZSZEx6?=
 =?utf-8?B?dFg3WjcrSXNpKzJvdjhNaGZ5V2Z3eThlcVU4TG1zdW1odGV4cXNRekFzOGxZ?=
 =?utf-8?B?YWZ1ZWx6VWdlenJGNXZnKzEreU91STJsNHpmTi95SXRlbDk3dStPZUpsNEh6?=
 =?utf-8?B?bE5hQlRqZGkvcFV2RmNvaXU5dUgrWnN6cUFlazV1Zm40d0NHZ0pNNklSeW5C?=
 =?utf-8?B?M0Z1OTQ4d1loYXltNCs5V3Z3TE1tamx2SHNsYnRKTGZ3T3NwdUgxZkNBZ0kw?=
 =?utf-8?B?YytmQUErK1V3YXd2MHVXd2txUjBGWVNLbHZHM0xwTXJWQU9xeXRJbElmeExZ?=
 =?utf-8?B?azhScDByTVVMd1lVRGxrdUExSnhiSFhWTk53STZvTG1hUU1VelFlUHZPT1NE?=
 =?utf-8?B?NFVVTzZuVG5hWDZGSWQxQkhwWGhVbDh3VmVtelFTdnpsZzZkcnE4MXRpaTJr?=
 =?utf-8?B?RFlxdG5QUzVHZVNyVzJCUUVoMzFrVVE1UWhHc1ZzQjRGUmFGdDdXNStoRUtk?=
 =?utf-8?B?b3pXRXA0MytRc0hlMTRFQkJFc2JqK0tEV0crTTBXbGdtWEQzQnRUbURUNjlw?=
 =?utf-8?B?TUlycmZEQ2ZBQS94OVprSU9MT2ZPczJtZmMrS2d3eThqSysxa3lvWTArRGpV?=
 =?utf-8?B?eUtqRytEcHhyTU03YzM2SW51aTZGWm5iZFJYZUp0dk5tcVQwb2FueUlTdEQ5?=
 =?utf-8?B?QndpUk5VV0NQL0xzYXNCakJ4MUxoYzc4VG42enkxcU1QenYvODVyWXoyQkJD?=
 =?utf-8?B?M3Fsd3Y0QU9TZWRYWkVSbW1peUczYm01V2NyUGE3a3NzaXlZTm5hb09mVTB1?=
 =?utf-8?B?OUJUV01Ra2hWdU4vM2ozWUwwVlhzWFY2SHcySFlIYzA5YlpGU3NxMDlQRzR4?=
 =?utf-8?B?SU8rUUl6N3BSbVFmdHo4cXBuZ3pIVW5QMjU1cTE5dGVYWnQvY0ZMZ2tWcGww?=
 =?utf-8?B?YmNYUERvbVVyYnJsY0lCTGUvZ28wcDlveE5NRkkwejJVMWljNVIxTG9kbjF3?=
 =?utf-8?B?RU9ySFZYNnFaOFUvSEhrU2k1d3dUalBBN3JBT3lLRkhUVWxORXJCS3F4YU1u?=
 =?utf-8?B?aWlIYWExcFdBWXk3c0NXOSt5NzFRSDd0WEhRMmlrSWZBdHlERXpkYUtkRkNZ?=
 =?utf-8?B?T0ZYTE9vWHZEUyt6KzhkcmRaSHJ6aHhEZVZXbU1wU2FLMTZvaDJWYjBEcXRG?=
 =?utf-8?B?dnFhRE5JWUpPcFc3NTRrZDFpM3kvRkRVaDM0OUlUVTA2ai84UDFsNDNKZWJB?=
 =?utf-8?B?UTh3R3FERmptOGwvM2h2QWxnV3RqNTdDYVVDajZoYjB2alBMeitTeTRWbjNt?=
 =?utf-8?B?WCsxTHBHbnQybTJTYUtaZWtUSUUxZERXb1crN09uVE9wRXVLc1RNUHhWU0Vw?=
 =?utf-8?B?YlVaVmwwM2V2K3l2ck4yQXR0SDN0dWxGR1RWZmV6eVZVMXExRlRqclBJTGNF?=
 =?utf-8?B?OEhIZXZEci90QmpSbzBwUHRIUmIxUTgwQnpDSzlrTG9QUFF4TnR2dmJ1ais2?=
 =?utf-8?B?T0lUT1JTTi9mQ01wZnR2UTRLNzVWT0F1NmlqcWlSTHR2L1l2L2JJNmpzQW9h?=
 =?utf-8?B?WGM3UmNVZWdmVzFtVHV5dU5Ha0YzSERIajg0YmprRWpXc2M5NU1EVXRicVlQ?=
 =?utf-8?B?VldYNVBPazhBdHNsU29MOTQ0K05xbm5UZyt1b3czdStKajhVd24vamlNSno4?=
 =?utf-8?B?NGQrMnU4aDd2UDB1eG9JY1B4NDVwZy80OUVyOGdJekV6ZUJjMFdUeTRvR3pu?=
 =?utf-8?Q?MYb6AELr2yETbNsh+k+Jeir745KHrEZnlnmvFwh?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e906c3af-ee94-4617-1d50-08d9511d04e3
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB5163.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2021 16:38:52.8844
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EXOlC2JlzTQYWwO0H7G3StxRqsOIIvgUifLy9dNvXBknoviTAkxKuT6fVXm28farbf5t+lyj6hoWCY+yNdmCuMdxe9wYd2ELBKv7Lsza53U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5148
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On 7/27/21 9:22 AM, Tom Rix wrote:
>
> On 7/27/21 9:15 AM, Russ Weight wrote:
>>
>> On 7/27/21 6:24 AM, Tom Rix wrote:
>>> On 7/26/21 2:33 PM, Russ Weight wrote:
>>>> Hi Moritz,
>>>>
>>>> I sent this version of the patchset out on July 8th. The only discussion has
>>>> been around the compat-id structure. I think there is agreement that this can
>>>> be treated separately. What are your thoughts? Do you think this patchset is
>>>> ready?
>>> While I agree the compat_id can be treated separately, i still have a problem with the 2 register functions.
>>>
>>> In this discussion,
>>>
>>> https://lore.kernel.org/linux-fpga/DM6PR11MB38194D113950FA4B75C7F2C485E49@DM6PR11MB3819.namprd11.prod.outlook.com/
>>>
>>> *register_full(..., *info) becomes
>>>
>>> *register(..., *info)
>>>
>>> and
>>>
>>> *register_simple() is moved out of the public api and becomes private to the subsystem.
>> Somehow I missed that part of the email. I'm not sure I understand the part about
>> register_simple() "becomes private to the subsystem". Most users would call the simple
>> version of the API. Is the proposal to replicate the register_simple() interface
>> for each driver that calls it?
>
> Still use *register_simple() internally, so most of your patchset is unchanged.
>
> Move it out the public api. include/linux/fpga-mgr.h into someplace appropriate in drivers/fpga/

Ok - I'll do another spin of the patch set.

Just to be clear, *register_full() gets renamed back to *register(). The current *register()
goes back to *register_simple(). *register_simple() is an exported symbol, but the function
prototype moves out of the public header file into private header file under drivers/fpga.

- Russ

>
> Tom
>
>>
>>> Tom
>>>
>>>> Thanks,
>>>> - Russ
>>>>
>>>>
>>>> On 7/26/21 2:27 PM, Russ Weight wrote:
>>>>> The FPGA framework has a convention of using managed resource functions
>>>>> to allow parent drivers to manage the data structures allocated by the
>>>>> class drivers. They use an empty *_dev_release() function to satisfy the
>>>>> class driver.
>>>>>
>>>>> This is inconsistent with linux driver model.
>>>>>
>>>>> These changes remove the managed resource functions and populate the class
>>>>> dev_release callback functions. They also merge the create() and register()
>>>>> functions into a single register() or register_full() function for each of
>>>>> the fpga-mgr, fpga-region, and fpga-bridge class drivers.
>>>>>
>>>>> The new *register_full() functions accept an info data structure to provide
>>>>> flexibility in passing optional parameters. The *register() functions
>>>>> support the legacy parameter list for users that don't require the use of
>>>>> optional parameters.
>>>>>
>>>>> For more context, refer to this email thread:
>>>>>
>>>>> https://marc.info/?l=linux-fpga&m=162127412218557&w=2
>>>>>
>>>>> I turned on the configs assocated with each of the modified files, but I
>>>>> must have been missing some dependencies, because not all of them compiled.
>>>>> I did a run-time test specifically with the dfl-fme infrastructure. This
>>>>> would have exercised the region, bridge, and fpga-mgr frameworks.
>>>>>
>>>>> Changelog v9 -> v10:
>>>>>     - Fixed commit messages to reference register_full() instead of
>>>>>       register_simple().
>>>>>     - Removed the fpga_bridge_register_full() function, because there is
>>>>>       not need for it yet. Updated the documentation and commit message
>>>>>       accordingly.
>>>>>     - Updated documentation to reference the fpga_manager_info and
>>>>>       fpga_region_info structures.
>>>>>
>>>>> Changelog v8 -> v9:
>>>>>     - Cleaned up documentation for the FPGA Manager, Bridge, and Region
>>>>>       register functions
>>>>>     - Renamed fpga_*_register() to fpga_*_register_full()
>>>>>     - Renamed fpga_*_register_simple() to fpga_*_register()
>>>>>     - Renamed devm_fpga_mgr_register() to devm_fpga_mgr_register_full()
>>>>>     - Renamed devm_fpga_mgr_register_simple() to devm_fpga_mgr_register()
>>>>>
>>>>> Changelog v7 -> v8:
>>>>>     - Added reviewed-by tags.
>>>>>     - Updated Documentation/driver-api/fpga/ files: fpga-mgr.rst,
>>>>>       fpga-bridge.rst, and fpga-region.rst.
>>>>>
>>>>> Changelog v6 -> v7:
>>>>>     - Update the commit messages to describe the new parameters for the
>>>>>       *register() functions and to mention the *register_simple() functions.
>>>>>     - Fix function prototypes in header file to rename dev to parent.
>>>>>     - Make use of the PTR_ERR_OR_ZERO() macro when possible.
>>>>>     - Some cleanup of comments.
>>>>>     - Update function definitions/prototypes to apply const to the new info
>>>>>       parameter.
>>>>>     - Verify that info->br_ops is non-null in the fpga_bridge_register()
>>>>>       function.
>>>>>     - Verify a non-null info pointer in the fpga_region_register() function.
>>>>>
>>>>> Changelog v5 -> v6:
>>>>>     - Moved FPGA manager/bridge/region optional parameters out of the ops
>>>>>       structure and back into the FPGA class driver structure.
>>>>>     - Changed fpga_*_register() function parameters to accept an info data
>>>>>       structure to provide flexibility in passing optional parameters.
>>>>>     - Added fpga_*_register_simple() functions to support current parameters
>>>>>       for users that don't require use of optional parameters.
>>>>>
>>>>> Changelog v4 -> v5:
>>>>>     - Rebased on top of recently accepted patches.
>>>>>     - Removed compat_id from the fpga_mgr_register() parameter list
>>>>>       and added it to the fpga_manager_ops structure. This also required
>>>>>       dynamically allocating the dfl-fme-ops structure in order to add
>>>>>       the appropriate compat_id.
>>>>>     - Created the fpga_region_ops data structure which is optionally passed
>>>>>       to fpga_region_register(). compat_id, the get_bridges() pointer, and
>>>>>       the priv pointer are included in the fpga_region_ops structure.
>>>>>
>>>>> Changelog v3 -> v4:
>>>>>     - Added the compat_id parameter to fpga_mgr_register() and
>>>>>       devm_fpga_mgr_register() to ensure that the compat_id is set before
>>>>>       the device_register() call.
>>>>>     - Added the compat_id parameter to fpga_region_register() to ensure
>>>>>       that the compat_id is set before the device_register() call.
>>>>>     - Modified the dfl_fpga_feature_devs_enumerate() function to restore
>>>>>       the fpga_region_register() call to the correct location.
>>>>>
>>>>> Changelog v2 -> v3:
>>>>>     - Cleaned up comment headers for fpga_mgr_register(), fpga_bridge_register(),
>>>>>       and fpga_region_register().
>>>>>     - Fixed error return on ida_simple_get() failure for fpga_mgr_register(),
>>>>>       fpga_bridge_register(), and fpga_region_register().
>>>>>     - Fixed error return value for fpga_bridge_register(): ERR_PTR(ret) instead
>>>>>       of NULL.
>>>>>
>>>>> Changelog v1 -> v2:
>>>>>     - Restored devm_fpga_mgr_register() functionality to the fpga-mgr
>>>>>       class driver, adapted for the combined create/register functionality.
>>>>>     - All previous callers of devm_fpga_mgr_register() will continue to call
>>>>>       devm_fpga_mgr_register().
>>>>>     - replaced unnecessary ternary operators in return statements with
>>>>>       standard if conditions.
>>>>>
>>>>> Russ Weight (3):
>>>>>     fpga: mgr: Use standard dev_release for class driver
>>>>>     fpga: bridge: Use standard dev_release for class driver
>>>>>     fpga: region: Use standard dev_release for class driver
>>>>>
>>>>>    Documentation/driver-api/fpga/fpga-bridge.rst |   6 +-
>>>>>    Documentation/driver-api/fpga/fpga-mgr.rst    |  38 +++-
>>>>>    Documentation/driver-api/fpga/fpga-region.rst |  12 +-
>>>>>    drivers/fpga/altera-cvp.c                     |  12 +-
>>>>>    drivers/fpga/altera-fpga2sdram.c              |  12 +-
>>>>>    drivers/fpga/altera-freeze-bridge.c           |  10 +-
>>>>>    drivers/fpga/altera-hps2fpga.c                |  12 +-
>>>>>    drivers/fpga/altera-pr-ip-core.c              |   7 +-
>>>>>    drivers/fpga/altera-ps-spi.c                  |   9 +-
>>>>>    drivers/fpga/dfl-fme-br.c                     |  10 +-
>>>>>    drivers/fpga/dfl-fme-mgr.c                    |  22 +-
>>>>>    drivers/fpga/dfl-fme-region.c                 |  17 +-
>>>>>    drivers/fpga/dfl.c                            |  12 +-
>>>>>    drivers/fpga/fpga-bridge.c                    | 122 +++-------
>>>>>    drivers/fpga/fpga-mgr.c                       | 215 ++++++++----------
>>>>>    drivers/fpga/fpga-region.c                    | 119 ++++------
>>>>>    drivers/fpga/ice40-spi.c                      |   9 +-
>>>>>    drivers/fpga/machxo2-spi.c                    |   9 +-
>>>>>    drivers/fpga/of-fpga-region.c                 |  10 +-
>>>>>    drivers/fpga/socfpga-a10.c                    |  16 +-
>>>>>    drivers/fpga/socfpga.c                        |   9 +-
>>>>>    drivers/fpga/stratix10-soc.c                  |  16 +-
>>>>>    drivers/fpga/ts73xx-fpga.c                    |   9 +-
>>>>>    drivers/fpga/xilinx-pr-decoupler.c            |  17 +-
>>>>>    drivers/fpga/xilinx-spi.c                     |  11 +-
>>>>>    drivers/fpga/zynq-fpga.c                      |  16 +-
>>>>>    drivers/fpga/zynqmp-fpga.c                    |   9 +-
>>>>>    include/linux/fpga/fpga-bridge.h              |  30 ++-
>>>>>    include/linux/fpga/fpga-mgr.h                 |  62 +++--
>>>>>    include/linux/fpga/fpga-region.h              |  36 ++-
>>>>>    30 files changed, 383 insertions(+), 511 deletions(-)
>>>>>
>

