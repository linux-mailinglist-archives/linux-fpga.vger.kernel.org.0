Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC80D66E3F3
	for <lists+linux-fpga@lfdr.de>; Tue, 17 Jan 2023 17:45:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbjAQQnx (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 17 Jan 2023 11:43:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233208AbjAQQnS (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 17 Jan 2023 11:43:18 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA031F741;
        Tue, 17 Jan 2023 08:43:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673973798; x=1705509798;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=HPhV+XPjOtkGB6qweuWoxejZakGoCkFtkIEUNDopgEA=;
  b=CieMnESXrdXNZ2wyijV7a99nHif5oseaNQCJvKFgQTPpHiwxPEe+mdVi
   TKCW1+2cYRdmYN8Xy/RLcmB7nJ4+QT1/tz2ZEUoPGedeVGZUGE3RXlODZ
   HGHr+kSUrME+56o9h50KGGOPYOX2pSec1YrxSfZz2FJEexPTpbU32wzwl
   GKzp6E4QatYOaeBv2uGOMvut4Urq3LdC2WGhiaHek11TDLiXLyXWBU2VI
   /0pHrj7sq/MJDyg7uTPdORtTMxKs54WHZT7UkcdZCAGs1bd30BZNHD2UJ
   QfPn+gZpgfvNEbb/LBrUsFzekASZgDDjIP+ns3t0ZhjutqI1Gry4rhxxF
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="326819429"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="326819429"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2023 08:43:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="659437248"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="659437248"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga002.jf.intel.com with ESMTP; 17 Jan 2023 08:43:16 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 17 Jan 2023 08:43:16 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 17 Jan 2023 08:43:16 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.106)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 17 Jan 2023 08:43:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mqJMZ+VmAZ6jiiK77WFjq6A6GTZFGH/mc5Wh7Eo9plwDIWb+eV4pIyUgFGAzX704TP3T6xbMppQjWxcPdyQP/NdICS4YSdFS7M8mJ5cFpSAxh2srtqHlI/U5Kz/M+i4ceKlnfamL7suB/kOVyhvs7VSEmYcJFdKsVzDmt+zrHNAUJTsUkvuCcbwz2uJd5W1wcUXRBXFSfPTJXBXSfDV51Q4jwFmrDmPXP/Eht8+amCLRR/jAvUG4tRMO/0G3+CjJdLpTil4tLrE+yuiswpe5deErId52KyE5ioArYc1P+JTLNHXWLmC5kxNnlGpI8yXbsCmyh8zGNJyMnu6abxGEkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dpKS/m3kWSWJZQaWGBLclXLzUBefLdDvKSy38eyOL8U=;
 b=dr6of/cGexG/dJ5HKbvfQbC3sb5IYNvfkwvrwpW8vxy+7oH8N8v1D+N7v/IlyNG+JuZlDSfwciDmK1cwsfGjqnEbPS2Ui+qG0TwskAqvD7q/plbPcI4d5tsRbTwwXKLJ2wZ29wS2cmcIhmvnTCwsU64cnQn7GCAPzOTvgbs7dNYT+KgIB819lD3h82HNP+Afr3YexE3/eukLswISaC3cXs6NUAZ8FWP9DG/ERzcLuDlGVb7SoopiaGV68U5Aih1fUc0IrrDrlLM8WQo/N99wC1WeXeHeaMaKOUczHWUhyIYow9SHm0X7p6W7O9ybq8zC/vDjHvnNbzthEYkYWZS+7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM5PR11MB1899.namprd11.prod.outlook.com (2603:10b6:3:10b::14)
 by DM4PR11MB5550.namprd11.prod.outlook.com (2603:10b6:5:38b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Tue, 17 Jan
 2023 16:43:10 +0000
Received: from DM5PR11MB1899.namprd11.prod.outlook.com
 ([fe80::d151:74c0:20d6:d5fc]) by DM5PR11MB1899.namprd11.prod.outlook.com
 ([fe80::d151:74c0:20d6:d5fc%6]) with mapi id 15.20.5986.023; Tue, 17 Jan 2023
 16:43:10 +0000
Message-ID: <1afecb9c-b17c-d2a5-d887-b7dced939586@intel.com>
Date:   Tue, 17 Jan 2023 08:43:03 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [PATCH v6 01/11] mfd: intel-m10-bmc: Add missing includes to
 header
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        <linux-fpga@vger.kernel.org>, Xu Yilun <yilun.xu@intel.com>,
        Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
        Moritz Fischer <mdf@kernel.org>, Lee Jones <lee@kernel.org>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        Tianfei zhang <tianfei.zhang@intel.com>,
        Mark Brown <broonie@kernel.org>,
        Marco Pagani <marpagan@redhat.com>,
        <linux-kernel@vger.kernel.org>
References: <20230116100845.6153-1-ilpo.jarvinen@linux.intel.com>
 <20230116100845.6153-2-ilpo.jarvinen@linux.intel.com>
From:   Russ Weight <russell.h.weight@intel.com>
In-Reply-To: <20230116100845.6153-2-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0304.namprd04.prod.outlook.com
 (2603:10b6:303:82::9) To DM5PR11MB1899.namprd11.prod.outlook.com
 (2603:10b6:3:10b::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR11MB1899:EE_|DM4PR11MB5550:EE_
X-MS-Office365-Filtering-Correlation-Id: 3524cf2f-105c-4a47-df6c-08daf8a9eaf3
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HIifVnlytMhMB8GN5aXM0RPwVeFBZy61cv5fQ5vZZaQtAIesEgMiZqVY0MG7ry6aSyQCGc4ikkPsqcKAYbSDLLR4Zm+HyrfiqCBSZRiueWoRtseeo/tYk6g/WCnsspW3bzzisYJ16nPIUDXcAs6qB+5x0H0yOf6DlJFldeN52yOg0p34wLpicSe9k707pzJHzqk480aKNzgcc26/3p40E3iF89DuJsOunO8X2YGlj1rDwuNOHLfcWrAiwXvsO2IdjLEeGk5YsY/+Iv1/K91/fmbYp0Iql+zxR4Fkxycx/C1mS64HECevzSXDIustop1nrIJJB3TiMYUVMb64TnZ9BFnXbNfPjaJYFE+dELz4Rfq4ob4AVlyywGdxnQTZnCM/jBbiSCTCUSqGIistCwg0e1o+Pru0oVIDDImeDH//4FZBrI6PcxmxQh+aDbbKHkDm17/liF0InyQ7uzg+SF/9NhBnySXj9eenZScfFWjW3Qz0Hq7VnIKlPMNOruFzjkEMO8dty5X6sSiDTovaSJsw5ATu9v0w57b8NsSr5Yaeb4iAc9R9LkLurWzKS/yYv2CXpSW0w9wovZmlZyCdagJsuaeQsUIFS4C3CExzeHPm/gk/3ZkURWtaCnKVPa3O38tq+9rklQduAE46WN0IqwgCbNEc7ZvkuQBeqFhZGJFO2QUjWOplKQGw3WRqfC4Avf2OBH+cBrLusJyO4rgM68CasEpqPRryq58TxyF8ctHlt9HIkACZpf9ma8AuHDhwpZQR
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR11MB1899.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(136003)(376002)(346002)(39860400002)(451199015)(82960400001)(38100700002)(921005)(31696002)(4744005)(2906002)(5660300002)(8936002)(8676002)(66946007)(66476007)(66556008)(41300700001)(26005)(6506007)(186003)(53546011)(2616005)(6512007)(6486002)(316002)(110136005)(6666004)(86362001)(478600001)(31686004)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bVg1WStObmZRSlJGZWZXWFl6ODlWbkFUbmRwVWF1ZTY5aDV5VXVGSUlMSEtL?=
 =?utf-8?B?L1FxSzJsbzFYWWM0STFJM2lYZ1JMenFmMGFiaUh5Sm1ROTMwdE9lbVBTcW1Z?=
 =?utf-8?B?ODRCTTFFTUFTNTNITklxQW1obU1rQnJONjA1cmo3ZGpVSk16Rno3V0o3TWVD?=
 =?utf-8?B?bGh1aG5nZjFMem5yTTl6WWZkNjlRamlBQTlEc2ZxRFZqWTRESWVHdzJidCtX?=
 =?utf-8?B?dkE1UjZ3dkdRSU5NcU9aZXVmclh5Nm9GQ2tLRGFaSlJKVGc3YWNWT29DR0U2?=
 =?utf-8?B?Ri9QbUVSc1FwYVdrQzY4dkhsTU9NQlBZOW5IVm5uWHBNck5WU1JxQk9QbjQz?=
 =?utf-8?B?dmdRNExIQmI2RDFpcWJYSGtwMGFGYlo3a3d3RDdxUFNhMkVxY2FMaVZtbmR3?=
 =?utf-8?B?YnUwSnRpbFRRVnNHOGYxc0Z1UEhOeGpDUkN6Um9Cb2RBMzNWU3FXeUJ0M2c5?=
 =?utf-8?B?cFN1WTZqamEwRVVEeStxSlBCODRjL0J0a01WSHZhNGtQZ01PRVdwS1cyaU1E?=
 =?utf-8?B?alU1ZzN3cEJ1bzRWdklWMDZMaE9xWmRZcDZGYXkyaVZGczFzR2lrc0tHaDkx?=
 =?utf-8?B?ZmtDV0U3L1Q1WGNFMWdaQXVrdTAvRW9KUVk3NXFCTVhHWjY1dWtiT0JHeEhq?=
 =?utf-8?B?dUp2eTNOcjZsTHRoRDNoVkw4WXBYd0FGa0dZRFNianY4ZlE4SjhnQXZYayt6?=
 =?utf-8?B?ZEZuS3dneGF4U09xL1BPdVd5eUF1SC9hajJqUG1ZUXJPaFVqSW1pZXRSOHM5?=
 =?utf-8?B?MlhsOXJLTEZWTi9CdjFxNHVFTlNwNHFMMnd3c3doQlFWNnlST0p5Yi9NSE90?=
 =?utf-8?B?V3hGNGtGMmwyZUtqdXNudGc2TE1YTTV3bHpvdkhMMFRhM3V4UEc3N3ZlZVpL?=
 =?utf-8?B?WHc5QmVhRXVlc1pYTnEvelBKTE9oMTNVMkljZEI1U1ZIbGZXYTYzS3VoZkxG?=
 =?utf-8?B?cnBVOElWVER1c29rWDZrTVNtc2RwUmR5WnFTd0JKb2xGK2EzU0hJODZtbXFO?=
 =?utf-8?B?Y0xnZHlBRFRHS3FzR0FiRnlUM3M2ajBpc2ovRmFYVU5RczhRbi91Ni9raUdy?=
 =?utf-8?B?blM3Z1dINHo2NjBLcjRzbitVQWJDWFNGTDJTYUYxbnlpUkplaDVyMnRIQ05m?=
 =?utf-8?B?TjFyaGhNb0NzbWQ3SHV0WGl3WmlJK2RuYWErN2poYU9MR25zeDV4djZ2NjVT?=
 =?utf-8?B?YkpWeW9HREF3UlpmaTZJb1NhNTRKSXJuVFd1Wklzb2FoRmt1a1ZUcGZXa3FJ?=
 =?utf-8?B?Ykx4R0RmWGVyWThQV3RGTHVUbkR4dHhpNDdlby9zbXZndWh3WGZmU2FzNS8r?=
 =?utf-8?B?dys4eTNXMkcvSU5ZclZPVVVlVnBFUy84UXllSDJRQVZxcHcydmhBcGI4YzZs?=
 =?utf-8?B?UzZ3K25ianhRb2Vzc0tCUHJBM2JIS0xiTVNHdHJRK1pEc0V4K3R1Rm94QUVa?=
 =?utf-8?B?VXAyZXNMQlVseE5tSHBoME9Fd1BESkJpQS9rbCtZSGhtUi9KZHllYnBSNUZv?=
 =?utf-8?B?Z1VvcDBZUHphM0psMDdEaHZiNXBNdm9JRlRaQ2ZOTkRNK1IyYlFhV1JVQkVx?=
 =?utf-8?B?L1NPclBsdkFkOFJiZUVGc3ZXQkxvNTg4N2pwOVc2dEhFRDljYVA4ZWM4QzJl?=
 =?utf-8?B?Wi9lMGpuMDVSU2hpUStnL2JuOUw1bU1mYWxMbmdGWlBaL1lzRWoxLzBjWktH?=
 =?utf-8?B?dkd5RStzdG5LOG95MGdJeGVXNnpSVVVKYzhHbzE2MmROcVJOREFUd3JlU3hX?=
 =?utf-8?B?TEowUnd1MkRSVkc4eGZQS1NDRlFoa0pEUWdoNlVqSWxBSnorbS9mQldjemQ4?=
 =?utf-8?B?ZVpLU214ZE4wSkFYS2RMQmNiclYrTDc2Mnd2NGkrdUg3ZlJhTDd1NWQzM0dX?=
 =?utf-8?B?V0ttMXJPY2RlQVhsRHd1REJCek95KzF6cEVWY3ZLbDRiWnEwT2NRMjdyaVBR?=
 =?utf-8?B?K1hGWHdXek8yZ0JlNTByWlo2NHFaRjRyWTNKZldCQW9wQm56ejNMRVNpaXVQ?=
 =?utf-8?B?cm9OT2NIYnIvU1lVNDlNc0o3LzBabmxianlHUlFjYTZ5K1VOZ0RmeWh5ZVVR?=
 =?utf-8?B?QWQ2c09nSmJEaVlnVFVVbExITmxvVXRNSjdBSFo0bnpUUHFvQS9kY1VMT3Zq?=
 =?utf-8?B?c2ZmSStPV1c4b0J6Q2ZQdVhWQ3JqcTJnRTJNTmRDWXlWNnJvSllNUmlWUytt?=
 =?utf-8?B?Q0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3524cf2f-105c-4a47-df6c-08daf8a9eaf3
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1899.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2023 16:43:10.4015
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pXU4C3uWEv6UC+NtXQxUjkw1Z4EsH0UonlrkrPxaNv15SC6F0EG35WPLhaKQIyS3ki5eKPH2Ej81t9vrxzmacxRU1GEB/wDVnw1kW4AOtp8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5550
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On 1/16/23 02:08, Ilpo Järvinen wrote:
> linux/mfd/intel-m10-bmc.h is using:
> 	- pr_err(), thus include also linux/dev_printk.h
> 	- FIELD_GET(), this include also linux/bitfield.h
> 	- GENMASK(), thus include also linux/bits.h

Reviewed-by: Russ Weight <russell.h.weight@intel.com>

> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  include/linux/mfd/intel-m10-bmc.h | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/include/linux/mfd/intel-m10-bmc.h b/include/linux/mfd/intel-m10-bmc.h
> index f0044b14136e..0d4db5d9d5af 100644
> --- a/include/linux/mfd/intel-m10-bmc.h
> +++ b/include/linux/mfd/intel-m10-bmc.h
> @@ -7,6 +7,9 @@
>  #ifndef __MFD_INTEL_M10_BMC_H
>  #define __MFD_INTEL_M10_BMC_H
>  
> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
> +#include <linux/dev_printk.h>
>  #include <linux/regmap.h>
>  
>  #define M10BMC_LEGACY_BUILD_VER		0x300468

