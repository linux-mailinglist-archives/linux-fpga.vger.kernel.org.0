Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D047A46208F
	for <lists+linux-fpga@lfdr.de>; Mon, 29 Nov 2021 20:32:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242036AbhK2Tf7 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 29 Nov 2021 14:35:59 -0500
Received: from mga11.intel.com ([192.55.52.93]:18397 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351964AbhK2Td6 (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 29 Nov 2021 14:33:58 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10183"; a="233556303"
X-IronPort-AV: E=Sophos;i="5.87,273,1631602800"; 
   d="scan'208";a="233556303"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2021 11:25:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,273,1631602800"; 
   d="scan'208";a="600317798"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by fmsmga002.fm.intel.com with ESMTP; 29 Nov 2021 11:25:36 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 29 Nov 2021 11:25:36 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Mon, 29 Nov 2021 11:25:36 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.170)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Mon, 29 Nov 2021 11:25:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m+iOiHsvpuL8rKjKNRt2Xpx8be33+PHop4VPSEucMbln6PI8Thux66mW1f6vHSrsoTcX4g/w9+xb4IgZ+Ztk0yNUUZaujvwv0DRfxvn65L8ufrHvOql5+3VDk/UcCZqqJIJg/U2paWXnB+cTbzVVZDMJrbzp3wNwDE3j7rTfrGv6FaV7b7umcEuo7BrjLWPTa809C8o8FYA6wgd+y+3GK+ft+mAA0KKItfn5em/LTcf4wkmB0K2tJ6XmmZzusIAnGvVyjciX1qc0dOweNvnsemc421hZWrBarKUn2tt+EHFNEieZR2gj0SDvFOHMIYIowT7ylexU3WRGp61JA+DVyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s2OMAPEYsPGm81yx8JqN5oBqA3BYPVz+b14LQ3vhe40=;
 b=hCnxvK+9xAon/wQ3fhC8KJfi0mHo4SyDEZYBmVJgVMcZiRigOlXy4hR+oWKrLxGK/8XretdAF4jqdZ61zcSDjJ+KZ4nkD9oL42da+16e3CXqhYbInCuEArzFRilDhAkW8NBLjOpCAwc8/hR1lFMDkpMG4XyNFgl17ZaDzD3ezKthn8zDfQrvZJK8MSreqZqWQlPsemfX6OYlc/acip6/nI2DIhpCsOl36sqcsfDjc1CpZ6Y03CniwGcky5w1uJ9HZpEezErygWfJwgcPoZmribTLYdtVrm88zQOApMGzSMaXexU37K5GxsnfzRr1R1CPxa8d4N0PSOWHwbgYdAhrZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s2OMAPEYsPGm81yx8JqN5oBqA3BYPVz+b14LQ3vhe40=;
 b=diJihg4kwfmglFS2GMANbusEZ3ghvPCmNiYN1xQOf9eNA6JGJ1Gf/d26i7YI6f9wzF2Wv2KF+BIHjfyjXOODPrTlmjz2mK4VunI05102k6qqZpAiOsC/aTTA2wt66/JmKIIm1E6TOuArTw1pgORX62YQb/o4swue/oMlRUz2ECg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA2PR11MB5163.namprd11.prod.outlook.com (2603:10b6:806:113::20)
 by SN6PR11MB3405.namprd11.prod.outlook.com (2603:10b6:805:c0::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22; Mon, 29 Nov
 2021 19:25:32 +0000
Received: from SA2PR11MB5163.namprd11.prod.outlook.com
 ([fe80::d455:2add:2fc6:99bb]) by SA2PR11MB5163.namprd11.prod.outlook.com
 ([fe80::d455:2add:2fc6:99bb%3]) with mapi id 15.20.4734.024; Mon, 29 Nov 2021
 19:25:32 +0000
Subject: Re: [PATCH] fpga: stratix10-soc: Do not use ret uninitialized in
 s10_probe()
To:     Nathan Chancellor <nathan@kernel.org>,
        Moritz Fischer <mdf@kernel.org>, "Wu Hao" <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>
CC:     Tom Rix <trix@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Dan Carpenter" <dan.carpenter@oracle.com>,
        <linux-fpga@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <llvm@lists.linux.dev>
References: <20211129161009.3625548-1-nathan@kernel.org>
From:   Russ Weight <russell.h.weight@intel.com>
Message-ID: <41939d45-76ef-e59f-135f-b5c05cd4f5e5@intel.com>
Date:   Mon, 29 Nov 2021 11:24:26 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
In-Reply-To: <20211129161009.3625548-1-nathan@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: MW3PR05CA0020.namprd05.prod.outlook.com
 (2603:10b6:303:2b::25) To SA2PR11MB5163.namprd11.prod.outlook.com
 (2603:10b6:806:113::20)
MIME-Version: 1.0
Received: from [10.0.2.4] (50.43.42.212) by MW3PR05CA0020.namprd05.prod.outlook.com (2603:10b6:303:2b::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11 via Frontend Transport; Mon, 29 Nov 2021 19:25:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a8cff057-9b38-4269-b2ad-08d9b36e0291
X-MS-TrafficTypeDiagnostic: SN6PR11MB3405:
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <SN6PR11MB34050F652EC0F4C54CCE51A5C5669@SN6PR11MB3405.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:14;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U7v1I3zHHk72CQElwUFPVmpPPIRkhvmapeCsJAnlrzop1EGgtafjJTHiZnbkp6xk6xgOvfpPDxWak0iRkRPUpSZBkJ5UGM1xgrhB/VveY9taS6SPEHTEBhGaFNPMxrqwVyoN9qcdKLCg62tV/PMkrljc3zjc2NhsCEGiVgdPPzAST3WULTo0QBkI8XRxOAhVRKowiTxobJZGHGyR75CZqkDie3Surrkif2H1XQEgCyBO7QNrk3F1Q0Gu+3BQK4DpG9ihBnG+yaY+8X5ea6MNTmY7Cu1XraWEJHvXifcvl31GTHc8/1U/B0wqCvk1/cRyj4VU9vJ+nZvwtYNhl9PBoXtdAb5m0+QVFV5RcqYcmFTNMVnBw+zdgqINySWPtxVdpnhgN9NdY28jfdLeYLJx08uzB6VnLnF/tM1lHyi/1+eOIr8+z2j24ijGGysTDjbvSEW/MCpLbdo9dYaNxp5BA7cV/LbDSyayVD5d8Q12qk2J8qIrrhpWjlrhVa+5ir04Ph5YVY8M0H9ElwVjK6Avovx2L152xBg99Fc38tRprxIOa/BrsKEtpcwazVcVhNLxbosRixSARTJHCMSCJNUoPippawJzrjksOaccoQklFd0EPuBNbYd6Ny0UvuQgkaHIcFzknd1w4acBw/soLQtDJjiP9eJOQzmcc83ZingsfH2XndGKcILrxoWU4J5auP31pvXCfgARq+PY67Io0V1FUOtux3IW4CvvxP3g5F8Qu7E4D6aQJ7y9P52ne+WcbTuA1BStWH76gqps3WRUDdmP2YEw2F0dpWWj5fgL4ClPXpN3q148lHD2LZrVanOkbuHOgW/Wt4rmxegEOtqAMgy4sg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB5163.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(5660300002)(83380400001)(8676002)(66946007)(110136005)(16576012)(508600001)(36756003)(38100700002)(66476007)(31696002)(186003)(31686004)(2906002)(316002)(54906003)(8936002)(6636002)(966005)(86362001)(66556008)(82960400001)(26005)(6666004)(6486002)(4326008)(53546011)(2616005)(956004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VXhjWE41OWlGakFVZ2lQNlNFeWJ5cDhNbmx1cDNzS2w1b3lKZXcrOU1COFd2?=
 =?utf-8?B?cDZZUWJwdVNvQ1BoYkMvN0Y0TUEvOWRiaGY1bUtXckU3cm9NVkJpSWpxczBJ?=
 =?utf-8?B?UlFmYVdKTmJlakNxUHpvd0MxeTVSRmlJb2RxYU5mUy8zTFdzUmxsZWpXa0p5?=
 =?utf-8?B?Ym1CYWlhWEZ6NXJTVWQyMHJjbE11NTJ1TkgwUFZHVzBzc2tjYW1Oc3ZZZm9O?=
 =?utf-8?B?QzVpUkhkM3VmdUdPSDViWkxlTTIrNmJ0VktQR3pMMXA2dWgwb0Z2WXIvMjd2?=
 =?utf-8?B?RHRTUGVzcExwWXBLYVg2ajJObzhBQ0dabk4vWE1ERXpFV214ODVyeklkYjRV?=
 =?utf-8?B?REI5RnQ2SXhZWVdWYVhwRWpBejdPblV3elM5bFlvemhWSEQ3L2tmcVgwU1Rr?=
 =?utf-8?B?N0YxUWE1WFl5RENwZENRZnRnM2RtUHFUbXRnVHE3VjFoT01ZSjFjZFVjR1RT?=
 =?utf-8?B?Zk43V2w1WkYwckpGT0NPWEozR3V1TE5VYzlNaDdBWkN2UW1Kam1QcWw0emFq?=
 =?utf-8?B?cktMdmMySjRIdzVIakM5N0c0S1gvM3F5YmpnZmpjNk4rUzJUSTdLZUZaVlJz?=
 =?utf-8?B?bHRSby9uVGlKbUFteFVTZExKN2VURmZ4cTYrVnNTM0wxNHJTOVQyUS9pTCtp?=
 =?utf-8?B?NGt5bXZuZ285bC9aNHpqYW5lc0NDQVNlaExkc1NUdGIyZ2kxYjQ0dE83THB2?=
 =?utf-8?B?ZGlXSkorNGZta1hSaTBzeW5VaTR1WldCbnZMRlZnL0luTDhabVFlckhIZVh6?=
 =?utf-8?B?NGFJTkVWdUtIN0h3cVQvRCtHYXZFdDJkSUhab1YvcmQzTjdZdkJRbktWbXhK?=
 =?utf-8?B?TUdySW1WcGZ5NGdVbC9oTEVPcHE5MjlUbTFPNkhMcHR1bUM5aEpkSkZRU0RX?=
 =?utf-8?B?Y2QxemV5WnNjbGlHSHpJSkE5SXNGRGpsbHg3NW1kM29wVDJPU2VCdlNLNWJ2?=
 =?utf-8?B?RVJZU2t4SXBXRGNBUGJERWNPYis0bG01bUpranJ5UWFYb083QzE4UHAxTFNI?=
 =?utf-8?B?bVFpUUVrcUNYNGJhMlUyY2pKYUxUTU9USUdTaDQyeEFQVGt6WG54bm9BeUtF?=
 =?utf-8?B?NXlYMVJUR0hVU2FoWm9GRml0WjFOVUJEeWpQQlhSL0ExRGxNNlp2eTQ0TFN2?=
 =?utf-8?B?dVo1blpnbVRRK0E0Q0g3S3RhK3NaOTVkMTRTbWxsVy9KMktqbVNVQzI1VkxT?=
 =?utf-8?B?SmVhSFIvdHZKSUFNVHNTRnZhbktpWlAyeU5HZXUrU3JMT1RMVUIvc0N6cUY5?=
 =?utf-8?B?cytudTVFZmFOTXNWWGs2Wnl6VStGekVka2lORlVlTHF4OEU1RmExeW1nTzdl?=
 =?utf-8?B?eDNXdGRscFZYSmlwYjB0NzRCOTQrY3RKTW9UaVdiTTBBMGNJa3VrNmo3dDBC?=
 =?utf-8?B?WStHdkpubFJTS3hTMkdRSjY5Yk83ZG5NNDNjdmt0YUR3OUNIS1hVdTU2S1p2?=
 =?utf-8?B?Rmt2dFdCa2cvemRoalFsd1ZmZTF1STF2WFNyblRkSTFnbGhyU0ZCa1FDbVJF?=
 =?utf-8?B?ZWk1MklOa1phbjJlVG4zQi9pSGdoZks3eER3WkUvaVpWTzM2WGZ1QlRZLzRT?=
 =?utf-8?B?YUFPWDdZeWdyckMyekcycDU0UUFYUUswSURZOGxaNUVlWnRnSmZ0WjZJKy9Z?=
 =?utf-8?B?MGVVWHVQaG1kcllPYmd0Y0ZjZXgrTXl4UTVuNmdjVDFaN3ludDVmUW44WVBh?=
 =?utf-8?B?NytzbDVhSkRQV0hNN0V2REdack11Sks2MndKL2lYOEx2L0pEaVNWTjZ4dDZK?=
 =?utf-8?B?WjBGZVlFa0xPd0Q5cGRTVU5XNjdYVnZJM0EwcXBINzFjMWVxem5iT1J2c3da?=
 =?utf-8?B?MzVjenlRQlZCZmxMNEp1VUM2ZHdmWENNZlRHcnd2dGNobk05VWJLdWJMYVp3?=
 =?utf-8?B?dFNxeklyL1M5dnZLakYycnNDN2IyY245WU5lR3dtanNQTWkxRldWbk5YTFlD?=
 =?utf-8?B?cTdKdS9JSEN1QU1FVmh1U2Iwb1MvK294STdGUWY3SWdCS3B5T3c3NUxNZmV0?=
 =?utf-8?B?aTNxdFVhalVEc200eWwyekhjK2tsUlc0Z0JrNThvK2hTdTh3dWtNdTg0U2J6?=
 =?utf-8?B?aUZBNnRpbjRrYUczWU4za2cwVE1WcS93aTgvSEQ2elBBSlBOSlRpdG5BU3E1?=
 =?utf-8?B?SUlHRzM0aGRVMkdBd200Sk8rckxlRHlJRk92akMvT3JLVGNMSWRvRVVRbzFs?=
 =?utf-8?B?amQ4Z1RFNU9JcGFOWHRNSWtXUXZrOWJJdmhZM2l1MEZWSHZNQS9oRkVOUXVH?=
 =?utf-8?B?QzIyaWc3R3Rwbm96SWVQbHFGTTVRPT0=?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a8cff057-9b38-4269-b2ad-08d9b36e0291
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB5163.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2021 19:25:32.2852
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BM9+gA5DyFryj6/pMkqW7H9rZfiyXTt9C/T3mPIYfWqkjQ979uU+pXwggEtY91YGxsgg9zhk999ofk5KyPKsibUH8HXTOrRRE9KBm/vboOI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3405
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Reviewed-by: Russ Weight <russell.h.weight@intel.com>

Thanks,
- Russ

On 11/29/21 8:10 AM, Nathan Chancellor wrote:
> Clang warns:
>
> drivers/fpga/stratix10-soc.c:431:9: warning: variable 'ret' is uninitialized when used here [-Wuninitialized]
>         return ret;
>                ^~~
> drivers/fpga/stratix10-soc.c:402:9: note: initialize the variable 'ret' to silence this warning
>         int ret;
>                ^
>                 = 0
> 1 warning generated.
>
> ret is only assigned in an error path now so just return 0 directly.
>
> Fixes: 4ba0b2c294fe ("fpga: mgr: Use standard dev_release for class driver")
> Link: https://github.com/ClangBuiltLinux/linux/issues/1517
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
>  drivers/fpga/stratix10-soc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/fpga/stratix10-soc.c b/drivers/fpga/stratix10-soc.c
> index 737d14c6e0de..357cea58ec98 100644
> --- a/drivers/fpga/stratix10-soc.c
> +++ b/drivers/fpga/stratix10-soc.c
> @@ -428,7 +428,7 @@ static int s10_probe(struct platform_device *pdev)
>  	}
>  
>  	platform_set_drvdata(pdev, mgr);
> -	return ret;
> +	return 0;
>  
>  probe_err:
>  	stratix10_svc_free_channel(priv->chan);
>
> base-commit: 8886a579744fbfa53e69aa453ed10ae3b1f9abac

