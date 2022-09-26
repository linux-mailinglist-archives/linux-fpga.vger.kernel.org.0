Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C748B5EADA2
	for <lists+linux-fpga@lfdr.de>; Mon, 26 Sep 2022 19:08:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbiIZRGq (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 26 Sep 2022 13:06:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbiIZRG1 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 26 Sep 2022 13:06:27 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 526ED57254
        for <linux-fpga@vger.kernel.org>; Mon, 26 Sep 2022 09:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664208662; x=1695744662;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=OTOkYLF6hjis7zMBeZ8rJYITJfG9BURlo49uFEwQbOY=;
  b=ZD5hFXn1jYvGI/bzkwhRcWU2ahRF5Z99gKVZB/+to4isdUy7CiAdBxaV
   bNbvRryeOnBU1IK2+s0IaaLu3KXFyfuozLucQYaSk50MRF30kKdVXA2o4
   P7zejwtDem8sXIwU5aQz56ZCVSCHGNhu5XfFBGK4TacjfQfCfVT7lhtf2
   hAmaWILyjGfGolz1uPHilyqGP8Tc4q7KYii3duUTrIcCjy/d3AAQcFvsB
   wVcRTmUIOkxAUftpnV3PtSQUKrKOF54+HUmSX55pBz3K8QROABuQMFnB+
   x5TS3DJ5xpHSCDSfohloGeB4UR3MRtOJJNFu6K5XCyClvEjhsTKVVdmLU
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="387360335"
X-IronPort-AV: E=Sophos;i="5.93,346,1654585200"; 
   d="scan'208";a="387360335"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2022 09:09:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="621111581"
X-IronPort-AV: E=Sophos;i="5.93,346,1654585200"; 
   d="scan'208";a="621111581"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga002.jf.intel.com with ESMTP; 26 Sep 2022 09:09:54 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 26 Sep 2022 09:09:54 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 26 Sep 2022 09:09:54 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 26 Sep 2022 09:09:53 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.176)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 26 Sep 2022 09:09:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lu036IT4VahzA3u3Z8x4BZGRs+Omtv4p1WoI1sdbSeQXXAhbwHivN0dF//DYqepo65gftqoR/7Ss7DfmZjW8i0wjxez9jxpKHoabaH8cBWcLQkdpyyaSsPJ1b/tA5WlKzVIBSVR8kCqZTBMu17oGNxAQdBzwt/YloTyBBjLAu/2EQmQVEzLhXY5xq/N1sQM76SBwKAW7/I+pIX6J32DGZQgCGxmgBsLqgM++JxjcFeneEX+gU6I5I1O9ROAnHrdB6K/+1XISJFg7pDhNPgED97KK2O9DQIq32Wr3Qg1VDbVoAV1NMxcNh+j5P5dZvTKXwvhR6xYUwrdRaGMGRfXpxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Egxlil4Ckz6atSem8l2w8ik6ld2E/jk9NGW5I4Dp0ok=;
 b=OmEJ1xGej2GxmWKol4dYOrQlLnuqQl+B4YlmDPzIKE0zeEkA1qGNo5Q/kH72AqChJzSdafWdsM0Nk/jJ10RywK74brDwEs/tWyJw9bv+GbR+YuBPxeqYtmU2gdIfyTk//NQzTSo9/VU2CoHInLKuWqgGsY/ISXWJgR15hqvl86HItKAovjIXkk8W75b7P0FrnMcG/RX4gZDIVM1fKPsu5A/IfWwQ5CLR7uxhlKJGHDZotqK46z+aCgLLk7rmud16bL/RpCr1F7l7aGnmmSP4yMv94U14M58Mi82dbnJBOKcwrAW0UHHnWatO54cyiqqubvVR4HgfzSAzE0pE4F/3sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM5PR11MB1899.namprd11.prod.outlook.com (2603:10b6:3:10b::14)
 by DM4PR11MB7327.namprd11.prod.outlook.com (2603:10b6:8:105::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.24; Mon, 26 Sep
 2022 16:09:46 +0000
Received: from DM5PR11MB1899.namprd11.prod.outlook.com
 ([fe80::78ac:48e7:c97a:152f]) by DM5PR11MB1899.namprd11.prod.outlook.com
 ([fe80::78ac:48e7:c97a:152f%7]) with mapi id 15.20.5654.024; Mon, 26 Sep 2022
 16:09:46 +0000
Message-ID: <c6981606-882e-b801-25ae-012da56d8309@intel.com>
Date:   Mon, 26 Sep 2022 09:09:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH -next resend] fpga: zynq: Switch to use dev_err_probe()
 helper
Content-Language: en-US
To:     Yang Yingliang <yangyingliang@huawei.com>,
        <linux-fpga@vger.kernel.org>
CC:     <mdf@kernel.org>, <hao.wu@intel.com>, <yilun.xu@intel.com>
References: <20220926141729.2292311-1-yangyingliang@huawei.com>
From:   Russ Weight <russell.h.weight@intel.com>
In-Reply-To: <20220926141729.2292311-1-yangyingliang@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0285.namprd04.prod.outlook.com
 (2603:10b6:303:89::20) To DM5PR11MB1899.namprd11.prod.outlook.com
 (2603:10b6:3:10b::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR11MB1899:EE_|DM4PR11MB7327:EE_
X-MS-Office365-Filtering-Correlation-Id: 3486f34b-0b62-40b7-f683-08da9fd987cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cAGpfOblCr2kGllrEQ0mMa5nfkSTPw8qSYIqo1p3LTq9fEiM704KgV+MwXpvuCYzXdPt3GvssyvgglrvPb+zNWMhdJ/bQN/oUyhIey8h7x0GB1r2qKP4RFmZDent4n1R7lrQ21ra5VqCuIyMYpwqiIVq0AZcpYqC0UBidIrxpqiHkdC6n2Jy0dh28bLPIlE9wwk3YzkGGuofGRAb1W2LItBWUv1oTkXhkvyYRa+pr9rW0S7pw7o4j0O++upDpmxSkkfs6wznTgyoa2OwzSqhApobSVJ9GsnZ4r1lsVuQ3HbFDlCzD2HeOIqsDAYC61dja5yeMTtqEMxjba0431StmjWvyXxjyA4h/g8hJvsxAeLNI/RR9RRhijogNhWwBF7sFxrgSlxYxl+ZEuCg3Kcakb6czCbrDgEd9ZJNmrLzQREUIxCYr5J0gMEAneEwtaYwqfUPgLOEU9vkqtFQmTeDhGnzyH+RJgorCcuQ4h83dKfpopYUSoCY/heNAMN4cNveeNAWOgQVfk4Ugyv00J5pj6YfTZK1JHqGOcYeUFLfkevhuvMZS5G9hCLakGTSb8WPsKdk1Ixtyg8XHSh//aM0oHLqu+y3djZxZpnWqU67AwicSAeUdYmyBed3oJSUBoMtKk4iIODKJH/EqbEI+CeIEH0Hkd0wwTkx7Cez2kHSA8A3E+Nm5VLLe1XdKEG2kYYbzTu0l6TjMjdmjfemqZK0qt526bXmGJ5WL0PBTa2Hy7b0FVAx0T2T15iXzSuPoWMYJHgC66FCJvfrbGpHPNyPFByVG/B5wdSRwohlKoXth5M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR11MB1899.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39850400004)(136003)(366004)(376002)(346002)(396003)(451199015)(6512007)(83380400001)(31686004)(86362001)(31696002)(38100700002)(36756003)(82960400001)(66476007)(4326008)(8676002)(66556008)(2906002)(8936002)(66946007)(5660300002)(6506007)(316002)(6666004)(2616005)(26005)(53546011)(186003)(107886003)(41300700001)(478600001)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UW5BcmZ2VXZROW9wRkUwYk1GL0c3TmZxVWwyc3VZQTRNRU1pbnpveFl3SlYw?=
 =?utf-8?B?c1NsbmdybDNjVEtDdWtsSmxqMGJZQzNXemtITG9zQ3dsMld5RDQvR1VLemxt?=
 =?utf-8?B?WVAyQkY5Z053ckpMZ2g3eHlmS0JKaVNXVWNadTBXSE9hS0NSYzlzb0VIM05O?=
 =?utf-8?B?QkNDTWl3VHErcTVWWVlMUGhFZ3JORlRYOEdpeEhIZGR6M1dRaUxWWkJ5eFJI?=
 =?utf-8?B?OWZISlpFcXlTOUFkbXVPSHhxRW1wdkc5N0Z3T1FKS205K2dqd1ZUK2o1T0FY?=
 =?utf-8?B?bHlDaVgxRVZUNjhzSGFjanFjTjdkN2gxbUlsUHJmMDc0aEx0enRLUUJWT0VB?=
 =?utf-8?B?cElrcWF6UlhuRUF2TnE0RnpDaXE0Z1ZQOEVLQUNGdEx2bGd3TDR0alNmUnUx?=
 =?utf-8?B?L20zalh5WUFPcU9QYk1FRXU1ejJKMkdTSmtOTXFMWkplbFBTRjJQVzhqL3F0?=
 =?utf-8?B?RWFjemoySkFjK2U3VDV4dFNKU0hJRVZjd3FNcElIVkRRaHp1ZHZzdG4rVmFw?=
 =?utf-8?B?WWNzZGo0Rjh3ei9qQ25DYytvQ1hHWGQ2QjhWUHd2OW50cXBPTlhHKzJpM3pP?=
 =?utf-8?B?aXpnSlRRaUp0eWFLMVdnQ2ZMTmVCRWdKWnNEZmNLTlFFbFA3cHR5TElsWmIw?=
 =?utf-8?B?b2tIYmZPQ0RMQ3BWR1B1cnZDMDZ3RlByTEdDWndNbnFvdGF2NDlseXYvU0l3?=
 =?utf-8?B?NGZLbGlUT2pCMjNaSkY1QzF3bjNKRlYvckx2cTFwZUpocnR2QnkvUVVVSjYw?=
 =?utf-8?B?ZUxBaVRRNGtjb2J1UTkwcmxueHg3TGFDWGd6UXIxTjRMOExZeExCN3VTTDg4?=
 =?utf-8?B?MmRseW5SbFFqa1R2SnVkRFlXZEJVWWhMQ2NhQTA3cGhmdWY4N2ZJVXk1Qjhs?=
 =?utf-8?B?dDFqeXlZV0VJUlgwTWFrRmc3SnhaTUVrU2M0MXZ2dEVjS3FwNEoya01OVjhr?=
 =?utf-8?B?YmhNcGl2Vjl4ZWQ4WS9DNjNYN1g1Ym5sQXJOV0ZreFRNL01paW9JaWkvY2l4?=
 =?utf-8?B?OUNaRUpObC9EZUc0VllRRW1ZM1VhTEVacm45N2NXYmM4L3dQSTZaTS9sQlJt?=
 =?utf-8?B?Q0tvY3h2bUMxZklzN0J4TjNRa0pieTJxNENmQlBPZ1BwWDJiYVFPN1l3VDdu?=
 =?utf-8?B?aDFtMXVGRmxWa1hHYnh4SDdIeGpHZjdLN0lFcFNTMWhSL2NRZ2pHbkpPbWg3?=
 =?utf-8?B?cDdUUnkzb0FCbHEyYWRDSmdFQWtBamsyemtwMkxveGZGenRaTTZWZkhTNXFU?=
 =?utf-8?B?TytycTFXamIvK0NaR2FBVExDbnZRUkxLMi9LTnQzR2xidlZPS3lETkNCdVU5?=
 =?utf-8?B?bHZENHViZVppeG9lUEZ2clhBY3FGSW83Ly9JUmFrU0RFcGd6NGdHemxVK1hj?=
 =?utf-8?B?d1QzbmR2V0RseEh2bmlZTE1LODAzVmhDbzVib1JBVzF0N1c1NHdkTUpCaURw?=
 =?utf-8?B?YnVKY0hlYzdYRXg0WENnUHFsbDNlWEpnSWRWc3dLU0FBK0ZDbG5UODZWeWVM?=
 =?utf-8?B?b0p5NG9ZMTRlY0U0cFY2Z0xTMnZKbGJOL2piUGNTS1ZJWTVySGJxL1hsdXlh?=
 =?utf-8?B?c1VBeWRaS0c3ZWxIYWxuNUNVcDJ1dVBUSWdObys5WWI0WEVPaWt6WEQ2YW5x?=
 =?utf-8?B?eWY2QXB4U2lwcmVLdTJlL3lUWjlXMk9jTkplb0lsKzBPazVyc055dkRTaHhU?=
 =?utf-8?B?dkZqcElzREpPUy9SU2pTOEMrZkQ1K081UVRaVTFlMkk5aEZRbkFEYjlPWmhJ?=
 =?utf-8?B?bStvektlaWZUTmh5R3I4RmNYaHkzMUowREFwUWlmZ2tGenI4WjQ5cVc2cThk?=
 =?utf-8?B?WW8vSm9aTkxwL3J5WHVqOTBmQWV5eEh0amhXemtNZDhpdU1VeitTazkzTXln?=
 =?utf-8?B?MG50a0VTVFZNSnVidnl4TWNmYldndzRMMG5ISER1ZFJMM21aL25LTkdNdW5X?=
 =?utf-8?B?eTFwcTZyZmxVU2ZQdWU3bkZQc3FYUzRKVEZHYXNqSXpQRXlOT2kxUTNwT0xY?=
 =?utf-8?B?YlQ1RFJNY3hNUEs4WXA2Q1R0eUFlU015eU92UHJpRlgyVlZhSFUzQ0o4VlpN?=
 =?utf-8?B?WkozbEJIUGpJNGpvNDlYTDRLVDZ6TFUyeU1QeWJMb0VZTmpWbkNoblcyU1FQ?=
 =?utf-8?B?YzJucmJ0cTZSeUN6R2JHc3NDRG5xSXNTME0wcjI0aEFyTE1zcXpDOEhINzND?=
 =?utf-8?B?SXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3486f34b-0b62-40b7-f683-08da9fd987cd
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1899.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2022 16:09:46.3519
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wA5NPoYvMngbhdqzSaYbqdX7adWtJ2v3qwJd0EY7Pb613GOUN0w/to2Ykyk/i5kxrtse9ZCATFPGAFx/iiFnjSC97Bs/QNzVAuZOMqGc/wc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7327
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On 9/26/22 07:17, Yang Yingliang wrote:
> In the probe path, dev_err() can be replaced with dev_err_probe()
> which will check if error code is -EPROBE_DEFER and prints the
> error name. It also sets the defer probe reason which can be
> checked later through debugfs. It's more simple in error path.
>
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
Reviewed-by: Russ Weight <russell.h.weight@intel.com>
> ---
> Resend for adding SoB.
> ---
>  drivers/fpga/zynq-fpga.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/fpga/zynq-fpga.c b/drivers/fpga/zynq-fpga.c
> index 426aa34c6a0d..ae0da361e6c6 100644
> --- a/drivers/fpga/zynq-fpga.c
> +++ b/drivers/fpga/zynq-fpga.c
> @@ -582,11 +582,9 @@ static int zynq_fpga_probe(struct platform_device *pdev)
>  		return priv->irq;
>  
>  	priv->clk = devm_clk_get(dev, "ref_clk");
> -	if (IS_ERR(priv->clk)) {
> -		if (PTR_ERR(priv->clk) != -EPROBE_DEFER)
> -			dev_err(dev, "input clock not found\n");
> -		return PTR_ERR(priv->clk);
> -	}
> +	if (IS_ERR(priv->clk))
> +		return dev_err_probe(dev, PTR_ERR(priv->clk),
> +				     "input clock not found\n");
>  
>  	err = clk_prepare_enable(priv->clk);
>  	if (err) {

