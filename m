Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E078B6A4EE1
	for <lists+linux-fpga@lfdr.de>; Mon, 27 Feb 2023 23:48:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbjB0Wqf (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 27 Feb 2023 17:46:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjB0Wqe (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 27 Feb 2023 17:46:34 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1A78B74D;
        Mon, 27 Feb 2023 14:46:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677537966; x=1709073966;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=I+0rsEXIb6k9tWhnkHAa23znw0vJgdf3TkRUUadoEsw=;
  b=Fcr6IcWw10hRQuw2eiGuzwU1PC5Qeoa3OPTje+ifP3trfDjD8oSqoxx+
   e6jniMNMTleuvMBL3k4d+HRhjQaL6G5quHVRQuUHREf33AYEUp0UHtajo
   00TLO1aXnfQdEjb5L9UR20zKXD1ZqO/2y8Za7bpWsI2Y6zjlihzhohR1z
   Cn9yJT4a8DiaFLbLzY1skPpwPnRgAsxDL+Upjs13G1wvNHX8DryMIq4j8
   fYn0IOkRhiNTIrX/jfULbK93bB+gqL21JlWsTq98FYRKZs23+eMCQMXdv
   qyUkIv3YSxnKpDnDXv+Ood9kbqkWSO7QIQQyG8PqqOBFU2jNyqKz8wMZN
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10634"; a="313660648"
X-IronPort-AV: E=Sophos;i="5.98,220,1673942400"; 
   d="scan'208";a="313660648"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2023 14:42:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10634"; a="704195571"
X-IronPort-AV: E=Sophos;i="5.98,220,1673942400"; 
   d="scan'208";a="704195571"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga008.jf.intel.com with ESMTP; 27 Feb 2023 14:42:51 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 27 Feb 2023 14:42:51 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 27 Feb 2023 14:42:51 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 27 Feb 2023 14:42:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IC92458lmpWv3ZegEthUfDQbts4E9FYzyK1FPdXn0tVoP8ob1hJevZDe/x2v2iL0pG+fzQvioOegA+vUjpW9AStP2v/RRm1ASBbmQRrxaNaUyjTeZNcLXHKjgzjtD6J9AekhPRGtRbwzozdtk6sb9o/rbZx+tDMxfSQHL+28RD9J8bz6HTKYC0wHJV59aOTtStKGDWfhJ8DLD6B+XCfrWIwmapdvyhGp2ncV8pub8lZqCdMOf2PbbBGiyaTJfviErIBZSdKDcpT5LJAzJ5P+yddm9keEJsMQFZCNCXuWKpytqN3v97gx0GDBI+KSJPJjvQTDNg/DUPMVQBwTAKqzkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I+0rsEXIb6k9tWhnkHAa23znw0vJgdf3TkRUUadoEsw=;
 b=bTeKdjOiJr96QOC/mIEZINR4a2ISiZBlbFuRlgFfqRSFprbtNrG/jCzv7KtmQQwxjiYzYfkT9zXZo62qNRuhdOSdkwIQaRpVzapg6qI/yri07F9H1uEJ3RSqJYYA6W2ijfb8PXlehAEmfXf1BDLKRtjyFE0T4F/GBAGPjo9LOETCdb47BLBsBIQze0OU8B6n47YQF9/riGW2JF61lj1miDyAI1G1f18hxtXHFuEMzV22U1LMrEJNFPPXpjHSQhw9q5RTrI6by6pr+jy3NGH2nhp93+sXJaPd/rb7L2kq5LdXSh2Q+NhXVk22PzZhMuOWCgdMFeHNvASnRrkzB4YG5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM5PR11MB1899.namprd11.prod.outlook.com (2603:10b6:3:10b::14)
 by LV2PR11MB6069.namprd11.prod.outlook.com (2603:10b6:408:17a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.25; Mon, 27 Feb
 2023 22:42:42 +0000
Received: from DM5PR11MB1899.namprd11.prod.outlook.com
 ([fe80::dcb3:5ba7:4576:d776]) by DM5PR11MB1899.namprd11.prod.outlook.com
 ([fe80::dcb3:5ba7:4576:d776%6]) with mapi id 15.20.6134.021; Mon, 27 Feb 2023
 22:42:42 +0000
Message-ID: <cc6176cb-6792-ef11-f42a-d2d5b12d04b4@intel.com>
Date:   Mon, 27 Feb 2023 14:42:30 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [PATCH v1 0/6] PolarFire SoC Auto Update Support
Content-Language: en-US
To:     Conor Dooley <conor@kernel.org>
CC:     Conor Dooley <conor.dooley@microchip.com>,
        Xu Yilun <yilun.xu@intel.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Tom Rix <trix@redhat.com>, <linux-riscv@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-fpga@vger.kernel.org>
References: <20230217164023.14255-1-conor@kernel.org>
 <Y/ht1eHgtRrLxIhC@yilunxu-OptiPlex-7050> <Y/h1KFGSw13OabYw@wendy>
 <21bebf9d-eb27-5607-b0a9-274c46ef8aa3@intel.com> <Y/0r1aR6Wik2KYBd@spud>
From:   Russ Weight <russell.h.weight@intel.com>
In-Reply-To: <Y/0r1aR6Wik2KYBd@spud>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0284.namprd04.prod.outlook.com
 (2603:10b6:303:89::19) To DM5PR11MB1899.namprd11.prod.outlook.com
 (2603:10b6:3:10b::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR11MB1899:EE_|LV2PR11MB6069:EE_
X-MS-Office365-Filtering-Correlation-Id: 6737323c-845f-413c-4887-08db1913ef8b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LbNPGyaPAHN+BdtrhmBTZswnAacYPpsBzvOE1WbQsPLP44FbxSknjl2b38y0pIVIVxtuLkbNv0PgxYwnleCj/ZA3xzgahKH5k2J8wqvbA2HTo0IWc9zY5cLNm082za6bBdbawWQ48QnoD7OuIfyDHhuvHHiHnKVFrCcC2DlPdROI+zw45psG6JVKyOGeXT1TudjghQaXkhiPGAkncIAZHA5/Nm5cw8RLjy4EdkC7NKVUvocHdZtDj7tynY4gXmHvC7Y8qSDmGo6FjdvaaoGlwtav8g1feBL0I+kaa/i0GMTHwiMXWbr1l+9KU56UGgwGmCROmQeROt6rCMqN6p2iYkeDnHs1Ip+NtB4klnUHtLEqn2S2MXqBSRBZXmYXSq0LCM0iKDBnB0rCYFEWNQkqaH5eVad4XHHQWTxppBR902obWMkU24L/olbBf2MXF3m1jz763cZJ8+tG2CU42DLpFLXiGYN4cJ+e7EEZVWgpPhse/2weXjz+H1a6tB3PVcgA6/IMdXKkstEm+BH3/CLlZwSPqIJPkIIcBaMEp5J7XI+2oOfEIWMYwrRgLJmnUVSgXV8SREFA1iCltJgn3KPHMHVG5JGMpxrbN/WuYoHhHMbeAAyX88kwwqr04tZjUo5XqOeDoc2qEjKU9xnTJDNsRJWirExdPKmn7A/iRc5xWE9N7e9eHVs3gJTEaTE3hRZF40CMtK5LZaNJ6uVdWlJsUxjgs+/JI3CZF50LONBrGpnHzP8jLWDTIy313Moddaeu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR11MB1899.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(396003)(39860400002)(366004)(346002)(376002)(451199018)(6512007)(15650500001)(82960400001)(38100700002)(8676002)(4326008)(66556008)(66946007)(6916009)(41300700001)(5660300002)(7416002)(8936002)(2906002)(66476007)(2616005)(6506007)(53546011)(26005)(478600001)(6666004)(186003)(966005)(31696002)(83380400001)(316002)(54906003)(86362001)(36756003)(31686004)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NVRtUC93aHhTZWlGY2RDeE9WejNxdlhQdUF4RUtzVCtDdWlBZXpxWVJ0MHNO?=
 =?utf-8?B?VUxWNTNTVWFHUnRtUDdFazRBa1l6U3pTdm4rR3UvUjVFSVVZdnpDcDM2VC9t?=
 =?utf-8?B?SzV2eWsvMTJEeStrZHpFUmI3VXVibGNwZ0JXRUNKYjhVQmhHeWxjQnhZQkQr?=
 =?utf-8?B?M3FWcDNBclN4S1lXbGhyUVpFUTNtNXVUeHVpVjVSa05WMUJ3QlNlSGF6dHNO?=
 =?utf-8?B?MlRRRSt0U0F1MEJ3K1NpNmhiUmF4YWQyejhsWHhKSkVLRm9kSVJaeXF3OVhJ?=
 =?utf-8?B?NmVOZTRiT05aK2ErVnhUZEQwc0FXbTQzV0hVclJNYlFkUlg4MjhKTzZnbkNK?=
 =?utf-8?B?ZVBrdDUyMkhscDZTenBZcmFpNkxrcjd4NnlaN3Z3YnM1VXh4UityWW5Wckg4?=
 =?utf-8?B?MHg1NlR0dHhFaHcrMFVXNUtJMjNkWHpqamtyRTY3RW1aT2lSZjl2d2h6dnlE?=
 =?utf-8?B?V1I1TnpnWE1McGJsV1hxK255N1B0aTUrVkdGLzFJcHBJejFWR2pBV1RIV0ZW?=
 =?utf-8?B?bzFDTHhxT011Z05jd04yZjE3cm0wc1V1ZEpZbGlUUUwrT0JYeU5HZWtxUGEw?=
 =?utf-8?B?YnkydGd3QVI5ZnNobWp4TW4zZitkT3RTRkQ0b2V3WDd5THpVWjlSNmRoZjJD?=
 =?utf-8?B?dDFPaVNpN21zOFhOVDVvdUVxcUl2SFB1MTJwVVBoWGJ2MURlTk1tbHRteFF0?=
 =?utf-8?B?c2RlU3R2endtNXhTb2FMT3d0RUp6UndLeWZvQ3dHVjRxRWs5UkluczZpY1d2?=
 =?utf-8?B?YU5OTUJuL0pGcmRiYU1zUVJjb2kyazN2OGFXUENEaDlDRWJzK3FCd1BXY3Fa?=
 =?utf-8?B?NzI5OWRQckFnTU9tUkZKa0kvRys1V0FHNXcwQ2hBLzJQbG1tWWtkeWdzb2xP?=
 =?utf-8?B?UjhCZGhUYWpscVpPcUcwR2dwYTdYMENrUjk5SlJpbTlzZWNUeWpxMzJPZUdK?=
 =?utf-8?B?aU85dkE2bVRqcjhyNjNaZDFVMUw4Nm5jRXdaZ3hFc2Q1TTQxSWptWnRPemdh?=
 =?utf-8?B?SUVDN1l5MVM1TkRsekpIWlpuV0RuMDJsRUl5TmljdHgwYU5uN290VkVZZVVB?=
 =?utf-8?B?cDVjUVVkcUpmWUtTTU5yTGxpeFdmQUJJM1A4NzdDb1hJRHhwekpialhYOUhP?=
 =?utf-8?B?Y1JsY091RW83b3o5VFFndVhhYXRSdTh0ZjRBdVhCclFlbDgvcllBcndjV3Zu?=
 =?utf-8?B?SzlpZDVENUR5Sm5ZL0xKaTIxMkhlYkd0SFdBN0F5VWxXdnRJSitzVDR3VWox?=
 =?utf-8?B?NmM3UWU4UTNVcW5PaVBTcjQ1VDEvbnJQYUcwdnV5N2duREIxUDZHS1hudk9T?=
 =?utf-8?B?MVQ0ajVhdHBJM21PUWhvc2tMSG1BeHRNY2xMdi8xTXcxdVc1b3pVUFVPY0Vi?=
 =?utf-8?B?dXJzbW9vM0QxcHkvTUt1RTJXV0Q0cGdFRnI4ekZTVm4vT3drQitoWVYwUkgw?=
 =?utf-8?B?V1pIMmF4N25PMlRxb1ZEYUQySnJKcnNwaWlDK2F3VEdLdDM1UFNnSDdGV24w?=
 =?utf-8?B?RVRSUU9IcURjYjhobUI2U2tacnVIblB1cER2ZTl6dXAydkVEQkV0djdBajZ1?=
 =?utf-8?B?RGE3Q21oT0toU1Z4VVZWckJXamNYcGdZTGRpUTZUZjdHT0VJRnZmTVh5MVFG?=
 =?utf-8?B?NXRkOS9zZGpGaE1JRS9HOEFDNTQ0cnIyNXkvN2ZNcWE2S0Y2a0hHR2JJVDNF?=
 =?utf-8?B?eXd4eUlYRHNUeHRCUjh2NS9jdFNFL1pQWmZ6QU15MEJpQ1ozVDBlRFp0YlRz?=
 =?utf-8?B?YkVTLzZ4RnBwd2J6SWtNaGRydEF4eDkrUkJGUWR0SEZHcG9VTjI0SU5Id1dq?=
 =?utf-8?B?akgxZzRiUVZDRjBzYy8rTEZiUDc3SjliVzFvOUU5OElKbGpEWkdxaGNacUky?=
 =?utf-8?B?Mnh4RTFvZUtVZVhoM2NwY0p6b1FQY0F6S2J0eWV1Q0FXekNmRTNTLzY4UCtU?=
 =?utf-8?B?dktXb2lvOUI3RHdDYmxLL28xQWM2WmVPQ0hkcGlvMkJRR3pkakRiaW40OTQ4?=
 =?utf-8?B?SnQwWWN6YmJGdnpOdTBsWXJmQzZvOU1ub2xCem92bTl2ajB3emx2VGI3VG9a?=
 =?utf-8?B?V2M2L0YzekQ0MTRaWngrRURYcjM2SGthc3Z3M0VUU2dXVGpCVGttdTljVlMv?=
 =?utf-8?B?YkFpMEIrQ0xuYzdDN3lCVG5lY1Yra3Z1NzQrWVYvcENmZ3REa01PcmV4ZURq?=
 =?utf-8?B?RXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6737323c-845f-413c-4887-08db1913ef8b
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1899.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2023 22:42:41.9512
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4ev7GBWBphzmO3SOUNdPh1EEcEVGEq95YUr/v0/6Grw+XYUwgRoHY4mRFwf6397MRWr3TxNkiWOZIc0/w5kP5Dyi7ePYFTTe7To2AUsYijE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB6069
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On 2/27/23 14:16, Conor Dooley wrote:
> Hey Russ,
>
> On Mon, Feb 27, 2023 at 02:04:36PM -0800, Russ Weight wrote:
>> On 2/24/23 00:28, Conor Dooley wrote:
>>> On Fri, Feb 24, 2023 at 03:57:09PM +0800, Xu Yilun wrote:
>>>> On 2023-02-17 at 16:40:17 +0000, Conor Dooley wrote:
>>>>> This patchset adds support for the "Auto Update" feature on PolarFire
>>>>> SoC that allows for writing an FPGA bistream to the SPI flash connected
>>>>> to the system controller.
>>>> I haven't fully checked the patches yet, just some quick comments:
>>>>
>>>> Since this feature is just to R/W the flash, and would not affect the
>>>> runtime FPGA region, I don't think an FPGA manager is actually needed.
>>>> Why not just use the MTD uAPI? There is a set of exsiting MTD uAPI &
>>>> MTD tool if I remember correctly.
>>> A lack of interest in opening up the system controller to userspace!
>>> You're right in that the writing of the image can be done that way, and
>>> while I was testing I used the userspace bits of mtd along the way - but
>>> for validating that the image we are writing we rely on the system
>>> controller.
>>> I'm really not interested in exposing the system controller's
>>> functionality, especially the bitstream manipulation parts, to userspace
>>> due to the risk of input validation bugs, so at least that side of
>>> things should remain in the kernel.
>>> I suppose I could implement something custom in drivers/soc that does
>>> the validation only, and push the rest out to userspace. Just seemed
>>> fitting to do the whole lot in drivers/fpga.
>> In case you haven't already looked at the new firmware-upload
>> support in the firmware-loader, I'll give you some references
>> here to see if it fit you needs. This would only support the
>> write (not the read) but it would allow the controller to do
>> validation on the write.
>>
>> The is the cover letter which shows a usage example:
>> https://lore.kernel.org/lkml/20220421212204.36052-1-russell.h.weight@intel.com/
>>
>> And this is a pointer to the latest documentation for it:
>> https://docs.kernel.org/driver-api/firmware/fw_upload.html
>>
>> The only current user is: drivers/fpga/intel-m10-bmc-sec-update.c
> Sounds interesting, I shall go and take a look. Just quickly, when you
> say it wouldn't support the read, what exactly do you mean?
> The only read that I am really interested in doing is reading the first
> 1K of flash as I need to RMW it, but I don't think that that's what you
> mean.
> Do you mean that I would not be able to dump the firmware using your
> fw_upload interface? If so, that's an acceptable constraint IMO.

Yes - I mean that you couldn't dump the firmware image from userspace
using the fw_upload interface. The sysfs interface allows you to read
and write a temporary buffer, but once you "echo 0 > loading", there
is no sysfs interface associated with the firmware-loader that would
allow you to read the image from flash. Your controller actually does
the writes, so RMW in that context is fine.

- Russ
>
> Your interface also circumvents us (Microchip) defining yet another
> method for interacting with the FPGA, since from my nosing around,
> everyone seems to do something different.
>
> Cheers,
> Conor.
>

