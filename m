Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1301844335B
	for <lists+linux-fpga@lfdr.de>; Tue,  2 Nov 2021 17:44:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231314AbhKBQqi (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 2 Nov 2021 12:46:38 -0400
Received: from mga18.intel.com ([134.134.136.126]:50327 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230357AbhKBQqi (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 2 Nov 2021 12:46:38 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10156"; a="218222104"
X-IronPort-AV: E=Sophos;i="5.87,203,1631602800"; 
   d="scan'208";a="218222104"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2021 09:25:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,203,1631602800"; 
   d="scan'208";a="599568080"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by orsmga004.jf.intel.com with ESMTP; 02 Nov 2021 09:25:22 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Tue, 2 Nov 2021 09:25:22 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Tue, 2 Nov 2021 09:25:22 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Tue, 2 Nov 2021 09:25:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BIdflXl7avk9MF4f8Or+jSsLh705lvLf+2BIzlhPWDAhcuO/PhnB0G90FM3V8vgg/61J6DzkmJTHc0/sErffBx+jJ96nyLDcg02jTmxNsRxhOuCeyQv+SxTQM5m8SBCVGBbzI34k19b1spvX6ltq/lkCBmixoXiQAYhXEFBtpuWzLOffTpgqFPFiff3H3yC9UnrgOyyfU4QsiuRS1uJ5bLkqTYSshT2iJ0og+igJiQMadesX/xv7o+tHPyPFTCf4dzEciDPInZ9P23w5n0rnBG/qDXvgz28PUlXkw60EDYWEqD6omnVv+AS6cKT5gZ8VE15PH0F0W3WtKiMzmEpjmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L01q2W30WZmNVzfSNKupD4+0cEuPZu7pa5okzR5xi8A=;
 b=bB/z8bC1PcBTlKL8ZKwvBIdjUvgkgm5mQ5Nv1VIqwfZvuh1YBnHJYz9r/EgYFxNqobs3hwxP7ZLFCW/sMQ8+7ygMxLwfnsnZ97UIEbvjiH7FzsgMBbU5IjRWMzbbHfJZGIegoR50nBBvrGrh2iH0+UEdaEVK+ip/SmvtA6Cij2KSZgzA2aSKMeSoj9s5ezeQOvSgP4YiFWYCpX/KdwKuSPw7kl5HZZH5OKHhCiQY2+cIeLX2qrsSnhgMGZYuQWtuEnbjlWR40sritauHX2lerPJI31bB/rFPaQVRA400vB7ta+XpaZlYd4p4L8Tmz/h1lxyejx5CRUf1DfM3SPwJPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L01q2W30WZmNVzfSNKupD4+0cEuPZu7pa5okzR5xi8A=;
 b=kAyiU48ikhRQgpOmmX0gozu8RCAz/gQWw8LVM1LqevHBHNKRiS25eDeKRcMTuCRUAln8WQ2FyrFGU5DzOX4rPPD0WhQCXUdnqCTmHJkmuWI9NPRH0y11EGTAO9vV0LVH3xuvt703Bd0dNbs/BVZKlRJmtVL9kgjXuLVf/ORq+vM=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=intel.com;
Received: from SA2PR11MB5163.namprd11.prod.outlook.com (2603:10b6:806:113::20)
 by SN6PR11MB2814.namprd11.prod.outlook.com (2603:10b6:805:55::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10; Tue, 2 Nov
 2021 16:25:13 +0000
Received: from SA2PR11MB5163.namprd11.prod.outlook.com
 ([fe80::a039:c121:4dce:5def]) by SA2PR11MB5163.namprd11.prod.outlook.com
 ([fe80::a039:c121:4dce:5def%8]) with mapi id 15.20.4649.019; Tue, 2 Nov 2021
 16:25:13 +0000
Subject: Re: [PATCH 02/12] fpga: sec-mgr: enable secure updates
To:     Greg KH <gregkh@linuxfoundation.org>,
        Moritz Fischer <mdf@kernel.org>
CC:     Tom Rix <trix@redhat.com>, <linux-fpga@vger.kernel.org>,
        <moritzf@google.com>
References: <20210517023200.52707-3-mdf@kernel.org>
 <YKH/6xQ7bEwJzEsM@kroah.com> <5d0552ce-d2bd-cca1-006e-8f11991fd378@intel.com>
 <f3d474d2-f85d-4759-75b5-84af64fe5b3c@intel.com> <YQPgFn/z024U06HJ@kroah.com>
 <85cd4801-ca1f-4482-6999-3d2e648b24e5@intel.com> <YQjY+KL59m51kucV@kroah.com>
 <3ba35b3c-3c85-394b-f404-130968587a6f@intel.com> <YQpDySXy0ASM5u9y@kroah.com>
 <YQqrGvwkf6bJ/5in@archbook> <YQquaUQCb0hIJmre@kroah.com>
From:   Russ Weight <russell.h.weight@intel.com>
Message-ID: <62ae6249-8561-7e85-2aa8-3dd49646180a@intel.com>
Date:   Tue, 2 Nov 2021 09:25:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
In-Reply-To: <YQquaUQCb0hIJmre@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: MW4PR04CA0103.namprd04.prod.outlook.com
 (2603:10b6:303:83::18) To SA2PR11MB5163.namprd11.prod.outlook.com
 (2603:10b6:806:113::20)
MIME-Version: 1.0
Received: from [10.0.2.4] (50.43.42.212) by MW4PR04CA0103.namprd04.prod.outlook.com (2603:10b6:303:83::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10 via Frontend Transport; Tue, 2 Nov 2021 16:25:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f3690c86-d64a-4446-43a9-08d99e1d592d
X-MS-TrafficTypeDiagnostic: SN6PR11MB2814:
X-Microsoft-Antispam-PRVS: <SN6PR11MB281415CA855075CDFA479550C58B9@SN6PR11MB2814.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZCWQE4w76Au/bft70xNbwGxJKM/nfvG2kiPtdb+latbnei601ImkKIaZX+VVnTB4L6gUYQOSjTKH3jwwDXouHtHf4M8dYEpyjmV/oiQ60DSOrabFvc4yauhP8/OLicZLhq+gzDvbT0vxZX3KgT1WNj2oZeDi1WMWKgT7iMxyB3pcldGCUXeIoz7JVSh7qFQWDmDa0emGuxURAZ4iINp8Gx6RVgEm1wJGP2jqtlRa4kqKA1MQOvfPyr5QMk0ius58WlCpAG1SO132XmUioWGZDJ6AAUMR60haqwuo5hSi5ctTbBjQAuchI/42Ko5ruQSuuPbyLTBu4FMFUexUfvTIY6XVtIWh97REo/ktgZmjob86pQP++BIAlU+BJlFmbVEmOudmmJB/F7Lixfybp2xVpCmDifY3pGVo8/qnPwm2k89nhBpbMHCYyY3IWttThZN1qOQn755ziWzxiQGJKbUZnsRF+ywx7vXVp+BS6qKclON3qhrTS7F/2+yyZuiAVNeAJHkbPrXjoKHMKlsSce80x0LsASqxQT1l978j7xHAtx5/f2m4ItfZHvaFrSdABw4QFEzpwTGcmsoQR1h4f/ZiY+k4Sb3vxBMDzk4+8DUkhH1QAKFKA4jtj9XR3iSfiufiPPSLMH44RXXGyVb7YdST9A3LsPIXJYZznwB3iBvuIdY9Zblw8XwWIEZj3JejmqFQ1HusONcsi3YM1FJ/TMzGI3Uz/Y5wBpARum/hIFZHxPg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB5163.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(82960400001)(31696002)(66946007)(66476007)(16576012)(110136005)(38100700002)(6486002)(31686004)(4326008)(66556008)(86362001)(8676002)(508600001)(15650500001)(5660300002)(26005)(316002)(2906002)(53546011)(8936002)(36756003)(956004)(186003)(2616005)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bWU4TFg3TTRaMFZ3Y0FHdnZTb2w2UFdHWFRYdTJiOVU0LzM2bktxVlZHeTBi?=
 =?utf-8?B?WGpaOEdLMlA2S2hQTmwvcnI1bDFkR1o1RXBhQXlyYWJFanB2c284R29yR2VJ?=
 =?utf-8?B?M3ZYbXFaVXFiMXdpZWRwdi9KZTJIY252a1p4V2NBVlg5bXNKU2RJYzVwYkVn?=
 =?utf-8?B?cGJxUk9iSHB4d1pZcXRkWVpmTW9YWmdyc3NGUVYzR0hITjVzN1NFR28vOEFJ?=
 =?utf-8?B?UVQrcTdiR29ZWTJuQjdxLzZYZjh6elNkZ3BnYXF4RjRyc3puZkhsdmc2cVZo?=
 =?utf-8?B?YTJ5cVpxTFBwWHRRUy9XTml4L0hLTXpiQ2l0MWYwWVdXbTh2RWJ4R2ZpNDE5?=
 =?utf-8?B?Tk82aFZ0TnZVeEFGSnNLSHdvUXRybkIwMVcyUHVHVEFpWHppZmt2eHVZODA1?=
 =?utf-8?B?c1gyUUYzbXorT0hiRHdjak50Y0tZY084NFVpMjJJZkpnN0FoUzZIUHJ4ZVJ0?=
 =?utf-8?B?MDhMWXZFdGdEdEFMTmJEWnlvUkJicXdmKzVJM0pqdTV3ZTVuZWVOeVIzVEds?=
 =?utf-8?B?dGJGeHhKcDYxWktWYk10U29JcXlOMWxCWlUzalZwWXdEWXE1ckp5NVlUSFZZ?=
 =?utf-8?B?UHkxYlM4OFVjMlh2VVBBZURSSzJWV2VkSzRMU0xrMW5JR1ZQQ0M0K0FyY2V5?=
 =?utf-8?B?alBFbmtSZWtTQ0ZRTTNPRjBFOWx0aTVyekFDcCtjY3VSWUw3bmZRZzZNNWlQ?=
 =?utf-8?B?Sk5YeXNFUVBkWm1ITlMxbStVbGpjZTAwMkZ3ZHFReStpUy9VV09CZlROd2RW?=
 =?utf-8?B?NG9LYjhVMXNCRERnZk5uR2VNb1lETjNud0o1bzFxQS9rbFlERFZGYzR6U0Zo?=
 =?utf-8?B?SXhUVzBPeWtPNTNGUkJQbC9mQWtJN1Y4LzJ1ZkRwam1JOExRdGNSQUhzYUNt?=
 =?utf-8?B?Ulp0UTlyUlp5OHRkTDdlY1E0QkhRWktEdHBpNWNIM29NTEpvb1Jadk5CWUt4?=
 =?utf-8?B?K09VTElVTjl5L05iK0hEb3RzYXM0OHBobzdHNUVrWXZnOFAzb1JmZXdQWWt4?=
 =?utf-8?B?ZkUwdjNsLzBEQUtVdFlJc3pPYWMvb2NDSjlPa0NROHJUWEUvNzZBS0RFcUZk?=
 =?utf-8?B?bWJXZWZFRUMvSHpsWDAyWjFOQldoMEhXYXZpRkNqaDl3NkFLc3p6T3FNVlhQ?=
 =?utf-8?B?WFlDYTRSOS9VTXRtM0FrUm5YOThMT1lLTzhDL0hqaHJzQnhKRmNPclBBbDZX?=
 =?utf-8?B?UE1YcjkxbUI4MXpTWWowb0pRdHBHeWZhVlZ5NFV5Vno5cGEyS0gwZkV0QUNV?=
 =?utf-8?B?STNpYmhyYW9PRmIrRzRKTDBBNTFSOXdiNzMzbmZSenRUNWQwRjBIeTJuYkVt?=
 =?utf-8?B?aVcwcFJ6RmRrVzBWOG1wUGZBRGJhb3pYTFhDT0paV1BWeTZWZDU5MGJpRDcx?=
 =?utf-8?B?OUNrUnllOHVLNmlhcGZwdDRqRk9WK1JtNHZJN0xmUDhjTk1pbWhTdkcya20w?=
 =?utf-8?B?SUpwYkhwQytEMjJ3eDhUc2FOR1BmSFBTUFRrRCtxb1JTbGhFbWRiaERKQUJa?=
 =?utf-8?B?TmRPclJJaW1RNDdub2FHZzZnbWp4MDhvK0RaS3pZcS95SnNPcVEwa3NYYTVF?=
 =?utf-8?B?TnpyYzZsR2g5YW1QeW5TQnFoL1ZHQkJSanRzZGtWbnBtUXkzU1lGa2hKVzkv?=
 =?utf-8?B?Y25QSDJvTVZuVDBoNXlLVzFkZi9BT2xEK2s0QS9UelVkQlNNazlzdDd2QXd6?=
 =?utf-8?B?UCtsdlJMWnFYS04xWWRIdlV4RnE4SjJuUTlKbEc1V0xYQnI0SkJsdkFyVTRQ?=
 =?utf-8?B?WENvL2xJZDE4YkNuQXlKYW1Nd0t5MmIyREdPU2R5ZkU2MzNobUhpeno1UE9x?=
 =?utf-8?B?ejd4UlRKT3pNYks3a3RxWmQydjduVVV5TFVQRWpUYnk2OVA1UkdXK1JNek5u?=
 =?utf-8?B?M2xtZUNpOTBudnZNVEVJUXRtQ3ZWMFJRdGlURnROZ2Q0a29DQXBwc0ZvdTJ4?=
 =?utf-8?B?Rkt3K3dFM2ZqZ0VkSVp0ajRoRHFDdHkrZU9aa0ErZXV2T2pFVGlzOVRaWE1o?=
 =?utf-8?B?SjM4Z2p5Sm0yS08ra3BTa0daR053VS9Cbk1VWGNPamdhRk03bHFIR083Zkx4?=
 =?utf-8?B?Zld6c3pSSHRCMU1XSGdsMUN3ZGIzZlR5TUx4Y0lUQS9lcWZ1M3d0VXFuUUFB?=
 =?utf-8?B?OFVzcHVsaW5GY1o5TnlML1RSb3BKUVRQblJJRDh4SVdTV0ZPeUNET0ZhMW41?=
 =?utf-8?B?bnFYLzg3RzViYjFKUnFicW93eHRRUXlRZUZSZkZtVE4rRXZQd1VoUXpDVWR0?=
 =?utf-8?B?c0NaMG51c3MyZ2pnbWZidU5KdlFRPT0=?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f3690c86-d64a-4446-43a9-08d99e1d592d
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB5163.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2021 16:25:13.8358
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NMysFPgtRSZGLtHG+PvOQx2BswXUc/VERlZltWdCYFmJy73nNzyUK9mFYEZfWZ6EULMKTvO5jQKWsZNrvQwYYAKy9UnY3U87nyMKpI1bJTI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2814
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On 8/4/21 8:12 AM, Greg KH wrote:
> On Wed, Aug 04, 2021 at 07:58:34AM -0700, Moritz Fischer wrote:
>> On Wed, Aug 04, 2021 at 09:37:45AM +0200, Greg KH wrote:
>>> On Tue, Aug 03, 2021 at 12:02:24PM -0700, Russ Weight wrote:
>>>>
>>>> On 8/2/21 10:49 PM, Greg KH wrote:
>>>>>> If the request_firmware() implementation is not acceptable, then would
>>>>>> you agree that an IOCTL implementation is our best option?
>>>>> There is no difference in the end between using an ioctl, or a sysfs
>>>>> file, to provide the filename of your firmware, don't get hung up on
>>>>> that.
>>>> I meant to suggest that passing file data (not a filename) through an
>>>> IOCTL might be better for this use case than trying to use request_firmware.
>>>> We have to, somehow, allow the user to point us to the desired image
>>>> data (which could be a root-entry-hash, or an FPGA image). We can't
>>>> really use a fixed filename modified by device version as many of
>>>> the devices do.
>>> Ah, yes, a "normal" write command might be best for this as that can be
>>> properly containerized and controlled.
>>>
>>>>> By providing a "filename", you are going around all of the namespace and
>>>>> other "container" protection that the kernel provides, and allowing
>>>>> processes to potentially load files that are normally outside of their
>>>>> scope to the hardware.  If you are willing to allow that security
>>>>> "escape", wonderful, but you better document the heck out of it and
>>>>> explain why this is allowed for your special hardware and use case.
>>>>>
>>>>> As you are expecting this to work "in the cloud", I do not think that
>>>>> the operators of such hardware are really going to be all that happy to
>>>>> see this type of interface given these reasons.
>>>>>
>>>>> What is wrong with the current fpga firmware api that somehow is lacking
>>>>> for your special hardware, that other devices do not have to worry
>>>>> about?
>>>> The existing framework wants to update the live image in the FPGA,
>>>> whereas for this device, we are passing signed data to BMC firmware
>>>> which will store it in FLASH to be loaded on a subsequent boot of
>>>> the card.
>>>>
>>>> The existing framework needs to manage FPGA state, whereas for this
>>>> device, it is just a transfer of signed data. We also have to handle
>>>> a total transfer/authentication time of up to 45 minutes, so we are
>>>> using a kernel worker thread for the update.
>>>>
>>>> Perhaps the name, fpga security manager, is wrong? Maybe something
>>>> like fpga_sec_image_xfer is better?
>>> It does not sound like this has anything to do with "security", and
>>> rather is just a normal firmware upload, so "fpga_image_upload()"
>>> perhaps?
>> I had originally suggested 'load' and 'persist' or 'load' and 'update or
>> something of that sort.
>>
>> Taking one step back, maybe the case could be made for a generic
>> 'persistent firmware' update framework that addresses use-cases that
>> require updating firmware that may take extended periods of time.
> There should not be a problem with using the existing firmware layer for
> images that take long periods of time, as long as you are not wanting to
> see any potential progress :)
>
> So how about just adding anything missing to the existing firmware
> subsystem.  It's attempting to handle all use cases already, if it is
> missing one, no harm in adding more options there...
Hi Greg,

We have had a lot of internal (to Intel) discussion about how to
organize the support for uploading FPGA images. It would be helpful
to know which of the following two options you find the least
disturbing :-)

Background: We are uploading signed, self-describing images that are
authenticated and dispositioned by the Card BMC. These could result
in FLASH updates for FPGA images, BMC images, firmware, or security
keys.  They could also result in a temporary authentication
certificate being loaded into RAM as part of a multi-step key
provisioning process.

Options:
(a) A single API that facilitates the upload of a data stream
without analyzing the stream contents, relying on the lower-level
driver and/or HW to accept or reject the data.

(b) Multiple, targeted APIs (e.g. IOCTL_FPGA_IMAGE_UPDATE,
IOCTL_BMC_IMAGE_UPDATE, IOCTL_KEY_UPDATE, IOCTL_KEY_CANCEL) that
each interpret the stream type and reject them if they don't
correspond to the API target.

Do you have a preference between (a) and (b)?

Thanks,
- Russ
> thanks,
>
> greg k-h

