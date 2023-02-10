Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1CFD692B76
	for <lists+linux-fpga@lfdr.de>; Sat, 11 Feb 2023 00:39:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbjBJXiG (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 10 Feb 2023 18:38:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbjBJXh4 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 10 Feb 2023 18:37:56 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BF8F126F4;
        Fri, 10 Feb 2023 15:37:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676072254; x=1707608254;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=PpqRoqW/SKiU6mHcoltxWUnwO/31sV0fJvY7/LVwU/I=;
  b=k2aonO3gobO1UYlZnKwvsROP1O6LfwI1ChRnisGYXFTXqy8m9K5S1McN
   9XYBxehtmqzL/L97LAtEvdqX6I/YURZyvnqwOcbV8115kNLMPk3FFr2fY
   j4+1VR6zwRWK59s4me4CpB61e2ydBAUoN2SeGtOViQJniMyte2RMg+i+y
   nwVqvDKe+ngmRLJp+7iCQDMlwlzqKGUZaXKMdA4KMAhIx0fyIDD+bIIC+
   8kWGoPhXHLxa5Lrjp50MYiiowUGisiMtF8jFlh9wYf2pDMbYz6eg8msIH
   siG0/3b2O3JRYNdBHNi+vrCoOj1iDyX5YxgJRzAhF867yve5WX3BiR9Pj
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="332693821"
X-IronPort-AV: E=Sophos;i="5.97,287,1669104000"; 
   d="scan'208";a="332693821"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2023 15:37:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="913707400"
X-IronPort-AV: E=Sophos;i="5.97,287,1669104000"; 
   d="scan'208";a="913707400"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga006.fm.intel.com with ESMTP; 10 Feb 2023 15:37:08 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 10 Feb 2023 15:37:08 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 10 Feb 2023 15:37:08 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.175)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 10 Feb 2023 15:37:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j7QxF++uWvjn3r5NtOb/0ZuEB8I8/f86Ins1FFI69FcJXXd2QU6Sqv9gKoxiNgW/FtihfA5hD+RX5YibInJkjl5V45+FrVbza/xFW8oB9JzD+d84kQFhIftHXCQx2Tg/xYfdNgaiQ9i/OLVIrgQHZiQAHQefgKW67550xTr2ztMgXjSxdl6qQucyM69VXx0FpC628GpBW+jM0KJI90Mx/K6/2DzTXq1cV8T3rBmigavoxUp1iYJPaxn/G27uc1gAOnowG2s0WjWilUIlUISxFEEiuJGNOYVDreG9eGdT1Ohm1WaMgHqcket3JG6404BXO5eW19D/QSuk1/zm2TE8UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7C5lC5paMtY+Emn5OPvkOXVWoiY5LjdXvVsUafxuCUg=;
 b=MZDwvge67B20/2ZexTxWmO208Mv1A+ChUQbUmD2WEyS/s9nDJ4YXIBGyXsvNwfpv4PovFNw5zF0UAgcXvVwFhP/KNddU7Lmm6zLeUgVOYn7hftbiGQiUUZUdxFvszUkf+sIxVL6tvpGhnMClgzpR/hqboZ0N5aJwxm0jgVMxPvkGWE+Ysc8ngdHr9N959KgPFhO1xyr/qCnV3aZascOWsofv0y2wzhW9onJBhiDCYB3WHL24VX+mb5arIFnh8UFXSES8ORqGlk8QnnK66bJsNRmPgqekyqQ628SJ4dO6OoNcArvgdK0ir9STyALfFbJlev7JS4Mua4/glnLQHiHZog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM5PR11MB1899.namprd11.prod.outlook.com (2603:10b6:3:10b::14)
 by SJ2PR11MB7426.namprd11.prod.outlook.com (2603:10b6:a03:4c2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.21; Fri, 10 Feb
 2023 23:37:05 +0000
Received: from DM5PR11MB1899.namprd11.prod.outlook.com
 ([fe80::d151:74c0:20d6:d5fc]) by DM5PR11MB1899.namprd11.prod.outlook.com
 ([fe80::d151:74c0:20d6:d5fc%6]) with mapi id 15.20.6086.019; Fri, 10 Feb 2023
 23:37:04 +0000
Message-ID: <e52ec21b-a1f3-7fab-e66e-5c4243d89c2b@intel.com>
Date:   Fri, 10 Feb 2023 15:37:01 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [PATCH 1/1] fpga: intel-m10-bmc-log: Create MAX 10 BMC log driver
Content-Language: en-US
To:     Xu Yilun <yilun.xu@intel.com>,
        =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC:     Tom Rix <trix@redhat.com>, Moritz Fischer <mdf@kernel.org>,
        Wu Hao <hao.wu@intel.com>, Lee Jones <lee@kernel.org>,
        <linux-fpga@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Tianfei Zhang <tianfei.zhang@intel.com>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>
References: <20230209111329.15791-1-ilpo.jarvinen@linux.intel.com>
 <Y+YSoJguy32umIj2@yilunxu-OptiPlex-7050>
From:   Russ Weight <russell.h.weight@intel.com>
In-Reply-To: <Y+YSoJguy32umIj2@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0026.namprd03.prod.outlook.com
 (2603:10b6:303:8f::31) To DM5PR11MB1899.namprd11.prod.outlook.com
 (2603:10b6:3:10b::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR11MB1899:EE_|SJ2PR11MB7426:EE_
X-MS-Office365-Filtering-Correlation-Id: 66676615-f5ab-4e3c-87f6-08db0bbfb6c8
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Jsi5dmm47zJ5QfLV6w2UJPQdtGuCkv2NsB4p1y/kvjvwNcP9LwGe7NF+CG9PaQw7I3cR1tm8h82mHgdADDb1rZF3rUNEzXMsEKPlIDqnZaoJ12b5hhlZgWsNl7bmoywEvU1RZwzskCxzVmKRNmAuP2uc5xNHyYCJPwyCuRDYKaw4xDkAmSN1qct++rWxn6YNRVz+yHaBGlAU7pPbdu4EU5tA4dBLq9ubhyA2MQyekqHyFeDtiAm/WY+lbey42UtJDfcA4VZnVDgNHXIBRZpdXUM3WLNu9Qr5aH84ejRheqgbbW7Gm3pQ1BqGPEHkaVMnrzEjO1ImhBcy8lD+rf1FLSTVzWJOSrHa5TcoxaWNq4m6tJ6de7nCWBdwO1xdd4AMX8+1PbymjgCdq4uqPXH2tIPrqXfnSX9MTY8av4yJhBaCinnX9OoWgbL1cXDzsBh7ZpE+nl4dn6qKoIhOx7aGJCj7Ku+W8031Fw3JJPybSDcc/8TtIqzykGzxV9kG2ZRLHOILeRgx+AbzrcfNid9CysxLooRTF2zHrCmAC8mL5Uk4g/EjFIVx0i4TUCO3LpiA8UBurQunmKIplV9zLLwkLBc7o+hG9FpGQsvqebc6owhwcon1DcVF4+72UK9IhWhSxLCwKQlfY+zou3wTJvoRP2sYyFB0IihvYxak6L95VltnBPoKfhu875t3t/Ri2I5UBfg4FK4uBzN2D8iJQIjjhiNGiGPjV9ownvCYgP8UCds=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR11MB1899.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(396003)(346002)(136003)(366004)(39860400002)(451199018)(31696002)(86362001)(36756003)(38100700002)(82960400001)(26005)(4326008)(186003)(66556008)(8676002)(66476007)(6506007)(66946007)(6512007)(8936002)(5660300002)(6666004)(30864003)(41300700001)(478600001)(6486002)(316002)(54906003)(110136005)(83380400001)(2906002)(66574015)(53546011)(2616005)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VkFaUGxOMm1XZDMydHE0MVVSbUh5NXFGajREaUpMdDlUaG1GNmdGQzI4aTBB?=
 =?utf-8?B?cmF2T3h2SkhMbldLN21kWEFEY081VDJtNnRpYlhQcDJHVnBYOUtGTWYzczdN?=
 =?utf-8?B?ZWw5L0loM1JKbUEwWnhXU3lpNldYTGRzTUhRK1NYN2hkT1dEQlVwK0hodVJG?=
 =?utf-8?B?ZHBOYXBtUHp3ZUJvUTlYWUYxYlRzRzBJRnZWTDRFcFhOc0tYMWY0aytWNEk0?=
 =?utf-8?B?SmVpTkhyaFpKZ0NLM1FNTVdmc0ZtYWJSc3lJTjI3S2hZeXNXc0lPc2VhVk5R?=
 =?utf-8?B?R0dLWndyNWpwbGV0cGVtbDNPYmpJeDNqN1NpMTRFUTVtekVMRDd6TS9RQ3Mr?=
 =?utf-8?B?cFZubGhHQ1F1N042OEFsU2RYbldxMUZlVWlYakxQd0c5dXVHK1U4N3JTWElF?=
 =?utf-8?B?TUxFV21aQ1F5VlZ1cHNVUU1jQUIwQnI3Wmo2NmJFYzE5eG55T21SSTVJK2N6?=
 =?utf-8?B?aWIwc2JidkNyWVduaWd3NFpWT2N4c3BzWFNuYVFsSldiTXFudHNnNnlwU0Rw?=
 =?utf-8?B?TUp3QXFVNXpEem5ZbVdhNEN2Y1FzcVhBOU1XY2N2eUJkQnBiUGdjL1crVmQr?=
 =?utf-8?B?ZzFBbXpUdVNucE1MendCL2RJRVhNQmhlM1JvS3VtK2xyZngyRnBiZDA1U0dI?=
 =?utf-8?B?ZGVSM0k5WjVwUDhNZFlmUCtmRVIxWnVuKzNUeEJUNEJFVXBzQzQyV3ltUE5W?=
 =?utf-8?B?dG1WRjdYTnA0QytBR3hLSXJDUUlLSnRIMjd0a2lwakJ3THRPU1dPc3JSbS9C?=
 =?utf-8?B?d1haTjkyVVV4NkEvRDNaUGYrdWhKeWRPMVZBNUFOZHRiWHluYTlmZzVyNkRx?=
 =?utf-8?B?bGc1aFhBZnVkcnFWRHVEWVQzdjY1bktPT051RmpkR3FWZktaakVURm9rR1A4?=
 =?utf-8?B?MGg1ZzljajdWK01iSlRJWUFHbnRQWmI3bEFtNytEdTgzMmhYWlN3UGp1c1VY?=
 =?utf-8?B?S1BnUkJnS2xRelViUFlFNHRYdDJuNHBaQWh4ZWt4czlFcWs1Q3FoclVWU0Yx?=
 =?utf-8?B?ZXhaRUQ0a3RQaFZVU3ZMV09hK05hYzF2NHVlTER6c2JrWGE0YzhNQkRkaXNy?=
 =?utf-8?B?NFpOblRQZlc3aWdSb1RJWjRVcVc5SjkxM3pGZThWeXpuVGp1TTZJdjFaN1ZZ?=
 =?utf-8?B?YkpMRzJxcmQxSGw3TmdVZFV2WEs2aTFMalJIeEs4eXhkNVJtMDU0RU45Y05C?=
 =?utf-8?B?LytuT3pXVEVwZkc3ZjRsR3JuWU54a3hPVUtldk4wM0lmaVJMNW45a09xb1NG?=
 =?utf-8?B?aW51aXNFRjNyVENGQnNjOTNEdDB0dGpXMm8rTW1qRGd4SVkrUjF0MncvRlg0?=
 =?utf-8?B?bzdwaTRRRnQ4NnJyRlBGcEJLVTdTNGhjVEpjS2VSeExQTG5maUtoYnBEVG1y?=
 =?utf-8?B?bEJqT05KVzFzT0ljcUIvVFltZzg1ZXdwa1lMcHJVRzMxTy9pUURramh6U0g0?=
 =?utf-8?B?ckpXdUNKOUxaNk83QUk5dnk0SFV6RmVMS1F1RU5JbkdLWXZjNEJieVZLTlcz?=
 =?utf-8?B?cVgvQVc4WEtZcCtoN1pSSWdNYzdlbFhJN0pLZC9yU1Uwc0VtNVZmQzZPWkc1?=
 =?utf-8?B?RERRL1RidEFBTmtMMzFtQ2xNRFpIVGZpRVpWaU56Nmk4NWk2RWZ0eWJ1Zldl?=
 =?utf-8?B?L0x4K3BjUG1BRURiS1BVSUhYWHBab1ROZXlabHEwallnR1UrMlk1T1loUnZq?=
 =?utf-8?B?NHRzc202U3l1NDBNcWtGemN6a3hQRWNKQnZxRWpmMzJWa1owN0p2Q0UrYU02?=
 =?utf-8?B?WDFNeG9HZS94V3g2ekdueU5kanFUMW84eTdaUHA4dG1rTzgyWFl2TmkyUkpG?=
 =?utf-8?B?MC9zeTlnSkwxS2RtVVZSbHJVOVVjQm5LUDI0TXNiTzgwQ2o2MTd0MWU0am4y?=
 =?utf-8?B?TkZsSi9QYWlOYnp2ZEpLL09Sd2lIbE1hSmJuUnZUUkxOWWMrSmlTaFcxekw4?=
 =?utf-8?B?a2NGZ3ZuUFphZWVnQmhvdnpkNHRIVHV3Q1JGRW9wSmcvaVA3am5ZY2RTRXpq?=
 =?utf-8?B?aERNMkJDMWJGcm53SWEvT0FMSGkxd0UyR0NYZTBscHl2UklqUldpSWZaRity?=
 =?utf-8?B?R3JBanJkcFN3b25jcjZNclBseExxV0YxOVVOb2VxRFlnN1BZZ1kyU0V0WU9y?=
 =?utf-8?B?YXAzYTZid0I0bHhqbW1QUTFUdjY2R0tWdjdNbmU3bzB2d2pRaUJEVXBWUTZk?=
 =?utf-8?B?Vnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 66676615-f5ab-4e3c-87f6-08db0bbfb6c8
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1899.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2023 23:37:03.8342
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v2MfX+zexPBc1zYQ7zKh2CnVkPV5vV+kbQ57GBDGhsWgMHJ708ZNqfooU5yFoo9itiNweVqvvByxEZYk+GTTDX6tJ1uXe8g1XYoreuKJbhg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7426
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Yilun,

On 2/10/23 01:47, Xu Yilun wrote:
> On 2023-02-09 at 13:13:28 +0200, Ilpo Järvinen wrote:
>> Add MAX 10 BMC log driver for accessing BMC event log, FPGA image
>> directory, and bill-of-materials (BOM) info partitions on FPGA card's
>> flash. Use the nvmem API to expose the event MAX 10 BMC event logs to
>> userspace.
> I didn't look into the details yet, but I suppose this driver is not
> for FPGA domain, which focuses on FPGA region re-configuration and
> re-enumeration of devices in FPGA region.

This driver was originally placed (without much thought) under drivers/mfd. It is
a sub-device of the BMC, not a multi-function device. I have looked for other
instances of log drivers and they seem to be grouped with the technology they are
logging for. For example:

./net/bridge/netfilter/ebt_log.c
./net/bridge/netfilter/ebt_nflog.c
./net/netfilter/nft_log.c
./net/netfilter/nfnetlink_log.c

There is no drivers/log subdirectory. Since this driver is used exclusively with
FPGA devices, drivers/fpga seemed like the best option. Do you have any suggestions
for a better place to put this driver?

Thanks,
- Russ

>
> Thanks,
> Yilun
>
>> The PMCI MAX 10 BMC contains high and low timestamp registers that are
>> periodically written by the host driver to facilitate BMC event logs.
>> Add a kernel worker thread to update the BMC timestamp registers. The
>> frequency of timestamp updates is controlled through sysfs file (the
>> default frequency is once per minute).
>>
>> Co-developed-by: Russ Weight <russell.h.weight@intel.com>
>> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
>> Co-developed-by: Tianfei Zhang <tianfei.zhang@intel.com>
>> Signed-off-by: Tianfei Zhang <tianfei.zhang@intel.com>
>> Co-developed-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
>> ---
>>
>> This requires commit 4f43a6e80ba9 ("fpga: m10bmc-sec: Add support for
>> N6000") from ib-mfd-fpga-hwmon-6.3-1 (the 11th patch of the M10 BMC split
>> series that wasn't picked up at first and still isn't in for-fpga-v6.3-rc1).
>>
>>  .../testing/sysfs-driver-intel-m10-bmc-log    |  37 +++
>>  MAINTAINERS                                   |   4 +-
>>  drivers/fpga/Kconfig                          |   9 +
>>  drivers/fpga/Makefile                         |   3 +-
>>  drivers/fpga/intel-m10-bmc-log.c              | 264 ++++++++++++++++++
>>  drivers/mfd/intel-m10-bmc-pmci.c              |   1 +
>>  include/linux/mfd/intel-m10-bmc.h             |  13 +
>>  7 files changed, 329 insertions(+), 2 deletions(-)
>>  create mode 100644 Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-log
>>  create mode 100644 drivers/fpga/intel-m10-bmc-log.c
>>
>> diff --git a/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-log b/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-log
>> new file mode 100644
>> index 000000000000..a170e675d11e
>> --- /dev/null
>> +++ b/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-log
>> @@ -0,0 +1,37 @@
>> +What: /sys/bus/platform/devices/intel-m10-bmc-log.*.auto/time_sync_frequency
>> +Date:		Apr 2023
>> +KernelVersion:	6.3
>> +Contact:	Russ Weight <russell.h.weight@intel.com>
>> +Description:	Read/write. This sysfs node controls the frequency (in
>> +		seconds) that the host writes to the MAX10 BMC registers
>> +		to synchronize the timestamp registers used for the BMC
>> +		event log. Write zero to stop the timestamp synchronization.
>> +		Write a non-zero integer value to restart or modify the
>> +		update frequency. Reading from this file will return the
>> +		same integer value.
>> +		Format: %u
>> +
>> +What:		/sys/bus/platform/devices/intel-m10-bmc-log.*.auto/bmc_event_log*/nvmem
>> +Date:		Apr 2023
>> +KernelVersion:	6.3
>> +Contact:	Tianfei zhang <tianfei.zhang@intel.com>
>> +Description:	Read-only. This file returns the contents of the "evemt log"
>> +		partition in flash. This partition includes the event and
>> +		error info for the BMC.
>> +
>> +What:		/sys/bus/platform/devices/intel-m10-bmc-log.*.auto/fpga_image_directory*/nvmem
>> +Date:		Apr 2023
>> +KernelVersion:	6.3
>> +Contact:	Tianfei zhang <tianfei.zhang@intel.com>
>> +Description:	Read-only. This file returns the contents of the "FPGA image
>> +		directory" partition in flash. This partition includes
>> +		information like the FPGA Image versions and state.
>> +
>> +What:		/sys/bus/platform/devices/intel-m10-bmc-log.*.auto/bom_info*/nvmem
>> +Date:		Apr 2023
>> +KernelVersion:	6.3
>> +Contact:	Tianfei zhang <tianfei.zhang@intel.com>
>> +Description:	Read-only. This file returns the contents of the "BOM info"
>> +		partition in flash. This partition includes information such
>> +		as the bill of materials (BOM) critical components like
>> +		PBA#, MMID.
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index ddfa4f8b3c80..1b2427ba6729 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -8075,11 +8075,13 @@ F:	Documentation/fpga/
>>  F:	drivers/fpga/
>>  F:	include/linux/fpga/
>>  
>> -INTEL MAX10 BMC SECURE UPDATES
>> +INTEL MAX10 BMC SUBDRIVERS
>>  M:	Russ Weight <russell.h.weight@intel.com>
>>  L:	linux-fpga@vger.kernel.org
>>  S:	Maintained
>> +F:	Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-log
>>  F:	Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-sec-update
>> +F:	drivers/fpga/intel-m10-bmc-log.c
>>  F:	drivers/fpga/intel-m10-bmc-sec-update.c
>>  
>>  MICROCHIP POLARFIRE FPGA DRIVERS
>> diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
>> index 0a00763b9f28..773667e3b027 100644
>> --- a/drivers/fpga/Kconfig
>> +++ b/drivers/fpga/Kconfig
>> @@ -244,6 +244,15 @@ config FPGA_MGR_VERSAL_FPGA
>>  
>>  	  To compile this as a module, choose M here.
>>  
>> +config FPGA_M10_BMC_LOG
>> +	tristate "Intel MAX 10 Board Management Controller Log Driver"
>> +	depends on MFD_INTEL_M10_BMC_CORE
>> +	help
>> +	  Support for the Intel MAX 10 Board Management Controller (BMC)
>> +	  event log, event log timestamp synchronization, and other
>> +	  information on flash partitions (available images and
>> +	  bill-of-materials critical information).
>> +
>>  config FPGA_M10_BMC_SEC_UPDATE
>>  	tristate "Intel MAX10 BMC Secure Update driver"
>>  	depends on MFD_INTEL_M10_BMC_CORE
>> diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
>> index 72e554b4d2f7..1db25ad3d76a 100644
>> --- a/drivers/fpga/Makefile
>> +++ b/drivers/fpga/Makefile
>> @@ -25,7 +25,8 @@ obj-$(CONFIG_FPGA_MGR_LATTICE_SYSCONFIG_SPI)	+= lattice-sysconfig-spi.o
>>  obj-$(CONFIG_ALTERA_PR_IP_CORE)		+= altera-pr-ip-core.o
>>  obj-$(CONFIG_ALTERA_PR_IP_CORE_PLAT)	+= altera-pr-ip-core-plat.o
>>  
>> -# FPGA Secure Update Drivers
>> +# MAX10 subdrivers
>> +obj-$(CONFIG_FPGA_M10_BMC_LOG)		+= intel-m10-bmc-log.o
>>  obj-$(CONFIG_FPGA_M10_BMC_SEC_UPDATE)	+= intel-m10-bmc-sec-update.o
>>  
>>  # FPGA Bridge Drivers
>> diff --git a/drivers/fpga/intel-m10-bmc-log.c b/drivers/fpga/intel-m10-bmc-log.c
>> new file mode 100644
>> index 000000000000..4e7a54afe786
>> --- /dev/null
>> +++ b/drivers/fpga/intel-m10-bmc-log.c
>> @@ -0,0 +1,264 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Intel Max10 Board Management Controller Log Driver
>> + *
>> + * Copyright (C) 2021-2023 Intel Corporation.
>> + */
>> +
>> +#include <linux/bitfield.h>
>> +#include <linux/dev_printk.h>
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/nvmem-provider.h>
>> +#include <linux/mod_devicetable.h>
>> +#include <linux/types.h>
>> +
>> +#include <linux/mfd/intel-m10-bmc.h>
>> +
>> +#define M10BMC_TIMESTAMP_FREQ			60	/* 60 secs between updates */
>> +
>> +struct m10bmc_log_cfg {
>> +	int el_size;
>> +	unsigned long el_off;
>> +
>> +	int id_size;
>> +	unsigned long id_off;
>> +
>> +	int bi_size;
>> +	unsigned long bi_off;
>> +};
>> +
>> +struct m10bmc_log {
>> +	struct device *dev;
>> +	struct intel_m10bmc *m10bmc;
>> +	unsigned int freq_s;		/* update frequency in seconds */
>> +	struct delayed_work dwork;
>> +	const struct m10bmc_log_cfg *log_cfg;
>> +	struct nvmem_device *bmc_event_log_nvmem;
>> +	struct nvmem_device *fpga_image_dir_nvmem;
>> +	struct nvmem_device *bom_info_nvmem;
>> +};
>> +
>> +static void m10bmc_log_time_sync(struct work_struct *work)
>> +{
>> +	struct delayed_work *dwork = to_delayed_work(work);
>> +	const struct m10bmc_csr_map *csr_map;
>> +	struct m10bmc_log *log;
>> +	s64 time_ms;
>> +	int ret;
>> +
>> +	log = container_of(dwork, struct m10bmc_log, dwork);
>> +	csr_map = log->m10bmc->info->csr_map;
>> +
>> +	time_ms = ktime_to_ms(ktime_get_real());
>> +	ret = regmap_write(log->m10bmc->regmap, csr_map->base + M10BMC_N6000_TIME_HIGH,
>> +			   upper_32_bits(time_ms));
>> +	if (!ret) {
>> +		ret = regmap_write(log->m10bmc->regmap, csr_map->base + M10BMC_N6000_TIME_LOW,
>> +				   lower_32_bits(time_ms));
>> +	}
>> +	if (ret)
>> +		dev_err_once(log->dev, "Failed to update BMC timestamp: %d\n", ret);
>> +
>> +	schedule_delayed_work(&log->dwork, log->freq_s * HZ);
>> +}
>> +
>> +static ssize_t time_sync_frequency_store(struct device *dev, struct device_attribute *attr,
>> +					 const char *buf, size_t count)
>> +{
>> +	struct m10bmc_log *ddata = dev_get_drvdata(dev);
>> +	unsigned int old_freq = ddata->freq_s;
>> +	int ret;
>> +
>> +	ret = kstrtouint(buf, 0, &ddata->freq_s);
>> +	if (ret)
>> +		return ret;
>> +
>> +	if (old_freq)
>> +		cancel_delayed_work_sync(&ddata->dwork);
>> +
>> +	if (ddata->freq_s)
>> +		m10bmc_log_time_sync(&ddata->dwork.work);
>> +
>> +	return count;
>> +}
>> +
>> +static ssize_t time_sync_frequency_show(struct device *dev, struct device_attribute *attr,
>> +					char *buf)
>> +{
>> +	struct m10bmc_log *ddata = dev_get_drvdata(dev);
>> +
>> +	return sysfs_emit(buf, "%u\n", ddata->freq_s);
>> +}
>> +static DEVICE_ATTR_RW(time_sync_frequency);
>> +
>> +static struct attribute *m10bmc_log_attrs[] = {
>> +	&dev_attr_time_sync_frequency.attr,
>> +	NULL,
>> +};
>> +ATTRIBUTE_GROUPS(m10bmc_log);
>> +
>> +static int bmc_nvmem_read(struct m10bmc_log *ddata, unsigned int addr,
>> +			  unsigned int off, void *val, size_t count)
>> +{
>> +	struct intel_m10bmc *m10bmc = ddata->m10bmc;
>> +	int ret;
>> +
>> +	ret = m10bmc->flash_bulk_ops->read(m10bmc, val, addr + off, count);
>> +	if (ret) {
>> +		if (ret != -EBUSY)
>> +			dev_err(ddata->dev, "failed to read flash %x (%d)\n", addr, ret);
>> +		return ret;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int bmc_event_log_nvmem_read(void *priv, unsigned int off, void *val, size_t count)
>> +{
>> +	struct m10bmc_log *ddata = priv;
>> +
>> +	return bmc_nvmem_read(ddata, ddata->log_cfg->el_off, off, val, count);
>> +}
>> +
>> +static int fpga_image_dir_nvmem_read(void *priv, unsigned int off, void *val, size_t count)
>> +{
>> +	struct m10bmc_log *ddata = priv;
>> +
>> +	return bmc_nvmem_read(ddata, ddata->log_cfg->id_off, off, val, count);
>> +}
>> +
>> +static int bom_info_nvmem_read(void *priv, unsigned int off, void *val, size_t count)
>> +{
>> +	struct m10bmc_log *ddata = priv;
>> +
>> +	return bmc_nvmem_read(ddata, ddata->log_cfg->bi_off, off, val, count);
>> +}
>> +
>> +static struct nvmem_config bmc_event_log_nvmem_config = {
>> +	.name = "bmc_event_log",
>> +	.stride = 4,
>> +	.word_size = 1,
>> +	.reg_read = bmc_event_log_nvmem_read,
>> +	.id = NVMEM_DEVID_AUTO,
>> +};
>> +
>> +static struct nvmem_config fpga_image_dir_nvmem_config = {
>> +	.name = "fpga_image_directory",
>> +	.stride = 4,
>> +	.word_size = 1,
>> +	.reg_read = fpga_image_dir_nvmem_read,
>> +	.id = NVMEM_DEVID_AUTO,
>> +};
>> +
>> +static struct nvmem_config bom_info_nvmem_config = {
>> +	.name = "bom_info",
>> +	.stride = 4,
>> +	.word_size = 1,
>> +	.reg_read = bom_info_nvmem_read,
>> +	.id = NVMEM_DEVID_AUTO,
>> +};
>> +
>> +static int m10bmc_log_probe(struct platform_device *pdev)
>> +{
>> +	const struct platform_device_id *id = platform_get_device_id(pdev);
>> +	struct intel_m10bmc *m10bmc = dev_get_drvdata(pdev->dev.parent);
>> +	struct nvmem_config nvconfig;
>> +	struct m10bmc_log *ddata;
>> +
>> +	if (WARN_ON_ONCE(!m10bmc->flash_bulk_ops))
>> +		return -ENODEV;
>> +
>> +	ddata = devm_kzalloc(&pdev->dev, sizeof(*ddata), GFP_KERNEL);
>> +	if (!ddata)
>> +		return -ENOMEM;
>> +
>> +	ddata->dev = &pdev->dev;
>> +	ddata->m10bmc = m10bmc;
>> +	ddata->freq_s = M10BMC_TIMESTAMP_FREQ;
>> +	INIT_DELAYED_WORK(&ddata->dwork, m10bmc_log_time_sync);
>> +	ddata->log_cfg = (struct m10bmc_log_cfg *)id->driver_data;
>> +	dev_set_drvdata(&pdev->dev, ddata);
>> +
>> +	if (ddata->log_cfg->el_size > 0) {
>> +		m10bmc_log_time_sync(&ddata->dwork.work);
>> +
>> +		memcpy(&nvconfig, &bmc_event_log_nvmem_config, sizeof(bmc_event_log_nvmem_config));
>> +		nvconfig.dev = ddata->dev;
>> +		nvconfig.priv = ddata;
>> +		nvconfig.size = ddata->log_cfg->el_size;
>> +
>> +		ddata->bmc_event_log_nvmem = devm_nvmem_register(ddata->dev, &nvconfig);
>> +		if (IS_ERR(ddata->bmc_event_log_nvmem))
>> +			return PTR_ERR(ddata->bmc_event_log_nvmem);
>> +	}
>> +
>> +	if (ddata->log_cfg->id_size > 0) {
>> +		memcpy(&nvconfig, &fpga_image_dir_nvmem_config, sizeof(fpga_image_dir_nvmem_config));
>> +		nvconfig.dev = ddata->dev;
>> +		nvconfig.priv = ddata;
>> +		nvconfig.size = ddata->log_cfg->id_size;
>> +
>> +		ddata->fpga_image_dir_nvmem = devm_nvmem_register(ddata->dev, &nvconfig);
>> +		if (IS_ERR(ddata->fpga_image_dir_nvmem))
>> +			return PTR_ERR(ddata->fpga_image_dir_nvmem);
>> +	}
>> +
>> +	if (ddata->log_cfg->bi_size > 0) {
>> +		memcpy(&nvconfig, &bom_info_nvmem_config, sizeof(bom_info_nvmem_config));
>> +		nvconfig.dev = ddata->dev;
>> +		nvconfig.priv = ddata;
>> +		nvconfig.size = ddata->log_cfg->bi_size;
>> +
>> +		ddata->bom_info_nvmem = devm_nvmem_register(ddata->dev, &nvconfig);
>> +		if (IS_ERR(ddata->bom_info_nvmem))
>> +			return PTR_ERR(ddata->bom_info_nvmem);
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int m10bmc_log_remove(struct platform_device *pdev)
>> +{
>> +	struct m10bmc_log *ddata = dev_get_drvdata(&pdev->dev);
>> +
>> +	cancel_delayed_work_sync(&ddata->dwork);
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct m10bmc_log_cfg m10bmc_log_n6000_cfg = {
>> +	.el_size = M10BMC_N6000_ERROR_LOG_SIZE,
>> +	.el_off = M10BMC_N6000_ERROR_LOG_ADDR,
>> +
>> +	.id_size = M10BMC_N6000_FPGA_IMAGE_DIR_SIZE,
>> +	.id_off = M10BMC_N6000_FPGA_IMAGE_DIR_ADDR,
>> +
>> +	.bi_size = M10BMC_N6000_BOM_INFO_SIZE,
>> +	.bi_off = M10BMC_N6000_BOM_INFO_ADDR,
>> +};
>> +
>> +static const struct platform_device_id intel_m10bmc_log_ids[] = {
>> +	{
>> +		.name = "n6000bmc-log",
>> +		.driver_data = (unsigned long)&m10bmc_log_n6000_cfg,
>> +	},
>> +	{ }
>> +};
>> +
>> +static struct platform_driver intel_m10bmc_log_driver = {
>> +	.probe = m10bmc_log_probe,
>> +	.remove = m10bmc_log_remove,
>> +	.driver = {
>> +		.name = "intel-m10-bmc-log",
>> +		.dev_groups = m10bmc_log_groups,
>> +	},
>> +	.id_table = intel_m10bmc_log_ids,
>> +};
>> +module_platform_driver(intel_m10bmc_log_driver);
>> +
>> +MODULE_DEVICE_TABLE(platform, intel_m10bmc_log_ids);
>> +MODULE_AUTHOR("Intel Corporation");
>> +MODULE_DESCRIPTION("Intel MAX 10 BMC log driver");
>> +MODULE_LICENSE("GPL");
>> diff --git a/drivers/mfd/intel-m10-bmc-pmci.c b/drivers/mfd/intel-m10-bmc-pmci.c
>> index 8821f1876dd6..f8803b7bb98e 100644
>> --- a/drivers/mfd/intel-m10-bmc-pmci.c
>> +++ b/drivers/mfd/intel-m10-bmc-pmci.c
>> @@ -350,6 +350,7 @@ static struct regmap_config m10bmc_pmci_regmap_config = {
>>  static struct mfd_cell m10bmc_pmci_n6000_bmc_subdevs[] = {
>>  	{ .name = "n6000bmc-hwmon" },
>>  	{ .name = "n6000bmc-sec-update" },
>> +	{ .name = "n6000bmc-log" },
>>  };
>>  
>>  static const struct m10bmc_csr_map m10bmc_n6000_csr_map = {
>> diff --git a/include/linux/mfd/intel-m10-bmc.h b/include/linux/mfd/intel-m10-bmc.h
>> index 1812ebfa11a8..1079e580e9e6 100644
>> --- a/include/linux/mfd/intel-m10-bmc.h
>> +++ b/include/linux/mfd/intel-m10-bmc.h
>> @@ -125,6 +125,9 @@
>>  #define M10BMC_N6000_SYS_BASE			0x0
>>  #define M10BMC_N6000_SYS_END			0xfff
>>  
>> +#define M10BMC_N6000_TIME_LOW			0x178
>> +#define M10BMC_N6000_TIME_HIGH			0x17c
>> +
>>  #define M10BMC_N6000_DOORBELL			0x1c0
>>  #define M10BMC_N6000_AUTH_RESULT		0x1c4
>>  #define AUTH_RESULT_RSU_STATUS			GENMASK(23, 16)
>> @@ -134,6 +137,16 @@
>>  #define M10BMC_N6000_MAC_LOW			0x20
>>  #define M10BMC_N6000_MAC_HIGH			(M10BMC_N6000_MAC_LOW + 4)
>>  
>> +/* Addresses for BMC log data in FLASH */
>> +#define M10BMC_N6000_ERROR_LOG_ADDR		0x7fb0000
>> +#define M10BMC_N6000_ERROR_LOG_SIZE		0x40000
>> +
>> +#define M10BMC_N6000_FPGA_IMAGE_DIR_ADDR	0x7ff6000
>> +#define M10BMC_N6000_FPGA_IMAGE_DIR_SIZE	0x3000
>> +
>> +#define M10BMC_N6000_BOM_INFO_ADDR		0x7ff0000
>> +#define M10BMC_N6000_BOM_INFO_SIZE		0x2000
>> +
>>  /* Addresses for security related data in FLASH */
>>  #define M10BMC_N6000_BMC_REH_ADDR		0x7ffc004
>>  #define M10BMC_N6000_BMC_PROG_ADDR		0x7ffc000
>> -- 
>> 2.30.2
>>

