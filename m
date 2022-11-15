Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 378B4628F74
	for <lists+linux-fpga@lfdr.de>; Tue, 15 Nov 2022 02:44:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231944AbiKOBnL (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 14 Nov 2022 20:43:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231379AbiKOBnK (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 14 Nov 2022 20:43:10 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F2E917421;
        Mon, 14 Nov 2022 17:43:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668476589; x=1700012589;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+fngAxE6snDLDBMyFn7J9w4Nn0DIMbUGkVT8KCIuILU=;
  b=nGz9gWGiLJr8P9MqbZYkr26jLE0ZTC6Hc4eWlfbOvyrMs/Yn53UkqvQI
   /UOPwjoqrR1xy7Yx0qj80nLKiyHraSZzpuXQY6fN0qB/w4SrVq/ur7ROO
   howKjiMU+NL7SL+N2oGvdLe6T1m1KQvNlQNLCtSace9/7YXtJL8hYTFt5
   IRSkytK3oFw+oZkgzyazoVu+FQLhM8eQF+k0TRXJL+MVV58r1Dm3Eh5KR
   tTRmNcym4MhLJEnStAOLjc4gVp9Z3xci2j0xfgRwndu2JAUt87ZVDa2Ji
   24ZRckxVoEyp9pbMESIqQY0emdb50Ibe9oLWmMPtmaSkjAx9wki3eseTl
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="312136661"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="312136661"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2022 17:43:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="781155879"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="781155879"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga001.fm.intel.com with ESMTP; 14 Nov 2022 17:43:08 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 14 Nov 2022 17:43:08 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 14 Nov 2022 17:43:08 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.49) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 14 Nov 2022 17:43:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EnymygfWJ4W2Tbssqyyryryj2Qqb9BvLRQwkvDbHlOLlL6gyb7/CNb2b5HY4TfVmqdUJs45Dk/Nuj6514lSbjyulcNeqYsc2TMOUPhtzqNamOjeprePwXnO730FUp3Vg4prB4U+7pEA/3HCeMa4KlzjD1nBN7vPNrmUdfm1y3MpI/dsCa5GkdSfuteH2bdHRLX/PcDokmCTpi4CyirUb0X8bwvGZdWhsIB6Uk+FCo4bWm/iKZT2C3yw+bC66uMXCwwWpB2XYCaqMfxP9gSwp+yzMyTY9kOuPUx/Iu/mHU8Djq46T4p/c+HDl1nW41BXI//V4breECGNxfvJCk47cdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t74jncNntbZ4J9qj2QmcmggQk69/xF5c3vVQPuoAYjI=;
 b=RpYGNo0EhMGUdcsl6km0Ath70sNlBe033RcMeLoEv3/27KK4KXrzGJtiZXhDlFHVuNxiNduA4hh2XhZHxx+TqoMd4dUY6r+BzFr7DpbORA1nVum+1o+/8kug5AJFSrRz1gm76sBYjBwhEDK+AhkJ1QNuUZ4+nnXXuJkoIAT5Bpxk8KxOUoOH06SWGHmcvYxtkjZFk7ZqvFuwC7hSIykFG2j5ASqZtdwEKnUY9psL7Q0kByn7Wq4IpZ9kx4oz99U8CNnkGNqWgoyxcgukSsbS68sA5qpWXLXQjOpKmJDeLT6iGAx3HKk+6aoGOJc0UrPam5xBt22eMgzOgWj6HkmpJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM5PR11MB1899.namprd11.prod.outlook.com (2603:10b6:3:10b::14)
 by BL1PR11MB5320.namprd11.prod.outlook.com (2603:10b6:208:316::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Tue, 15 Nov
 2022 01:43:05 +0000
Received: from DM5PR11MB1899.namprd11.prod.outlook.com
 ([fe80::cdc6:8225:35ef:247d]) by DM5PR11MB1899.namprd11.prod.outlook.com
 ([fe80::cdc6:8225:35ef:247d%9]) with mapi id 15.20.5813.017; Tue, 15 Nov 2022
 01:43:05 +0000
Message-ID: <24a29af5-ca9b-38c0-5dce-523104f163d0@intel.com>
Date:   Mon, 14 Nov 2022 17:43:01 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH 06/12] fpga: intel-m10-bmc: Add flash ops for sec update
Content-Language: en-US
To:     Xu Yilun <yilun.xu@intel.com>,
        =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC:     <linux-fpga@vger.kernel.org>, Wu Hao <hao.wu@intel.com>,
        Tom Rix <trix@redhat.com>, Moritz Fischer <mdf@kernel.org>,
        Lee Jones <lee@kernel.org>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        "Tianfei zhang" <tianfei.zhang@intel.com>,
        Mark Brown <broonie@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20221108144305.45424-1-ilpo.jarvinen@linux.intel.com>
 <20221108144305.45424-7-ilpo.jarvinen@linux.intel.com>
 <Y24K0LGs1tHru4vX@yilunxu-OptiPlex-7050>
 <375b8b75-9de0-6f9c-241e-27d479388fd7@linux.intel.com>
 <Y3HuvXfgA5Tit4YO@yilunxu-OptiPlex-7050>
From:   Russ Weight <russell.h.weight@intel.com>
In-Reply-To: <Y3HuvXfgA5Tit4YO@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0299.namprd04.prod.outlook.com
 (2603:10b6:303:89::34) To DM5PR11MB1899.namprd11.prod.outlook.com
 (2603:10b6:3:10b::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR11MB1899:EE_|BL1PR11MB5320:EE_
X-MS-Office365-Filtering-Correlation-Id: 1de517a0-dc45-40ab-a890-08dac6aabda2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: phgNSOT2tsikZg/piHAh4BvX2N7PCf1T2td85Q2WxmWD9y46sFzZdoKnFUNm3OJA7gnV0pL95DkhrThZMa5oAhiE6fELCx1xOnwBpcKPwlmZyW4B60H2a+1qRx9JJwbD701ZLGQZ9L7CYoHt5xHmAmB3d64qiQIaT8VBVYzZPDuZwnT4q3zss90PCkAnApGBMqfwlbnwfmTtRIsHX+c+0wHrxzQ6L1di23QFSsDlonvzTcapKpjGejyMmcMuQaUhfbbWljs/Bv9Ss4me1cDTvMcywS9eabVfBd+ythvsY6HDRf4lfFApkN6eqHss9db++zTtQEh2vgJMmI/0Sxz4cV3Kmy5JlHgcGlX7+UectoAWsu73amUdSTo+9MWsQESdodUpE8e0MecJ4AlII4KQeZoQ/6wPraCEq3aZ8xbcvcKh7MUfMqYJkGKPvyddrny190uE+CJTlb2v8ps9ABMgQJRVJpctE3eyeVJsagez+gteOssBYhb6sYhhg0gWbO6QBJjxAjohPoNjSeDUp/x1fKBVOYDO2l0XM0l8OhGWL9cMvJ/zewnKsmBHbrBIt1IM2b9i/5r+ZFRDR4TQFXojKdIiXQE6l2iqf4Genhv953PgKKIg04nXhi30OEv5FTmZmY3KR1+m97LirDnpW5XUt4gNkYXTLD2fDtgP2UiXoSrgz/NZAiP2bskewAi+1M7DHHEk6+60xookQh/g57qWLdHvyBo9cPYOE8SHMmsd1jX9G60Bj71YyMuuSdsllpKjfs44cwGEuFsIhX0EEANZDFXfZN5SGfFzzYh0ttbJ2fU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR11MB1899.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(376002)(39860400002)(366004)(136003)(346002)(451199015)(26005)(6506007)(6512007)(6486002)(41300700001)(53546011)(6666004)(478600001)(4326008)(110136005)(316002)(8676002)(54906003)(31696002)(38100700002)(66946007)(82960400001)(66556008)(66574015)(66476007)(186003)(83380400001)(2616005)(86362001)(31686004)(2906002)(36756003)(30864003)(8936002)(15650500001)(5660300002)(4001150100001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TVBiQ2NSOGNtRGw5ditsU0t0N3hmRitOejMvbEJzL2hGTm5jWWN2dFY3NTZD?=
 =?utf-8?B?V1VCdVNMVXVOVkVZUTNBcTZCQnF1UzdJZWJmbk5tVHBqY1I4dE5OWG9pVFhp?=
 =?utf-8?B?dXVQR0ovTmpJQ28yalQyL1p2WmNuNmR5Ni85clBycklENFY0V1l1SEdVaGc1?=
 =?utf-8?B?TC9aQUdkTWNZTlhZUnl2ejF4d2NhTUtNbXBmdDBtVm5ZVGZqdEh1M0RvZDFh?=
 =?utf-8?B?b3B1dHhjUzhoREk2QmhzRS94eThkTGpEVXRQa3BiMjFuRTdqcUY1WTdZcWtH?=
 =?utf-8?B?eFM5eHlOMnhlbVpYM2pLQVI3NjRNK1V0ZUErZWd0QUxoeGxFT1dPczNwOGtk?=
 =?utf-8?B?cHQyRFhNVHpLR0dJTm8xbjlZZnU2M29QRXlXUVpuZy9qQ3VTSVVhZFM1ZmlG?=
 =?utf-8?B?Q0Y1Z3A1YnYyaUJNOGxJMFdCaGpIbkpzQ3hUUll0WGhWNkhCd3IvSFJFR041?=
 =?utf-8?B?a1didmRCZzlTeGNIeVU3U3A0aDN4VGJIWVpxcjI1MTZhU3ZzK0ZHUnE5MWNL?=
 =?utf-8?B?d3IvemRCdW4rWmZ4WTNJZ3lZSG5pUFJ1WFNEcE9GWHNIZEhscmY5TVNPMG1P?=
 =?utf-8?B?WkM5MFg2ZTVMVVJMdklIbkJXS3QxVFBSdzZBQkx0TzdmdzJTUXFsUmdjUjI2?=
 =?utf-8?B?OHpsUVZnaFFaaS9Qa1JJcFlZVWxzOXBsWjk1UElhZ3BKQWdkY1h0czFqY3BY?=
 =?utf-8?B?ekVBejQxb2pxY0NmTlBvQ2VMcE9Va3Vpdi85VHpSSGxHVTBPVndSVm0xK1Va?=
 =?utf-8?B?WTF2djB3SkFxdkI4STlpVTNUdFBFV2tYSzhjaFRxaFo5K2ZtQlpkRTlrSTRO?=
 =?utf-8?B?cFVxM3NONWdGRk4ySDFhR3NId0ZTZ1E1RzhSZkVJcEJRQWJNZ3dnemJLUUl6?=
 =?utf-8?B?MnlvZUYvRFIrM1lMeW8rcDFCZVY4N3J2U1pTVU1RS09ad3gydjQ2MnlZSEpx?=
 =?utf-8?B?Wi9ZckJWdE02T1kvdnhlRE1Ua2dZalh0bTlvWVVLem9EOFg1R1ozMmhUeWFl?=
 =?utf-8?B?K0Z6cGlVWnZTU01SSSs5NzVHZTNJa05NMm1DNmZHSmxlSTVoZkVoa1NSaXpr?=
 =?utf-8?B?dHdYWXc1YlZKZ21CditlSkdMbk1TVGtHd3AvREpIN2w3TEVhSENGRVdyMFhx?=
 =?utf-8?B?a2RQM3ZuQlozNHZyVWdVWnZoVWdvdXF6cnQ4YTNiRzFtejlsRS9EQmFaNGtY?=
 =?utf-8?B?UE94OEVOYlhHODJxMSsxWk41dVUzK2dhWmtMZkxzMC9hT3Y2dTlac0ZmNTVR?=
 =?utf-8?B?MFAzWTUwR2xuTGdkSTR2cmxqd2doblpvODJvZlRaOGMybnJzeDJhbUwzVTdn?=
 =?utf-8?B?LzE2YUFoeTI2b1A4WEJzMjhIbmttdFpjemRza1oyUHM4ZHkrZlgyZFR2eC9q?=
 =?utf-8?B?SjBsRTdyVU5abnR1YjhnS1pBTHZlbmx2T0JrYzN0d2xiRVpxOE4zMUtBMGpN?=
 =?utf-8?B?eGUrWXhIUEMwR28razRuT2xJUmtlWjVkdkhIWkY2Y0FSczZNb1NXalZIeExR?=
 =?utf-8?B?VzVVYUs4MkZCUWszZVFUWkpKblFHZEl0Uzh1RXdGR0YyRHdva3lXb2VJZTNl?=
 =?utf-8?B?Z0I2Z2VCNk1OelZMdXNHNjBKTjhnUElUVVdFUi9ReG9tTm1RRWJlektQT0ht?=
 =?utf-8?B?blJ4WGpDdnpzWTFGVmxra3EycFNKNDRvT1I0UWQyOGd6YVBTNlRkQVA0eUNu?=
 =?utf-8?B?V0FtVzRvR0lHcW9naEoyVmZxS3diem1SVXRnUC8rQlNGMjAwdWdLZFVWSFJo?=
 =?utf-8?B?dFU0YzRZQ3hJWjNhL0N0eXYrTkdJVlBJcmVHWDVwWE1CcTRjNm51WWZQWDUw?=
 =?utf-8?B?Yk4xMTN6YS9aOTdwb3R2VCtlSE5OZHNEYTFWUWQrQVJ3Wm16a3BTWWt6RmxS?=
 =?utf-8?B?cmUxWmgxSEpvczdtQytDYk1SQkswYTFPb1V2ZXZ4ampKVEQwRGtuREg1UUln?=
 =?utf-8?B?aFhPa1VrdlQ3aGJCNTNrcUdQSU9BQm5oTEhxZjhFUEdCQW9NdUV6eFVsdUVu?=
 =?utf-8?B?QTJXUk5oRXNZcmlab2NPSUdPekNmcXA5WjNqaUV3SmlBMzFVQThqMFBoK1cw?=
 =?utf-8?B?d1hWdEtvNDJiV3c4MmJQbnZQRjJqcXJaU3F5TWQ3eDZpMC92WUxpZnhLMGhm?=
 =?utf-8?B?K24yY2w4ZVFjZlhZZExkZmVQUm9Ecm5CalU4T2NMeWVhS1Fock4weENBeWpa?=
 =?utf-8?B?M0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1de517a0-dc45-40ab-a890-08dac6aabda2
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1899.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2022 01:43:05.5733
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a7c1r2pPfnzDGrWjkPZBtTbqs9MQDPxhaS5NCp+HrP6ZDWbHAvAvaZGSowwvuAbJc9sZc9+EECmB7Dd5dlMBaA9GEDPK0gLgPFOyrWVVvSQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5320
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On 11/13/22 23:31, Xu Yilun wrote:
> On 2022-11-11 at 15:32:42 +0200, Ilpo Järvinen wrote:
>> On Fri, 11 Nov 2022, Xu Yilun wrote:
>>
>>> On 2022-11-08 at 16:42:59 +0200, Ilpo Järvinen wrote:
>>>> Access to flash staging area is different for N6000 from that of the
>>>> SPI interfaced counterparts. Introduce intel_m10bmc_flash_ops to allow
>>>> interface specific differentiations for the flash access path for sec
>>>> update.
>>>>
>>>> Co-developed-by: Tianfei zhang <tianfei.zhang@intel.com>
>>>> Signed-off-by: Tianfei zhang <tianfei.zhang@intel.com>
>>>> Co-developed-by: Russ Weight <russell.h.weight@intel.com>
>>>> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
>>>> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
>>>> ---
>>>>  drivers/fpga/intel-m10-bmc-sec-update.c | 79 ++++++-------------------
>>>>  drivers/mfd/intel-m10-bmc-spi.c         | 52 ++++++++++++++++
>>>>  include/linux/mfd/intel-m10-bmc.h       | 14 +++++
>>>>  3 files changed, 84 insertions(+), 61 deletions(-)
>>>>
>>>> diff --git a/drivers/fpga/intel-m10-bmc-sec-update.c b/drivers/fpga/intel-m10-bmc-sec-update.c
>>>> index dbe8aff95da3..3bd22d03616a 100644
>>>> --- a/drivers/fpga/intel-m10-bmc-sec-update.c
>>>> +++ b/drivers/fpga/intel-m10-bmc-sec-update.c
>>>> @@ -38,11 +38,9 @@ show_root_entry_hash(struct device *dev, u32 exp_magic,
>>>>  	struct m10bmc_sec *sec = dev_get_drvdata(dev);
>>>>  	int sha_num_bytes, i, ret, cnt = 0;
>>>>  	u8 hash[REH_SHA384_SIZE];
>>>> -	unsigned int stride;
>>>>  	u32 magic;
>>>>  
>>>> -	stride = regmap_get_reg_stride(sec->m10bmc->regmap);
>>>> -	ret = m10bmc_raw_read(sec->m10bmc, prog_addr, &magic);
>>>> +	ret = sec->m10bmc->flash_ops->read(sec->m10bmc, (u8 *)&magic, prog_addr, sizeof(magic));
>>>>  	if (ret)
>>>>  		return ret;
>>>>  
>>>> @@ -50,19 +48,16 @@ show_root_entry_hash(struct device *dev, u32 exp_magic,
>>>>  		return sysfs_emit(buf, "hash not programmed\n");
>>>>  
>>>>  	sha_num_bytes = FIELD_GET(REH_SHA_NUM_BYTES, magic) / 8;
>>>> -	if ((sha_num_bytes % stride) ||
>>>> -	    (sha_num_bytes != REH_SHA256_SIZE &&
>>>> -	     sha_num_bytes != REH_SHA384_SIZE))   {
>>>> +	if (sha_num_bytes != REH_SHA256_SIZE &&
>>>> +	    sha_num_bytes != REH_SHA384_SIZE) {
>>>>  		dev_err(sec->dev, "%s bad sha num bytes %d\n", __func__,
>>>>  			sha_num_bytes);
>>>>  		return -EINVAL;
>>>>  	}
>>>>  
>>>> -	ret = regmap_bulk_read(sec->m10bmc->regmap, reh_addr,
>>>> -			       hash, sha_num_bytes / stride);
>>>> +	ret = sec->m10bmc->flash_ops->read(sec->m10bmc, hash, reh_addr, sha_num_bytes);
>>>>  	if (ret) {
>>>> -		dev_err(dev, "failed to read root entry hash: %x cnt %x: %d\n",
>>>> -			reh_addr, sha_num_bytes / stride, ret);
>>>> +		dev_err(dev, "failed to read root entry hash\n");
>>>>  		return ret;
>>>>  	}
>>>>  
>>>> @@ -98,27 +93,16 @@ DEVICE_ATTR_SEC_REH_RO(pr);
>>>>  static ssize_t
>>>>  show_canceled_csk(struct device *dev, u32 addr, char *buf)
>>>>  {
>>>> -	unsigned int i, stride, size = CSK_32ARRAY_SIZE * sizeof(u32);
>>>> +	unsigned int i, size = CSK_32ARRAY_SIZE * sizeof(u32);
>>>>  	struct m10bmc_sec *sec = dev_get_drvdata(dev);
>>>>  	DECLARE_BITMAP(csk_map, CSK_BIT_LEN);
>>>>  	__le32 csk_le32[CSK_32ARRAY_SIZE];
>>>>  	u32 csk32[CSK_32ARRAY_SIZE];
>>>>  	int ret;
>>>>  
>>>> -	stride = regmap_get_reg_stride(sec->m10bmc->regmap);
>>>> -	if (size % stride) {
>>>> -		dev_err(sec->dev,
>>>> -			"CSK vector size (0x%x) not aligned to stride (0x%x)\n",
>>>> -			size, stride);
>>>> -		WARN_ON_ONCE(1);
>>>> -		return -EINVAL;
>>>> -	}
>>>> -
>>>> -	ret = regmap_bulk_read(sec->m10bmc->regmap, addr, csk_le32,
>>>> -			       size / stride);
>>>> +	ret = sec->m10bmc->flash_ops->read(sec->m10bmc, (u8 *)&csk_le32, addr, size);
>>>>  	if (ret) {
>>>> -		dev_err(sec->dev, "failed to read CSK vector: %x cnt %x: %d\n",
>>>> -			addr, size / stride, ret);
>>>> +		dev_err(sec->dev, "failed to read CSK vector\n");
>>>>  		return ret;
>>>>  	}
>>>>  
>>>> @@ -157,31 +141,21 @@ static ssize_t flash_count_show(struct device *dev,
>>>>  {
>>>>  	struct m10bmc_sec *sec = dev_get_drvdata(dev);
>>>>  	const struct m10bmc_csr_map *csr_map = sec->m10bmc->info->csr_map;
>>>> -	unsigned int stride, num_bits;
>>>> +	unsigned int num_bits;
>>>>  	u8 *flash_buf;
>>>>  	int cnt, ret;
>>>>  
>>>> -	stride = regmap_get_reg_stride(sec->m10bmc->regmap);
>>>>  	num_bits = FLASH_COUNT_SIZE * 8;
>>>>  
>>>> -	if (FLASH_COUNT_SIZE % stride) {
>>>> -		dev_err(sec->dev,
>>>> -			"FLASH_COUNT_SIZE (0x%x) not aligned to stride (0x%x)\n",
>>>> -			FLASH_COUNT_SIZE, stride);
>>>> -		WARN_ON_ONCE(1);
>>>> -		return -EINVAL;
>>>> -	}
>>>> -
>>>>  	flash_buf = kmalloc(FLASH_COUNT_SIZE, GFP_KERNEL);
>>>>  	if (!flash_buf)
>>>>  		return -ENOMEM;
>>>>  
>>>> -	ret = regmap_bulk_read(sec->m10bmc->regmap, csr_map->rsu_update_counter,
>>>> -			       flash_buf, FLASH_COUNT_SIZE / stride);
>>>> +	ret = sec->m10bmc->flash_ops->read(sec->m10bmc, flash_buf,
>>>> +					   csr_map->rsu_update_counter,
>>>> +					   FLASH_COUNT_SIZE);
>>>>  	if (ret) {
>>>> -		dev_err(sec->dev,
>>>> -			"failed to read flash count: %x cnt %x: %d\n",
>>>> -			csr_map->rsu_update_counter, FLASH_COUNT_SIZE / stride, ret);
>>>> +		dev_err(sec->dev, "failed to read flash count\n");
>>>>  		goto exit_free;
>>>>  	}
>>>>  	cnt = num_bits - bitmap_weight((unsigned long *)flash_buf, num_bits);
>>>> @@ -470,15 +444,14 @@ static enum fw_upload_err m10bmc_sec_write(struct fw_upload *fwl, const u8 *data
>>>>  {
>>>>  	struct m10bmc_sec *sec = fwl->dd_handle;
>>>>  	const struct m10bmc_csr_map *csr_map = sec->m10bmc->info->csr_map;
>>>> -	u32 blk_size, doorbell, extra_offset;
>>>> -	unsigned int stride, extra = 0;
>>>> +	struct intel_m10bmc *m10bmc = sec->m10bmc;
>>>> +	u32 blk_size, doorbell;
>>>>  	int ret;
>>>>  
>>>> -	stride = regmap_get_reg_stride(sec->m10bmc->regmap);
>>>>  	if (sec->cancel_request)
>>>>  		return rsu_cancel(sec);
>>>>  
>>>> -	ret = m10bmc_sys_read(sec->m10bmc, csr_map->doorbell, &doorbell);
>>>> +	ret = m10bmc_sys_read(m10bmc, csr_map->doorbell, &doorbell);
>>>>  	if (ret) {
>>>>  		return FW_UPLOAD_ERR_RW_ERROR;
>>>>  	} else if (rsu_prog(doorbell) != RSU_PROG_READY) {
>>>> @@ -486,28 +459,12 @@ static enum fw_upload_err m10bmc_sec_write(struct fw_upload *fwl, const u8 *data
>>>>  		return FW_UPLOAD_ERR_HW_ERROR;
>>>>  	}
>>>>  
>>>> -	WARN_ON_ONCE(WRITE_BLOCK_SIZE % stride);
>>>> +	WARN_ON_ONCE(WRITE_BLOCK_SIZE % regmap_get_reg_stride(m10bmc->regmap));
>>>>  	blk_size = min_t(u32, WRITE_BLOCK_SIZE, size);
>>>> -	ret = regmap_bulk_write(sec->m10bmc->regmap,
>>>> -				M10BMC_STAGING_BASE + offset,
>>>> -				(void *)data + offset,
>>>> -				blk_size / stride);
>>>> +	ret = m10bmc->flash_ops->write(m10bmc, data, offset, blk_size);
>>>>  	if (ret)
>>>>  		return FW_UPLOAD_ERR_RW_ERROR;
>>>>  
>>>> -	/*
>>>> -	 * If blk_size is not aligned to stride, then handle the extra
>>>> -	 * bytes with regmap_write.
>>>> -	 */
>>>> -	if (blk_size % stride) {
>>>> -		extra_offset = offset + ALIGN_DOWN(blk_size, stride);
>>>> -		memcpy(&extra, (u8 *)(data + extra_offset), blk_size % stride);
>>>> -		ret = regmap_write(sec->m10bmc->regmap,
>>>> -				   M10BMC_STAGING_BASE + extra_offset, extra);
>>>> -		if (ret)
>>>> -			return FW_UPLOAD_ERR_RW_ERROR;
>>>> -	}
>>>> -
>>>>  	*written = blk_size;
>>>>  	return FW_UPLOAD_ERR_NONE;
>>>>  }
>>>> diff --git a/drivers/mfd/intel-m10-bmc-spi.c b/drivers/mfd/intel-m10-bmc-spi.c
>>>> index e7b0b3b03186..e3b2edb8bc07 100644
>>>> --- a/drivers/mfd/intel-m10-bmc-spi.c
>>>> +++ b/drivers/mfd/intel-m10-bmc-spi.c
>>>> @@ -33,6 +33,57 @@ static struct regmap_config intel_m10bmc_regmap_config = {
>>>>  	.max_register = M10BMC_MEM_END,
>>>>  };
>>>>  
>>>> +static int m10bmc_spi_flash_write(struct intel_m10bmc *m10bmc, const u8 *buf, u32 offset, u32 size)
>>>> +{
>>>> +	unsigned int stride = regmap_get_reg_stride(m10bmc->regmap);
>>>> +	u32 leftover = size % stride;
>>>> +	u32 extra_offset, extra = 0;
>>>> +	int ret;
>>>> +
>>>> +	if (WARN_ON_ONCE(stride > sizeof(extra)))
>>>> +		return -EINVAL;
>>>> +
>>>> +	ret = regmap_bulk_write(m10bmc->regmap, M10BMC_STAGING_BASE + offset,
>>>> +				buf + offset, size / stride);
>>>> +	if (ret)
>>>> +		return ret;
>>>> +
>>>> +	/* If size is not aligned to stride, then handle the extra bytes with regmap_write */
>>>> +	if (leftover) {
>>>> +		extra_offset = offset + ALIGN_DOWN(size, stride);
>>>> +		memcpy(&extra, (u8 *)(buf + extra_offset), leftover);
>>>> +
>>>> +		ret = regmap_write(m10bmc->regmap, M10BMC_STAGING_BASE + extra_offset, extra);
>>>> +		if (ret)
>>>> +			return ret;
>>>> +	}
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +static int m10bmc_spi_flash_read(struct intel_m10bmc *m10bmc, u8 *buf, u32 addr, u32 size)
>>>> +{
>>>> +	unsigned int stride = regmap_get_reg_stride(m10bmc->regmap);
>>>> +	int ret;
>>>> +
>>>> +	if (WARN_ON_ONCE(size % stride)) {
>>>> +		dev_err(m10bmc->dev, "read size (0x%x) not aligned to stride (0x%x)\n",
>>>> +			size, stride);
>>> Why read should be aligned to stride but write doesn't have to? It's odd that
>>> same amount of data could be written into flash but can't be read back.
>> I'll see what needs to be done with this before resubmitting.
>>
>>>> +		return -EINVAL;
>>>> +	}
>>>> +
>>>> +	ret = regmap_bulk_read(m10bmc->regmap, addr, buf, size / stride);
>>>> +	if (ret)
>>>> +		dev_err(m10bmc->dev, "failed to read flash block data: %x cnt %x: %d\n",
>>>> +			addr, size / stride, ret);
>>>> +	return ret;
>>>> +}
>>>> +
>>>> +static const struct intel_m10bmc_flash_ops m10bmc_spi_flash_ops = {
>>>> +	.read = m10bmc_spi_flash_read,
>>>> +	.write = m10bmc_spi_flash_write,
>>>> +};
>>> Is the flash ops used in other devices? For now, I see it's specific for
>>> sec-update dev. So why not implement it in sec-update driver?
>> Are you suggesting the sec-update driver should implement a similar split 
>> per interface type (SPI/PMCI) as the mfd/bmc one currently does? ...While 
>> doable, it seems a bit overkill to have that kind of double split.
> My preference is, try best not to impact MFD driver if a subdev IP is internally
> changed. For FPGA/CPLD, IP change happens normally. Till now, I see the flash
> area is dedicated for sec-update dev. So the direct operations for related
> HW ioaddrs had better be handled by sec-update driver. In case the layout
> of these HW IO is changed, no need to change the MFD driver.
>
> And the PMCI provides an accelerated channel for flash area instead of
> direct access. It's OK for PMCI MFD driver to implement the acceleration
> access callbacks, but it is still the sec-update driver's responsibility
> to decide whether to use it for flash area access.

Actually, the FIFO interface to the FLASH is the _only_ access path to the
the FLASH for the PMCI connected BMC. From the perspective of the secure
update driver, it not a question of choosing the accelerated path or
the non-accelerated path; it is a question a PMCI BMC connection vs a SPI
BMC connection.

If we move these functions into the secure update driver, then we need
to move the SPI version of these functions into the secure update driver
as well and add conditionals based on device type, right? IMHO, it seems
cleaner to split it out they way it is here - less clutter in the secure
update driver, and the PMCI related functions are not even present if the
PMCI driver is not needed/installed.

- Russ

>
> I don't have a solid idea how to implement the accelerated access, maybe
> some callback in MFD driver, or leverage regmap_bus.write/gather_write?
>
> I also have concern about accessing M10BMC_PMCI_FLASH_CTRL in MFD
> driver, if this register is also dedicated for sec-update.
>
> Thanks,
> Yilun
>
>> -- 
>>  i.
>>
>>>>  static int check_m10bmc_version(struct intel_m10bmc *ddata)
>>>>  {
>>>>  	unsigned int v;
>>>> @@ -72,6 +123,7 @@ static int intel_m10_bmc_spi_probe(struct spi_device *spi)
>>>>  
>>>>  	info = (struct intel_m10bmc_platform_info *)id->driver_data;
>>>>  	ddata->dev = dev;
>>>> +	ddata->flash_ops = &m10bmc_spi_flash_ops;
>>>>  
>>>>  	ddata->regmap = devm_regmap_init_spi_avmm(spi, &intel_m10bmc_regmap_config);
>>>>  	if (IS_ERR(ddata->regmap)) {
>>>> diff --git a/include/linux/mfd/intel-m10-bmc.h b/include/linux/mfd/intel-m10-bmc.h
>>>> index d752c0d7cbdb..860408aa8db3 100644
>>>> --- a/include/linux/mfd/intel-m10-bmc.h
>>>> +++ b/include/linux/mfd/intel-m10-bmc.h
>>>> @@ -161,16 +161,30 @@ struct intel_m10bmc_platform_info {
>>>>  	const struct m10bmc_csr_map *csr_map;
>>>>  };
>>>>  
>>>> +struct intel_m10bmc;
>>>> +
>>>> +/**
>>>> + * struct intel_m10bmc_flash_ops - device specific operations for flash R/W
>>>> + * @read: read a block of data from flash
>>>> + * @write: write a block of data to flash
>>>> + */
>>>> +struct intel_m10bmc_flash_ops {
>>>> +	int (*read)(struct intel_m10bmc *m10bmc, u8 *buf, u32 addr, u32 size);
>>>> +	int (*write)(struct intel_m10bmc *m10bmc, const u8 *buf, u32 offset, u32 size);
>>>> +};
>>>> +
>>>>  /**
>>>>   * struct intel_m10bmc - Intel MAX 10 BMC parent driver data structure
>>>>   * @dev: this device
>>>>   * @regmap: the regmap used to access registers by m10bmc itself
>>>>   * @info: the platform information for MAX10 BMC
>>>> + * @flash_ops: optional device specific operations for flash R/W
>>>>   */
>>>>  struct intel_m10bmc {
>>>>  	struct device *dev;
>>>>  	struct regmap *regmap;
>>>>  	const struct intel_m10bmc_platform_info *info;
>>>> +	const struct intel_m10bmc_flash_ops *flash_ops;
>>> Same concern, maybe implement it in sec-update driver?

