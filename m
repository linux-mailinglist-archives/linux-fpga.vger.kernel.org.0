Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F6F34748AE
	for <lists+linux-fpga@lfdr.de>; Tue, 14 Dec 2021 18:00:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233685AbhLNQ77 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 14 Dec 2021 11:59:59 -0500
Received: from mga11.intel.com ([192.55.52.93]:43497 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233680AbhLNQ76 (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 14 Dec 2021 11:59:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639501198; x=1671037198;
  h=subject:to:cc:references:from:message-id:date:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WqmtGEqKm/SdyWcQmM9/vuE09tAsAwQnGjMpBQTnTBs=;
  b=E4DjCcZdwin6wy4Ym0DB1100DY7pcEuiyu3GGmwGFBecZtzSMQNMWIRU
   vpeJivJN7A/gensHYgFooHot3ZykObaGtcvbxyIeKRyNIHqWP8docJ3OW
   xkv33AIvZxZzWlhihUOquhn30DRmTcj6OblCUuX8fyyPHtSr2rm6svT3l
   ZwzmELiFswhlzU1KMf8Zr8UL3EEITght7j272bYBZi5Q1QwSgUuXaJodj
   JC+zyaP9AGy2tBZu4P+hQp2pIo0yKXuVMBW4Yw1J6+569cDgjWtjxRrel
   c8FJ7aM4N15UXXurTMSoQjaWZeqyZWbpfE/hYbdMsmbZF6kk6QxGDah5j
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10197"; a="236557505"
X-IronPort-AV: E=Sophos;i="5.88,205,1635231600"; 
   d="scan'208";a="236557505"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2021 08:59:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,205,1635231600"; 
   d="scan'208";a="519288111"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga007.fm.intel.com with ESMTP; 14 Dec 2021 08:59:57 -0800
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 14 Dec 2021 08:59:57 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Tue, 14 Dec 2021 08:59:57 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Tue, 14 Dec 2021 08:59:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BLr45DyJcnbarcZ9MFDecKj/5gjlApbvbLUiHPnD10gB1iuu3MuhejTmHaPFq76dxULasHYKyDYKGwvHdxffMT1crvTviNMjuz14iPlFcXZ+UyhPskKCp9m2+CxyZxHMRqsVuNfxWrzIq89fxw1ORRDVwW0p7IRZfGT+HXljsml+CZfF/WFBgi4Nxg6b4UuucazPtvPadJOcfU+iXYQ1yNzViICPdjuQo51i9vI5ExTnEDNhTvPRf59dnn2bjq39oYUqJujWdB1beWvYhjdVROrkvlbOun4w/pLYRqLh0PATD8A6nKmkVqcPqWfuIMLiMbBgRoZZ8ACJH+ARorS9dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1PDzsiyk0q/OUZBaPkBgVLmiXjbPL+uDoDDO/i7b5zQ=;
 b=d6SjPItsieLUJPkJTugebKtBdAIWQZUCLNWN3xCv9CUpBAtyv2K2w2crHKugEwziJck1XTlOo1r2IBRK+RP3j2YKI88CFqKDi4G6JQaSEd2xXxeMTY5MIk1L/+AqzHGQ9POLceJwEHM+NoaZs6N+YC3jCHjHE+PRiA2mXcFpFIsgWv+hpz9ccd+kZVmMXMEGXpfH+XNqzZGTTJsn20VOfS5apQDR5xwds7GjrRHA1lxIZCc39QHOw5jNnqmR6KDCsZUJWGRXr//NYGY7a5OgVAbpgVm4wm+hywX4xUMzSeMX/h1KwuqLAdfa3RCY+jKqrczhzind0rYaZY/Ck9/gIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1PDzsiyk0q/OUZBaPkBgVLmiXjbPL+uDoDDO/i7b5zQ=;
 b=DwtQtz+g3ucpF1Ok+UZntP2o9TtzxXrXD9slXI6BqvVoNF55RAgfDgNG5r3bmHlUMLjAGU+VIxJ+wpqf3BN2OK2my3jFH3eHzXZ12HW6Nows5TimooaoOmed+kTYc7mFoC8k+fhXqcmrv6rmzJT6xvjC/Nga32w9UCnQ+WWmiCk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA2PR11MB5163.namprd11.prod.outlook.com (2603:10b6:806:113::20)
 by SA0PR11MB4591.namprd11.prod.outlook.com (2603:10b6:806:9c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Tue, 14 Dec
 2021 16:59:52 +0000
Received: from SA2PR11MB5163.namprd11.prod.outlook.com
 ([fe80::857a:947e:f2e4:b78d]) by SA2PR11MB5163.namprd11.prod.outlook.com
 ([fe80::857a:947e:f2e4:b78d%2]) with mapi id 15.20.4778.017; Tue, 14 Dec 2021
 16:59:52 +0000
Subject: Re: [PATCH] fpga: stratix10-soc: cleanup double word in comment
To:     <trix@redhat.com>, <mdf@kernel.org>, <hao.wu@intel.com>,
        <yilun.xu@intel.com>
CC:     <linux-fpga@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20211214154749.2463147-1-trix@redhat.com>
From:   Russ Weight <russell.h.weight@intel.com>
Message-ID: <6d5f9555-47c5-c84e-a62d-73fbee78a483@intel.com>
Date:   Tue, 14 Dec 2021 08:59:45 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
In-Reply-To: <20211214154749.2463147-1-trix@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: MWHPR10CA0061.namprd10.prod.outlook.com
 (2603:10b6:300:2c::23) To SA2PR11MB5163.namprd11.prod.outlook.com
 (2603:10b6:806:113::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 26ffb519-3f00-4e2e-4bbe-08d9bf23259a
X-MS-TrafficTypeDiagnostic: SA0PR11MB4591:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <SA0PR11MB4591D0B630607D5465407D15C5759@SA0PR11MB4591.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:639;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0CXJygm87uS1tX+oOscysCCWUGMislimQwqZf5oreWY+rCG6hc9mO22PLNZ0ibb9uR00Uia4iPJw0XjKHnOc9cBvvBAE2do2jlVRcB2WoaNeO3guA4aMb/jBAvSFmwCtsn+PNGvsG8QVDKJ1jrFoe9Ed4aDPfobrKf8A+uQemO6pyX2dH1dwq7e2YQcQmzTlFzblv99D/+RratZ0vuEkRLTrsV0AYTtCod6sU57sAKwd4EZh/8WGbJrff+/giFR2M+jHuW130Ly4b1srVryebEeW2sQxu3ZdLfsGL7ezOjGtVCYEVakey7/pKKCZn+k2UVLsemIoKq9PhXgbvceSdx5sSBCM0xvtAAWNBFcv7xlwKTK7+k3yeohebf3rMQb3zYztaKacU0THSUegJIeIXcoKOZ+116wDqkC03Hlg6zOAupQuWOlpZ3Dagb9omkK509nDq6jMsiHxglKK/U8pV+QPcyhT40tjvdwcDNvt7dA2u581JvyLhVOHlUl6rmU4P9z+0JL3925lWhhYMvhfROuKlUh7EveuQUqbtZj5woPtVJzceTEgNraFcIJ4/zofOYGFfY3yKgX8Jqy3kT5vBeWKZvAC6XR24wlj67UOHo8DsGZOHCyMqd2/eH59CoqI/ztd1/br7DyFUgJH+/yYqJtGjaCfnRCCo9ofpA0nBqjUAvjpyR0VFOkzgKTm2veOtkSIYV1PYvi+yjrPnM/zahFrkqBASy1izbb+p/mqTnRVShO9rqe2u4Sk1qo2tsKH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB5163.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8676002)(36756003)(66946007)(66556008)(38100700002)(66476007)(6666004)(186003)(53546011)(6506007)(8936002)(508600001)(82960400001)(316002)(31686004)(86362001)(2616005)(6512007)(5660300002)(31696002)(6636002)(4326008)(83380400001)(6486002)(4744005)(2906002)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q3QvcHh3NHVCVlc0SS96R050REoxOVNZd3JPT1lNSUNPU2JiV2QzNG8ya1JW?=
 =?utf-8?B?SzFqazYvdDRibDZoc3l1bGR0MVBpWFo0OU5VaVp0RVFvYWRGKzZKTmk1ajc0?=
 =?utf-8?B?bWxYLzVQN2RqKzJ6d0psYXZUbWVmSkk2dE5EQnJVdkREc2xDS0JveEtBek05?=
 =?utf-8?B?L0FtaXl1L3lnazJOc2JNZm5NU1NVTjJTMzB4UnY2SE1rMjI5UnY3RTBxYmdv?=
 =?utf-8?B?bEZVREhVRE9FbjFHRXRSVldyQ3ZVVEg2Q2JkdVNiaFZKbmQvTDdGQnRxT0N4?=
 =?utf-8?B?ZjVVYkwva0tDazJwTnpVWitvNVRyOHBMUWVQOFMyNnJvMnFSSzMzSTNNWEtL?=
 =?utf-8?B?K1c1Y0tjVlFQVGIzcEtYUXRhbkQ1Y2dEN1NtdHlNSUcvY1NLbU4rQUt4TnNN?=
 =?utf-8?B?ZWdueTRCajlwNFk3dWlkUHpMcTBEQlNMOHhRYytjWDJoZERCN0Q0SEUwcTZj?=
 =?utf-8?B?d1NLSU5rOVVQUWR3WW1KdnpzeUZjSkhLM3FjQnZ0SkE0UHc2UXlaMTdOVHJI?=
 =?utf-8?B?TklnSkViWW1wSVdLWStFRmNtS3FiU3J4Nm9xZ3AzUWd6a0JtY0RYMFpWMWJY?=
 =?utf-8?B?SFBGdE50emVkNkw0OUViUGh6aWp6M2gzVVpUSEIrNFRtczVLcFFCOGhpM3lP?=
 =?utf-8?B?V1U5ODY1ZkhzYXlZYkUwUis3dEltdXlQdVlHeFIxV2QwelNZQW02VlFJOVVT?=
 =?utf-8?B?eFZMQkpjaStPbHcvRHZsNjdTWEJ5Zzh6ZTBWN2loRzZ0M3BTNU5KWnRZRlFT?=
 =?utf-8?B?NndlTXhONVcwNEFqemJQUC81aWZ4SjdkMzFwZkZyZmNnZkR2WmN2MEZreDVl?=
 =?utf-8?B?emxVT2hkbmRZSWN3VmEzczhwSnpiMjBDQjRXZlNxT1pWN0hpOFpYOFNKejdJ?=
 =?utf-8?B?OU15WXM1dmhvYldSMW9yR3JqVG0vdm5TcHp2am9RVnhSTkJadW9OUTBMYW9L?=
 =?utf-8?B?K1FaWDZJK1BtTEt0RWs0SWYrdkQzcExOelJSMkdoZEpyaEYxYXV5R2FWQW94?=
 =?utf-8?B?ZlUxcWxPdXdndVZqZm13ZmlYWnRLYjY1Y2dWYWpmeWZuYitqZWlyNlZZVXI0?=
 =?utf-8?B?QUpSR3NUaDdROXZzQnNrSkRSaWJhcTdiR0R0V0JqOFVidnZ6cW50dE5maEUw?=
 =?utf-8?B?WUxCTHA5Vk90d2s5WmU3b2pVYU5NVnJJamR0ZEJrck4yenpzc05aZHhQSThv?=
 =?utf-8?B?NGtEU1NIbWR2VEFSc29GaWs4UTY3YjRLdDM1cytHczRpQTEvWThkMW5CNSta?=
 =?utf-8?B?RXRjQ3Y2L0M2dlpRNjdacUxNM0N6RXJIVUtHNFFzb3M2Y1laREpKd2hMdDRt?=
 =?utf-8?B?WjB0UVIzK0hLWWZ2ZkZ4cDUwa2VJcW9VVGtBRVFDQkRqMEdGZENUYS90bEpV?=
 =?utf-8?B?NTBWOFhwNTVIUmNmSUdwRzZjNEdsSU8zQUtVeTJFNGJHWWlGeDdzVzhEVys5?=
 =?utf-8?B?NGVDaWN0azNkMStRamRXWWdPWWlPaGdGemJJNGEyMGRtSm9tVUpsc0VvRGNC?=
 =?utf-8?B?akpwc05Id0VxOHVNb0czRmN2NEtPY2x1WjBkcW1GRGg5QmtXc2l5VDJaVUdE?=
 =?utf-8?B?MEZlYS9nT1d2Rzk5N1BiMi9DMDJqNW0zSHhQZ1l2NVJrYXBSalBnRndoK1ly?=
 =?utf-8?B?Z2NRZzJ1ZC8wNVRsY2dqQTY4UGsvcy90cXQvWGQ1YVJhS2RwREVhdjZ1RW1R?=
 =?utf-8?B?dU9rZy9qODlLalBtN1dxZjZJb2wzZysxTU5YTk9xZTNIb2ZmaTFxcllXM2Zv?=
 =?utf-8?B?VDZmR2tlT1preS92UGUvQUZheUQ2M1lLbnBzMk1mNU9BOUhsNVB0RUN0dEJK?=
 =?utf-8?B?U3VJYmU5SW9ZVkV0bE5TTGJVRVByVWlHN3VLRW55ZEd1VTRYTERWd2VqdENo?=
 =?utf-8?B?WWkwV0JrR1Urc2I3eHhnRnBWOTkwOEh2QmpyL1locC9LWWJIUXcxVmNrRThJ?=
 =?utf-8?B?NFllUzR0Z2hPNDdGbTN1UnFOKzVnaTUwS2REb0dubW91NlRqdWFCMDlqOUcx?=
 =?utf-8?B?NzdtSGZvY1VNc3VXMWtPb3ZRd3BhNWdDb3FJYStvM2JtcEFhN2J6SWxJKzli?=
 =?utf-8?B?VnBzQVBkZlViRm55RDE1Z09WSlFuYjJCUFNJQllLRWtBR1hTZVFUUnVyNXpH?=
 =?utf-8?B?QnJGMC9wQ1cxQ0RJNHhkbm5wNDNKZGNRbTUvNDg4WVZCYUR2RGtTOUJleEhR?=
 =?utf-8?B?a1l6bHNYNUdHTG1aZTRkRm53WE94N3l5NVEycVZNOHRhcFhad1JZUVhmakNx?=
 =?utf-8?B?NTViR3IvQzRhUHZlb1RyeDcxUXRRPT0=?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 26ffb519-3f00-4e2e-4bbe-08d9bf23259a
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB5163.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2021 16:59:52.7139
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: baNf6Bsv3/gdi3dtW2/SAym5PFS8qyvGps3AXOCzYPFeLmNNdOOyk5ZSjB9Qk2Dh9H4MailMpBoETrugFFvfM3dZL5E94wVrjQ6eRnb8hA0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4591
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On 12/14/21 7:47 AM, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
>
> There are two that's in the comment, remove one.
>
> Signed-off-by: Tom Rix <trix@redhat.com>
Reviewed-by: Russ Weight <russell.h.weight@intel.com>

> ---
>  drivers/fpga/stratix10-soc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/fpga/stratix10-soc.c b/drivers/fpga/stratix10-soc.c
> index 357cea58ec98e..862069c95aa3c 100644
> --- a/drivers/fpga/stratix10-soc.c
> +++ b/drivers/fpga/stratix10-soc.c
> @@ -245,7 +245,7 @@ static int s10_send_buf(struct fpga_manager *mgr, const char *buf, size_t count)
>  	int ret;
>  	uint i;
>  
> -	/* get/lock a buffer that that's not being used */
> +	/* get/lock a buffer that is not being used */
>  	for (i = 0; i < NUM_SVC_BUFS; i++)
>  		if (!test_and_set_bit_lock(SVC_BUF_LOCK,
>  					   &priv->svc_bufs[i].lock))

