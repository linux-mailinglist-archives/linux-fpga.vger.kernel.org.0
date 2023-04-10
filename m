Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 601556DC280
	for <lists+linux-fpga@lfdr.de>; Mon, 10 Apr 2023 04:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbjDJCAJ (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 9 Apr 2023 22:00:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjDJCAI (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 9 Apr 2023 22:00:08 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2101.outbound.protection.outlook.com [40.107.117.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 874F53590;
        Sun,  9 Apr 2023 18:59:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lR1oWJwJ+7bdxfqMdR+BSmWmcV4P9YbcK09UCTYd+T7cF8CHSkBXcubZcfi4zViYjWDUWNrrIIk+nD3N/h6SkZ6G5y5+KvCPZoN+Q723EFDdZUSLF/QAyahugCaxTVkGjlzdSeNYuBnlHq2OM9taNrfIFhXFql/ltEmoX8k/fLb2MQBrDHfddVnfDJ0+5SBziuy1nnv+YCoCJ0R8H93H4eYKZZcCXw2Rj8A2eRvekBngjWzn4+ZBvOdk1QMe2DCEbhWY/pZFV2+hhY6M8RGxh5UHK4jmP5+fBhwq7XvEE1FE7TEdCjI5mLRfsGDD2OuRSLaPcbjl7YJCs5RbleZnnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o1G12H+m1lle0qjW01b99nYxWoMBLDUQ9f7bDcn+7JU=;
 b=kjQSBv3wNQQ2CVHaWAOaWt/h7r6qIxqW8w+o9+m4IqlY5rV/faNop2aWBRSVqqussOit/FlrUNiY9m7BByls4UiY7fFMi2aj+GIoSfzwh4HDXsHTIl8xf6rUt/Ipj1qOePDSyBC76HdiK5aFxcWP9UqVjfglKtGc6XH7WHFvyxdtrmP5d0ft//YI6S3qj04ouJ/NXGMbooMNO3FDitasivV1SsEiuDF3W/+LMNfKECNKnbiqNx3KMfOERYz4IfZioyi3T8QJRZBEMuM5I1yxS3bUXJyLBUndqNPk+e1/Mvzu+rh+Q5xpxy/znsMHUQSjaviypFxQ9vZdX4KehyiRow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from TYUPR03MB7232.apcprd03.prod.outlook.com (2603:1096:400:354::5)
 by SEZPR03MB6761.apcprd03.prod.outlook.com (2603:1096:101:64::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.33; Mon, 10 Apr
 2023 01:59:17 +0000
Received: from TYUPR03MB7232.apcprd03.prod.outlook.com
 ([fe80::dad8:bd4f:3723:f3df]) by TYUPR03MB7232.apcprd03.prod.outlook.com
 ([fe80::dad8:bd4f:3723:f3df%6]) with mapi id 15.20.6277.038; Mon, 10 Apr 2023
 01:59:17 +0000
Message-ID: <de25219b-2f7e-1e7b-ebad-70287ee4c28f@amlogic.com>
Date:   Mon, 10 Apr 2023 10:00:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 07/32] perf/amlogic: Assign parents for event_source
 devices
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org
Cc:     linuxarm@huawei.com, Dan Williams <dan.j.williams@intel.com>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        Khuong Dinh <khuong@os.amperecomputing.com>,
        Robert Richter <rric@kernel.org>,
        Atish Patra <atishp@atishpatra.org>,
        Anup Patel <anup@brainfault.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Frank Li <Frank.li@nxp.com>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Vineet Gupta <vgupta@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Dave Jiang <dave.jiang@intel.com>, Wu Hao <hao.wu@intel.com>,
        Tom Rix <trix@redhat.com>, linux-fpga@vger.kernel.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Liang Kan <kan.liang@linux.intel.com>
References: <20230404134225.13408-1-Jonathan.Cameron@huawei.com>
 <20230404134225.13408-8-Jonathan.Cameron@huawei.com>
From:   Jiucheng Xu <Jiucheng.Xu@amlogic.com>
In-Reply-To: <20230404134225.13408-8-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0154.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::34) To TYUPR03MB7232.apcprd03.prod.outlook.com
 (2603:1096:400:354::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYUPR03MB7232:EE_|SEZPR03MB6761:EE_
X-MS-Office365-Filtering-Correlation-Id: 216fc914-f088-4bdf-af84-08db396730f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: isYHvjh0eF3zFwGOydX+UWw9j+XydC3RQw5QDVIeJGOLTkBPxORkQ4ZWZGOIC3TFLQb9qMQTiyijV0/n8eixEPiH/EpAvCWc39WltHgL0mpeEotENm1m5GRSenYWJTD/v1khwZzuwWjCY2NDKn81BxTyM3rWB8//nCSkSOyDOaaxxnZxQ3Eed0OTiYkV/soPmEsEZW1bydrWWNtdQfzzh7aPvF50RkgFqNLEPrEm85DTomxpww+vhgrgRq762G+uNhgx4o+Dwv5Ag68jT3WLPOCyv5inF4zCAawOE6FF9UP6g/Lz1oHoQjx0a7GoWAICY4eFAZ0fDmHB8QIfmGImVs3X/TBcluFwdrvQMo6H4+Fs3F3psTVlx+jQK4UL7XtGHqVEW+8xG+UJPAFChdeaxVjIerz8ef+WC3DWWWQtJCyyD/SgEcZP2d6QO7dH7+Js0WCVl0X4F0ss05QfFpeKdnvjkKyQcCbEgWQ+/xKABOHj+V6gIk0iyK+J6bZIaWsRNaoMijkfzZQ3Rlom+2UMo4BwCfMRPKa4DryqfUfGP+9u5vbUmEOEgY+A1wQixe5RgmK+tbbKn1YVb6ly48vPChyec6XQtFSGHX0ZV5TWroErQMW2X+lyiIU8k7lYB6FTlzzrJOdI63zGSt6/Kl9M/2AJku5EVQYTVLydSplpSfrAmmT72jOw7szBjBAFjvThWiMXgo8RARoTFMqYIwUdGg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYUPR03MB7232.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(396003)(39840400004)(346002)(376002)(451199021)(31686004)(52116002)(6666004)(478600001)(86362001)(31696002)(36756003)(38350700002)(38100700002)(2616005)(6486002)(966005)(2906002)(54906003)(110136005)(316002)(186003)(53546011)(6512007)(6506007)(26005)(7416002)(4326008)(41300700001)(8936002)(5660300002)(8676002)(66556008)(66476007)(66946007)(7406005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eDRBeGMvR2ZZQ1lIL2htQjBJZ3BrU1l2L04wR0pnMTVpbXA3VTdOSzZMQkwz?=
 =?utf-8?B?Q3NZWnJ6ZW03WUhqSzEyQnU1U0xxYXZBQ0dTKzNRSTZTckxNNnV3OXZvNk11?=
 =?utf-8?B?YUs0VExXNGg5Z1hHVDlkWTUzcVpqemlHTHdEaVV0M1MyT2ZteU9heVFlMGoy?=
 =?utf-8?B?T203SXJEY1hBYTFWNThWRWJlSmc0dFhpTkowNGZyTy9yd0VlNzV1dUF5ZVZN?=
 =?utf-8?B?L1lCcVYyb1NZTnJZNS9HamY1WjNnVlBRK2RWVVhjZ2pkMDhlcTRYSnVxb3Jz?=
 =?utf-8?B?d3NVVjRSR0k3cXRNdlJpQ3BJcnZ0UWlLMVgxekFZdEZadlF3S2t0UGxtemRs?=
 =?utf-8?B?RXQwUFBOQ3pXNUt5UklMMElxVDljelBpQ3VBYXAwYld3Tk0wcUlLVW14OGlo?=
 =?utf-8?B?Uk9mTElFdlJlMjhLTHhndWZ3RkJHKzhGVE03ckVqaWNXSU5RZitPUmFYaHh5?=
 =?utf-8?B?REpCV2VaSFl4em40dFR6WXl0V0UybVpZeGRtdHU1enhNR3hqWXVtTUs5TWRO?=
 =?utf-8?B?b2M0M25QZkFCMWhXeEFrQnBpMVYwendzejhSVTR5Q3JsVDNNZXFDTk5FT2RR?=
 =?utf-8?B?YVJiYUI0WXlFbUJwZytSTmZDK04rdGVwcHB4QUp4cHlHdDl0Y1MzMUVFK212?=
 =?utf-8?B?QzNVSXZvQ0twRHRBZlh5TmF6WUM0NFcwajRYWEJET3lJVUZCZTBPV1RVV2s3?=
 =?utf-8?B?WkJTZXhFR1hRWWdvT2ZQMmJ2ZmRvWEZlaEw4NGx3L2pjZW44NG1ja0JPdTRR?=
 =?utf-8?B?NUhqS2c0ZzMyNXVNbWdxUC95OXQ0VDVoTll0a2RGdWR5ZHg5aUtWYWU0bTl5?=
 =?utf-8?B?ZnBSMHFRZTB5WmlTUW5IdEM2YXBqTm91TDcxaS9jSzFyWFpxbmkxWlB2SHpY?=
 =?utf-8?B?NFkwcnJrSjBJbkVkTmQ3NU52UUVxVzJvaG1FKzR1SmtJeG1VbzNYRCtrM3F5?=
 =?utf-8?B?S1F1TGJhWW1MK0tGWDhOczVOd0NDaVVkRXJsSXZFTHBzd1J4VEtONUs2NjBF?=
 =?utf-8?B?Q1RFKzNQRXEwYXBobWcrL3VTQUg5YzNGSW5Zcmc4aTlaT3JEY2JDclNmRjht?=
 =?utf-8?B?NnROZUU1cG1pekVvQlpJSmtOR3prcWxPYlNPZXVYSHM4WmI5dUFLcUszRWpE?=
 =?utf-8?B?M05zMzNBdW1NeXNTcWVRV0p2VEw1dE9UZzB2Y1F0SWlEZW5DeWg2a1dadW0y?=
 =?utf-8?B?SXZ6VHdENzBTUWpTUUdZbUVrdENMcW1VRGdHcnFVMlFjdXNycDFSaDRvMWYr?=
 =?utf-8?B?UVo3SGJ3TFI3Nlh2RjRxMDVqbTZaTGlwWnNLbkp1d3dqNDU5QXMxMnRHNGxp?=
 =?utf-8?B?aGI2OTVUV0FpTHAzUkM0dFd1VVRVbDVlOGtSaCtISDA2WWcwNnowZHRYREhW?=
 =?utf-8?B?Skc2d3E3cmJxOFpVYnAzcFUzK0FjMHMzRDd2WEYxcUswUEhMcTJFRExXNWM4?=
 =?utf-8?B?QkU1R1Q2R2NIaXA5R2owRnk2UE5kL2VXWmFVbVMwQjczR0lsQS9Oc1J1SlFJ?=
 =?utf-8?B?WlJIT1pvSWxES29pd3BTZWRLVTd3dEJ2MEtHUzNyNktUYmNqS2IxOWRGOStr?=
 =?utf-8?B?WkZ0S0pPck5iWGswS2VQQXlDUlNpL2FSVWFSTHAwRVNvbEFUeGt4WGlPUlF6?=
 =?utf-8?B?SXlFa2poVTFzVUxPbkpWdkpXd0RFQ2pmZ09haG1XTXM4a2cvbUI1NFF5Vlcr?=
 =?utf-8?B?U3Zoc3g1cWZlc2Q2S1dkbDIzMHNXeTNHVGFSWm56d3YvWWJDZVZBTGcrbzlO?=
 =?utf-8?B?NmpZbDAvc3Q5ZU1tMmNkbFhBL0k1R0lnT0FOZGF4MDlvQ0YzdXNMbDgxdGFm?=
 =?utf-8?B?TjFNaUp0Zk9nRGtwYkxDRnlCdmdRbGltOTdZc3RKQXBnZzFLcVd1TUNpc2o5?=
 =?utf-8?B?Z3hCZHVxcDM4REF1dEh2eHNBR1RWMVpOalZmUHRTZ2FLcG4xejlXVi9VaUdJ?=
 =?utf-8?B?RlMwRVNpYWNYaW5Ua09nOW5XYzh0cEJFWVVBR0N5R1ZHblB0cXd6RXYyNzRp?=
 =?utf-8?B?UUNpNkNYckJIUHNta2hVMHNtcVJmYW92WU4zZFE0TXZMN0oxdFVEaXl1M3hS?=
 =?utf-8?B?cW14MjBMMzVxRTJGdlFMeUxJaEtac0FHU2c0bDJTUGE4QmUyQWpmTmRxZCtJ?=
 =?utf-8?B?dlVPclp0dnZsbTQ1dFlteVZPbUZ2RGp4Tnl3OVhlbDEvQXF2NzlDejRkS2h6?=
 =?utf-8?B?WWc9PQ==?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 216fc914-f088-4bdf-af84-08db396730f3
X-MS-Exchange-CrossTenant-AuthSource: TYUPR03MB7232.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2023 01:59:17.4660
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6095LAkJfwCU6KtEc4UBEwZVbNefr+0B+S2q+mMg21B66duFW/YoVU/hkcKnZSiPtesde5uG4ML+7Zn9SbPA5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB6761
X-Spam-Status: No, score=-2.9 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 2023/4/4 21:42, Jonathan Cameron wrote:
> [ EXTERNAL EMAIL ]
>
> Currently all these devices appear directly under /sys/devices/
> Only root busses should appear there, so instead assign the pmu->dev
> parents to be the platform device.
>
> Link: https://lore.kernel.org/linux-cxl/ZCLI9A40PJsyqAmq@kroah.com/
> Cc: Jiucheng Xu <jiucheng.xu@amlogic.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>   drivers/perf/amlogic/meson_ddr_pmu_core.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/perf/amlogic/meson_ddr_pmu_core.c b/drivers/perf/amlogic/meson_ddr_pmu_core.c
> index b84346dbac2c..e0d3e87457e0 100644
> --- a/drivers/perf/amlogic/meson_ddr_pmu_core.c
> +++ b/drivers/perf/amlogic/meson_ddr_pmu_core.c
> @@ -490,6 +490,7 @@ int meson_ddr_pmu_create(struct platform_device *pdev)
>   	*pmu = (struct ddr_pmu) {
>   		.pmu = {
>   			.module		= THIS_MODULE,
> +			.parent		= &pdev->dev,
Reviewed-by: Jiucheng Xu <jiucheng.xu@amlogic.com
>   			.capabilities	= PERF_PMU_CAP_NO_EXCLUDE,
>   			.task_ctx_nr	= perf_invalid_context,
>   			.attr_groups	= attr_groups,
