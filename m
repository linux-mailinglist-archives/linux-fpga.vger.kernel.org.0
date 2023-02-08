Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF35968F80D
	for <lists+linux-fpga@lfdr.de>; Wed,  8 Feb 2023 20:30:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbjBHT2o (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 8 Feb 2023 14:28:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231837AbjBHT2g (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 8 Feb 2023 14:28:36 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BCEB2597F;
        Wed,  8 Feb 2023 11:28:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675884515; x=1707420515;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=HnjrM0giyAjP9Tjhd2V2M+ctNPuQ33xQlrk3cZma7EI=;
  b=FWdEAXEy0dIJ4JLNSfCO79cBCiwl+335C7Xciy3SthCoOEJ+QYTkaigF
   s+F94qHg1IxEnAsHqxW0N5/CjTNGY2N4MPcQE7dsmslBJQ7iBJBBANkeY
   Yeu9KHKOuhTCKoSLUsUhYx90XlUpPAQjI6X/DGZYYeVLnK6IiuzLn3iXK
   aZ/WcouKHfxpWlvRIZTHEykn/f9zjEEx/A8/KW76NcEzeVgkVdtxkyfsa
   apUSfw2GdMra5xUmeik+AkYfYT8vZsUSeTK11v+8+PI3Qp4Y1vZvXDH5R
   64Ub6oARnzrqSwppKDgZy39mPowpMFN/ihI/FT3qUF/P0/VK4vLD6qz+H
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="416121215"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="416121215"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 11:28:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="810044103"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="810044103"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga001.fm.intel.com with ESMTP; 08 Feb 2023 11:28:34 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 8 Feb 2023 11:28:34 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 8 Feb 2023 11:28:33 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 8 Feb 2023 11:28:33 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.109)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 8 Feb 2023 11:28:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xih/Xj7aZFoMM7jmVc4oyIaf45kwI6ogrIN+TMaokR+4fCtXbCagKSG/NKDDiRfxrAe5cPg1oZIzGUUGPjLyTlUSbhHvn1D8I+pdkCcYtw0QxjUlBBAgfo4bKAZbcg//8qUDjg3DgsX3Gr4Ya9uL7GO2GNfSodvV2pR4eMImfAVkeN45O2zCBq16dncT/5e4TQUTNYISXGi/WzVgsh86tAMzGjGAKYMESf8EBO79nU26C48dwoj06j+NEwHSKYWMNWpGTJH7fwTy+TnTzzQ5w7b/J86bbtly1KzZp7wxj6L/lAB5dHC9HBNMAlzp4Lgsm0/qUqcHKTQzl+ZmP1TbpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GjimV39Xwy5i1MbGCLzrM2G5+Ze/GKENbuVnCOP2cN8=;
 b=ZHKac0UjJtDm8EepgYsqjeOeVyN7l8sXU5KugB7mCwQqsDWdzD9DPIrhxEaeBHaxaahiWtaYAmcyth1jXfqhH/+cDi4uzsn16594fS8HsGSotas4W3cf3wZKJ4RTJAYPr2a4TcPmOimyGIic0nEhqGJAILP2BzDreka9XPfOuRH6xp40EvSboV81akHAbVt3HgSwTZZjxrQglKaL0CWpSeibl/hGju22JF4oIKY1rUU70tuEYvSmG48IwxAggHu9niRr5NQZmcwzQI3z9iZufod9k2yh9ANfwad9s35z9Mz3R7aKLnwow2qpsbGMFNcLQxpPTsmC7eCl1Jh/Z1hGnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM5PR11MB1899.namprd11.prod.outlook.com (2603:10b6:3:10b::14)
 by BL1PR11MB5542.namprd11.prod.outlook.com (2603:10b6:208:31d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.17; Wed, 8 Feb
 2023 19:28:30 +0000
Received: from DM5PR11MB1899.namprd11.prod.outlook.com
 ([fe80::d151:74c0:20d6:d5fc]) by DM5PR11MB1899.namprd11.prod.outlook.com
 ([fe80::d151:74c0:20d6:d5fc%6]) with mapi id 15.20.6064.034; Wed, 8 Feb 2023
 19:28:29 +0000
Message-ID: <79d47a18-90dd-9fc2-aa0e-ca5627b7ca6d@intel.com>
Date:   Wed, 8 Feb 2023 11:28:26 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [PATCH] fpga: m10bmc-sec: Fix rsu_send_data() to return
 FW_UPLOAD_ERR_HW_ERROR
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        "Moritz Fischer" <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
        Lee Jones <lee@kernel.org>,
        Tianfei zhang <tianfei.zhang@intel.com>,
        <linux-fpga@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230208080846.10795-1-ilpo.jarvinen@linux.intel.com>
From:   Russ Weight <russell.h.weight@intel.com>
In-Reply-To: <20230208080846.10795-1-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4P223CA0002.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::7) To DM5PR11MB1899.namprd11.prod.outlook.com
 (2603:10b6:3:10b::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR11MB1899:EE_|BL1PR11MB5542:EE_
X-MS-Office365-Filtering-Correlation-Id: 241b7df4-0fd9-4b7d-ca03-08db0a0aa858
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0Ee+xjDmEzfoK/2m6dHPnUTyIO6bXMVF5FsfmQluVz2XDJAbjbuOTE3Rrgms/BBdPnz8TU7phI8NY+cd5xx4p5d9Cn944Zqi2fsCWLpYxchOTG4Ngw/Y9cqQ/u8Ywfg1yqANYwfwFW6km2eAmoDov5XYe702D4LC6qQTPwSceK0dKItvZYGhNfaxKy6+Ec3ZdG3nYo5Y1XFbxDnJvzxK0iyC24ws4TKcFX+Li+6mzwQiBBCENWJes+R1O9HwgmzOV86CeoUCTtggOzcj64uRrTUi8YlUfG2kwUD5qSuMsqodakugm+mxRvMHJUsIJmiAK07domVRvhIs8DPWuqHAYrFkcjKyvza9c3JOVnteC9z76tDO76vTs0n8qEimFprSLkhXmUNFZs/5rPsyFmn3TxF5SLYjyIAnAO/kUmO86U3eK6ur7vbXByo9ZtPthSt/GidTljUfOQU1TFR+SSVzD8lLjBqSBCxQGBT6FpjaSCnuSVHqm5uC1PhEj5+34tuSoofS9ZU7SXD1S913OQ2aOmjZB/lJRbWdcPJ1BHHgWKXFplzwGSsA/LHWoderqIbg3EGe57cNu0WlqyQxRD2AQHukD0Z9nnjw2/s5paJB61Oz2kyZAhhXvm+5kWkBcvHjlJNrPHy3CogxLdcx+WTvMEzIv/tMQlqTdsleYBgJgILH4cfOCIr8NpgBqOv0CJ2F/8vklYPnd42G+14DshlS7pz1BwIhPQcLLfCK9B5qXeU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR11MB1899.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(136003)(366004)(396003)(39860400002)(376002)(451199018)(31686004)(66574015)(83380400001)(36756003)(4744005)(5660300002)(2906002)(186003)(31696002)(6506007)(53546011)(6512007)(8936002)(26005)(6666004)(66556008)(41300700001)(316002)(478600001)(6486002)(86362001)(66476007)(38100700002)(2616005)(82960400001)(110136005)(66946007)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aTFlTXhqdEtUZ3FvRFV2WStjL2dsNmVzSnJBSFlMam9OL0V5K2txc1JQc2x4?=
 =?utf-8?B?M3AvdWVHU2tCSkRaSWtReDlGNWk1Q1ZGd0N4dkkxVDAxVlBUWkwzM3FLZHlo?=
 =?utf-8?B?WnJqSDNaSkFxRzZ3N09UWlRIWDliSStzb1Y4d3JOdnZhbW9KMHpKaFJKcDRY?=
 =?utf-8?B?WUEwV2NvQmt2WHFUNHVXT2hQdmxWbGE2YVVMUmhqb0VYSDlKcEFpZzcxeEsx?=
 =?utf-8?B?SjNPaEVObHRIS0QwZFE3aEdKVnBUalRQbHRxeXJ4dzF0MjdqMUtLMFpkU0dv?=
 =?utf-8?B?alRjbG5jQTlsVzUxREltU2VtTmdJb0VKcE4zTmwxVnUxYWRxamFIT3lNZjJl?=
 =?utf-8?B?T0xaZnhBUEJyVE4rT2pkQmxyc2MzKzRFY2F4TlpTT093TnUvUEo0WHcxNUZC?=
 =?utf-8?B?Q2o1VGtQKzc5NUk3RGUyU0l5cm0rd25ZY1dmOGNFc2dNYVVzTXU5c0lhajdm?=
 =?utf-8?B?akpmSlpTRXlSVVdSU2JXR0pwV1NtSFlnZ1hSUzV5YkpXSzBkS2d5eXl1Y1Jw?=
 =?utf-8?B?elpzTEdzbFprdzlSN21zaXJ1azBsRVhtTURHNWZPbWRHdWdMcFZ6Y2xJeUww?=
 =?utf-8?B?bTRlZlM5NjdCS0h2NG5pUWJmcHl4RmlxeUpmUXJyVTdSVkhMQ2FoZi9tY3pD?=
 =?utf-8?B?R0FXL3RPUFVTWi9jRlp6elJkR1FnQXhWRC9HalYyNXV4TWtVUk9JaGZ6TnNB?=
 =?utf-8?B?ODNXV3FVOFJzVGt2VEVLbmFrc25VK0dmYTR0S0UrZGhtQm5wZm4xR2s2ZjRu?=
 =?utf-8?B?YnBKMWFnZWNPV203dEkxK2hzY2NDNEpBZjluaFRSaUo5VER2aHkrclNyUU9t?=
 =?utf-8?B?VHhlTWFuSWpZSmtwUGxoN3M1Nm5DMTA5b1VQdm50YVY2b3Q2S1E2THlwdFJX?=
 =?utf-8?B?VG1IaEJvZVB2OGsrbTFXQ2RrMDNCYWR2RG1sRlJNUEsvMGNXb1BXSDdZcjY5?=
 =?utf-8?B?UlAxQm5hK0xQODdmeEZVQ0NtQTE4YWJudDhWcG5iMFZ0b081N3dsaEtSdzZ3?=
 =?utf-8?B?bkZBWHlJTkx1Q1hyUS9TSkkwbThVbW5ldmIzcW1SeVMzT2FSeWVhbFNSaWZU?=
 =?utf-8?B?WjBGNlBIRzBBYTROQTZEVVRZdVRSZmU0N3hyeVltMTlVeFZRcEE0WG4zN2ph?=
 =?utf-8?B?OUpQa0JyejI0cG94WTEzaG9mckI5YnphYVRHTW8xUG5jd1RxOEFrZGFORTBC?=
 =?utf-8?B?N2ZxcHdJcHQyalI1cThYdEhvWS9KOHNnVFZlV040bzZpYmltUDNWVU1KdHdW?=
 =?utf-8?B?RzJnNkZOSUJBalM3VmpQWUxuazA4cWRlSlpBM0FiN0dwNndkZS84enkyVFFC?=
 =?utf-8?B?anF0Q3l5a0FXSjJHMkFXNzFjVExYQkpkR3pDNVUvQUZIMC9PdE9ORDRFenhG?=
 =?utf-8?B?dEZydXhSa0dRMGlTc3lMM0MvKzhiTFRZVE5CamgwTEdtMXFyOElwcmg5dGhy?=
 =?utf-8?B?SURDVk5PQUtEdmNPOFlrVGZ3L2xSQWQxMVZ3RHJMb0pKT0JxMTMremR0d256?=
 =?utf-8?B?NFVWTmk0eEJ2VWxGNXowZ3ViRDJpRjY2Znl5NXI5aEhaZmxHM3l1aTArYVNR?=
 =?utf-8?B?RjJPQS9mNDEwT1JjTEpVK09oWUMreThtM0JmZTlSWTJOOElManI1OTRpSkxq?=
 =?utf-8?B?ZVIxMVJtVEhDaklwQzJpeUVDTWdLM3ovVXZBNmpEa1A2VVpIbEJudEVhMXZo?=
 =?utf-8?B?SjAzeHRQWGZvTVQvcVRodUZsdlAvaEVkZEIzZ0ovYlVzNEJTeVUwTW52cnly?=
 =?utf-8?B?SHhWS21kdkZpVFlzVnlqZnJLK2RjNnBLU1FCMmdGZVZ4U2xucmJKR0xMQkFP?=
 =?utf-8?B?eVhkWGhZak1XdXNVQk5DQVJpMWZUM1U1bWpBSEpVTXpBUlZlbG52YXNMb0V1?=
 =?utf-8?B?MExtYmxOWUd3S3FyVHNTM1FlMmpwYzIzSURBMjVXWWVUdEFRVjdNWGJrVEhP?=
 =?utf-8?B?elljQmY2SldlT05DZlFHalVFdFNvVFp6RUdxd3JhaGx0M0lhK2F3NGtldFN1?=
 =?utf-8?B?SFVvazBURXlCY1c4ZU9aVngvVnFIWC9BcnBIRS9tcmYyWTdYUi9xd2tzaWwv?=
 =?utf-8?B?a25JZ1I4Sk16VXZmazhZZnJ6d0FLWVJla3dOYTh0VElESjRkZW8wYzBZbWsy?=
 =?utf-8?B?RnNEVUsvMGttRXZtT2JOTDVmNzVHTGxXU25rdzVuSFE3QmwxQXdpYURCSGxW?=
 =?utf-8?B?L0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 241b7df4-0fd9-4b7d-ca03-08db0a0aa858
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1899.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2023 19:28:29.7617
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g+kCV8Dily7msVCfngItxThRxR7lHSMaj7L8ZjOPGNomgETMQYC6eu5Be/GnalZ2Jp1nyOeu5825AvlEYcKQ448Jg1Lai2E351j1/HkCUhU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5542
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


On 2/8/23 00:08, Ilpo Järvinen wrote:
> rsu_send_data() should return FW_UPLOAD_ERR_* error codes instead of
> normal -Exxxx codes. Convert <0 return from ->rsu_status() to
> FW_UPLOAD_ERR_HW_ERROR.
>
> Fixes: 001a734a55d0 ("fpga: m10bmc-sec: Make rsu status type specific")
Reviewed-by: Russ Weight <russell.h.weight@intel.com>

> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
>
> ---
>  drivers/fpga/intel-m10-bmc-sec-update.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/fpga/intel-m10-bmc-sec-update.c b/drivers/fpga/intel-m10-bmc-sec-update.c
> index f0acedc80182..d7e2f9f461bc 100644
> --- a/drivers/fpga/intel-m10-bmc-sec-update.c
> +++ b/drivers/fpga/intel-m10-bmc-sec-update.c
> @@ -474,7 +474,7 @@ static enum fw_upload_err rsu_send_data(struct m10bmc_sec *sec)
>  
>  	ret = sec->ops->rsu_status(sec);
>  	if (ret < 0)
> -		return ret;
> +		return FW_UPLOAD_ERR_HW_ERROR;
>  	status = ret;
>  
>  	if (!rsu_status_ok(status)) {
>

