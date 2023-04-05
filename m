Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D5FE6D862F
	for <lists+linux-fpga@lfdr.de>; Wed,  5 Apr 2023 20:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234269AbjDESkh (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 5 Apr 2023 14:40:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234275AbjDESkd (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 5 Apr 2023 14:40:33 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3DB295;
        Wed,  5 Apr 2023 11:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680720029; x=1712256029;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=izmu8xeb8R87NepKOGDR9bCCW8uh+tq1e7Wk09EelNA=;
  b=ms8PgonHyvhIEZc9eFJurCalNR6mBDtpUtxNEszfqpXi8tNm/3yNca60
   LjevC3wqva1b95eNgNJUC0elCRo5jeK/NRd0fS5mD4a7WFnOOy4nEolcz
   KMeqpUxawGUO7e4C8VH8tK23EYs0gDxD0JtBY/ihm/Q/P2XHx/2aM+1SO
   QyelPzUgup/UFECYJZZQvNIdfolfdBKbxbhTdcBQpEY7B6NO4eMeXKCiv
   vQNZRuaBDfgYy2UmGsx2V/DDWnN8ArZCHffl4x9WdAM/DgnbFlRwZ8IL9
   zptDW8sbnGm2ABkTv3KpC8Bi9XbPf619ls+UhR/OmUzitwU4yuyB92aPe
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10671"; a="322189614"
X-IronPort-AV: E=Sophos;i="5.98,321,1673942400"; 
   d="scan'208";a="322189614"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2023 11:40:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10671"; a="751359094"
X-IronPort-AV: E=Sophos;i="5.98,321,1673942400"; 
   d="scan'208";a="751359094"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga008.fm.intel.com with ESMTP; 05 Apr 2023 11:40:29 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 5 Apr 2023 11:40:28 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 5 Apr 2023 11:40:28 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Wed, 5 Apr 2023 11:40:28 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Wed, 5 Apr 2023 11:40:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fb0MnLEOUDJz7U2iWe10PGXKrQLrM+XGFs0JoughYurNAhirogop8cepKE/kvF877kidsyO+qvn8J9kPcIsQQQgq/CTIBUWHdJ8wTTgzclTCuXwB77m4WpED7jQ0XmKrQ/LaqwFGlpp4Gd5jTOq8Br5jAEulPWE0V5fYwGjMnlb4szbn2Q0V9rqCVH5HrXtZNjhalptJh9b/b/fzPIU3sHc/b/aBtq6KSeL+IoIy8ZgHgKk6LkiU/ob6Ii35HZKHopM2c+ClrEG0/nw5tLcONM2wzXMPCL1nEtGvjgRfpM7rOSCteusUCRS6oHOk9zfaVda8ZV2jxSdWpqZTMAxbUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1UxrAkWhnVF3TWE0AiZ9o8PZP6Nvjmv3s4a2AZNBuPs=;
 b=HgH0ypVE639ftz+riGNUElHLDLXgDc101eFItT1RvPM39qEyOhT3Iijnbv6bb8VzHrCYi7PYnXjKxLUY3WH7aoUd38DjgfUDtlOkiDsCEaDrg+bf2UxFu25vyHI9Rb72ttgJEtrAGMdhD6S0/GUQer4gL64kOczbGh7eYpHIxh6koFHRUsrKlDIM5/nqdhfDyNsgWlWvcVLzScQdDQaJCpILycbjNhEHZF/VcUZOUbEQyvm84Js+xpGc60lW1SwXmAfSAEaBnJHTZOBorNuhNCfT4QhJfwNM+97DWrGETpXCKmGv9pVYBs2x4ITbNfb/gP/fw7hl5tTiTl0fLZfvyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB6763.namprd11.prod.outlook.com (2603:10b6:303:20b::7)
 by SJ2PR11MB7672.namprd11.prod.outlook.com (2603:10b6:a03:4cd::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.37; Wed, 5 Apr
 2023 18:40:25 +0000
Received: from MW4PR11MB6763.namprd11.prod.outlook.com
 ([fe80::c4e:6c7:e9f7:7222]) by MW4PR11MB6763.namprd11.prod.outlook.com
 ([fe80::c4e:6c7:e9f7:7222%6]) with mapi id 15.20.6254.030; Wed, 5 Apr 2023
 18:40:25 +0000
Message-ID: <52a15482-b23c-e772-4a56-0f4a09f3af17@intel.com>
Date:   Wed, 5 Apr 2023 11:40:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.9.0
Subject: Re: [PATCH 3/4] mfd: intel-m10-bmc: Move m10bmc_sys_read() away from
 header
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
        Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
        <linux-fpga@vger.kernel.org>, Lee Jones <lee@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230405080152.6732-1-ilpo.jarvinen@linux.intel.com>
 <20230405080152.6732-4-ilpo.jarvinen@linux.intel.com>
From:   Russ Weight <russell.h.weight@intel.com>
In-Reply-To: <20230405080152.6732-4-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0274.namprd03.prod.outlook.com
 (2603:10b6:303:b5::9) To MW4PR11MB6763.namprd11.prod.outlook.com
 (2603:10b6:303:20b::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB6763:EE_|SJ2PR11MB7672:EE_
X-MS-Office365-Filtering-Correlation-Id: ad9f34c1-2288-4e56-da4b-08db3605385b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 79y+zUDEEXdGjJ+udswpz8aZldqXZXVOnkMIdA+ca4mT0WxB+6JXuJPhDqkra6TA+RjqNMEoJ53SA4Ew2vCDEKY1OtKkPHRQGht/pRMB5t8U7jRQFU6fZ9RB0KI+1V4qr8P5GniVtQzp5Hon7fVrPqlpv1z8Mdx736NWbPKjpZzY0PxetdgqXHuRsVk/tkynHHk3P6GTiBcJg/VvBnHnv1S2nJgbHtUKgCvjqPiFASxUSQMHAn9NjZCX7GAVsU60sAoSYc83CgJdc3xG4Y4hJoHAsapp0ZEhzjHP8JAUDqEBQdziyop6Y1ULXLB0NXAWpVMdLWeuTAWDI0iAskvAjv1NTT2lC2LLFrc5b8IajBViI5e+W+KYlwFy4a//NcI9x7FXePQ9Tf7Mq1teX76AIUoANV/bPaSieBVhX9BNkx8vOARAyROAq4M/tsF8cpyWUCQZXLi5d7Z9lDMzsDM+Mqsv/H5J8qrr4/p2V62DwHXjumXmeI1QXqZXII+vu1nM2rWmAuLiTNUBtrS7ZYMc82i3+BCGOQea9UWITw7gZ8VDzd6xWBbEUdyl7Y7DVJHkCU1gZjNuep+6Y1yOrOVgDYHLKr43i8wtJTx4xBvdN4IqaZbKgmi6vUyeAHvH9GMbjyKVuav8hf5cxqgFJn0tLe0BnyoBSEoy+LsGid2hid8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB6763.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(39860400002)(136003)(366004)(376002)(396003)(451199021)(31686004)(2906002)(86362001)(66946007)(5660300002)(6666004)(8936002)(8676002)(66556008)(36756003)(316002)(41300700001)(110136005)(66476007)(478600001)(6486002)(2616005)(921005)(26005)(6512007)(6506007)(53546011)(31696002)(83380400001)(66574015)(82960400001)(186003)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TXNXSVFkSlNaRFNKMjQ4aGxzNFJpU01DNGZ3T0gzV3lUYmpqMVJ0N1ZmQVZa?=
 =?utf-8?B?YmxFYmlCejJLZWNOL0VOd0xDeXJ3S25vMHFsUGpIZUVRU0l1bUhvSnJZcnNm?=
 =?utf-8?B?VDBIdU5ObDRDR0xiZ3pkVUNqNHYrLzl3TkplM0NQTVJVRHh6TDROUko0WkRa?=
 =?utf-8?B?M25jdk5hYkxCVFYwUCtJRlBESUprb0oyeTBBT2Vqd1FyRlZ1NHZxdWVjM01v?=
 =?utf-8?B?Si9URnRlNzREcHh2MnowQXZxVGRNci9uM1d1SnV3anpTNGZLNVU0R1pHcHJJ?=
 =?utf-8?B?MDVlTnNPL3YxSVZyZGp3aWFQU0pweVM4a1h4RWVwb3BWeEpLWjBqaTMxaHRX?=
 =?utf-8?B?Z2hxc05oR2htSkxpNmJXN3NyRitQSy9PNFpMWm9UWUdvTmtrM3o1b3hhN0hz?=
 =?utf-8?B?VkNGZCtKWkcvNjVzcUFyUDRsbnBDMGJsYUVaWkZMK1U3VGtkN3NRQ1hkeVpQ?=
 =?utf-8?B?c1Nqa3lXNmlReUhJTUtoMDREN1ZoVmI0aFovUXZwN2MzOE1vMEdkRnNlcWhj?=
 =?utf-8?B?alVSRTAyMFJIZUVENTIzRlZoZGFUclZVVlhjM1hmSmVPV3hFYWdtM2FkcVYy?=
 =?utf-8?B?RXBHekVKRHd3alNXYXhZWDlxcERRT0kvVmZiZDlYZmRxWDRVSlozNjRMMmlP?=
 =?utf-8?B?ODdlajBzZkRRZi9IZmpLaXk1VFlrSkt5WWEwQ1piVE9PcFRZcXREYXdXZFk2?=
 =?utf-8?B?c2tQYlQxNFJFdzcvR1NINXZ5Y3BMR3hTMmdmY0tCRytTZHU5QndnWHZNUFVE?=
 =?utf-8?B?SFBXNWkrNVp0ZnFKSkdjZk5VdCtaNjlCL0FCSWhUZ1hKdWx1UU9QcmtJWDRS?=
 =?utf-8?B?dHVTcTBySlVkRTRoaktNVE1ZQUZ5S0ZRdzBET3JSOUlJd29KbG5Nb3FGTWh4?=
 =?utf-8?B?QS9lVDJ0cXhiOG5uU04vejlMWnFTbVlkblA3Y3lLUHZWcXp2NTFpbUJqaE50?=
 =?utf-8?B?UFVDQlZHK1RLSExaYkQwVkZXTFNRaS9mOW5PQ3A5TXJEekhENUlsN1dGcFBt?=
 =?utf-8?B?d3p2Nk9hbHY1MUtiMTJDb0RJUFRTdmtmY1MxT1M0V0JNSDBtVE5pZFFpR1hV?=
 =?utf-8?B?Qmk3c0NsTTM3QmdLNFJKQ3dDdjdoK3UxOWF2UTBQbnNhb1phUjFuUUFBNms2?=
 =?utf-8?B?WXE5Z3ExRkVXaVpYdVZLMDZLOHplWlREVzJHak1wVzZUcmpHV2JkS1RiTGFK?=
 =?utf-8?B?ZjdCYnMxc2VjWURUMGMzbkQ0VkNXSklHVXVUcFpwakxwZERTVXFhY3FGcnVi?=
 =?utf-8?B?d21KZkJhVWM2M2FhZU1rczR3U3RoWXUwdXd0K3dwTDJGMThGN0oyMFhtUUNT?=
 =?utf-8?B?bHhqb2RLV25tcjh1RkJhbkpLcEE1WnB6ci9aWXJiMXFOV083QUcrNjBaTjJz?=
 =?utf-8?B?ZDJjREZsVUVuNDVrVDUrcHVFQzc5STZDR2l6ZjMzY0Fzc1NMaWd1Yjhia1oy?=
 =?utf-8?B?ZlJTWFJwNldhbTlpYU5ITk1yMDB0cXp1WnpYQk1IOHBNWmVZUElVcmlNTmRE?=
 =?utf-8?B?R3ZzTUx0RU1MYTlYOEdrczZFZit6Nng0Y3VLaHZTQkkzYjJ1VmlSak9YWndV?=
 =?utf-8?B?VkliTTdNcEF3UEJyS1VHWk8vSFFWUnQ4RWlFQ2JYL0lWOGwvVUFKS1M4YzAz?=
 =?utf-8?B?d1gyT2lPY3lIT3ZjMTlDdmtZZVJ4ckVsSkoxaDV1UW1BWG8rSXF0NDFsejRX?=
 =?utf-8?B?Zld2TkpOZFBDeUNpV3Q2L0pFcWNLMDA5S25Sa0tFUi8rNDVOWlY1TjFzclZ4?=
 =?utf-8?B?UDAzTGVJT3N1bWJqYVBCME5FbFZ5Y3dWeTJZMy9ZNXpJdTQ2RFNMMDF1Z1ND?=
 =?utf-8?B?bVNYK0ExRFQxZmtlcG9VaVRqUkpOK0N5Y0ZmUitxNGJsR3VGZzlSZ0Z5b0Rk?=
 =?utf-8?B?RmZSSHNkMlVlWDBNeUVFMWI3OHQyeGNpK0ZoblR1YU9nVjNIUzl6M0ZOczM3?=
 =?utf-8?B?QnRQNkdvNmpnajV4NzV1WnhjV1pyMXh3aEtycjRqWEYrSllhNXFWbFFFdDNr?=
 =?utf-8?B?ZmtYYnZEOGVkRWpiUTMyb2xRSnhBQ3NwVUJaVFpZK291cGVEWW5hTURWUnYx?=
 =?utf-8?B?Qm9hanI1cmd5eFA5cmYvS01zQ1dNYmd4Tk8zR241d3N4YXQ3dlZnN2YrRzZP?=
 =?utf-8?B?Tlc3UkhPYWxpVmxjRFpFMitmQWFES2FSdGVxSWhnQ2hEa3pnWWNscFYzVGNn?=
 =?utf-8?B?ZHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ad9f34c1-2288-4e56-da4b-08db3605385b
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB6763.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2023 18:40:25.3169
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ESoCvMH5EjWKUT2+vu4pUnnVe1wBdqSK/U74YlGUHNfk587ZTOAlyo4pxfcElrpiIiqjcbSJSUZtJ+2WS92e+htycfw20cOdrQscJ/Us5rU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7672
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.9 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On 4/5/23 01:01, Ilpo Järvinen wrote:
> Move m10bmc_sys_read() out from the header to prepare it for adding
> more code into the function which would make it too large to be a
> static inline any more.
>
> While at it, replace the vague wording in function comment with more
> precise statements.
Reviewed-by: Russ Weight <russell.h.weight@intel.com>
>
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  drivers/hwmon/intel-m10-bmc-hwmon.c |  1 +
>  drivers/mfd/intel-m10-bmc-core.c    | 14 ++++++++++++++
>  include/linux/mfd/intel-m10-bmc.h   | 17 +----------------
>  3 files changed, 16 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/hwmon/intel-m10-bmc-hwmon.c b/drivers/hwmon/intel-m10-bmc-hwmon.c
> index 2f0323c14bab..92900ce7986b 100644
> --- a/drivers/hwmon/intel-m10-bmc-hwmon.c
> +++ b/drivers/hwmon/intel-m10-bmc-hwmon.c
> @@ -794,3 +794,4 @@ MODULE_DEVICE_TABLE(platform, intel_m10bmc_hwmon_ids);
>  MODULE_AUTHOR("Intel Corporation");
>  MODULE_DESCRIPTION("Intel MAX 10 BMC hardware monitor");
>  MODULE_LICENSE("GPL");
> +MODULE_IMPORT_NS(INTEL_M10_BMC_CORE);
> diff --git a/drivers/mfd/intel-m10-bmc-core.c b/drivers/mfd/intel-m10-bmc-core.c
> index 879d98b9b14d..4a1bfe135293 100644
> --- a/drivers/mfd/intel-m10-bmc-core.c
> +++ b/drivers/mfd/intel-m10-bmc-core.c
> @@ -12,6 +12,20 @@
>  #include <linux/mfd/intel-m10-bmc.h>
>  #include <linux/module.h>
>  
> +/*
> + * This function helps to simplify the accessing of the system registers.
> + *
> + * The base of the system registers is configured through the struct
> + * csr_map.
> + */
> +int m10bmc_sys_read(struct intel_m10bmc *m10bmc, unsigned int offset, unsigned int *val)
> +{
> +	const struct m10bmc_csr_map *csr_map = m10bmc->info->csr_map;
> +
> +	return m10bmc_raw_read(m10bmc, csr_map->base + offset, val);
> +}
> +EXPORT_SYMBOL_NS_GPL(m10bmc_sys_read, INTEL_M10_BMC_CORE);
> +
>  int m10bmc_sys_update_bits(struct intel_m10bmc *m10bmc, unsigned int offset,
>  			   unsigned int msk, unsigned int val)
>  {
> diff --git a/include/linux/mfd/intel-m10-bmc.h b/include/linux/mfd/intel-m10-bmc.h
> index 5418f7279ed0..252644fa61be 100644
> --- a/include/linux/mfd/intel-m10-bmc.h
> +++ b/include/linux/mfd/intel-m10-bmc.h
> @@ -267,22 +267,7 @@ m10bmc_raw_read(struct intel_m10bmc *m10bmc, unsigned int addr,
>  	return ret;
>  }
>  
> -/*
> - * The base of the system registers could be configured by HW developers, and
> - * in HW SPEC, the base is not added to the addresses of the system registers.
> - *
> - * This function helps to simplify the accessing of the system registers. And if
> - * the base is reconfigured in HW, SW developers could simply change the
> - * csr_map's base accordingly.
> - */
> -static inline int m10bmc_sys_read(struct intel_m10bmc *m10bmc, unsigned int offset,
> -				  unsigned int *val)
> -{
> -	const struct m10bmc_csr_map *csr_map = m10bmc->info->csr_map;
> -
> -	return m10bmc_raw_read(m10bmc, csr_map->base + offset, val);
> -}
> -
> +int m10bmc_sys_read(struct intel_m10bmc *m10bmc, unsigned int offset, unsigned int *val);
>  int m10bmc_sys_update_bits(struct intel_m10bmc *m10bmc, unsigned int offset,
>  			   unsigned int msk, unsigned int val);
>  

