Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0CE853677A
	for <lists+linux-fpga@lfdr.de>; Fri, 27 May 2022 21:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233988AbiE0T0y (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 27 May 2022 15:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354117AbiE0T0x (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 27 May 2022 15:26:53 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C587663DE;
        Fri, 27 May 2022 12:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653679609; x=1685215609;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=24tIP644c9GsaVE2MdD4xkIlywhTrLT+L+6qJofq4kI=;
  b=JL/dfbBHoDji7eaKyj5G36FhCgY7BIvCkCPud+asmCR8p8q64zBmyWGZ
   egUIn2QSvsQTlbHB2pN8SYrjVUfdBCl36p40Wf+acRC/EbT5bxure3Hed
   rWikhBxBhXBPX5HfUAlMotmTaZA/1UnNJd6rCEwrOsnqIjIzfjJsm48T6
   agOB9MJ99oLhgsaulSrqZxMm0KnqDJcX1BS9G3IyCWL3hntdspBFD5pk0
   pGjAMMGeNaE1jnJNtNNAlFvVxXxB16OqYY9ryDJYEw1CLRxfO8bomlrjq
   2K6zMJot5Vfa5qeLg+UDKXUKBACK6RrIhkqjH+yAAxc7a2dmVdiMw5+B6
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10360"; a="273373712"
X-IronPort-AV: E=Sophos;i="5.91,256,1647327600"; 
   d="scan'208";a="273373712"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2022 12:26:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,256,1647327600"; 
   d="scan'208";a="560903564"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by orsmga002.jf.intel.com with ESMTP; 27 May 2022 12:26:48 -0700
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 27 May 2022 12:26:47 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Fri, 27 May 2022 12:26:47 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.43) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Fri, 27 May 2022 12:26:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ESNzR889SguMjWQD+60QOdU9CHP8JxcH7JKcpo7SNBQkjYwZZFNAZ/l3smI3azY/2GfEsD3IZSlY6tVuk15G1cmaSRMEs/zqc8Rrk7xEB2SKTWABJEg7Eu38y7CJrBbwAdMrn4yfESGQpMGW7/TrDeoSccjFY30Y9fsP5xLAH54Nuw15yvIUXolcW4fK9ERv95yHxSv500SFrtw+1GqmxN+t+PTdOdTW/2Rc99AVnXO3TaZ8APmpEstC77u2IsQuI/F7W0XPlELcMbE2iwRoyAByn6W0h2a8DH3pcQHCf4snWKYxqUh8WWniL2voFefu9vnprFa785Aqc9PPiddRbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uG6m9I6Fdpm0aSAXWebD296eHU3BbLoi2/A/8nWCIT0=;
 b=VXe9W7xBg8IVzQYUXfdDv6dkETw8DdN72ZNWjx9YCGTOi9nIdNJ4p0Cd4K1FIUua6rVK3sIOFLaSFSaDpd4AFzQ2sJZTFBU4+JMnIAK5ev2dR6XdvFfmpXAn5ubGsgvWesuPVrAwpTPnCFQpyTMCNK0mf6oeAe8DpoluevV1jigwavHf0LsZHCJluOnaT2yB8lCbdNXb5Lv+ttIryN0T4CvE+kq1V62/hizaJNe+NbHrV9K8/g2kvHrHWsRrYH3qqtyrmATVcnrS61uaHIoTRcN+E1CM39HKvRmnuipEOueNn6CujyQiv49JNRuCwVpPC7xefOIHuMIuv2wPFdeXsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM5PR11MB1899.namprd11.prod.outlook.com (2603:10b6:3:10b::14)
 by MWHPR11MB1775.namprd11.prod.outlook.com (2603:10b6:300:10e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Fri, 27 May
 2022 19:26:45 +0000
Received: from DM5PR11MB1899.namprd11.prod.outlook.com
 ([fe80::b9cb:2e5f:f3ef:f397]) by DM5PR11MB1899.namprd11.prod.outlook.com
 ([fe80::b9cb:2e5f:f3ef:f397%6]) with mapi id 15.20.5273.023; Fri, 27 May 2022
 19:26:45 +0000
Message-ID: <5205c925-ef41-e92c-f255-bcfe1c42d0ea@intel.com>
Date:   Fri, 27 May 2022 12:26:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.8.1
Subject: Re: [PATCH v21 5/5] fpga: m10bmc-sec: add max10 secure update
 functions
Content-Language: en-US
To:     Xu Yilun <yilun.xu@intel.com>
CC:     <mdf@kernel.org>, <hao.wu@intel.com>, <lee.jones@linaro.org>,
        <linux-fpga@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <trix@redhat.com>, <marpagan@redhat.com>, <lgoncalv@redhat.com>,
        <matthew.gerlach@linux.intel.com>,
        <basheer.ahmed.muddebihal@intel.com>, <tianfei.zhang@intel.com>
References: <20220521003607.737734-1-russell.h.weight@intel.com>
 <20220521003607.737734-6-russell.h.weight@intel.com>
 <20220526074856.GA148394@yilunxu-OptiPlex-7050>
 <4cd795ae-1648-9f0c-7b1c-68f761e83d79@intel.com>
 <20220527044709.GA165258@yilunxu-OptiPlex-7050>
From:   Russ Weight <russell.h.weight@intel.com>
In-Reply-To: <20220527044709.GA165258@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0178.namprd04.prod.outlook.com
 (2603:10b6:303:85::33) To DM5PR11MB1899.namprd11.prod.outlook.com
 (2603:10b6:3:10b::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d5935a24-e338-4911-9dee-08da4016d61c
X-MS-TrafficTypeDiagnostic: MWHPR11MB1775:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <MWHPR11MB17755125EB51B3954B6ED13CC5D89@MWHPR11MB1775.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bSbg6/sEHHR2uH61UjlpcnRNyEqHLm1gA1KvvxYIdTkaEiZ56JntTwftZrHPiEsRYa9lFE1FBfuCwdxWJf3FgLlUWvPme+vO6XwZt7Z+vRAFGWy0DyGetSTidT8VXj4qDP6+BV4YSLDyG/g6p7zQsG26UOe3dJXxFp7Dv/2/7nehDzzKN3KFsJM+9ix5eJRXZnPpTQCvFVi+02UPvcJkz8clWecRuEClHsIF5xTHSSpbvq1Ui0jfY/56VGzG2Kdzi6IZn53Fo/b6s2YYL9gUkEKGnf8kA4Wr2y8FMs9odwuwY6hG/JMXeRm5C6xn/XU2xrPcXI54K35TrbuxVIaJAiMlgxOyVdMrtWGxcEt/jGHi57CEGd0TIF0Og4ysS0j+HIWpIXbNoTt2N9xXhnD6LilzU/0qCb4yy3KhQYLjram4ZKRzqDVMVz0qeh/GYqwX4kMKGfvwtn7nId+RypYgq+KvA9cXeFctSf/0oJv2vK4UvEeWQ3TqcPon2GS6ntuFthDz27LF3PBgiWxKIRiz5Hil1aCLsoMmj2CjZ0fXkeFnz9KLDT42n3VRxkyXZlXD6zEzP3y89ClBer/Wnc2i4R7FJt/FtQQDfD0mQDXs/eVboDn0XkXPNnqXmGUsyoP96P1SEyAiE0xyWdwOArXv/wZbgMyCjneMnU2iqExh1V6twATC5m6FrJOc4Sbu9QAfDGMk/EG+Gk+XNjBDTzJH69LWTPHKk4LbAavVM9EJe3gVVehgW8qIDx4dG+zlxiH8bToFR/5EzpVcfU4O0HufI/1VC1Ths0/0CSDxSC4VVgCXHn2lJYCI3TKyA0bUf90I
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR11MB1899.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(6512007)(66556008)(66946007)(66476007)(6862004)(8676002)(38100700002)(4326008)(53546011)(82960400001)(5660300002)(508600001)(6486002)(966005)(6506007)(316002)(15650500001)(6666004)(86362001)(186003)(6636002)(36756003)(37006003)(31696002)(2906002)(26005)(30864003)(2616005)(31686004)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cmJqdERScXNENkdMUXIyWFc3VldVbVE2c3I1TUsyMytSNnJZbjdRQ0dkSEZv?=
 =?utf-8?B?cU1VdWdnaEtIVGh4ajNqYjNxbUhzcC9GTzBCNXQ1QmZhYVZiY2tTVTdHWUJs?=
 =?utf-8?B?MXFjUEpMcmpHbHg2VCtZanpSTWc1NVZubmd1K09Ieks2cEhpaFY2ZFhySEpX?=
 =?utf-8?B?TjNoQnA1SUp2VUIyNHFWWkFiY3pKZ09KdzRLVlJmbzJwa1VHZWl3RTRnZHMy?=
 =?utf-8?B?RlR5U01LRnowSTJUN0dVdS93MG00b0NZWjZadFAyYnVLOEl2VmFjWlMya0ZP?=
 =?utf-8?B?UXZUcW1zQ05GbFVRT3puVEdMY0MrYWw1K000eEE5L3FhQUh4K3VqNkNBMUQw?=
 =?utf-8?B?TWdCZXBwOXFuN3lkcHNuWnNZcUtMVXVseW5PQTlwbUFzSnZBOW91eXBnT3JK?=
 =?utf-8?B?Tm1BYlhRVmRwRXp3TWZIUXdDVS9QWVhiR0F6dDZJYVZ1S2Z4ckJ2SGxrdUFO?=
 =?utf-8?B?bytEbnpuUDlTd2YwdE01SWxJalZONkIxblVxZXQvOWJ0N1h5S0lRRENWVzh2?=
 =?utf-8?B?N2RiYmdDaVVQd3A2aFVlcFF3ckliZWw2dmdOaDE3blQvYzdycmNROGpoMHNV?=
 =?utf-8?B?NVJXWTJ5UkttUGZQRmJlWWtaOFQySGJkYmpvcGl3YlNHZlhnb0x5VUU3dStv?=
 =?utf-8?B?SE54TXAxemJDRkJQZ1doZkhITFNwK2RHTG9kay9YT1hUcmljMmVGQ3NLS1hW?=
 =?utf-8?B?aFVZMjZHU2d4QkRSUTNWR3N1VUJqR0JjZ1pLZ1hvYVVoZmw1MG9jcGltNGI1?=
 =?utf-8?B?OTJoSlRzQWcyM2Fxa2VvRXpLOThCbXhFYWNtbHo4VnlWUm9qR0FVaFVySmd0?=
 =?utf-8?B?YkswVnNSWEJPQWl1U1NWWmtubkYyOHo5SGx1S3ljNWg0M2xEUW5yYWY1TVNi?=
 =?utf-8?B?M29CcWdiaGphcGR4cWZSQTIxOURpRUVKeTQyRmdUa0Zjeko2RldrTXhoNTZm?=
 =?utf-8?B?ZWR0WGNtOHhNQTFXOSswMHB2Z3Z4RFVXMkQwdy9Xekc4WndWeThydDFyWFhJ?=
 =?utf-8?B?QnV6UkJOb1ZPenlJcmhwRjlBT1MvdE9vQ2JPbTlUc1Q3UDVVYmRLWkpIeXp0?=
 =?utf-8?B?em5hZ1o0dUFHODVobEhxZ2Z3azYxMU5sdWlmR0JSc3draVJOdzlLL2pvdVBG?=
 =?utf-8?B?MHdyeFZ0N2cwdCtyQUpndVUwQzdGQzZ6ZDM3UjB0aFJSRnlUZjF0TW5ONFZK?=
 =?utf-8?B?R3oxcDlmL3NJL1pzczNMdXJPUGo0QVhQMUhxWFVpOFJQVEpxaHBvR0hxaFNj?=
 =?utf-8?B?Y2E0MEcrclVtSU1Qek9NaDVtdVpvYTZ0M2VjdVVLNjFwZE1wa1hXaGZ6dGp3?=
 =?utf-8?B?MytBcTVvZDhRdUtscHpONFRHSk01YlpocFpvYmtkQkp4enhyQUlOMStnSkxm?=
 =?utf-8?B?bGpRaVd4RTNkMzdEZmxQQjF5WkhuVFlPc2RsbkpFdDJyZW80MjBMYTB4emtJ?=
 =?utf-8?B?T21GZFpaTzFtaWtvSHNPZ0JHM3owV052ODI1L3FVa3VKN053YncvZ29VY1lH?=
 =?utf-8?B?aTU4d2ZzVTBzRzY4clpMTHhPVnYxaU4rd01RM01NazA5WXQ0WmlFa3Z0MDY3?=
 =?utf-8?B?K2dSTWkySXg1WTNsak1QTGtMenFua21zZ3I4Qk9abFRVWUpMSkMvL1Z2a1VM?=
 =?utf-8?B?UU1KT1lFWHU0SlBiYmFaN25yNEhnQU5CYnR5UDJDSldhUDgraDU2WkhzQmV6?=
 =?utf-8?B?OUwrUlVEMHlJZkUybXVrbzkyTnMyaHZ5eXh4ay9OOVZEaEJ3M1d3Ynlyb3hk?=
 =?utf-8?B?ZDFaQ0hFYlVhMDZRT2t1b2I1TkpqY2M3REV5YVFpemZoMFZIZkdBYXFRSmFn?=
 =?utf-8?B?eWRyVXNDZmxvNHRNcU1JZnVDLzRDRnA4bWxyYXMvampJNlJDUDd1a2g2YVor?=
 =?utf-8?B?MWp5QXkvMTVkRUNlcDYyWXFDK1JzOHBNclJPdHdPSERaZXp0a1pNZW1HM002?=
 =?utf-8?B?QjlvMSsxc2VSTTM5SmpKZTdESDBHRWExV0ZWRzByYktUejZxeHFoUTdidjFB?=
 =?utf-8?B?eEVXdXFXMFVRREhCd1VibHJPRkNxc05kYnZwTDNOZHJpVGNNNFNYem1IL2Ix?=
 =?utf-8?B?aUdQQ2QwSU9OaHJnbDdhUUV3cG1veWZ3WUhweTZJanB3c2N6VXVjNERaa2ps?=
 =?utf-8?B?Yk9FSFVMWklYZEpCaVl3SXQwQy9TdHFWVVdISkFvUXRTQ2NMWXc0bU1Wb3FN?=
 =?utf-8?B?cHR5bmwwUlZtdEpUc2pzUTVvUkV3R0V6cEVaUVVsYVZUTUM4bFlzUjl2Wmx0?=
 =?utf-8?B?OWxZZ2hOSFZWT2o2R3pvT1lGZ1lDRzRyTjI5a3J0elBwcU9EUUdicHVkUk5x?=
 =?utf-8?B?VHVwVFRJZ1lrU1BnQXpNRWpVTHZpM0ZkcFZpWGRIZCtKVDdMd3lSN0RYREtI?=
 =?utf-8?Q?L/hSB1uIXcp3bDxI=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d5935a24-e338-4911-9dee-08da4016d61c
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1899.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2022 19:26:45.4504
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j+r4ZxBjWmmhN4M1AOhmZQIJj2qUAjtW57Shfiz8s4Q8CtfxtYe18lxgtBFfBM+PSteHNOQXSPEiBhzIHrsUcFzFCMsLvApD2hT8gqDdeBI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1775
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On 5/26/22 21:47, Xu Yilun wrote:
> On Thu, May 26, 2022 at 02:27:15PM -0700, Russ Weight wrote:
>>
>> On 5/26/22 00:48, Xu Yilun wrote:
>>> On Fri, May 20, 2022 at 05:36:07PM -0700, Russ Weight wrote:
>>>> Create firmware upload ops and call the Firmware Upload support of the
>>>> Firmware Loader subsystem to enable FPGA image uploads for secure
>>>> updates of BMC images, FPGA images, etc.
>>>>
>>>> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
>>>> ---
>>>> v21:
>>>>   - Update m10bmc_sec_prepare() to ensure that the base address for an
>>>>     update image is aligned with stride.
>>>>   - Update m10bmc_sec_write() to handle a block size that is not aligned
>>>>     with stride by allocating a zero-filled block that is aligned, and
>>>>     copying the data before calling regmap_bulk_write().
>>>> v20:
>>>>   - No change.
>>>> v19:
>>>>   - Change "card bmc" naming back to "m10 bmc" naming to be consistent
>>>>     with the parent driver.
>>>> v18:
>>>>   - Moved the firmware_upload_register() function here from an earlier
>>>>     patch since this is where the required ops are provided.
>>>>   - Moved the bmc_sec_remove() function here from an earlier patch to
>>>>     unregister the firmware driver and do cleanup.
>>>> v17:
>>>>   - Change "m10bmc" in symbol names to "cardbmc" to reflect the fact that the
>>>>     future devices will not necessarily use the MAX10.
>>>>   - Change from image_load class driver to the new firmware_upload 
>>>>     functionality of the firmware_loader.
>>>>   - fw_upload_ops functions will return "enum fw_upload_err" data types
>>>>     instead of integer values.
>>>> v16:
>>>>   - Use 0 instead of FPGA_IMAGE_ERR_NONE to indicate success.
>>>>   - The size alignment check was moved from the FPGA Image Load framework
>>>>     to the prepare() op.
>>>>   - Added cancel_request boolean flag to struct m10bmc_sec.
>>>>   - Moved the RSU cancellation logic from m10bmc_sec_cancel() to a new
>>>>     rsu_cancel() function.
>>>>   - The m10bmc_sec_cancel() function ONLY sets the cancel_request flag.
>>>>     The cancel_request flag is checked at the beginning of the
>>>>     m10bmc_sec_write() and m10bmc_sec_poll_complete() functions.
>>>>   - Adapt to changed prototypes for the prepare() and write() ops. The
>>>>     m10bmc_sec_write_blk() function has been renamed to
>>>>     m10bmc_sec_write().
>>>>   - Created a cleanup() op, m10bmc_sec_cleanup(), to attempt to cancel an
>>>>     ongoing op during when exiting the update process.
>>>> v15:
>>>>   - Adapted to changes in the FPGA Image Load framework:
>>>>     (1) All enum types (progress and errors) are now type u32
>>>>     (2) m10bmc_sec_write_blk() adds *blk_size and max_size parameters
>>>>         and uses *blk_size as provided by the caller.
>>>>     (3) m10bmc_sec_poll_complete() no long checks the driver_unload
>>>>         flag.
>>>> v14:
>>>>   - Changed symbol names to reflect the renaming of the Security Manager
>>>>     Class driver to FPGA Image Load.
>>>> v13:
>>>>   - No change
>>>> v12:
>>>>   - Updated Date and KernelVersion fields in ABI documentation
>>>>   - Removed size parameter from the write_blk() op. m10bmc_sec_write_blk()
>>>>     no longer has a size parameter, and the block size is determined
>>>>     in this (the lower-level) driver.
>>>> v11:
>>>>   - No change
>>>> v10:
>>>>   - No change
>>>> v9:
>>>>   - No change
>>>> v8:
>>>>   - Previously patch 5/6, otherwise no change
>>>> v7:
>>>>   - No change
>>>> v6:
>>>>   - Changed (size / stride) calculation to ((size + stride - 1) / stride)
>>>>     to ensure that the proper count is passed to regmap_bulk_write().
>>>>   - Removed unnecessary call to rsu_check_complete() in
>>>>     m10bmc_sec_poll_complete() and changed while loop to
>>>>     do/while loop.
>>>> v5:
>>>>   - No change
>>>> v4:
>>>>   - No change
>>>> v3:
>>>>   - Changed: iops -> sops, imgr -> smgr, IFPGA_ -> FPGA_, ifpga_ to fpga_
>>>>   - Changed "MAX10 BMC Secure Engine driver" to "MAX10 BMC Secure Update
>>>>     driver"
>>>>   - Removed wrapper functions (m10bmc_raw_*, m10bmc_sys_*). The
>>>>     underlying functions are now called directly.
>>>>   - Changed calling functions of functions that return "enum fpga_sec_err"
>>>>     to check for (ret != FPGA_SEC_ERR_NONE) instead of (ret)
>>>> v2:
>>>>   - Reworked the rsu_start_done() function to make it more readable
>>>>   - Reworked while-loop condition/content in rsu_prog_ready()
>>>>   - Minor code cleanup per review comments
>>>>   - Added a comment to the m10bmc_sec_poll_complete() function to
>>>>     explain the context (could take 30+ minutes to complete).
>>>>   - Added m10bmc_ prefix to functions in m10bmc_iops structure
>>>>   - Moved MAX10 BMC address and function definitions to a separate
>>>>     patch.
>>>> ---
>>>>  drivers/fpga/intel-m10-bmc-sec-update.c | 409 ++++++++++++++++++++++++
>>>>  1 file changed, 409 insertions(+)
>>>>
>>>> diff --git a/drivers/fpga/intel-m10-bmc-sec-update.c b/drivers/fpga/intel-m10-bmc-sec-update.c
>>>> index 65fec2a70901..7c48c47a74a6 100644
>>>> --- a/drivers/fpga/intel-m10-bmc-sec-update.c
>>>> +++ b/drivers/fpga/intel-m10-bmc-sec-update.c
>>>> @@ -17,8 +17,14 @@
>>>>  struct m10bmc_sec {
>>>>  	struct device *dev;
>>>>  	struct intel_m10bmc *m10bmc;
>>>> +	struct fw_upload *fwl;
>>>> +	char *fw_name;
>>>> +	u32 fw_name_id;
>>>> +	bool cancel_request;
>>>>  };
>>>>  
>>>> +static DEFINE_XARRAY_ALLOC(fw_upload_xa);
>>>> +
>>>>  /* Root Entry Hash (REH) support */
>>>>  #define REH_SHA256_SIZE		32
>>>>  #define REH_SHA384_SIZE		48
>>>> @@ -192,10 +198,380 @@ static const struct attribute_group *m10bmc_sec_attr_groups[] = {
>>>>  	NULL,
>>>>  };
>>>>  
>>>> +static void log_error_regs(struct m10bmc_sec *sec, u32 doorbell)
>>>> +{
>>>> +	u32 auth_result;
>>>> +
>>>> +	dev_err(sec->dev, "RSU error status: 0x%08x\n", doorbell);
>>>> +
>>>> +	if (!m10bmc_sys_read(sec->m10bmc, M10BMC_AUTH_RESULT, &auth_result))
>>>> +		dev_err(sec->dev, "RSU auth result: 0x%08x\n", auth_result);
>>>> +}
>>>> +
>>>> +static enum fw_upload_err rsu_check_idle(struct m10bmc_sec *sec)
>>>> +{
>>>> +	u32 doorbell;
>>>> +	int ret;
>>>> +
>>>> +	ret = m10bmc_sys_read(sec->m10bmc, M10BMC_DOORBELL, &doorbell);
>>>> +	if (ret)
>>>> +		return FW_UPLOAD_ERR_RW_ERROR;
>>>> +
>>>> +	if (rsu_prog(doorbell) != RSU_PROG_IDLE &&
>>>> +	    rsu_prog(doorbell) != RSU_PROG_RSU_DONE) {
>>>> +		log_error_regs(sec, doorbell);
>>>> +		return FW_UPLOAD_ERR_BUSY;
>>>> +	}
>>>> +
>>>> +	return FW_UPLOAD_ERR_NONE;
>>>> +}
>>>> +
>>>> +static inline bool rsu_start_done(u32 doorbell)
>>>> +{
>>>> +	u32 status, progress;
>>>> +
>>>> +	if (doorbell & DRBL_RSU_REQUEST)
>>>> +		return false;
>>>> +
>>>> +	status = rsu_stat(doorbell);
>>>> +	if (status == RSU_STAT_ERASE_FAIL || status == RSU_STAT_WEAROUT)
>>>> +		return true;
>>>> +
>>>> +	progress = rsu_prog(doorbell);
>>>> +	if (progress != RSU_PROG_IDLE && progress != RSU_PROG_RSU_DONE)
>>>> +		return true;
>>>> +
>>>> +	return false;
>>>> +}
>>>> +
>>>> +static enum fw_upload_err rsu_update_init(struct m10bmc_sec *sec)
>>>> +{
>>>> +	u32 doorbell, status;
>>>> +	int ret;
>>>> +
>>>> +	ret = regmap_update_bits(sec->m10bmc->regmap,
>>>> +				 M10BMC_SYS_BASE + M10BMC_DOORBELL,
>>>> +				 DRBL_RSU_REQUEST | DRBL_HOST_STATUS,
>>>> +				 DRBL_RSU_REQUEST |
>>>> +				 FIELD_PREP(DRBL_HOST_STATUS,
>>>> +					    HOST_STATUS_IDLE));
>>>> +	if (ret)
>>>> +		return FW_UPLOAD_ERR_RW_ERROR;
>>>> +
>>>> +	ret = regmap_read_poll_timeout(sec->m10bmc->regmap,
>>>> +				       M10BMC_SYS_BASE + M10BMC_DOORBELL,
>>>> +				       doorbell,
>>>> +				       rsu_start_done(doorbell),
>>>> +				       NIOS_HANDSHAKE_INTERVAL_US,
>>>> +				       NIOS_HANDSHAKE_TIMEOUT_US);
>>>> +
>>>> +	if (ret == -ETIMEDOUT) {
>>>> +		log_error_regs(sec, doorbell);
>>>> +		return FW_UPLOAD_ERR_TIMEOUT;
>>>> +	} else if (ret) {
>>>> +		return FW_UPLOAD_ERR_RW_ERROR;
>>>> +	}
>>>> +
>>>> +	status = rsu_stat(doorbell);
>>>> +	if (status == RSU_STAT_WEAROUT) {
>>>> +		dev_warn(sec->dev, "Excessive flash update count detected\n");
>>>> +		return FW_UPLOAD_ERR_WEAROUT;
>>>> +	} else if (status == RSU_STAT_ERASE_FAIL) {
>>>> +		log_error_regs(sec, doorbell);
>>>> +		return FW_UPLOAD_ERR_HW_ERROR;
>>>> +	}
>>>> +
>>>> +	return FW_UPLOAD_ERR_NONE;
>>>> +}
>>>> +
>>>> +static enum fw_upload_err rsu_prog_ready(struct m10bmc_sec *sec)
>>>> +{
>>>> +	unsigned long poll_timeout;
>>>> +	u32 doorbell, progress;
>>>> +	int ret;
>>>> +
>>>> +	ret = m10bmc_sys_read(sec->m10bmc, M10BMC_DOORBELL, &doorbell);
>>>> +	if (ret)
>>>> +		return FW_UPLOAD_ERR_RW_ERROR;
>>>> +
>>>> +	poll_timeout = jiffies + msecs_to_jiffies(RSU_PREP_TIMEOUT_MS);
>>>> +	while (rsu_prog(doorbell) == RSU_PROG_PREPARE) {
>>>> +		msleep(RSU_PREP_INTERVAL_MS);
>>>> +		if (time_after(jiffies, poll_timeout))
>>>> +			break;
>>>> +
>>>> +		ret = m10bmc_sys_read(sec->m10bmc, M10BMC_DOORBELL, &doorbell);
>>>> +		if (ret)
>>>> +			return FW_UPLOAD_ERR_RW_ERROR;
>>>> +	}
>>>> +
>>>> +	progress = rsu_prog(doorbell);
>>>> +	if (progress == RSU_PROG_PREPARE) {
>>>> +		log_error_regs(sec, doorbell);
>>>> +		return FW_UPLOAD_ERR_TIMEOUT;
>>>> +	} else if (progress != RSU_PROG_READY) {
>>>> +		log_error_regs(sec, doorbell);
>>>> +		return FW_UPLOAD_ERR_HW_ERROR;
>>>> +	}
>>>> +
>>>> +	return FW_UPLOAD_ERR_NONE;
>>>> +}
>>>> +
>>>> +static enum fw_upload_err rsu_send_data(struct m10bmc_sec *sec)
>>>> +{
>>>> +	u32 doorbell;
>>>> +	int ret;
>>>> +
>>>> +	ret = regmap_update_bits(sec->m10bmc->regmap,
>>>> +				 M10BMC_SYS_BASE + M10BMC_DOORBELL,
>>>> +				 DRBL_HOST_STATUS,
>>>> +				 FIELD_PREP(DRBL_HOST_STATUS,
>>>> +					    HOST_STATUS_WRITE_DONE));
>>>> +	if (ret)
>>>> +		return FW_UPLOAD_ERR_RW_ERROR;
>>>> +
>>>> +	ret = regmap_read_poll_timeout(sec->m10bmc->regmap,
>>>> +				       M10BMC_SYS_BASE + M10BMC_DOORBELL,
>>>> +				       doorbell,
>>>> +				       rsu_prog(doorbell) != RSU_PROG_READY,
>>>> +				       NIOS_HANDSHAKE_INTERVAL_US,
>>>> +				       NIOS_HANDSHAKE_TIMEOUT_US);
>>>> +
>>>> +	if (ret == -ETIMEDOUT) {
>>>> +		log_error_regs(sec, doorbell);
>>>> +		return FW_UPLOAD_ERR_TIMEOUT;
>>>> +	} else if (ret) {
>>>> +		return FW_UPLOAD_ERR_RW_ERROR;
>>>> +	}
>>>> +
>>>> +	switch (rsu_stat(doorbell)) {
>>>> +	case RSU_STAT_NORMAL:
>>>> +	case RSU_STAT_NIOS_OK:
>>>> +	case RSU_STAT_USER_OK:
>>>> +	case RSU_STAT_FACTORY_OK:
>>>> +		break;
>>>> +	default:
>>>> +		log_error_regs(sec, doorbell);
>>>> +		return FW_UPLOAD_ERR_HW_ERROR;
>>>> +	}
>>>> +
>>>> +	return FW_UPLOAD_ERR_NONE;
>>>> +}
>>>> +
>>>> +static int rsu_check_complete(struct m10bmc_sec *sec, u32 *doorbell)
>>>> +{
>>>> +	if (m10bmc_sys_read(sec->m10bmc, M10BMC_DOORBELL, doorbell))
>>>> +		return -EIO;
>>>> +
>>>> +	switch (rsu_stat(*doorbell)) {
>>>> +	case RSU_STAT_NORMAL:
>>>> +	case RSU_STAT_NIOS_OK:
>>>> +	case RSU_STAT_USER_OK:
>>>> +	case RSU_STAT_FACTORY_OK:
>>>> +		break;
>>>> +	default:
>>>> +		return -EINVAL;
>>>> +	}
>>>> +
>>>> +	switch (rsu_prog(*doorbell)) {
>>>> +	case RSU_PROG_IDLE:
>>>> +	case RSU_PROG_RSU_DONE:
>>>> +		return 0;
>>>> +	case RSU_PROG_AUTHENTICATING:
>>>> +	case RSU_PROG_COPYING:
>>>> +	case RSU_PROG_UPDATE_CANCEL:
>>>> +	case RSU_PROG_PROGRAM_KEY_HASH:
>>>> +		return -EAGAIN;
>>>> +	default:
>>>> +		return -EINVAL;
>>>> +	}
>>>> +}
>>>> +
>>>> +static enum fw_upload_err rsu_cancel(struct m10bmc_sec *sec)
>>>> +{
>>>> +	u32 doorbell;
>>>> +	int ret;
>>>> +
>>>> +	ret = m10bmc_sys_read(sec->m10bmc, M10BMC_DOORBELL, &doorbell);
>>>> +	if (ret)
>>>> +		return FW_UPLOAD_ERR_RW_ERROR;
>>>> +
>>>> +	if (rsu_prog(doorbell) != RSU_PROG_READY)
>>>> +		return FW_UPLOAD_ERR_BUSY;
>>>> +
>>>> +	ret = regmap_update_bits(sec->m10bmc->regmap,
>>>> +				 M10BMC_SYS_BASE + M10BMC_DOORBELL,
>>>> +				 DRBL_HOST_STATUS,
>>>> +				 FIELD_PREP(DRBL_HOST_STATUS,
>>>> +					    HOST_STATUS_ABORT_RSU));
>>>> +	if (ret)
>>>> +		return FW_UPLOAD_ERR_RW_ERROR;
>>>> +
>>>> +	return FW_UPLOAD_ERR_CANCELED;
>>>> +}
>>>> +
>>>> +static enum fw_upload_err m10bmc_sec_prepare(struct fw_upload *fwl,
>>>> +					     const u8 *data, u32 size)
>>>> +{
>>>> +	struct m10bmc_sec *sec = fwl->dd_handle;
>>>> +	unsigned int stride;
>>>> +	u32 ret;
>>>> +
>>>> +	sec->cancel_request = false;
>>>> +
>>>> +	stride = regmap_get_reg_stride(sec->m10bmc->regmap);
>>>> +	if (!IS_ALIGNED((unsigned long)data, stride)) {
>>>> +		dev_err(sec->dev,
>>>> +			"%s address (0x%p) not aligned to stride (0x%x)\n",
>>>> +			__func__, data, stride);
>>>> +		return FW_UPLOAD_ERR_RW_ERROR;
>>>> +	}
>>> Why the base of the source data should be stride aligned? What prevents
>>> the driver from reading out the unaligned data?
>> This check also exists in regmap_bulk_write(), so regmap_bulk_write() would
>> fail for an unaligned base address with -EINVAL:
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/base/regmap/regmap.c#n2274
> I'm sorry I just see the regmap_bulk_write() checks the alignment of
> register addr, but not the data. Am I missed something?
You are right. I was looking at it wrong. It is the destination
address alignment that is being enforced.

>
>> By checking it here, I am able to print something useful to the kernel log.
>>
>>> And this may be a too strict rule. I'm not sure who should ensure the
>>> alignment of the firmware data? The firmware upload framework? Or a user
>>> has no idea about the stride and cannot do the right thing.
>> The firmware upload framework uses an array of pages to allocate space
>> for the firmware image, so in its current implementation it will always
>> be aligned.
>>
>> Would it be better to use regmap_write() for an unaligned start and
>> then follow up with regmap_bulk_write()?
> The driver only supports the firmware upload framework, is it? So if the
> framework ensures the alignment, the extra check is not a must for drivers.
Yes - I agree. There is no check required here.

>
>>>> +
>>>> +	if (!size || size > M10BMC_STAGING_SIZE)
>>>> +		return FW_UPLOAD_ERR_INVALID_SIZE;
>>>> +
>>>> +	ret = rsu_check_idle(sec);
>>>> +	if (ret != FW_UPLOAD_ERR_NONE)
>>>> +		return ret;
>>>> +
>>>> +	ret = rsu_update_init(sec);
>>>> +	if (ret != FW_UPLOAD_ERR_NONE)
>>>> +		return ret;
>>>> +
>>>> +	ret = rsu_prog_ready(sec);
>>>> +	if (ret != FW_UPLOAD_ERR_NONE)
>>>> +		return ret;
>>>> +
>>>> +	if (sec->cancel_request)
>>>> +		return rsu_cancel(sec);
>>>> +
>>>> +	return FW_UPLOAD_ERR_NONE;
>>>> +}
>>>> +
>>>> +#define WRITE_BLOCK_SIZE 0x4000	/* Default write-block size is 0x4000 bytes */
>>>> +
>>>> +static enum fw_upload_err m10bmc_sec_write(struct fw_upload *fwl, const u8 *data,
>>>> +					   u32 offset, u32 size, u32 *written)
>>>> +{
>>>> +	struct m10bmc_sec *sec = fwl->dd_handle;
>>>> +	u32 blk_size, doorbell;
>>>> +	unsigned int stride;
>>>> +	u8 *blk_addr;
>>>> +	int ret;
>>>> +
>>>> +	stride = regmap_get_reg_stride(sec->m10bmc->regmap);
>>>> +	if (sec->cancel_request)
>>>> +		return rsu_cancel(sec);
>>>> +
>>>> +	ret = m10bmc_sys_read(sec->m10bmc, M10BMC_DOORBELL, &doorbell);
>>>> +	if (ret) {
>>>> +		return FW_UPLOAD_ERR_RW_ERROR;
>>>> +	} else if (rsu_prog(doorbell) != RSU_PROG_READY) {
>>>> +		log_error_regs(sec, doorbell);
>>>> +		return FW_UPLOAD_ERR_HW_ERROR;
>>>> +	}
>>>> +
>>>> +	WARN_ON_ONCE(WRITE_BLOCK_SIZE % stride);
>>>> +	blk_size = min_t(u32, WRITE_BLOCK_SIZE, size);
>>>> +
>>>> +	/*
>>>> +	 * If the source data size does not align to stride, then create
>>>> +	 * a temporary buffer that is aligned, copy the data, and use the
>>>> +	 * temporary buffer as the source for the write.
>>>> +	 */
>>>> +	if (blk_size % stride) {
>>>> +		blk_addr = kzalloc(blk_size + blk_size % stride, GFP_KERNEL);
>>>> +		if (!blk_addr)
>>>> +			return FW_UPLOAD_ERR_RW_ERROR;
>>>> +		memcpy(blk_addr, data + offset, blk_size);
>>> You don't have to alloc and copy the whole block, just copy the last unaligned
>>> bytes to a local variable and regmap_write().
>> OK - I'll do that. And I'll look at doing something similar for a misaligned start.
> Please double confirm if the checking for misaligned start is necessary.
Done - thanks for your comments!

- Russ
>
> Thanks,
> Yilun
>
>> Thanks,
>> - Russ
>>> Others are good to me.
>>>
>>> Thanks,
>>> Yilun
>>>
>>>> +	} else {
>>>> +		blk_addr = (u8 *)data + offset;
>>>> +	}
>>>> +
>>>> +	ret = regmap_bulk_write(sec->m10bmc->regmap,
>>>> +				M10BMC_STAGING_BASE + offset, blk_addr,
>>>> +				(blk_size + stride - 1) / stride);
>>>> +
>>>> +	if (blk_size % stride)
>>>> +		kfree(blk_addr);
>>>> +
>>>> +	if (ret)
>>>> +		return FW_UPLOAD_ERR_RW_ERROR;
>>>> +
>>>> +	*written = blk_size;
>>>> +	return FW_UPLOAD_ERR_NONE;
>>>> +}
>>>> +
>>>> +static enum fw_upload_err m10bmc_sec_poll_complete(struct fw_upload *fwl)
>>>> +{
>>>> +	struct m10bmc_sec *sec = fwl->dd_handle;
>>>> +	unsigned long poll_timeout;
>>>> +	u32 doorbell, result;
>>>> +	int ret;
>>>> +
>>>> +	if (sec->cancel_request)
>>>> +		return rsu_cancel(sec);
>>>> +
>>>> +	result = rsu_send_data(sec);
>>>> +	if (result != FW_UPLOAD_ERR_NONE)
>>>> +		return result;
>>>> +
>>>> +	poll_timeout = jiffies + msecs_to_jiffies(RSU_COMPLETE_TIMEOUT_MS);
>>>> +	do {
>>>> +		msleep(RSU_COMPLETE_INTERVAL_MS);
>>>> +		ret = rsu_check_complete(sec, &doorbell);
>>>> +	} while (ret == -EAGAIN && !time_after(jiffies, poll_timeout));
>>>> +
>>>> +	if (ret == -EAGAIN) {
>>>> +		log_error_regs(sec, doorbell);
>>>> +		return FW_UPLOAD_ERR_TIMEOUT;
>>>> +	} else if (ret == -EIO) {
>>>> +		return FW_UPLOAD_ERR_RW_ERROR;
>>>> +	} else if (ret) {
>>>> +		log_error_regs(sec, doorbell);
>>>> +		return FW_UPLOAD_ERR_HW_ERROR;
>>>> +	}
>>>> +
>>>> +	return FW_UPLOAD_ERR_NONE;
>>>> +}
>>>> +
>>>> +/*
>>>> + * m10bmc_sec_cancel() may be called asynchronously with an on-going update.
>>>> + * All other functions are called sequentially in a single thread. To avoid
>>>> + * contention on register accesses, m10bmc_sec_cancel() must only update
>>>> + * the cancel_request flag. Other functions will check this flag and handle
>>>> + * the cancel request synchronously.
>>>> + */
>>>> +static void m10bmc_sec_cancel(struct fw_upload *fwl)
>>>> +{
>>>> +	struct m10bmc_sec *sec = fwl->dd_handle;
>>>> +
>>>> +	sec->cancel_request = true;
>>>> +}
>>>> +
>>>> +static void m10bmc_sec_cleanup(struct fw_upload *fwl)
>>>> +{
>>>> +	struct m10bmc_sec *sec = fwl->dd_handle;
>>>> +
>>>> +	(void)rsu_cancel(sec);
>>>> +}
>>>> +
>>>> +static const struct fw_upload_ops m10bmc_ops = {
>>>> +	.prepare = m10bmc_sec_prepare,
>>>> +	.write = m10bmc_sec_write,
>>>> +	.poll_complete = m10bmc_sec_poll_complete,
>>>> +	.cancel = m10bmc_sec_cancel,
>>>> +	.cleanup = m10bmc_sec_cleanup,
>>>> +};
>>>> +
>>>>  #define SEC_UPDATE_LEN_MAX 32
>>>>  static int m10bmc_sec_probe(struct platform_device *pdev)
>>>>  {
>>>> +	char buf[SEC_UPDATE_LEN_MAX];
>>>>  	struct m10bmc_sec *sec;
>>>> +	struct fw_upload *fwl;
>>>> +	unsigned int len;
>>>> +	int  ret;
>>>>  
>>>>  	sec = devm_kzalloc(&pdev->dev, sizeof(*sec), GFP_KERNEL);
>>>>  	if (!sec)
>>>> @@ -205,6 +581,38 @@ static int m10bmc_sec_probe(struct platform_device *pdev)
>>>>  	sec->m10bmc = dev_get_drvdata(pdev->dev.parent);
>>>>  	dev_set_drvdata(&pdev->dev, sec);
>>>>  
>>>> +	ret = xa_alloc(&fw_upload_xa, &sec->fw_name_id, sec,
>>>> +		       xa_limit_32b, GFP_KERNEL);
>>>> +	if (ret)
>>>> +		return ret;
>>>> +
>>>> +	len = scnprintf(buf, SEC_UPDATE_LEN_MAX, "secure-update%d",
>>>> +			sec->fw_name_id);
>>>> +	sec->fw_name = kmemdup_nul(buf, len, GFP_KERNEL);
>>>> +	if (!sec->fw_name)
>>>> +		return -ENOMEM;
>>>> +
>>>> +	fwl = firmware_upload_register(THIS_MODULE, sec->dev, sec->fw_name,
>>>> +				       &m10bmc_ops, sec);
>>>> +	if (IS_ERR(fwl)) {
>>>> +		dev_err(sec->dev, "Firmware Upload driver failed to start\n");
>>>> +		kfree(sec->fw_name);
>>>> +		xa_erase(&fw_upload_xa, sec->fw_name_id);
>>>> +		return PTR_ERR(fwl);
>>>> +	}
>>>> +
>>>> +	sec->fwl = fwl;
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +static int m10bmc_sec_remove(struct platform_device *pdev)
>>>> +{
>>>> +	struct m10bmc_sec *sec = dev_get_drvdata(&pdev->dev);
>>>> +
>>>> +	firmware_upload_unregister(sec->fwl);
>>>> +	kfree(sec->fw_name);
>>>> +	xa_erase(&fw_upload_xa, sec->fw_name_id);
>>>> +
>>>>  	return 0;
>>>>  }
>>>>  
>>>> @@ -218,6 +626,7 @@ MODULE_DEVICE_TABLE(platform, intel_m10bmc_sec_ids);
>>>>  
>>>>  static struct platform_driver intel_m10bmc_sec_driver = {
>>>>  	.probe = m10bmc_sec_probe,
>>>> +	.remove = m10bmc_sec_remove,
>>>>  	.driver = {
>>>>  		.name = "intel-m10bmc-sec-update",
>>>>  		.dev_groups = m10bmc_sec_attr_groups,
>>>> -- 
>>>> 2.25.1

