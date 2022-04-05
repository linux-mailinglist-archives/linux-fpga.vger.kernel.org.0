Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C03354F5342
	for <lists+linux-fpga@lfdr.de>; Wed,  6 Apr 2022 06:30:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233454AbiDFEDs (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 6 Apr 2022 00:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1457524AbiDEQDU (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 5 Apr 2022 12:03:20 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89236B1F;
        Tue,  5 Apr 2022 09:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649174442; x=1680710442;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jOiEPoGDyS7sD4rzNA+HqC1Pe0Fwrrg4JbdMCef2aY4=;
  b=QouUP5ElnFTW4Qg72BE0k3uPSbfzOxHx9ux9civd+LNcBkDu66/p3tTN
   lX0G1mWMhhnuF588hHvLM8Ij8OYRJCkCHhCGpGgzqrlz/nqK5tGz/Euzx
   2aqRLljsBqYIaCIjUQDdl5061iH4wJxN6o2D6FHl+2ygDZPfpHeFxqhTo
   TgL2gjE1QCIgdjO2O0/LUHdrlhB4k15slC9rR2jLZcMjNsvgnkcg1Y4aQ
   JXxX8phuM97O0dAzpSNCh3Bj8khZ+SatX8Ciqmxq32zxFPfDH0ZPPcbeF
   DYW1q0+vZ36NPkxDHFmAQkqM4ex/5ONgk5AQcV7VMh47GHTIXZya9J7i7
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10308"; a="323959260"
X-IronPort-AV: E=Sophos;i="5.90,236,1643702400"; 
   d="scan'208";a="323959260"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2022 09:00:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,236,1643702400"; 
   d="scan'208";a="608495986"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by fmsmga008.fm.intel.com with ESMTP; 05 Apr 2022 09:00:35 -0700
Received: from fmsmsx605.amr.corp.intel.com (10.18.126.85) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 5 Apr 2022 09:00:34 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 5 Apr 2022 09:00:34 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.170)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 5 Apr 2022 09:00:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gK17GgO429OHPDyN2OczgCxbcyWE56+Si9roSGRMqZGGOhgfOaZTnOF5npeiLd0iPfZMJugvFW0yY+RDBpNB9+Y33v5au5faKk24vuSPmteqNpLqT8kSPiTkAUGKyIQac6JNwMGyqkMXZAiXWiuAl/w6BCRJVqczKW6V9cA14jevmRuaadmP3JPfRTfERugRWaL5wCRhigjA/OsDbYRsqQ/iS/++UaUo6brB69RG8nofBKRFti8fH9os+9nR4j+VDQ4gqoB1v0GXc6t/cT7AbICLiUcF88G+f+HA1cPL1ZV0P6AHPac/8dg6udBTKVKPr3kpt+GhxBZGiohWGPD9RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GgCeENaf1n/8FJBSoElZNp/Yof1s0bb/zE1Q117K1UE=;
 b=UMEEIG/CrFPRVdxyFmoRJ3SSRZnP/t3NkYTvdEOl9GMRmfBfUiILpbcsQMrKGwsE56S6/z0mRcg1DeGyVxWnwOwUZ8mBch3jVcWasD9tDeJodiHoRr8XPu5NIaPvgIq08rB18MJ876TRASSWdj6TZkxG9XPnJmuxH1/s+BzdGAw2Ni2mn2Yql/2BBp6mivXInmib/o3yiE3onlv0ERB1seyD8e8OZhMrV6/FtKKhiPbANlkPqMHbixcVwHytGtMLJO6/KdD6FdiZWKqh/ThmWbXb/Xs3iNKvEsI6lR0asnbYY906b8sBajmCNXps3Q7Gwnm1vQaxlJzBWMaHf6nhig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM5PR11MB1899.namprd11.prod.outlook.com (2603:10b6:3:10b::14)
 by PH7PR11MB6006.namprd11.prod.outlook.com (2603:10b6:510:1e1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Tue, 5 Apr
 2022 16:00:32 +0000
Received: from DM5PR11MB1899.namprd11.prod.outlook.com
 ([fe80::c94c:fd5d:2e7f:251d]) by DM5PR11MB1899.namprd11.prod.outlook.com
 ([fe80::c94c:fd5d:2e7f:251d%12]) with mapi id 15.20.5123.031; Tue, 5 Apr 2022
 16:00:31 +0000
Message-ID: <94758036-b697-6e7d-2a44-bb0c698b5e5a@intel.com>
Date:   Tue, 5 Apr 2022 09:00:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.5.0
Subject: Re: [PATCH v3 1/5] fpga: zynq: Fix incorrect variable type
Content-Language: en-US
To:     Xu Yilun <yilun.xu@intel.com>,
        Nava kishore Manne <nava.manne@xilinx.com>
CC:     <mdf@kernel.org>, <hao.wu@intel.com>, <trix@redhat.com>,
        <michal.simek@xilinx.com>, <linux-fpga@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <git@xilinx.com>
References: <20220403051641.3867610-1-nava.manne@xilinx.com>
 <20220403051641.3867610-2-nava.manne@xilinx.com>
 <20220405043804.GA248628@yilunxu-OptiPlex-7050>
From:   Russ Weight <russell.h.weight@intel.com>
In-Reply-To: <20220405043804.GA248628@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0224.namprd04.prod.outlook.com
 (2603:10b6:303:87::19) To DM5PR11MB1899.namprd11.prod.outlook.com
 (2603:10b6:3:10b::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dd5cb727-9fbd-426c-c789-08da171d6960
X-MS-TrafficTypeDiagnostic: PH7PR11MB6006:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <PH7PR11MB60060B399356169132A91E58C5E49@PH7PR11MB6006.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PjdaXlIpws7aXdJaIQty2QxJ3Iw6BEluLtuxtu4/SfSZMAZsPdJOeN9W4Vn5LH5Og07MmlhIWlvtxHr+nSPPgaCNTYoRNdVM6/ovUHF/+8Yor1k0wOJaIAiL7pXe+2fWseB+dgoEmiFSXllSYFdxvOiriVlvMsqV63B3tKfYOVPR467JGmBXrvajq8Lb62kv0m8scnl42IMoCcEHMOaJLE+w37qqFoCfdh019riKOZxgbZpnvIF5gAzL88PINXe+Yx6wPer5grwOlIBU27IIKblJ2yT2hSM3zBelLZLcCee3ZxlJS3AgUNlQPpQKELIMnL1kNOZmHiuTFZQewQvubFYEJbL0N28Kl5PtHG2qfbsymgwzmR17E7q+Ax1t96MWhOMYcbQV/jvFR5cm7NEwLzjkT0C6BkGq9WofONtRr60GCTFFpklvPp1k6y3/YaWlKCK0sCTopvVbe2aqHNKK+7RaBiCjBod9m/AnZa41qHEZfizU9/xWUH9gc+On8TxhUilK2hKyF9yI0YHz5R1At3K3660ERgNfBtin32AjClX99uARUca6DQRmPu7TZEnBBi0lyyEndNpR8ZNRwvkz6l/WgGkfiOxYsmA02nE8v5PapewuNxqOa8uEG5I4me3Fu0japcRBpicYe+cMaxkSzfdaPCcg4dkl52q0A6pBKJK7FLaQZP7JmYPri/sYrMSge3H90Zmhr/pgn8DBT+Nl+i+0mzhpQmZBrBazdfCziiOfkIJ2f5Dnk+vEJLEVbMYP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR11MB1899.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6486002)(38100700002)(36756003)(508600001)(5660300002)(8936002)(2906002)(83380400001)(31686004)(186003)(26005)(8676002)(82960400001)(66946007)(66556008)(86362001)(4326008)(110136005)(53546011)(316002)(6506007)(2616005)(6666004)(31696002)(6512007)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VHN1bThaZXc3R0pQdUxLNWZteDh0NEhwOTdWUjNVM2pqNEJqay9ENE1PaWZW?=
 =?utf-8?B?OGpJc3JYWEtkc2twTkYzcUJxT3NEOHdncExteDE4RU9mcnFpd0FoVElubXBv?=
 =?utf-8?B?bFErVjVPWGJhZ1BvYlVQWGx1Mk9QYjl5VzBlSHJucGszR0I4U2xobDFjYVVn?=
 =?utf-8?B?Q2k0RWNFdDVOVzBBODVhS2U0KzhQcmh4QXBXd2tXWS9jVDEwaG5OSGRkZHBO?=
 =?utf-8?B?OFNHcDBPcVV4WEY4clFWSEtHSk1YbUlKU0swODZlVTJPTVJvRHVOcDhrenFp?=
 =?utf-8?B?UnZDSW5Ud2h4aFNVcXAxcE9DSjkwTlB1Q3d5U1lzd0hBbk9rQVZuRkg4RGFs?=
 =?utf-8?B?S1BhZUNGeWpUU2pSZi9iakRHMVRlZDlQN3R5QVRTZHVkQmE0empWUFdXcHFW?=
 =?utf-8?B?b1BTT1ZZVW1vcHVrZThLU1gyWWRHMWlma3NjS2htQkdnbVdHNlNmaFpKeXVk?=
 =?utf-8?B?NUljZVI4L0Q2b1FBNllqT3JxcHliRW9PRWM3Wm84ejNlZytib0pLTXFCQmFN?=
 =?utf-8?B?MGJMaytPdjB2QU4ybWg5RXdvQ3dKaGcxQU9NQnJMZzIwRW5PSnhDcThMajdq?=
 =?utf-8?B?MFMzcWFEOXRmcXBJNXNOYUIyZy9FOTNEWnlIaUpscE9ueDYyd1Z5UFE1UDFB?=
 =?utf-8?B?Mm5kUVVwa3NLb1hpYndlNnJjdytiWU1VT3B5cVVJMkgrYzhsU0dUWEVGYXV2?=
 =?utf-8?B?L1lrSzR0WW8vb0tyQ2RWMXArd3hXWlRSZEhRRnRCVG4wRHFmVTBGamJUaGZO?=
 =?utf-8?B?YlJjU2VNaUFjYitQenpIaGp4UG1Mbk5TRVJhbmNKeTdkT3d6TDB0aWY0VHc4?=
 =?utf-8?B?T040bUtuc3pzdmxWU1JVeFBrL1FCb21ycURJUkRzdUR6cVRlU3JETld2SG81?=
 =?utf-8?B?N3NyVkIrR3JsOHVxdTBRVzVwTENXQk1GeGd4SEQ5Zi9rTXZPRmRsTnVJbmhL?=
 =?utf-8?B?OEp0eHRONS9wa3dydGN1dm5WanJhT0VveDZQT0lGZTBxdXEzaWZXYnVPWm45?=
 =?utf-8?B?NnNpdWE4bzBHSTFIWmpucjVTUGNORHNjdlU5dFN6TU1yZzRFSXA5a3JwRGF3?=
 =?utf-8?B?STNqQzNONGxpdzZlWFV3aU44ZDRjRjk3em9aNnRPU1pDWVNWR0hDVEdIMzZI?=
 =?utf-8?B?bUh4OU5wVE5ZV0JTR3IxWVhqU2NQN1dBcGRCQzJkKzlnTHNVM3BmbHFrTG1E?=
 =?utf-8?B?TzRYL25QMGhiS0ZkYVMvRXFxRTJhY0hVRWxLbnE2TFNTOXJBVjJydlB1VVFN?=
 =?utf-8?B?N2s0N0dROGNFOUlvZ3hqejY3azdaTkQxRTlvUmNIaDRnem5jS1F1cS9zY1g3?=
 =?utf-8?B?SGpxSjdkQzdnTGJDbTdQSVlCak9pSjFOVmMyWS9Vd2gyMWUyb2MvMkZjbDJR?=
 =?utf-8?B?d3d2OHJ1emp3VW5SVnNKTnNNeUE0K2xOWFdvN2M1SzIvUnlWTm5jZlM3RDZJ?=
 =?utf-8?B?U2thdUlMYWxYWDNjZWg0dHI1RkdFU21aUFVhcVN2YnkvMzJRMjh3NDZrWUJa?=
 =?utf-8?B?dHdxMGtmNTczdVZacDhnMHYwUUdXdEJmQmdxMVpMSmtzUzdJR2t5Y1NxN3k2?=
 =?utf-8?B?bzF2OVA3L1crZmNmbWpQWFh4RGJwR0dMY2VqYnZsSEVoalF1cm5ESWxJOEdH?=
 =?utf-8?B?SG53S201V1FBLyt3cTIzdlg1blFvNjJQbE5WNXNlbzhKME5Uc09WK1ZHdW9J?=
 =?utf-8?B?VERqMllETlJ1RjJ5ZGNpenhXVWZGWEdJWG5vV0cxaWZhbW4zOUdiUmJhaldF?=
 =?utf-8?B?ZkJZQ094K3ZCbm9sZHZ4Y0J4TEpmaW5zSlVNNmxVanU2YkVveWRGOVlRU2d4?=
 =?utf-8?B?ck14bHV1NG0vSk9pSUVROWlXOUVVQ2JhODFSandmanJxdGpWUTV1WExEUG5Z?=
 =?utf-8?B?WG1IZmJ4NjY3aTUwQTdKTi9RVCtTNWdyRVRjRHRWai83MDVoUThqN2hzYXBC?=
 =?utf-8?B?RFUyMytVMDg1Ykw2S01MS0p3dU1GS0FaQysyK3lyTFUybm1Vbk9zbjdIMTlS?=
 =?utf-8?B?Qi9FNjFlNzhFSzllbFdhdEg3WXY3YmZZZjJFK0FVMkM4MG8zYUJObTVjRFVJ?=
 =?utf-8?B?RUFGV1ErellRSHZJendoNWQ0VkxTL2F0TnNvUndQNnBxaVAzdytoT3d2MkR2?=
 =?utf-8?B?YzFRVGdQODhoSGNMMnY4eC9VVlZ5WXJLSXc3TTNSYzAyZC9RQ2xualJqRFdY?=
 =?utf-8?B?NkpHT1ZtK2NTRm9PeGpQOG05OHhiQlVxRE5Hd1RYSllwRVNGWGdVaWhIaTBt?=
 =?utf-8?B?R3Z6RTFEdDROSmlVaXc2aVg2bTN1ckFKTytuQ3V3dDhRY2oxYnNJZEMveUww?=
 =?utf-8?B?Vms5Z0J1SDRsRXUxZGZhRlpyeVRmRU1FckprY042QzVDaWx4dDhpWDdBQWpz?=
 =?utf-8?Q?Dxj5iE0ME+D9/4Xs=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dd5cb727-9fbd-426c-c789-08da171d6960
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1899.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2022 16:00:31.8130
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vi6Gja7yVuUV7qx1JfF+GIR6kN7JKJMxgFv81cf/e5Sgr8wPRAeK3p74Y+k61SUDcn0c58YTJYXiMpUqJ/efOaGph1PqzNyRrCEGkI9jh4E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6006
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On 4/4/22 21:38, Xu Yilun wrote:
> On Sun, Apr 03, 2022 at 10:46:37AM +0530, Nava kishore Manne wrote:
>> zynq_fpga_has_sync () API is expecting "u8 *" but the
>> formal parameter that was passed is of type "const char *".
>> fixes this issue by changing the buf type to "const char *"
>   Fix
>
>> This patch will also update zynq_fpga_has_sync () API description
>> to align with API functionality.
>>
>> Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
>> ---
>> Changes for v2:
>>                 -None.
>> Changes for v3:
>>                - Changed arg buf type to "const char *" as suggested by Tom.
>>
>>  drivers/fpga/zynq-fpga.c | 8 ++++----
>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/fpga/zynq-fpga.c b/drivers/fpga/zynq-fpga.c
>> index 426aa34c6a0d..ada07eea64bc 100644
>> --- a/drivers/fpga/zynq-fpga.c
>> +++ b/drivers/fpga/zynq-fpga.c
>> @@ -235,11 +235,11 @@ static irqreturn_t zynq_fpga_isr(int irq, void *data)
>>  	return IRQ_HANDLED;
>>  }
>>  
>> -/* Sanity check the proposed bitstream. It must start with the sync word in
>> - * the correct byte order, and be dword aligned. The input is a Xilinx .bin
>> - * file with every 32 bit quantity swapped.
>> +/* Sanity check the proposed bitstream. The sync word must be found in the
>> + * correct byte order and it should be dword aligned. The input is a
>> + * Xilinx.bin file with every 32 bit quantity swapped.
> I didn't found these changes in v2, or in change logs. Please record it.
>
> Sorry, as a foreign English user, I didn't find the necessity of the change.
> The previous words are as clear as the current. Anyone could help?

I think the change adds a little clarity to the second sentence.

- Russ
>
> And they are not for variable type fix. Please make a separate patch if
> really needed.
>
> Thanks,
> Yilun
>
>>   */
>> -static bool zynq_fpga_has_sync(const u8 *buf, size_t count)
>> +static bool zynq_fpga_has_sync(const char *buf, size_t count)
>>  {
>>  	for (; count >= 4; buf += 4, count -= 4)
>>  		if (buf[0] == 0x66 && buf[1] == 0x55 && buf[2] == 0x99 &&
>> -- 
>> 2.25.1

