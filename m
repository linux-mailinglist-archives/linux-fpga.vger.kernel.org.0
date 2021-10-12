Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75D8C429AAE
	for <lists+linux-fpga@lfdr.de>; Tue, 12 Oct 2021 03:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231361AbhJLBC2 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 11 Oct 2021 21:02:28 -0400
Received: from mga17.intel.com ([192.55.52.151]:16150 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229456AbhJLBC1 (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 11 Oct 2021 21:02:27 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10134"; a="207810364"
X-IronPort-AV: E=Sophos;i="5.85,366,1624345200"; 
   d="scan'208";a="207810364"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2021 18:00:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,366,1624345200"; 
   d="scan'208";a="441005662"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga006.jf.intel.com with ESMTP; 11 Oct 2021 18:00:24 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Mon, 11 Oct 2021 18:00:23 -0700
Received: from orsmsx605.amr.corp.intel.com (10.22.229.18) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Mon, 11 Oct 2021 18:00:23 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Mon, 11 Oct 2021 18:00:23 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.108)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Mon, 11 Oct 2021 18:00:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LH8JSRRbrUrr0HxxWiYMh2iNtCIn6qaN4uEOQ32AGImhUE64AR0TOVDft0o/I3krAeUGa29y6AApiRz0cBiZ2MlaNTDKDNq6XpJkdFShV5hxsXnSL3bZQCLSc5alu0qNNarsSppHeGSZftlGGQURtVWdOTO+5PCQCrnLNymrEAr16XFpTJjkBNdlKJBmHV/LMIyPtQXd0fB4kIcoKb8+6au/u5dI/fPLPDJjhcFJ93Gn/bxKeUNJh4a60xX/lCwWwzdqRHMjZec6DhTANWZ1mMKfuI981zAJAiCwuhdaD2rCG4QQx7aOGGno86ojQd7Eut3Ue1YU8jxtKjj7c8dJNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O66YN8t40mrLQHMMyUr2z5QNXvcKUSmeeE+ntN24eKU=;
 b=SFAEOZqaifLauT0SHW6p5UlIXAzb4Li/ZUnCILOYr0FvgEKapNwuYKNc8HXKWRrb1mfPhmvJUtM/ZoSfLB98k4M3wOvfMFD5GLm9r3oIJwDdxVcdc0/6mxpuBEzJ7gcvuXAsv0ldYpWCMbpJhgYNPE709t0SQcergkQReOzuN4vQehwNAOyhfQYcs5F/3BRM7zOvOACrU+wBEMFrSaW1L7s/dgqTY0uCEia0TiWD6zPK6QY98xXkXi90WBq0VxmvVJbFWtBOeteIQPKnxySxyvGhyohOb/Q4PfHSlOILcdtZlvq2afl7yoAyKsuuy1/IOhaawU4LXdtxFwfhlG5s3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O66YN8t40mrLQHMMyUr2z5QNXvcKUSmeeE+ntN24eKU=;
 b=gZ12f0rCnKKhSuFouaPMxCb/IHcncYgpx4y6wC0ewnT6DkarFz2wz0Zg8ItLWKceO/8PtB9Oita6lsLai49oQE6QuXXyJPljo8yQh9uQVu+GZEgDtQsuRrqwtkmXBRdDvkISDCuhDFN8hLXY3ktZPypb2K7WPAaa4dR3viBUJSc=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
Received: from SA2PR11MB5163.namprd11.prod.outlook.com (2603:10b6:806:113::20)
 by SA0PR11MB4576.namprd11.prod.outlook.com (2603:10b6:806:97::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.20; Tue, 12 Oct
 2021 01:00:21 +0000
Received: from SA2PR11MB5163.namprd11.prod.outlook.com
 ([fe80::a039:c121:4dce:5def]) by SA2PR11MB5163.namprd11.prod.outlook.com
 ([fe80::a039:c121:4dce:5def%8]) with mapi id 15.20.4587.026; Tue, 12 Oct 2021
 01:00:21 +0000
Subject: Re: [PATCH v17 0/5] FPGA Image Load (previously Security Manager)
To:     Tom Rix <trix@redhat.com>, Xu Yilun <yilun.xu@intel.com>
CC:     <mdf@kernel.org>, <linux-fpga@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <lgoncalv@redhat.com>,
        <hao.wu@intel.com>, <matthew.gerlach@intel.com>
References: <20210929230025.68961-1-russell.h.weight@intel.com>
 <20211009080859.GA85181@yilunxu-OptiPlex-7050>
 <450ed897-f726-9671-26b7-2a24bb046e89@redhat.com>
 <20211011014154.GA82360@yilunxu-OptiPlex-7050>
 <79350773-3629-2734-21c0-0314a762e722@redhat.com>
From:   Russ Weight <russell.h.weight@intel.com>
Message-ID: <336e4827-b09a-e1ab-b67d-d8755012d71c@intel.com>
Date:   Mon, 11 Oct 2021 18:00:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
In-Reply-To: <79350773-3629-2734-21c0-0314a762e722@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: MW3PR06CA0029.namprd06.prod.outlook.com
 (2603:10b6:303:2a::34) To SA2PR11MB5163.namprd11.prod.outlook.com
 (2603:10b6:806:113::20)
MIME-Version: 1.0
Received: from [10.0.2.4] (50.43.42.212) by MW3PR06CA0029.namprd06.prod.outlook.com (2603:10b6:303:2a::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.19 via Frontend Transport; Tue, 12 Oct 2021 01:00:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d1002fb2-1051-4253-d485-08d98d1baa7d
X-MS-TrafficTypeDiagnostic: SA0PR11MB4576:
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR11MB45763A133D74F2CF0DEC3D0DC5B69@SA0PR11MB4576.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lTxQxjetodpfubmRtIVcH+T3bT/egL7at4JNxrj/QeBozM51+HzESYJgbOxnUAz3i9rVZqOzJw5paoCVdEr/UVFh4lJjI3bng6ACo9M9f5mNXg6R2D1oqHMXeNZkxRSspvd3ay2qFe8PIRJ5uYalqIQz7jrYXZt0utt+MoB6HUavSAQtvHEG8j3U7rPakP4GVS5tcpbjdgtJAbdla/wioHMCAP2pAC7wVSiUtuIriuZdBmVsM5g37wKWIRCiZSs0I82L5gHRJ9zSbtrpLC8eGVRnF4qut2CrHUaFWYaX1tWH5fUS2FlpeKpXqCbGYRY1G1wsubWkXnI752AptAn8JPWhJ8ocd2uDxyxe79U9K4OErZYYad7Avt/bnEIdhYzkwT+BnlnNR09TIbT6CgI1ckcC3ifeRCuYkkLloBzuABlx3rpOz9i/lvADuKuVMHmoXkko68bHpqS4oTk7rypFBuezhbLNhoTD1a8FZJRAsdUjd9GuiHFSN454/bmnR7zhGBG5RnYTm+r4iCUapWvtkZahwhTGN2kr0Uw8hQPSi0bSVxDEDuxu3MXGtYHYGvzick4SygWOc/JLcPqTN9o+i1r/+2oJGzNr47TSxd6xo8T4WgJbWO0YgfKmnWev4Q8WjpNrdaD2PKAw3m0qWPdp3rXuJxL3rAcj99lzozbwYjzBxNjF8cB5M8EC+scRtbHAsdQZoOnEJ2/AadfLUC6FNtBzFqI665cWv+n/9u3nNO+ulopthrnf7U31HM1ZumCSFkiQ/FUQy5WHT/lrap9PL3/pKixpr76RMmH51BHtlIdUsXM4GpyYgaYaWcW4WzV9+qwvbDYjIsJn7NZZlv9UH7pAcZHqBm9kgeNDaRtxaQU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB5163.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(5660300002)(16576012)(15650500001)(6636002)(110136005)(316002)(31686004)(508600001)(38100700002)(53546011)(36756003)(6666004)(956004)(966005)(2616005)(83380400001)(26005)(8676002)(2906002)(4326008)(8936002)(66556008)(86362001)(186003)(66946007)(31696002)(66476007)(6486002)(107886003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZkJsNWxDQkFrUTZhaGwwWnpSaFN0SkVUTE1PY3NjVnlFcnZPSjdOSWxLU3ZX?=
 =?utf-8?B?WDdRVVo2WHVub1RNbWR4eFVndjVOTGtKRGhsSHJLUmRHK0gyN01PaVpLSlc5?=
 =?utf-8?B?aUozcVgyVXN6clFTSzlYNEJ0YlNmR1krejhSZ2RmRjAvREVGdDRSaDh0ekRj?=
 =?utf-8?B?Wll0Y0MybEtNcVB1RnVqRThDTFpyZ2thTlMvajhoazFIREhaQ1lFa2lhcXdU?=
 =?utf-8?B?YWxOMW53UGRoUVBEYlNHdEk4YW5TSEhFT3RreE44WXRicWlNNXFPdjhYdWM3?=
 =?utf-8?B?V1FLK3dEVlVaREw3NXYzWE5aZ3ViWlA1cks3U3JPRWYyMW1vRWhMQW9PRE1o?=
 =?utf-8?B?TS85UzJKQ2U4OE1scE5nUU83c29JWGFTRnJJZmFWL04xNzNwYzBMZUxmZzBa?=
 =?utf-8?B?SENRUkYxVXhobStqK0VUTTJldUtCQktSWXRpVXBKdFhiUWxpVkVjQnI1bEJG?=
 =?utf-8?B?c09naGc1VDJQbWo4cll2MExpTURoWnhXYnFNSk1rc1VES0djRUpEQTNudy9y?=
 =?utf-8?B?UkpBS3JXanB4SitRQVlpMU5YNlF0OVhlY0x0a21heXFqRWVPQWVMOFlMNEh5?=
 =?utf-8?B?NjZtcS9VU2xIdEdBOGJQSXlYd0o0RzRGTWdpSTJsK1JSYjZTRkg2WmY3bHhQ?=
 =?utf-8?B?dHI2TkoxRE44MFJzZWZsRkVIZ3JiOUxaNlhpZXJPcVZETFozLzFGMnhqeGpP?=
 =?utf-8?B?MnpJeDErL3hxSzUwOXAyWHh3TlNxSDFCSU11c0U4ZXZyRVYxbEpTLzNQME9r?=
 =?utf-8?B?ajh1TS9jS2lFRmV6UDRTSlM2VFRpYk1RYlgxaVROWnZ1TTJvMTdPZHJ0Q3VN?=
 =?utf-8?B?MXBzQmNmWjRlbTd6emhKdXNHUS9zNXZkMk1mQ1FKNWZ0UmhxT2VtSGtFNkIy?=
 =?utf-8?B?aU1raG1NTDNYSER2dVBBY3FzUG1BSFR1bWdrWHduc0ZLUHdIdkUraG1BYTZn?=
 =?utf-8?B?RjR0RDd1Tm9LRWdxU2xtMG1JVmk5cG1vTWFYT0lvVEV4dnFFWGRLWGtwQWZO?=
 =?utf-8?B?RHhGWnV6R3Nld0c4VzdiaUVYaW5FWE4wTGh2cnZRMHB5ZUhuT1lkbEZvc2tl?=
 =?utf-8?B?bEJOQnBDMDFXM0VxUk9HanlzTXJnT2RnYjJIb0dWd1FVbjFyYmVxdnJidGlD?=
 =?utf-8?B?TXRXdnZHVU1Ialc1L25qVFpnNGJSVi9ZaU9uaFBKRkl1VFJBb1ptYXRYRjd2?=
 =?utf-8?B?SlZOOXpabkFiVkJWY01XS2FFOXNXQ040S2RGclBTQ2xHWm9lMHB6a0pNaXpN?=
 =?utf-8?B?VXE3cG5Gd2s5VXZpNVYvQ3lJV1FaaGhZS1lGam9OaGtUaXk3dXFxaW10bUd5?=
 =?utf-8?B?VzRtR0JncEJ6b1N5ckV3Nmw2YTk0bHo2Q1RwN3hXVzcyMXhxTmZzUXVYRnRk?=
 =?utf-8?B?bnJaMTVFYjJIdGk1REtJcDFpa2xLanZxOC9QMDNHdDNyaGFnYWhUSnh1Q1pi?=
 =?utf-8?B?K3Y0aDNBbEpKM1RvZi9Vb2lIbVY5NFdna0R2aDlKd1FKS29GTng1STcyUU8y?=
 =?utf-8?B?VnEzaHduWnNUUUowSll6dThCMHdnMU9aNDNIM2hxSTVIblJLcHRMM2dJaWJP?=
 =?utf-8?B?Wk5pUUh6NUtxM3FPbWFVSGlKMjVFQm45T1gwOVhIQ2JXU0gzWHczYXZXYS9X?=
 =?utf-8?B?blJqSFhXU0xicjJZbCtoSk9DUlJmNzV4RXlMTDlUWmJoT0QyWUttOXZKYWth?=
 =?utf-8?B?WmJ3VERXZWc4YVIwaHNFSDFTT3RyeURPZUUrVFNVOEtNQXJEZHIycDZMMndV?=
 =?utf-8?Q?xQ8XuR3cCKa31Eg4X7SNUWlzjOKUrWbHqhU8s7g?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d1002fb2-1051-4253-d485-08d98d1baa7d
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB5163.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2021 01:00:21.5125
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FcoyLTs9/UmpzVyRFgo/wZvh6oDLlhgKzFCSqcFC+WhEUVHU9NwIe6Ba7GxSf+/IgMiTN4jhc4q5sZI9apeYMsmKgKMniMlzZql4D/oivN4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4576
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On 10/11/21 5:35 AM, Tom Rix wrote:
>
> On 10/10/21 6:41 PM, Xu Yilun wrote:
>> On Sat, Oct 09, 2021 at 05:11:20AM -0700, Tom Rix wrote:
>>> On 10/9/21 1:08 AM, Xu Yilun wrote:
>>>> On Wed, Sep 29, 2021 at 04:00:20PM -0700, Russ Weight wrote:
>>>>> The FPGA Image Load framework provides an API to upload image
>>>>> files to an FPGA device. Image files are self-describing. They could
>>>>> contain FPGA images, BMC images, Root Entry Hashes, or other device
>>>>> specific files. It is up to the lower-level device driver and the
>>>>> target device to authenticate and disposition the file data.
>>>> I've reconsider the FPGA persistent image update again, and think we
>>>> may include it in FPGA manager framework.
>>>>
>>>> Sorry I raised this topic again when it is already at patch v17, but now
>>>> I need to consider more seriously than before.
>>>>
>>>> We have consensus the FPGA persistent image update is just like a normal
>>>> firmware update which finally writes the nvmem like flash or eeprom,
>>>> while the current FPGA manager deals with the active FPGA region update
>>>> and re-activation. Could we just expand the FPGA manager and let it handle
>>>> the nvmem update as well? Many FPGA cards have nvmem and downloaders
>>>> supports updating both FPGA region and nvmem.
The fpga-image-load driver is actually just a data transfer. The class
driver has no knowledge about what the data is or where/if the data will
be stored.

This functionality could, of course, be merged into the fpga-mgr. I did
a proof of concept of this a while back and we discussed the pros and cons.
See this email for a recap:

https://marc.info/?l=linux-fpga&m=161998085507374&w=2

Things have changed some with the evolution of the driver. The IOCTL
approach probably fits better than the sysfs implementation. At the time
it seemed that a merge would add unnecessary complexity without adding value.

>>>>
>>>> According to the patchset, the basic workflow of the 2 update types are
>>>> quite similar, get the data, prepare for the HW, write and complete.
>>>> They are already implemented in FPGA manager. We've discussed some
>>>> differences like threading or canceling the update, which are
>>>> not provided by FPGA manager but they may also nice to have for FPGA
>>>> region update. An FPGA region update may also last for a long time??
>>>> So I think having 2 sets of similar frameworks in FPGA is unnecessary.
>>>>
>>>> My quick mind is that we add some flags in struct fpga_mgr & struct
>>>> fpga_image_info to indicate the HW capability (support FPGA region
>>>> update or nvmem update or both) of the download engine and the provided
>>>> image type. Then the low-level driver knows how to download if it
>>>> supports both image types.An char device could be added for each fpga manager dev, providing the
>>>> user APIs for nvmem update. We may not use the char dev for FPGA region
>>>> update cause it changes the system HW devices and needs device hotplug
>>>> in FPGA region. We'd better leave it to FPGA region class, this is
>>>> another topic.
I'll give this some more thought and see if I can come up with some RFC
patches.

- Russ
>>>>
>>>> More discussion is appreciated.
>>> I also think fpga_mgr could be extended.
>>>
>>> In this patchset,
>>>
>>> https://lore.kernel.org/linux-fpga/20210625195849.837976-1-trix@redhat.com/
>>>
>>> A second, similar set of write ops was added to fpga_manger_ops,
>>>
>>> new bit/flag was added to fpga_image_info
>>>
>>> The intent was for dfl to add their specific ops to cover what is done in
>>> this patchset.
>> I think we don't have to add 2 ops for reconfig & reimage in framework,
>> the 2 processes are almost the same.
>>
>> Just add the _REIMAGE (or something else, NVMEM?) flag for
>> fpga_image_info, and low level drivers handle it as they do for other
>> flags.
>>
>> How do you think?
>
> A single set is fine.
>
> A difficult part of is the length of  time to do the write. The existing write should be improved to use a worker thread.
>
> Tom
>
>>
>> Thanks,
>> Yilun
>>
>>> Any other driver would do similar.
>>>
>>> Is this close to what you are thinking ?
>>>
>>> Tom
>>>
>>>> Thanks,
>>>> Yilun
>>>>
>

