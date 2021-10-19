Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB9B54339E3
	for <lists+linux-fpga@lfdr.de>; Tue, 19 Oct 2021 17:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231250AbhJSPOZ (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 19 Oct 2021 11:14:25 -0400
Received: from mga03.intel.com ([134.134.136.65]:28877 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232126AbhJSPOY (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 19 Oct 2021 11:14:24 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10142"; a="228491643"
X-IronPort-AV: E=Sophos;i="5.87,164,1631602800"; 
   d="scan'208";a="228491643"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2021 08:10:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,164,1631602800"; 
   d="scan'208";a="718312273"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by fmsmga006.fm.intel.com with ESMTP; 19 Oct 2021 08:10:01 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Tue, 19 Oct 2021 08:10:00 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Tue, 19 Oct 2021 08:10:00 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Tue, 19 Oct 2021 08:10:00 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.107)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Tue, 19 Oct 2021 08:10:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nE9YDF6wB48hHZ8tEhJj+Ha7S7ZWNOjM1RjRntowJtOZSs6oWGd3I2cHr4JzIAO5K2ATfpEIRKcDkBbvAEbHEX1YTuVFsEhII62qIBeMAKMChxD9hq3OIBnshvltCc/AMCIvXyILWTObQVz3Ms18jXgJ7Kkkk48UELLm7WuMtHU/o3kDokHZj//Y2CLAW2YkiYzrm5OG6FjQXE5MYzQbU65suqkV37Xak6qR3Ke2GaJip6gw8wtNcpI553N7i2LUtonsvFpR/IPBJudwtkg79+4/wW6rprXa/2qucA8Y0mL7m8xbLa/EjyiV2CyvsOYlqW1XQUSMHwUfUgyZEBGQLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jwwsvgOf5HfrU1PHsktIB+Wm3YztzF/1OEOh7hgDMmU=;
 b=U1pau0bJKMoEE7RGSWcfRKbPjfyyYB5+r4x7/idbQseu34uAXmPzgZOu5L7a2KGRcxfQ95IdG7c/9l/sIsg0V1ZXaUTPJwM8gT+jZL1E76FrJX9jxfi6qpGx4eYjmsA456fBcFqJCdmNmagmZlOyEWhXhwnC3P4tkwOJv2IKyAtlVk15+O9E+x1xkBUxmTRyRbvSsujTKTR3QSyDSK8kDpEV/ows1X1gykS1fxPq36wNRUb9D3DbmEYHxAOtNBMsdAG+ovqr9DfYEd3AI2XuPMMTl//gzh3h1bcEv+lZTk1OfRxCy2mWo8+1/3CZsVPfshVnUhdDNSqkQhDsEoQtlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jwwsvgOf5HfrU1PHsktIB+Wm3YztzF/1OEOh7hgDMmU=;
 b=ml8mLgV7FOdHwP7gHRJNHT/FAXbLH1ITLeNkae/Tu5ZbhcEhI7NquR9BJauSN7+H2bibrPap0QsRgkZRtTQJZGO54skEi1z1KuqT6B2/KzfjRdulXBnc5WmrCaxNoVjSnWxeanmUH09Fdsg8nsko2Ztb4R09MUhEN++qwLXOZSE=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
Received: from SA2PR11MB5163.namprd11.prod.outlook.com (2603:10b6:806:113::20)
 by SA2PR11MB5084.namprd11.prod.outlook.com (2603:10b6:806:116::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.18; Tue, 19 Oct
 2021 15:09:55 +0000
Received: from SA2PR11MB5163.namprd11.prod.outlook.com
 ([fe80::a039:c121:4dce:5def]) by SA2PR11MB5163.namprd11.prod.outlook.com
 ([fe80::a039:c121:4dce:5def%7]) with mapi id 15.20.4608.018; Tue, 19 Oct 2021
 15:09:55 +0000
Subject: Re: [PATCH v17 0/5] FPGA Image Load (previously Security Manager)
To:     Xu Yilun <yilun.xu@intel.com>
CC:     Tom Rix <trix@redhat.com>, <mdf@kernel.org>,
        <linux-fpga@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lgoncalv@redhat.com>, <hao.wu@intel.com>,
        <matthew.gerlach@intel.com>
References: <20211012074752.GB95330@yilunxu-OptiPlex-7050>
 <e629eca0-a86c-4028-7bbf-65185699137b@intel.com>
 <20211013010617.GE95330@yilunxu-OptiPlex-7050>
 <58036b2d-ca8f-2deb-f1b4-0301d633714b@intel.com>
 <20211014014947.GF95330@yilunxu-OptiPlex-7050>
 <7d1971d0-b50b-077f-2a82-83d822cd2ad7@intel.com>
 <20211015025140.GH95330@yilunxu-OptiPlex-7050>
 <2b26bea5-60d3-6763-00e8-9a94fa0bf45b@intel.com>
 <20211018081356.GB40070@yilunxu-OptiPlex-7050>
 <301850cf-9f34-530b-bd9c-fbe9bf9feee5@intel.com>
 <20211019025356.GC40070@yilunxu-OptiPlex-7050>
From:   Russ Weight <russell.h.weight@intel.com>
Message-ID: <85d56e4b-5bed-693d-4f76-027173a6e7a0@intel.com>
Date:   Tue, 19 Oct 2021 08:09:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
In-Reply-To: <20211019025356.GC40070@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: TY1PR01CA0149.jpnprd01.prod.outlook.com
 (2603:1096:402:1::25) To SA2PR11MB5163.namprd11.prod.outlook.com
 (2603:10b6:806:113::20)
MIME-Version: 1.0
Received: from [10.0.2.4] (50.43.42.212) by TY1PR01CA0149.jpnprd01.prod.outlook.com (2603:1096:402:1::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16 via Frontend Transport; Tue, 19 Oct 2021 15:09:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e870657c-15ab-4a37-283a-08d9931281ed
X-MS-TrafficTypeDiagnostic: SA2PR11MB5084:
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA2PR11MB5084F31F6987C87A1CAC1D7FC5BD9@SA2PR11MB5084.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sH5Y7XX7ayv8bCn9RxUmnAokFAbHBWq1gL/OlHs1aO9TzPClMJJGbeo7+7wp7Zh93EDUrEhnU6nOWu9HjcyQDCsd6CBPaHC8nAJ6VANgbx14tjtZ6M5coxxEMRVWNkl208yT3BEO29fCqyLVYw+2Xzd35zBveWoB4CwN+9a5h9Hhnoc5lYxAI33ZHjX/w7WTXlZb+JduFtZwDQUlGG94ZAOMPiYZVwQVVyy5gMRp+rjfzEMbQJ/u+ZwpX03JhQ8sO+mtzr7XuQg6jOg5rkL1vLzw6tPtNL+hgiXS4G6650DEMNQxRha0mL6dgy/IYj/smaiZXbiEpu7aYh8wZaGiPWgmjmQs0zNvBWm9FKd4cgcW7ETEbIwpe+Z3w+yKIZ1MkHbJntfx4ovqUBpkrwW++aR9vmHQlq6IVJ2S0vD9gxo0mNhcsZm7fny5RN50FYV9YPiWwRiEFa9do5irjK3/oJ2FBQZLXL7Xp9sz+iF7395mWO4vUpKL6zmJN1JoHpEA8cD5hcPXA0PiJDNwvGdzpT3c62NZOLk2PLLp5aaq6PV30cfNxazyJTu6sDwggyVfkv9vqaILCoAoCqiTnyFExX79Jij4pF9g2RDKRxNrNbX7NClVFprTYtKixsEl7zhL6yidK6JdEcBp478mnPg+jH2xIPodOYUIDMCs5M/QomXMdmXpPBw13sTr1G9ETiFUkkmgqa9H2J6v2KrhcmkpisFgfvcA8AiIqIg466K2sPjVOn9oDTvxz1IwtjFZcD6MsOrjlkqMin5Lq2NEv8nImw4dWOsb6//9WNyhuzmttnacUTMZvHEsWwO3GsowIhAYmm6VuyK6gY0sEAZ0uJaPDo1+Vj2W2CpUwV7qsNOIASg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB5163.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(53546011)(66476007)(36756003)(186003)(26005)(6862004)(956004)(83380400001)(5660300002)(66946007)(30864003)(86362001)(508600001)(6666004)(37006003)(6636002)(82960400001)(31696002)(6486002)(31686004)(66556008)(38100700002)(15650500001)(316002)(4326008)(8676002)(966005)(2906002)(16576012)(2616005)(8936002)(107886003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U1NNakJJaThEK3k2VG12Mkdma29JTzdMOVVtL2h1ZFVLa3RYZVNTTjBxY2Zt?=
 =?utf-8?B?T3d5NHRuU0ovK0JQV1hNMG4rNndpNEdNQ0FIUG9iSHZHa1dSeUZQeXJRZThF?=
 =?utf-8?B?M1NEenAwRlhNRXZFbTE3TUFWdWM4S1ZnSVg2Z2NGdVg0WFR4Mkt0MlZhemJS?=
 =?utf-8?B?c0pFbit1NU5EZjNTUXkxOExxVGcvQTY3UXd2eUI5Q0k5OFd3OXgrUHUxemZz?=
 =?utf-8?B?c3RSMUFyV2dMQWZmdUhJR2dXUmo3SjRRZGdsWlBFQ3dmNys1TEl3aDEwYyth?=
 =?utf-8?B?eit2ZG9aYlBsZG1UNW1hVmR1bjdkOWp5ekF4WW9RbC9oYXVkTXVhc1h2TjJV?=
 =?utf-8?B?UTg2Njc2eHF6bHI0czA2SXIyOVFLRjdWZkdEZ3VXTjNQZEFXcyt1ZUlQK0Jk?=
 =?utf-8?B?TXRqZUh3UHQwcWllbEZWNmJMbWp5SU1CQ1oxWWhtem10VnNTRnVISG5xVURT?=
 =?utf-8?B?UVhLN0Yybi9QdmJKbTlwdnV4clFGVEtqRTU3RGFOUEpDVlVpVlhtL2tMZ0VM?=
 =?utf-8?B?SDJML3U0cm92TUg5czd4S0RiOVE2endXZXJaWk40N3VhOUhNMEF4eW5YQUVi?=
 =?utf-8?B?K1VjYUpvaWN2ai93WjdBZlRxS0VHVGM0RU11Rm11Q2JFWVB3RjVhTXZJaFFM?=
 =?utf-8?B?dnRyenNZaG83QVBFRjJvYlZGanRkeU9MYWxwa3d4dUpRdFR3am9YWmhYTDJj?=
 =?utf-8?B?OW56eXJpcXI5N3F6TVdDSGhTVFdRWkhpU3YxYjdOMjVyalpZRUl4MVZ0Ui95?=
 =?utf-8?B?VEdYM3hOcXpGYXgrazdSUTgweS91bDFJRjNzY0g1NVJpYVZOTWdlczhpMm5X?=
 =?utf-8?B?Y0x3L3RhSHo4dlhzb0hhVnRvcXp4NHBwSnU2VHJjZy9WcmVxTmxab1FHMEhR?=
 =?utf-8?B?UzhkQVhXaFdiMzRwRUpub2I0Q3ZJQ0dNN2ZqUUdVR01kdVBBemppTDJ4b2NL?=
 =?utf-8?B?SkRubmhhdmdBalFhYTNiN1ljOTVBcG92a0xOL3pVcDN2MlJnbXY0NWtEQWNp?=
 =?utf-8?B?MVBkM2Y0b29NN2NzQ21ZSGJrOFI5am9Zc2Z0ZTNmNlEyTWhvVDkwQU9tTlQr?=
 =?utf-8?B?RUNPTzlmdXJQc2kveEUrNytheHJPTHVZMkxjSXJBUmdNL2NYVzVpZk9menBn?=
 =?utf-8?B?YzJBWXdFNE8rTE4rY0xWWUV3YjNLdU50VmF0RXZkT2xtV2dYRzh5UjJhNkJ0?=
 =?utf-8?B?ZmhXVnkyeTFjbTA0QzRxVytxcllCVEtMNkxoVzVWNmN5ZlpMOEUyL0FmVmNr?=
 =?utf-8?B?a08vcEJGcVVBekNyak05aWpKNEdsZjJLY1psUWpVN2xJZjBuZWtKSXpGdzlN?=
 =?utf-8?B?NHBERnI1aFUwbHVhaTVvWjNScWhteEFwYkpZVURzTGpPSmh5SUFZNWU1ZDRT?=
 =?utf-8?B?SndINkdpU0VNR0FzUUxKd290MG56cjNCUnNLUlByb091a2h2d1RhMlhCSUxi?=
 =?utf-8?B?clN5T3N3UzcvN2RHRzZUTnQyMTNKbkI2Sm1yTWZiZ0dDZTBCdC9kNmhUb3NY?=
 =?utf-8?B?a0xzd05zaUdiZ2xhbTUrWmJiaklaLzBEcXdKWGFzY0ZwYlhsNU5xOE5yc3o2?=
 =?utf-8?B?S1F1NXpveDdma3J3SHNMQWJGTlNOcFU5VmhCcUxMYWUydlFVUndjM01OVGFV?=
 =?utf-8?B?VWI0cW1SL3V4d1VLUkdCRWpNVHo1cWh5UDFDbHJDUGtENE8zV01xUlhybkgr?=
 =?utf-8?B?VHgyZk15T2hUbGtsVW9ING10d3lhZVBaQ1FJM2JKMHJ0eXlCazZ6VkcwMXFh?=
 =?utf-8?Q?4mt99aOKFu0rV8LQWJNIaBjaqsZohOT8COJL+Vi?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e870657c-15ab-4a37-283a-08d9931281ed
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB5163.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2021 15:09:55.0423
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1qEV0aiXuKCCXZ/piqzZGkjEoAKUMRd6H5cjD0MgJnZKMh+J/GdVJssYFCv5gJw2T4taj/+RksbZhwdNLT4ZkFW9SMgKaqEREjIoC1x4KpY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5084
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On 10/18/21 7:53 PM, Xu Yilun wrote:
> On Mon, Oct 18, 2021 at 09:24:08AM -0700, Russ Weight wrote:
>>
>> On 10/18/21 1:13 AM, Xu Yilun wrote:
>>> On Fri, Oct 15, 2021 at 10:34:23AM -0700, Russ Weight wrote:
>>>> On 10/14/21 7:51 PM, Xu Yilun wrote:
>>>>> On Thu, Oct 14, 2021 at 09:32:53AM -0700, Russ Weight wrote:
>>>>>> On 10/13/21 6:49 PM, Xu Yilun wrote:
>>>>>>> On Wed, Oct 13, 2021 at 11:09:08AM -0700, Russ Weight wrote:
>>>>>>>> On 10/12/21 6:06 PM, Xu Yilun wrote:
>>>>>>>>> On Tue, Oct 12, 2021 at 10:20:15AM -0700, Russ Weight wrote:
>>>>>>>>>> On 10/12/21 12:47 AM, Xu Yilun wrote:
>>>>>>>>>>> On Mon, Oct 11, 2021 at 06:00:16PM -0700, Russ Weight wrote:
>>>>>>>>>>>> On 10/11/21 5:35 AM, Tom Rix wrote:
>>>>>>>>>>>>> On 10/10/21 6:41 PM, Xu Yilun wrote:
>>>>>>>>>>>>>> On Sat, Oct 09, 2021 at 05:11:20AM -0700, Tom Rix wrote:
>>>>>>>>>>>>>>> On 10/9/21 1:08 AM, Xu Yilun wrote:
>>>>>>>>>>>>>>>> On Wed, Sep 29, 2021 at 04:00:20PM -0700, Russ Weight wrote:
>>>>>>>>>>>>>>>>> The FPGA Image Load framework provides an API to upload image
>>>>>>>>>>>>>>>>> files to an FPGA device. Image files are self-describing. They could
>>>>>>>>>>>>>>>>> contain FPGA images, BMC images, Root Entry Hashes, or other device
>>>>>>>>>>>>>>>>> specific files. It is up to the lower-level device driver and the
>>>>>>>>>>>>>>>>> target device to authenticate and disposition the file data.
>>>>>>>>>>>>>>>> I've reconsider the FPGA persistent image update again, and think we
>>>>>>>>>>>>>>>> may include it in FPGA manager framework.
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> Sorry I raised this topic again when it is already at patch v17, but now
>>>>>>>>>>>>>>>> I need to consider more seriously than before.
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> We have consensus the FPGA persistent image update is just like a normal
>>>>>>>>>>>>>>>> firmware update which finally writes the nvmem like flash or eeprom,
>>>>>>>>>>>>>>>> while the current FPGA manager deals with the active FPGA region update
>>>>>>>>>>>>>>>> and re-activation. Could we just expand the FPGA manager and let it handle
>>>>>>>>>>>>>>>> the nvmem update as well? Many FPGA cards have nvmem and downloaders
>>>>>>>>>>>>>>>> supports updating both FPGA region and nvmem.
>>>>>>>>>>>> The fpga-image-load driver is actually just a data transfer. The class
>>>>>>>>>>> IMHO, The fpga-mgr dev is also a data transfer. The fpga-region dev is
>>>>>>>>>>> acting as the FPGA region admin responsible for gating, transfering and
>>>>>>>>>>> re-enumerating.
>>>>>>>>>>>
>>>>>>>>>>> So my opinion is to add a new data transfer type and keep a unified process.
>>>>>>>>>>>
>>>>>>>>>>>> driver has no knowledge about what the data is or where/if the data will
>>>>>>>>>>>> be stored.
>>>>>>>>>>> The fpga-image-load driver knows the data will be stored in nvmem,
>>>>>>>>>> FYI: This is not strictly correct. In a coming product there is a
>>>>>>>>>> case where the data will be stored in RAM. Richard Gong was also
>>>>>>>>>> looking to use this driver to validate an image without programming
>>>>>>>>>> or storing it. The fpga-image-load driver has no expectation that
>>>>>>>>>> the data will be stored in nvmem, or even that it will be stored
>>>>>>>>>> at all.
>>>>>>>>> OK, we can discuss that use case then. But fundamentally a driver should
>>>>>>>>> be clear what it is doing.
>>>>>>>> The lower-level driver is, of course, clear what it is doing. And the
>>>>>>>> FPGA Image Load Framework simply provides a consistent API and manages
>>>>>>>> a potentially long-running data transfer in the context of a kernel
>>>>>>>> worker thread.
>>>>>>>>
>>>>>>>> It sounds like you are saying that that is not "clear enough" in the
>>>>>>>> context of the FPGA Manager?
>>>>>>>>
>>>>>>>> The files that are used with Intel PAC devices are self-describing. The
>>>>>>>> user-space tools, the class driver and the lower-level driver just pass
>>>>>>>> the data through to the card BMC without any knowledge of the content,
>>>>>>>> purpose or final destination of the data.
>>>>>>>>
>>>>>>>> The card BMC will receive signed data, validate it, and process it as a
>>>>>>>> BMC image, an FPGA image, a Root Entry Hash, or a key cancellation. In
>>>>>>> I category all these actions as firmware update fully or partially on
>>>>>>> persistent storage. The FPGA Manager don't have to know the meaning of
>>>>>>> every byte on flash, but it should be aware the firmware is updated and
>>>>>>> the card may acts differently with a new firmware. This is the common
>>>>>>> working model for most of the FPGA cards so that we implement it in FPGA
>>>>>>> manager class. 
>>>>>>>
>>>>>>>> the n6000, it could also be part of a multi-step process for programming
>>>>>>>> SDM keys and the data may not be stored permanently.
>>>>>>> This is new to me, but seems to be different from firmware update, so lets
>>>>>>> think about it again.
>>>>>>>
>>>>>>>>> You may try to extend the FPGA framework to
>>>>>>>>> support nvmem storage, or image validation, but cannot say we feed the
>>>>>>>>> data to any engine undefined by the framework.
>>>>>>>> I'm not sure what you mean by "feed the data to any engine undefined by the
>>>>>>>> framework". I think the "engine" is the lower level driver/device that invokes
>>>>>>>> the fpga_mgr. The lower level driver, of course, is clear what it is doing.
>>>>>>>> The fpga_mgr cannot control what driver invokes it.
>>>>>>>>
>>>>>>>> Are saying that when invoking the fpga-mgr, that it _must_ also pass descriptive
>>>>>>>> data. Meaning that a self-describing file alone is not acceptable?
>>>>>>> The class driver should define a reasonable working model and APIs.
>>>>>>> Updating the FPGA backup storage is good to me. But receiving a mystery
>>>>>>> box and do whatever it requires is not.
>>>>>>>
>>>>>>> Self-describing file is OK, encryption is OK, but either the class
>>>>>>> driver itself, or with the help of the low level driver, should make
>>>>>>> sure it works within its scope.
>>>>>> In our secure update process, the card BMC firmware authenticates
>>>>>> the data using the root entry hashes and will either reject the
>>>>>> data or perform some function based on the contents. Neither the
>>>>>> user-space, the class driver, nor the lower level driver know
>>>>>> what the contents are. It _is_ a "mystery box" to them. How do we
>>>>>> verify scope in this model?
>>>>> I think we need to find out how. One case is, the HW is designed to have
>>>>> one single function, such as firmware update, then any image input
>>>>> through firmware update API is within expectation, and the driver
>>>>> should only serve the firmware update API. I think this is how the
>>>>> N3000 is working now. If the HW is for another function, register itself
>>>>> to serve another API, or another class driver.
>>>>>
>>>>> Another case is, the HW could do multiple types of tasks depending on
>>>>> the content of the image, such as firmware update, image verification,
>>>>> or assumably power off the card ... There should be some mechanism for
>>>>> the driver to only accept the right image according to what API is called.
>>>>> Or the user may input an image named update_the_card.img through
>>>>> firmware update API and finally get the card off. Having some headers
>>>>> readable by host for the operation type? Or, some HW interface for host
>>>>> to apply the operation type as well as the image, let the HW verify?
>>>>> Let's think about it.
>>>> I'm not sure if I am following your thinking here. The HW, of course,
>>>> verifies authentication of the image and acts according to the image
>>>> type. I don't think it is reasonable to require the class driver to
>>>> interpret the data to determine what it is. That implies that the
>>>> class driver would have to know the header format and possible values.
>>>> It also means that changes to the header format would require patches
>>>> to the class driver.
>>>>
>>>> The FPGA card is trusted by virtue of the fact that the customer
>>>> purchased it and physically placed it in the machine. If the FPGA card
>>>> (or the lower level driver) validates the image, then why does the
>>>> Class driver need to be concerned about the file type? I think the
>>>> purpose of the class driver is primarily to provide a common API and
>>>> perform common functions so that they don't have to be replicated
>>>> among similar low-level drivers. It is up to the low-level driver
>>>> or the device itself to ensure that the data received is acceptable.
>>>>
>>>> If the card receives data through the fpga-mgr upload facility that
>>>> isn't strictly a firmware update, and if the lower-level driver or
>>>> the card handles it and returns appropriate status - is that really
>>>> a problem?
>>>>>> As you have noted, most current cases result in a change to the
>>>>>> card, and I suspect that it will remain that way. But that can't be
>>>>>> guaranteed, and I'm not convinced that a host driver needs to be
>>>>>> concerned about it.
>>>>> A host driver should know what is done, in some abstraction level.
>>>>> I think updating the persistent storage is an acceptable abstraction
>>>>> in FPGA domain, so I'd like to extend it in FPGA manager. But doing
>>>>> anything according to the image is not.
>>>> By host driver, do you mean the class driver? Or the lower-level device
>>>> driver?
>>> The class driver.
>>>
>>>> It seems to me that you are saying that self-describing images are not
>>>> acceptable? Or at least they are not acceptable payload for an FPGA
>>>> Manager firmware-update API?
>>> For N3000, we are working on the persistent storage update APIs, which is
>>> a much simpler working model, no runtime device change, and needs no
>>> device removal & re-enumeration.
>>>
>>> But if you need to extend something more that would potentially changes
>>> the behavior of the running devices on FPGA, device removal &
>>> re-enumeration are needed so that the system knows what devices are
>>> changed.
>>>
>>>> The FPGA Image Load Framework was designed with the concept of
>>>> transferring data to a device without imposing a purpose on the data.
>>>> The expectation is that the lower-level driver or the device will
>>>> validate the data. Is there something fundamentally wrong with that
>>> I think there is something wrong here. As I said before, persistent
>>> storage updating has different software process from some runtime
>>> updating, so the class driver should be aware of what the HW engine
>>> is doing.
>> So far, there are no self-describing images that cause a
>> change in run-time behavior, and I don't think that will
>> happen for the very reason that the class-driver would
>> need to know about it.
> Again, the class driver needs to know what is happening, at some
> abstraction level, to ensure the system is aligned with the HW state.
>
> If the class driver cannot tell the detail, it has to assume the
> whole FPGA region will be changed, and removal & re-enumeration is
> needed.
So we make it a requirement that the self-describing files
cannot make changes that require the class driver to manage
state.
>
>> When I asserted that not all self-describing images are
>> changing firmware, I did not mean to imply that they change
>> run-time behavior; they do not. They are part of a multi-
>> step update of firmware. However, looking at each part of
>> the sequence independently, there is at least one instance
>> where a certificate is stored in RAM for temporary use.
>> When the driver exits from this call, there is no firmware
>> change. There is also no change in run-time behavior.
>>
>> I'm thinking we could have different IOCTLs:
>>
>> (1) firmware  update (address, size, purpose provided
>>     with the image)
> Will the firmware update use the self-describing files?
The firmware update option would be for files that
are not self-describing.
>
>> (2) image upload (self-describing files)
> If both 1 & 2 use self-describing files, how the class driver verifies
> the type of the file without looking into the file?
Only 2 would use self-describing files.

- Russ
>
> For example, if a user calls a firmware update API but inputs an image
> upload file, will the class driver block the call? How?
>
>> (3) image validation
>>
>> These would all use most of the same code, but the FPGA
>> Manager flags and structure fields would be set differently.
> This is good to me.
>
> Thanks,
> Yilun
>
>> - Russ
>>> Thanks,
>>> Yilun
>>>
>>>> approach? And if not, why couldn't we incorporate a similar image_load
>>>> API into the FPGA Manager?
>>>>
>>>> - Russ
>>>>
>>>>> Thanks,
>>>>> Yilun
>>>>>
>>>>>> - Russ
>>>>>>
>>>>>>> Thanks,
>>>>>>> Yilun
>>>>>>>
>>>>>>>> Thanks,
>>>>>>>> - Russ
>>>>>>>>
>>>>>>>>> Thanks,
>>>>>>>>> Yilun
>>>>>>>>>
>>>>>>>>>>> while
>>>>>>>>>>> the fpga-mgr knows the data will be stored in FPGA cells. They may need
>>>>>>>>>>> to know the exact physical position to store, may not, depends on what the
>>>>>>>>>>> HW engines are.
>>>>>>>>>>>
>>>>>>>>>>>> This functionality could, of course, be merged into the fpga-mgr. I did
>>>>>>>>>>>> a proof of concept of this a while back and we discussed the pros and cons.
>>>>>>>>>>>> See this email for a recap:
>>>>>>>>>>>>
>>>>>>>>>>>> https://marc.info/?l=linux-fpga&m=161998085507374&w=2
>>>>>>>>>>>>
>>>>>>>>>>>> Things have changed some with the evolution of the driver. The IOCTL
>>>>>>>>>>>> approach probably fits better than the sysfs implementation. At the time
>>>>>>>>>>>> it seemed that a merge would add unnecessary complexity without adding value.
>>>>>>>>>>> I think at least developers don't have to go through 2 sets of software
>>>>>>>>>>> stacks which are of the same concept. And adding some new features like
>>>>>>>>>>> optionally threading or canceling data transfer are also good to FPGA
>>>>>>>>>>> region update. And the nvmem update could also be benifit from exsiting
>>>>>>>>>>> implementations like scatter-gather buffers, in-kernel firmware loading.
>>>>>>>>>>>
>>>>>>>>>>> I try to explain myself according to each of your concern from that mail
>>>>>>>>>>> thread:
>>>>>>>>>>>
>>>>>>>>>>> Purpose of the 2 updates
>>>>>>>>>>> ========================
>>>>>>>>>>>
>>>>>>>>>>>   As I said before, I think they are both data transfer devices. FPGA
>>>>>>>>>>> region update gets extra support from fpga-region & fpga-bridge, and
>>>>>>>>>>> FPGA nvmem update could be a standalone fpga-mgr.
>>>>>>>>>>>
>>>>>>>>>>> Extra APIs that are unique to nvmem update
>>>>>>>>>>> ==========================================
>>>>>>>>>>>
>>>>>>>>>>>   cdev APIs for nvmem update:
>>>>>>>>>>>     Yes we need to expand the functionality so we need them.
>>>>>>>>>>>
>>>>>>>>>>>   available_images, image_load APIs for loading nvmem content to FPGA
>>>>>>>>>>>   region:
>>>>>>>>>>>     These are features in later patchsets which are not submitted, but we
>>>>>>>>>>>     could talk about it in advance. I think this is actually a FPGA region
>>>>>>>>>>>     update from nvmem, it also requires gating, data loading (no SW transfer)
>>>>>>>>>>>     and re-enumeration, or a single command to image_load HW may result system
>>>>>>>>>>>     disordered. The FPGA framework now only supports update from in-kernel
>>>>>>>>>>>     user data, maybe we add support for update from nvmem later.
>>>>>>>>>>>
>>>>>>>>>>>   fpga-mgr state extend:
>>>>>>>>>>>     I think it could be extended, The current states are not perfect,
>>>>>>>>>>>     adding something like IDLE or READY is just fine.
>>>>>>>>>>>
>>>>>>>>>>>   fpga-mgr status extend:
>>>>>>>>>>>     Add general error definitions as needed. If there is some status
>>>>>>>>>>>     that is quite vendor specific, expose it in low-level driver.
>>>>>>>>>>>
>>>>>>>>>>>   remaining-size:
>>>>>>>>>>>     Nice to have for all.
>>>>>>>>>>>
>>>>>>>>>>> Threading the update
>>>>>>>>>>> ====================
>>>>>>>>>>>
>>>>>>>>>>>   Also a good option for FPGA region update, maybe we also have a slow FPGA
>>>>>>>>>>>   reprogrammer?
>>>>>>>>>>>
>>>>>>>>>>> Cancelling the update
>>>>>>>>>>> ====================
>>>>>>>>>>>
>>>>>>>>>>>   Also a good option for FPGA region update if HW engine supports.
>>>>>>>>>> These are all good points.
>>>>>>>>>>
>>>>>>>>>> Thanks,
>>>>>>>>>> - Russ
>>>>>>>>>>> Thanks,
>>>>>>>>>>> Yilun
>>>>>>>>>>>
>>>>>>>>>>>>>>>> According to the patchset, the basic workflow of the 2 update types are
>>>>>>>>>>>>>>>> quite similar, get the data, prepare for the HW, write and complete.
>>>>>>>>>>>>>>>> They are already implemented in FPGA manager. We've discussed some
>>>>>>>>>>>>>>>> differences like threading or canceling the update, which are
>>>>>>>>>>>>>>>> not provided by FPGA manager but they may also nice to have for FPGA
>>>>>>>>>>>>>>>> region update. An FPGA region update may also last for a long time??
>>>>>>>>>>>>>>>> So I think having 2 sets of similar frameworks in FPGA is unnecessary.
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> My quick mind is that we add some flags in struct fpga_mgr & struct
>>>>>>>>>>>>>>>> fpga_image_info to indicate the HW capability (support FPGA region
>>>>>>>>>>>>>>>> update or nvmem update or both) of the download engine and the provided
>>>>>>>>>>>>>>>> image type. Then the low-level driver knows how to download if it
>>>>>>>>>>>>>>>> supports both image types.An char device could be added for each fpga manager dev, providing the
>>>>>>>>>>>>>>>> user APIs for nvmem update. We may not use the char dev for FPGA region
>>>>>>>>>>>>>>>> update cause it changes the system HW devices and needs device hotplug
>>>>>>>>>>>>>>>> in FPGA region. We'd better leave it to FPGA region class, this is
>>>>>>>>>>>>>>>> another topic.
>>>>>>>>>>>> I'll give this some more thought and see if I can come up with some RFC
>>>>>>>>>>>> patches.
>>>>>>>>>>>>
>>>>>>>>>>>> - Russ
>>>>>>>>>>>>>>>> More discussion is appreciated.
>>>>>>>>>>>>>>> I also think fpga_mgr could be extended.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> In this patchset,
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> https://lore.kernel.org/linux-fpga/20210625195849.837976-1-trix@redhat.com/
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> A second, similar set of write ops was added to fpga_manger_ops,
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> new bit/flag was added to fpga_image_info
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> The intent was for dfl to add their specific ops to cover what is done in
>>>>>>>>>>>>>>> this patchset.
>>>>>>>>>>>>>> I think we don't have to add 2 ops for reconfig & reimage in framework,
>>>>>>>>>>>>>> the 2 processes are almost the same.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Just add the _REIMAGE (or something else, NVMEM?) flag for
>>>>>>>>>>>>>> fpga_image_info, and low level drivers handle it as they do for other
>>>>>>>>>>>>>> flags.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> How do you think?
>>>>>>>>>>>>> A single set is fine.
>>>>>>>>>>>>>
>>>>>>>>>>>>> A difficult part of is the length of  time to do the write. The existing write should be improved to use a worker thread.
>>>>>>>>>>>>>
>>>>>>>>>>>>> Tom
>>>>>>>>>>>>>
>>>>>>>>>>>>>> Thanks,
>>>>>>>>>>>>>> Yilun
>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> Any other driver would do similar.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> Is this close to what you are thinking ?
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> Tom
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> Thanks,
>>>>>>>>>>>>>>>> Yilun
>>>>>>>>>>>>>>>>

