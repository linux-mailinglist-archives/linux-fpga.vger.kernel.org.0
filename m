Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD44468C3E2
	for <lists+linux-fpga@lfdr.de>; Mon,  6 Feb 2023 17:53:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229488AbjBFQve (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 6 Feb 2023 11:51:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbjBFQvc (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 6 Feb 2023 11:51:32 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 930572A16D;
        Mon,  6 Feb 2023 08:51:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675702275; x=1707238275;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gc1RiiisLLIHoU8Vp6PWUdegZGo7AQSj8h8EARNwiN4=;
  b=BfgEg5xZvbc0XBolTpWtj4IUPqJoHb+1VbPkQqkH/sqkk8P5l2cDhbf2
   Itdmq6FzYy3SJk4CaRH8/ZdztkeAhnH/tZz92GeQIQEZ6TXbVP6vJ1FfM
   SaUuOxSKA0cjAMEkOHgAcjasf5E9SE9r+otqOcnrzqcdUHeELTaYJtAME
   hxndaR12mys46AJLdBYtsv0WqZPFmkHgbhXccMvvCJxYsgYtI3zLKczbJ
   79nZ4FeXCnGlAvBixPyBhRzYg7zwapp4yIm3CR0YHNZ9IjNZzEPOHbCA+
   NZgK3Om29dYG+k4aeyKGpo5BtngIXbulD456kXxTU9JKGyVuJ9x0X/V2r
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="393851725"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="393851725"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 08:50:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="698896470"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="698896470"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga001.jf.intel.com with ESMTP; 06 Feb 2023 08:50:40 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 6 Feb 2023 08:50:39 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 6 Feb 2023 08:50:39 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.47) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 6 Feb 2023 08:50:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MfLCWlPFUbJPFWjlcU3n4qvH2vQdjXh5+3LvbzfJ+xggPr78AdA3HzoxABnbX8D0qKgY6J8+3ESj3ua498lkFhN7cRjlibD0w5KOdFEG7lNWI1P9BwJfxxutnoPjK24IUKiPbNvGY6aFsPgXbvi0hA00+FJ0hviM0oiEqwyhWsH5LQ/vPXHyOg3LyLL46ILCl17SKuOTmrlYkJQI6/irmgeZFWHyjmBOMT6QneUFV5zIu8R0xXXZ5FtG+POeug0ySh3cU1MI9tdL1ydpQFvzJyFPDqJpak29zheIC9nrir+sJ0TvVafPoIHu/ZzUiE8Bn283RWFnm2ic4H1itT0OxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5GTURChVqvyqluWyn/G7fxcX/RahDfm0Eh+8VH08sL4=;
 b=dJ6XORGe+iXr86nbChiO/bJ5u/eRK0UdAmEBOGvjiQ2hE8rJjk6T0xnksF7pE1QVFHcvKRsQXhcVdPwhA757wwzUGTkkjyF1k6xDsG3x11equww6msn8eQXE+wefXa4SYG7reWMnK0nO0logRxZ6Du4s/olTjmqw2vnAkt0WJRCDFGA3jUjR0ZlxKaSEub8T9Wxzv9G8JGzUgVovaT8XWkujA8zVNfDjogxUKRqbIaH4ADXMHGSCPkB0hXeuvIE5UrLhE/f8WVYzo7rCLMpnYYFCuQmYz/M6xxFiyW/bJX7+L7MDX1NdE+d1tYB/bn/PBZ70b57aviU+2v9yT1Jakw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM5PR11MB1899.namprd11.prod.outlook.com (2603:10b6:3:10b::14)
 by CH0PR11MB5491.namprd11.prod.outlook.com (2603:10b6:610:d6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Mon, 6 Feb
 2023 16:50:36 +0000
Received: from DM5PR11MB1899.namprd11.prod.outlook.com
 ([fe80::d151:74c0:20d6:d5fc]) by DM5PR11MB1899.namprd11.prod.outlook.com
 ([fe80::d151:74c0:20d6:d5fc%6]) with mapi id 15.20.6064.034; Mon, 6 Feb 2023
 16:50:36 +0000
Message-ID: <777498f0-9a0f-6ff7-ecc6-9fc53e8c558d@intel.com>
Date:   Mon, 6 Feb 2023 08:50:31 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [PATCH] fpga: dfl-afu-region: Add overflow checks for region size
 and offset
Content-Language: en-US
To:     <k1rh4.lee@gmail.com>, Wu Hao <hao.wu@intel.com>
CC:     Tom Rix <trix@redhat.com>, Moritz Fischer <mdf@kernel.org>,
        Xu Yilun <yilun.xu@intel.com>, <linux-fpga@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20230206054326.89323-1-k1rh4.lee@gmail.com>
From:   Russ Weight <russell.h.weight@intel.com>
In-Reply-To: <20230206054326.89323-1-k1rh4.lee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0125.namprd04.prod.outlook.com
 (2603:10b6:303:84::10) To DM5PR11MB1899.namprd11.prod.outlook.com
 (2603:10b6:3:10b::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR11MB1899:EE_|CH0PR11MB5491:EE_
X-MS-Office365-Filtering-Correlation-Id: 311fe19e-39c4-4152-aa3f-08db08624518
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +YI109zP7LfHfBpdEJLYl1JnklO2jmie8p1SzL+WaLwfW6OLEr1DEDZXIZozn4UEozir4WpTNYBacb+ABA4+pfS/uM/VJgEs2+f/IwEPofH3T0qFU2p3DxdKaPr0TuI3upzlQIMDATdXzJka1lGYghAsbAVUdFxVb2WUGqqd4NfDTAdYMN6btAfV+FewloiK7M0R3KgUohtjwJ6MeBG0LdS0KbjBzFuOjAZ4JJNLEoffQJra8cyDDEEAfANKa9DuWx4vdcLkxkaRqxAaOfQ8m+pVEXmSTYhGuvpQkrLvXnN/EGkyZZVUEC6mMyqmH1RJoLl+MFESqm8+p8RDmg6j00obiO3LnUVQVzxaOfpFVYth7dAklW/KDc/ibzFNTQwHxeqBgK79S3FPRFMfoxvhJ8BGadWtxbKnssaUg4LgH+cHmZuW3sAWEFfK5fg753zSE8JN/27ZIPhAA345tvPmJKCnbZxsvjyqEDKPDqQC+732CExwO8dRhBN6gRw9fS6S4cnXFbpLeIrTXsVlzr9a5qFGD+8qoOgMBWNz5hieQCMyu4Zsy77ki8VBrbr+cMX7MpIJO4q1nGG+4l3WDO3eZOz/rsKkwB+JTTb08GxHXio+/+H1cDEC1qU3n7E2Z49iNpOGqmCM+VRvgWT1blCTFMkJs1B8WAb8Si33gzYFSvf8YgzEKCjM8JYhmCVBY7T6oYbbkUpvrKITaa/wATVxFJ74eeT1VkWuQ7cbFfhPh9s=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR11MB1899.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(366004)(396003)(136003)(346002)(376002)(451199018)(66476007)(82960400001)(83380400001)(66946007)(38100700002)(5660300002)(6862004)(8936002)(478600001)(66556008)(4326008)(41300700001)(8676002)(6486002)(2906002)(6666004)(6506007)(53546011)(2616005)(186003)(54906003)(6512007)(26005)(31696002)(37006003)(316002)(6636002)(36756003)(86362001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?enROekV3eXpZdmZNYVBhbzZzdWcxTVBrbXdkNHNIRjVqelRYSDV1aWlrSlY3?=
 =?utf-8?B?Q2NlV3lTa056LzVCRlFadlc0cnF4TUlvOFd5Rnp3ZmhxOGtYQ2FvdU5rbnJv?=
 =?utf-8?B?cnd0V0hRNFBqQmhzSW5McWhXNTZ1VHNhU3JGVDJMdVBCMC8zcjY3R1NxMlNn?=
 =?utf-8?B?UWhIVVJEN3Y5VjNWRnQ3ZkxSMGY5cG9HRnhrSk45QUxWV21oSll3RWxTa21m?=
 =?utf-8?B?S055NDIwZGpNRTZWN3ZzNER4cGN6VUwzekVvTE0yNTNYWkZxTFZRV0ZlU21R?=
 =?utf-8?B?aGhVR3ZFU3BXT1ZtWnpXQ0EyTVhZT1lWYitMcnhUUWN3dExaNjJJS3JEWjhH?=
 =?utf-8?B?MFhpQlhYQy9FV1lrTzBKWEVBNDJHSDdwUFVDaitjeFV3ZWRDQ0pic3F1WGdw?=
 =?utf-8?B?V1B5ZDVnbiswQStYMFhOUk01SVg4cWdGNUQ5TEk4NXQydVlSNFEzSjFXejAx?=
 =?utf-8?B?dlU1N1V6dlU4M3VmMEs5MmRoaEM3bVdUOXJyMUtPMjEyYm9BMlhtUkRmdWYy?=
 =?utf-8?B?dUxuVWFNeGJMb1k0Tzk1MmE0cldiVmRJaktpTDU4NmgxZU9zOEtCeEt2TmZH?=
 =?utf-8?B?dmtqOHBwbmdSaCtPeS9aTllwRUEyREdVSklnN1dmcmRoTU9Cb2ovV21zaG8y?=
 =?utf-8?B?UFZWK1M2Sm5Ca05xVTd6ZFVieW9nek1mdVIyeFVQV1VjeThtN3pZU2tIZUFI?=
 =?utf-8?B?R0VmVkFBRGFTQm8vUTRkYXBWWjNUM0dlZ2NSa3FFaGdTcGkzUnU0ejVjYW1N?=
 =?utf-8?B?VjBKNmlrVWZscWc0YUZ6VktyQUZYL24zYlF4T3VDWGJyN0R1Mk1zN1U3eXdG?=
 =?utf-8?B?aGF3YmdyR0xQK0hmL05COEkwbUlhUC8vekkyYVVocnpvbWJxQkpmM1hXSnZo?=
 =?utf-8?B?QklyRFB4YnloZnRPUytJSHJFeDdPajJWczNIeDkxSm84Ym83ZWRwUi8yblgr?=
 =?utf-8?B?dGRQdlBvdmpSdWRFdDQyd25nb0trNG8yUjd5UlhhNlZjNWZMWHNlNFVZVSti?=
 =?utf-8?B?cTZOOWJZelpKN3I0cG1DZzhxVmYvaHFRNGNNK2wrSFNKaGxWbWRRcTFpcGFI?=
 =?utf-8?B?dnp2ZCtOZVRvWWpnem4xRjcxWng4T3BhYjZZbWpkTlZzcVdSQlRxc1FwUXA4?=
 =?utf-8?B?dVplTXBKZXlRK0FhMjlyVFk2cGRtUWVSdDB4b2RuOHpVUmtSSzA5S0lRODFk?=
 =?utf-8?B?MHRNK1V5MlRtcjh1ZTFPalFjeFdoKzdhMVRCbGhrdnhnaUtCZS9jcEh2L0lr?=
 =?utf-8?B?OC8wZXl1SWo5anl2RHpUaFpzTlJRc2lvNGFrQzJEUFcvSzdjR2FVUWFKMEpO?=
 =?utf-8?B?YlFZZlhscFRLbEtocFU3NTFESlpnTm0wYkNaaHlPNXF1MGszSVlQZlVnUjVB?=
 =?utf-8?B?RnZFaUNHazM4YVpTbjJWSzlkUkV2QVg3NVp6WS83QWs1L0V6KzNXM2puT2dm?=
 =?utf-8?B?VGhxS2EraVdEcklKWFAwNlJnR29ZN2tCc21lRjRPMTE0RnZEVTZqRkZ6bnhV?=
 =?utf-8?B?Mmh1d2ZnSWxaVVVuRW1BY09qNCtiUEtPSVgzUURWbVFyY2NuMXc2dUdJd3Zw?=
 =?utf-8?B?b3Jmd3BhVHRXeVczNjcvMjhnVTQvL0JKaW45VXUwamlpRWlhekxTQXRWRmVo?=
 =?utf-8?B?UXVXQ3JsdlplSTczWTJTaWFjd0RTWjI5RVJuZmh4SlZHNzdNMWxwd3BDcWdv?=
 =?utf-8?B?Ri9OSXo0OHRjbzAzQVM0NmdCcHBkMnQ0ZWlZNGg1Nzl2aUJjb01HMElsaUpJ?=
 =?utf-8?B?MUwzQ3ZjUlhHUU9BMzdmTi9BbGRTMXdGcVY4UldVd0tmOW1veFMzY2FXdEoy?=
 =?utf-8?B?NTB1NitNK3UxUk9UVGROaW5PZXBQWW9kWURxS3ZoUzc5VVdlOEhoL2o2Y1d0?=
 =?utf-8?B?NGg5YUM3ZytaaHdCQm80OTVMaGVmVkFRcmpjSWZ1TXhXdEd2MDBVYWYzbEJO?=
 =?utf-8?B?MUQ2YnprRTRDZ2Fsckg3OTJEWWFoZVlYWCtzWlJBc1NoVEp0ekpaQXJWNTl0?=
 =?utf-8?B?czI5M1FCZ01RMThiZHlCNXlRZDZqcnVURjN2UnNMS2hHczhUNHBEeSt1SmJT?=
 =?utf-8?B?QitWUThKeUxqaE5RT3BpcnBWbWxoYTk2RXNGMG8xWEo0eDB2ckRpbUVNNHY1?=
 =?utf-8?B?MGUxRlBnb0lIeXIwekk0T2kzM0hqTU5WRVlhdVJPTGlaM2E5VSsyUnhKSjJ1?=
 =?utf-8?B?dFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 311fe19e-39c4-4152-aa3f-08db08624518
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1899.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2023 16:50:36.5243
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qHgGqbtwxXRF1I3jhoNP/9yFikKAewiTHXiovADnl4bF7J1Ns+pL8uYEH9lxQDVA+1Ixwvezeo5m6LCeBpTj6Pv6vNsUf32VW9eg+q13sjI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5491
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



On 2/5/23 21:43, k1rh4.lee@gmail.com wrote:
> From: Sangsup Lee <k1rh4.lee@gmail.com>
>
> The size + offset is able to be integer overflow value and it lead to mis-allocate region.
Reviewed-by: Russ Weight <russell.h.weight@intel.com>
> Signed-off-by: Sangsup Lee <k1rh4.lee@gmail.com>
> ---
>  drivers/fpga/dfl-afu-region.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/fpga/dfl-afu-region.c b/drivers/fpga/dfl-afu-region.c
> index 2e7b41629406..82b530111601 100644
> --- a/drivers/fpga/dfl-afu-region.c
> +++ b/drivers/fpga/dfl-afu-region.c
> @@ -151,12 +151,17 @@ int afu_mmio_region_get_by_offset(struct dfl_feature_platform_data *pdata,
>  	struct dfl_afu_mmio_region *region;
>  	struct dfl_afu *afu;
>  	int ret = 0;
> +	u64 region_size = 0;
>  
>  	mutex_lock(&pdata->lock);
> +	if (check_add_overflow(offset, size, &region_size)) {
> +		ret = -EINVAL;
> +		goto exit;
> +	}
>  	afu = dfl_fpga_pdata_get_private(pdata);
>  	for_each_region(region, afu)
>  		if (region->offset <= offset &&
> -		    region->offset + region->size >= offset + size) {
> +		    region->offset + region->size >= region_size) {
>  			*pregion = *region;
>  			goto exit;
>  		}

