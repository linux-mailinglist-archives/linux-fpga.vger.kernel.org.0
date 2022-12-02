Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E23A640C2F
	for <lists+linux-fpga@lfdr.de>; Fri,  2 Dec 2022 18:31:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233510AbiLBRaG (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 2 Dec 2022 12:30:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232519AbiLBRaF (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 2 Dec 2022 12:30:05 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3566C205;
        Fri,  2 Dec 2022 09:30:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670002204; x=1701538204;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dSKaEkNej5+TQEcnxfvpJzrDJXOuOe7VzZEW6/6Olq8=;
  b=UWEB/xoEVVrIMxSHZtBW+4AzLCfJmediBZ0ohjvJdYpiDf111iPRr4G5
   gfX9HMZ/EAmEVz+IH3Js81T1OaTetLU2zzhCXwYBdiFdjg2EAQscJm540
   m2KAhwKYQLmQg4iqo1Q6kNqX+vgki0vizqy6Qx+hlpOSuxdzAWwIQotWB
   EB17VhPzxJg2VGiGpjYLWquGGEubKzkQK1bflf4FS/aTEpfXidL5ewp0e
   aZPkpnsT+bySp2scdja6X2W5p1Qr/z7PJH25uHAxH2+EZAaaFUduD4uri
   upzhldUhJoqMxjaA7x/J4JIk09ToFKlRiPi/lq8FTaI6CYlDYzPNmGaC/
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="314708344"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="314708344"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 09:30:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="708553186"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="708553186"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga008.fm.intel.com with ESMTP; 02 Dec 2022 09:30:03 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 2 Dec 2022 09:30:03 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 2 Dec 2022 09:30:03 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 2 Dec 2022 09:30:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PdrYmWSwwC/m5ZAOcIDpg2UGV1d4iIi9hzjmgWRubsjLu1sv9z3im7By0z2LBgt67ugjuD8KR6zphBSnhcW/6SMjyTarFg930qkoE7IBolg454W4e4iQpYN5YAzj4vGiqMMGUmGO9rnwtNkUdTLvhaWl/lDzeCsQspdGEmaVQn7mGEUgB0b/WUbgTgfh1WbVO2epjyGwDQkglnhY+AWFxLpUHkrfYFK7cjuL4r1KywiKOKIHUWuXg7Wj67q7MomiMahtys/lwI7BEe3+gv6TV/KT5GmP3voyWAbl+0KX9gxAjjeWVLZlFq4T7fm7QMsYlD7FZC36nH++tgiOFOjEeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X//hHs4VdYP5oa1GKufERbixnRKiQ7lF3PnmC0YsirE=;
 b=J55uuoJ1vKBXXBjO6HvZpbPYWPONy9Sn1Wu/d/fDIdO/Hy/ttpHOUspPAj8BhBs/TgK5GHsixUv6q2dNRNZE+rW+3o16sgIYj01pe0mddyIGcZDzaWcCmTwY98VYi5JvvI/YvK9mXBjk7Mis6qlurp6LRJlkqDeNMfaV+uBBV9Yc3nACIDIojKrR9K20ag9UQyxxz9kIbEvG2lkjuNPoYCmfDrFl9jvu8yeCX9iQSjnkvk5MwbcoiFAeg5NJ16DGYIJGvkj9uLBFgVC2zXxRU6gGOmpWt/NNaLvhLNTxH5U/ziEDekwIWKQaVlbi8SEyRvnGfD0txCS+yG8jczWBWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM5PR11MB1899.namprd11.prod.outlook.com (2603:10b6:3:10b::14)
 by BL3PR11MB6364.namprd11.prod.outlook.com (2603:10b6:208:3b7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Fri, 2 Dec
 2022 17:29:58 +0000
Received: from DM5PR11MB1899.namprd11.prod.outlook.com
 ([fe80::eead:b901:ac48:7680]) by DM5PR11MB1899.namprd11.prod.outlook.com
 ([fe80::eead:b901:ac48:7680%9]) with mapi id 15.20.5857.023; Fri, 2 Dec 2022
 17:29:58 +0000
Message-ID: <2b253321-72ff-f15a-8879-aa41dce48055@intel.com>
Date:   Fri, 2 Dec 2022 09:29:53 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v3 6/9] mfd: intel-m10-bmc: Downscope SPI defines & prefix
 with M10BMC_SPI
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
        Marco Pagani <marpagan@redhat.com>,
        <linux-kernel@vger.kernel.org>
References: <20221202100841.4741-1-ilpo.jarvinen@linux.intel.com>
 <20221202100841.4741-7-ilpo.jarvinen@linux.intel.com>
 <Y4onmwWT8duVV0Sv@yilunxu-OptiPlex-7050>
From:   Russ Weight <russell.h.weight@intel.com>
In-Reply-To: <Y4onmwWT8duVV0Sv@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0051.namprd04.prod.outlook.com
 (2603:10b6:303:6a::26) To DM5PR11MB1899.namprd11.prod.outlook.com
 (2603:10b6:3:10b::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR11MB1899:EE_|BL3PR11MB6364:EE_
X-MS-Office365-Filtering-Correlation-Id: 964abfc4-9087-4f7e-f8fc-08dad48ad5da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wkEjvchwXVj2IFiRen+Qaq1rhX6WkhOFJ2dh/S1zGtgBmw7Kp5PsU89UCDICKrwfqm7xDGf/xjSnTbnlYuBvkiCujQW99p1CdFXEpkqTjabZSBDhhKdvSFq+VD+In3jg6cEuvBcmdLlegIKIZUCyMZxCH4iM7L9ibZ1gyHPgzhVpErVdiPt++Z7LYFDvduHKHZWfOASQU1ajF8u+VK/KAuC7nC4HWhOxrSO/X+WXeayUSQE2B/qPi/2EaDCIdBIbNmGx6h6yhpH4Qx6ndbF+euTiTuhPSWxGUERfc29r84ogWtC4ptB6oI/kEKQsYibYLeV0AEN4om8Ugvk0bhVMEcXUPsK6Uv9c1ZjiYWDqo0gFW8Qs8nPD2zmj0miCY/ZGh9FpuURoTadTuRddSARPYGQMM5RSRxH5hm7oPZwjiRUQlA2DzjeLfMGNBasw4jQdK4QXVqPXS3/abdSTkeWJR5KnSUZhLNbAHEIzGVyJY6LlyZRBRaI5JxKv8b6ON5SZlMUaysWe+MXX5C0LGIp3Te/yh1YIHBmTD0C9JhYlk6hpG+rKIHw/74HGCkEmSrRKYlFoxdM5OPnI0MYpF8kAYgGtGUJ4F3kdI59vnfluOwrh9CK8nHdW+7FbkDUhbw9TRv6l1I3VLlRXVxvv3jhdXpBN9iFPpUf/ivUigfOX9RxvuuYT7Cy7uRqqxQVLvl0nGGdaX/P7uaSKndONusNy1JeetI3Nn5sbxL/kOMzHp3o8DC2DyAT+5EcAlwkP/7is
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR11MB1899.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(376002)(366004)(136003)(346002)(39860400002)(451199015)(7416002)(478600001)(31686004)(6666004)(82960400001)(6486002)(38100700002)(5660300002)(186003)(53546011)(8936002)(66574015)(110136005)(54906003)(6512007)(316002)(26005)(66946007)(83380400001)(36756003)(2906002)(2616005)(6506007)(86362001)(8676002)(66556008)(4326008)(31696002)(66476007)(41300700001)(21314003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c2hza2Znb2IxR2hVaU9zNTlndWFYcTR6YVNLTlZSUVJZeXh2N3pHTmY3Q05y?=
 =?utf-8?B?eVExZjFCQ1hDajhsNXk2aERFNkZqajI4ZWxtVkhRUmVGMVlPa0Q2WWs5azlU?=
 =?utf-8?B?K2VGSXF4TmppSUVBV05yaTZndFhNSGZjRjZsci9sRzZmcUlBM2crdHZmcUU3?=
 =?utf-8?B?Z2o5aDJkVzNRQjdQME1DcVBrNXFsc2lWaDNwZnNNeUU4cm9EWlVucUZBcWtH?=
 =?utf-8?B?UnFZbUtYREVMT05nSTJwZ2tXTVNTOUk2MXZRVHBGT1ZrekVVWnZuV2dmRmxQ?=
 =?utf-8?B?UWkxdWU4L0Y4ZUwzcEYxSnhTVDd3YlFDK2JCbHlCbEpWNGt1dUtIWHpJTE5o?=
 =?utf-8?B?WjU3NFEvRnZtRUhQN3dadlRkZFEvOTdqZERzNXUvRjVMZ3BkVmtQckU3alZv?=
 =?utf-8?B?Q2ZqUWYzRjF0WmI0SnNubGNiYmpPbURIR25UNGI3SWlqcDBLMW9vaGVHczBG?=
 =?utf-8?B?TUxOY0t2dDR1cXE0Ri9ib2J0NWJyRVRTbkVIelBoR1pObkV5N2t0MU9VenVm?=
 =?utf-8?B?ZEFhYXZEdFUvVE9NWTV1UUZEKzZwTWxWa3E1RWRuK3JLWjMrZWkrN1l5aEsr?=
 =?utf-8?B?R0JIK2R2SUhvUEFIQkxqb05iaFQwVkU4MTJGY0hYRy9LTHo5L2VoSTFkRGtJ?=
 =?utf-8?B?TEtwSG95LzM3aVFpUi8zMWVVanEzb1Qydkd4VmRha05Mekx6Z2grQUFxQzFJ?=
 =?utf-8?B?aGNJc2cwL3pFTExxK1V4eE1wVXV1N2JscEZVQnNScFVtMkVqcm1mWm40U1U2?=
 =?utf-8?B?cEk4aG9qbWkrWStvQUNCRWI2R3kvNEt3Ymo4YzRTNmFoL1d3cFprNERMMlBW?=
 =?utf-8?B?Ti9MNTBxU1FSZHovaldjRGNFWjVndWtFN0lRUmRCZFlRUHlybHM1TkxTWHkr?=
 =?utf-8?B?b0dZUndWMnNqcmtzZXg4YTlmMzQrNzl4MTRRQlRyVTNRbUV5TkZreDdoMTJy?=
 =?utf-8?B?TmJ6OUt6SXBDWm43SUwrMlNKU0lRdDg2QTBtSlE4TzFOVU1ZSU9pQ09VTm83?=
 =?utf-8?B?RWZ5bXFjOVpVUTN6eWpZak1sbmZNVDRocmhzK1BYSzh5Q3RscFZLRk1jMTht?=
 =?utf-8?B?U0RWTVRQdERiejU2TXRTZDJvMkdqaFNzWkhEMlZnUDV1T3NIV1FpM1ZMTXYz?=
 =?utf-8?B?ZEllSk52cXlDSVVzZCsrcDdFUCtWeXBiV0FDS25ESE1LVFlrNXJNTVlTenh2?=
 =?utf-8?B?c0E0b2orV2lzczIxL3dFeEdmS25iOVZmVU52UDFXMTZNVHNsdzlwRXNMelFX?=
 =?utf-8?B?K3JrelU1bDJVV2lUdjNYWnJtMm54VHNIQ1RtT0ZlTzJoUTZuOFdPY3o2Ym91?=
 =?utf-8?B?Um40OVRMMGY4T3NuNlp6aWhWaHNKMmZ0QVNnd0ZCelYwREtzQkt3dGE1MnV3?=
 =?utf-8?B?V042ZXptYTBRMWRtWU9uOTIwdCtrTExwNWx0cGNoVXBReGs3ZkxFdWF6WDJD?=
 =?utf-8?B?S0prZ05paC82MktldkZvZEhOdUtndk95b3RyUDBTQlZVSElzT012V09raVI5?=
 =?utf-8?B?ekZsNFpEc3JBRjBEQm9RcHlmbmZvSk8zUEZSMkduWjA1cmsydng1SUY4MWlz?=
 =?utf-8?B?SDNBOTVaSlpjWmFNcDNDUlNhd1o5YUxmWHJadU9iN0ExZTBCdWY2UWwrSFZh?=
 =?utf-8?B?TWdLWDlnV3g0eWlMOTZidFUvSVByczh5cTdPRkN3emNoK25WVjNWMFUxeGpi?=
 =?utf-8?B?MTlGRmNqcEJaU29nQjNVVllDSStaYUhuUUV4L0hjSmR1K3VFQ1orcWI3RGw2?=
 =?utf-8?B?LytwSHJjcGRWNllENi9ISzB3S2loR0VqbnI5QS9JM0hGLy9SVVM1NVhtSGtX?=
 =?utf-8?B?WE9UUUloakkxM2laV2picVVuYlRqUnUrcTY5VXBRdHRITUR5cC84SDBJSGJ0?=
 =?utf-8?B?ZXhFemFLTXd5bUhDRnlrRG1WOUxaQ3ZhSnBtNHYwMitMdlNwN0MvdVBzejA5?=
 =?utf-8?B?UjhnMFpneXMwYXQ0Qk5WN1RnRDBUVmQxTmtybHNFSm9WcjhxSjRzL2x5SWQw?=
 =?utf-8?B?UXUxdlJ0empxKzkyQTFSeFpHajZZemZibitISEtnbVNJUHpkUWtGa05EK2dR?=
 =?utf-8?B?bzhBQ1RqQ1kyejJQcytoSUhWamN5cEFIaGdXVDRndVN0dDg5ZHdrSXBtbkUy?=
 =?utf-8?B?ZlROdUdTVDNNT2swT2NjRVVwcFpOOVFRREZrQWN4UnpBR1dOVFExRnRGcngx?=
 =?utf-8?B?eXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 964abfc4-9087-4f7e-f8fc-08dad48ad5da
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1899.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2022 17:29:58.6850
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VyomkGFTO2VkCRXmo1m2Rolt2MBY2rfZNzTGxoW1tH0ZIeaeVpCHoJzOXhqZoPwjfBbYwx4+mw0TRSkv44Wrp1J+LiLDEchoW0tg8NM3270=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6364
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On 12/2/22 08:28, Xu Yilun wrote:
> On 2022-12-02 at 12:08:38 +0200, Ilpo Järvinen wrote:
>> Move SPI based board definitions to per interface file from the global
>> header. This makes it harder to use them accidently in the
>> generic/interface agnostic code. Prefix the defines with M10BMC_SPI
> I'm not sure if the register layout is actually bound to the bus
> interface. My experience is the register layout is always decided by
> board type. Is it possible there will be a new SPI based board but
> has different register layout in future?
>
> So is M10BMC_SPI_XXX a good nam

There could be future devices, spi or pmci based, that require different
addresses for some of these values, and at that time we would need to
additional versions of some of these macros using different names.
Right now, spi and pmci are the primary differentiating factors. I'm not
sure how to improve on the naming. Do you have any suggestions?

- Russ

>
> The same concern for PMCI in patch #7.
>
> Thanks,
> Yilun
>
>> to make it more obvious these are related to SPI only.
>>
>> Some bitfield defs are also moved to intel-m10-bmc-core which seems
>> more appropriate for them.
>>
>> Reviewed-by: Russ Weight <russell.h.weight@intel.com>
>> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
>> ---
>>  drivers/mfd/intel-m10-bmc-core.c  | 11 ++++
>>  drivers/mfd/intel-m10-bmc-spi.c   | 87 ++++++++++++++++++++++---------
>>  include/linux/mfd/intel-m10-bmc.h | 46 ----------------
>>  3 files changed, 73 insertions(+), 71 deletions(-)
>>
>> diff --git a/drivers/mfd/intel-m10-bmc-core.c b/drivers/mfd/intel-m10-bmc-core.c
>> index 51b78b868235..50a4ec758bdb 100644
>> --- a/drivers/mfd/intel-m10-bmc-core.c
>> +++ b/drivers/mfd/intel-m10-bmc-core.c
>> @@ -12,6 +12,17 @@
>>  #include <linux/mfd/intel-m10-bmc.h>
>>  #include <linux/module.h>
>>  
>> +/* Register fields of system registers */
>> +#define M10BMC_MAC_BYTE4		GENMASK(7, 0)
>> +#define M10BMC_MAC_BYTE3		GENMASK(15, 8)
>> +#define M10BMC_MAC_BYTE2		GENMASK(23, 16)
>> +#define M10BMC_MAC_BYTE1		GENMASK(31, 24)
>> +#define M10BMC_MAC_BYTE6		GENMASK(7, 0)
>> +#define M10BMC_MAC_BYTE5		GENMASK(15, 8)
>> +#define M10BMC_MAC_COUNT		GENMASK(23, 16)
>> +#define M10BMC_VER_MAJOR_MSK		GENMASK(23, 16)
>> +#define M10BMC_VER_PCB_INFO_MSK		GENMASK(31, 24)
>> +
>>  static ssize_t bmc_version_show(struct device *dev,
>>  				struct device_attribute *attr, char *buf)
>>  {
>> diff --git a/drivers/mfd/intel-m10-bmc-spi.c b/drivers/mfd/intel-m10-bmc-spi.c
>> index 611a4ab42717..e99fe7c43314 100644
>> --- a/drivers/mfd/intel-m10-bmc-spi.c
>> +++ b/drivers/mfd/intel-m10-bmc-spi.c
>> @@ -13,10 +13,47 @@
>>  #include <linux/regmap.h>
>>  #include <linux/spi/spi.h>
>>  
>> +#define M10BMC_SPI_LEGACY_BUILD_VER	0x300468
>> +#define M10BMC_SPI_SYS_BASE		0x300800
>> +#define M10BMC_SPI_SYS_END		0x300fff
>> +#define M10BMC_SPI_FLASH_BASE		0x10000000
>> +#define M10BMC_SPI_FLASH_END		0x1fffffff
>> +#define M10BMC_SPI_MEM_END		M10BMC_SPI_FLASH_END
>> +
>> +/* Register offset of system registers */
>> +#define NIOS2_FW_VERSION		0x0
>> +#define M10BMC_SPI_MAC_LOW		0x10
>> +#define M10BMC_SPI_MAC_HIGH		0x14
>> +#define M10BMC_SPI_TEST_REG		0x3c
>> +#define M10BMC_SPI_BUILD_VER		0x68
>> +#define M10BMC_SPI_VER_LEGACY_INVALID	0xffffffff
>> +
>> +/* Secure update doorbell register, in system register region */
>> +#define M10BMC_SPI_DOORBELL		0x400
>> +
>> +/* Authorization Result register, in system register region */
>> +#define M10BMC_SPI_AUTH_RESULT		0x404
>> +
>> +/* Addresses for security related data in FLASH */
>> +#define M10BMC_SPI_BMC_REH_ADDR		0x17ffc004
>> +#define M10BMC_SPI_BMC_PROG_ADDR	0x17ffc000
>> +#define M10BMC_SPI_BMC_PROG_MAGIC	0x5746
>> +
>> +#define M10BMC_SPI_SR_REH_ADDR		0x17ffd004
>> +#define M10BMC_SPI_SR_PROG_ADDR		0x17ffd000
>> +#define M10BMC_SPI_SR_PROG_MAGIC	0x5253
>> +
>> +#define M10BMC_SPI_PR_REH_ADDR		0x17ffe004
>> +#define M10BMC_SPI_PR_PROG_ADDR		0x17ffe000
>> +#define M10BMC_SPI_PR_PROG_MAGIC	0x5250
>> +
>> +/* Address of 4KB inverted bit vector containing staging area FLASH count */
>> +#define M10BMC_SPI_STAGING_FLASH_COUNT	0x17ffb000
>> +
>>  static const struct regmap_range m10bmc_regmap_range[] = {
>> -	regmap_reg_range(M10BMC_LEGACY_BUILD_VER, M10BMC_LEGACY_BUILD_VER),
>> -	regmap_reg_range(M10BMC_SYS_BASE, M10BMC_SYS_END),
>> -	regmap_reg_range(M10BMC_FLASH_BASE, M10BMC_FLASH_END),
>> +	regmap_reg_range(M10BMC_SPI_LEGACY_BUILD_VER, M10BMC_SPI_LEGACY_BUILD_VER),
>> +	regmap_reg_range(M10BMC_SPI_SYS_BASE, M10BMC_SPI_SYS_END),
>> +	regmap_reg_range(M10BMC_SPI_FLASH_BASE, M10BMC_SPI_FLASH_END),
>>  };
>>  
>>  static const struct regmap_access_table m10bmc_access_table = {
>> @@ -30,7 +67,7 @@ static struct regmap_config intel_m10bmc_regmap_config = {
>>  	.reg_stride = 4,
>>  	.wr_table = &m10bmc_access_table,
>>  	.rd_table = &m10bmc_access_table,
>> -	.max_register = M10BMC_MEM_END,
>> +	.max_register = M10BMC_SPI_MEM_END,
>>  };
>>  
>>  static int check_m10bmc_version(struct intel_m10bmc *ddata)
>> @@ -41,16 +78,16 @@ static int check_m10bmc_version(struct intel_m10bmc *ddata)
>>  	/*
>>  	 * This check is to filter out the very old legacy BMC versions. In the
>>  	 * old BMC chips, the BMC version info is stored in the old version
>> -	 * register (M10BMC_LEGACY_BUILD_VER), so its read out value would have
>> -	 * not been M10BMC_VER_LEGACY_INVALID (0xffffffff). But in new BMC
>> +	 * register (M10BMC_SPI_LEGACY_BUILD_VER), so its read out value would have
>> +	 * not been M10BMC_SPI_VER_LEGACY_INVALID (0xffffffff). But in new BMC
>>  	 * chips that the driver supports, the value of this register should be
>> -	 * M10BMC_VER_LEGACY_INVALID.
>> +	 * M10BMC_SPI_VER_LEGACY_INVALID.
>>  	 */
>> -	ret = m10bmc_raw_read(ddata, M10BMC_LEGACY_BUILD_VER, &v);
>> +	ret = m10bmc_raw_read(ddata, M10BMC_SPI_LEGACY_BUILD_VER, &v);
>>  	if (ret)
>>  		return -ENODEV;
>>  
>> -	if (v != M10BMC_VER_LEGACY_INVALID) {
>> +	if (v != M10BMC_SPI_VER_LEGACY_INVALID) {
>>  		dev_err(ddata->dev, "bad version M10BMC detected\n");
>>  		return -ENODEV;
>>  	}
>> @@ -92,23 +129,23 @@ static int intel_m10_bmc_spi_probe(struct spi_device *spi)
>>  }
>>  
>>  static const struct m10bmc_csr_map m10bmc_spi_csr_map = {
>> -	.base = M10BMC_SYS_BASE,
>> -	.build_version = M10BMC_BUILD_VER,
>> +	.base = M10BMC_SPI_SYS_BASE,
>> +	.build_version = M10BMC_SPI_BUILD_VER,
>>  	.fw_version = NIOS2_FW_VERSION,
>> -	.mac_low = M10BMC_MAC_LOW,
>> -	.mac_high = M10BMC_MAC_HIGH,
>> -	.doorbell = M10BMC_DOORBELL,
>> -	.auth_result = M10BMC_AUTH_RESULT,
>> -	.bmc_prog_addr = BMC_PROG_ADDR,
>> -	.bmc_reh_addr = BMC_REH_ADDR,
>> -	.bmc_magic = BMC_PROG_MAGIC,
>> -	.sr_prog_addr = SR_PROG_ADDR,
>> -	.sr_reh_addr = SR_REH_ADDR,
>> -	.sr_magic = SR_PROG_MAGIC,
>> -	.pr_prog_addr = PR_PROG_ADDR,
>> -	.pr_reh_addr = PR_REH_ADDR,
>> -	.pr_magic = PR_PROG_MAGIC,
>> -	.rsu_update_counter = STAGING_FLASH_COUNT,
>> +	.mac_low = M10BMC_SPI_MAC_LOW,
>> +	.mac_high = M10BMC_SPI_MAC_HIGH,
>> +	.doorbell = M10BMC_SPI_DOORBELL,
>> +	.auth_result = M10BMC_SPI_AUTH_RESULT,
>> +	.bmc_prog_addr = M10BMC_SPI_BMC_PROG_ADDR,
>> +	.bmc_reh_addr = M10BMC_SPI_BMC_REH_ADDR,
>> +	.bmc_magic = M10BMC_SPI_BMC_PROG_MAGIC,
>> +	.sr_prog_addr = M10BMC_SPI_SR_PROG_ADDR,
>> +	.sr_reh_addr = M10BMC_SPI_SR_REH_ADDR,
>> +	.sr_magic = M10BMC_SPI_SR_PROG_MAGIC,
>> +	.pr_prog_addr = M10BMC_SPI_PR_PROG_ADDR,
>> +	.pr_reh_addr = M10BMC_SPI_PR_REH_ADDR,
>> +	.pr_magic = M10BMC_SPI_PR_PROG_MAGIC,
>> +	.rsu_update_counter = M10BMC_SPI_STAGING_FLASH_COUNT,
>>  };
>>  
>>  static struct mfd_cell m10bmc_d5005_subdevs[] = {
>> diff --git a/include/linux/mfd/intel-m10-bmc.h b/include/linux/mfd/intel-m10-bmc.h
>> index 91567375f1bf..71ace732bb48 100644
>> --- a/include/linux/mfd/intel-m10-bmc.h
>> +++ b/include/linux/mfd/intel-m10-bmc.h
>> @@ -9,39 +9,9 @@
>>  
>>  #include <linux/regmap.h>
>>  
>> -#define M10BMC_LEGACY_BUILD_VER		0x300468
>> -#define M10BMC_SYS_BASE			0x300800
>> -#define M10BMC_SYS_END			0x300fff
>> -#define M10BMC_FLASH_BASE		0x10000000
>> -#define M10BMC_FLASH_END		0x1fffffff
>> -#define M10BMC_MEM_END			M10BMC_FLASH_END
>> -
>>  #define M10BMC_STAGING_BASE		0x18000000
>>  #define M10BMC_STAGING_SIZE		0x3800000
>>  
>> -/* Register offset of system registers */
>> -#define NIOS2_FW_VERSION		0x0
>> -#define M10BMC_MAC_LOW			0x10
>> -#define M10BMC_MAC_BYTE4		GENMASK(7, 0)
>> -#define M10BMC_MAC_BYTE3		GENMASK(15, 8)
>> -#define M10BMC_MAC_BYTE2		GENMASK(23, 16)
>> -#define M10BMC_MAC_BYTE1		GENMASK(31, 24)
>> -#define M10BMC_MAC_HIGH			0x14
>> -#define M10BMC_MAC_BYTE6		GENMASK(7, 0)
>> -#define M10BMC_MAC_BYTE5		GENMASK(15, 8)
>> -#define M10BMC_MAC_COUNT		GENMASK(23, 16)
>> -#define M10BMC_TEST_REG			0x3c
>> -#define M10BMC_BUILD_VER		0x68
>> -#define M10BMC_VER_MAJOR_MSK		GENMASK(23, 16)
>> -#define M10BMC_VER_PCB_INFO_MSK		GENMASK(31, 24)
>> -#define M10BMC_VER_LEGACY_INVALID	0xffffffff
>> -
>> -/* Secure update doorbell register, in system register region */
>> -#define M10BMC_DOORBELL			0x400
>> -
>> -/* Authorization Result register, in system register region */
>> -#define M10BMC_AUTH_RESULT		0x404
>> -
>>  /* Doorbell register fields */
>>  #define DRBL_RSU_REQUEST		BIT(0)
>>  #define DRBL_RSU_PROGRESS		GENMASK(7, 4)
>> @@ -102,22 +72,6 @@
>>  #define RSU_COMPLETE_INTERVAL_MS	1000
>>  #define RSU_COMPLETE_TIMEOUT_MS		(40 * 60 * 1000)
>>  
>> -/* Addresses for security related data in FLASH */
>> -#define BMC_REH_ADDR	0x17ffc004
>> -#define BMC_PROG_ADDR	0x17ffc000
>> -#define BMC_PROG_MAGIC	0x5746
>> -
>> -#define SR_REH_ADDR	0x17ffd004
>> -#define SR_PROG_ADDR	0x17ffd000
>> -#define SR_PROG_MAGIC	0x5253
>> -
>> -#define PR_REH_ADDR	0x17ffe004
>> -#define PR_PROG_ADDR	0x17ffe000
>> -#define PR_PROG_MAGIC	0x5250
>> -
>> -/* Address of 4KB inverted bit vector containing staging area FLASH count */
>> -#define STAGING_FLASH_COUNT	0x17ffb000
>> -
>>  /**
>>   * struct m10bmc_csr_map - Intel MAX 10 BMC CSR register map
>>   */
>> -- 
>> 2.30.2
>>

