Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 989296DB08B
	for <lists+linux-fpga@lfdr.de>; Fri,  7 Apr 2023 18:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbjDGQZJ (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 7 Apr 2023 12:25:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbjDGQZE (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 7 Apr 2023 12:25:04 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7788E10D5;
        Fri,  7 Apr 2023 09:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680884700; x=1712420700;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=UdZpjdryUrxp9AY6HOyp5Zb+xOyjH1Eqar6XM28UtSA=;
  b=cf27FdpSuI5XhkotjOlVAGin/1pQ1yo1JpwAdwN5yOG72GI9OZpvTdjb
   ccPWylDXYbki3oMk3F3TIH8Sbl7N5NiQwGHEgCy1ELPXE+fL89jQwKnlC
   gIAt+2AOJDedcEEqF54pGJ8riLsUuwQgwplS+Pg2QNg/M3hfI2esHrj5E
   a6fs0ikxN7463uNqBv26aIFhBhYeB7awCOm6r2k2l+VyzIH2tUyVUQdj/
   mhSHRgiO2wa4H1qB/u8ADIBDcN2SuavpAq3lfW88gr09lhLBb6lRGmhqa
   k3jVurcl048j+OYVCefFaFLkGXF1txZ1YD7vYtoaojOmter3rzMdQhjsX
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10673"; a="343026836"
X-IronPort-AV: E=Sophos;i="5.98,327,1673942400"; 
   d="scan'208";a="343026836"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2023 09:24:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10673"; a="861830704"
X-IronPort-AV: E=Sophos;i="5.98,327,1673942400"; 
   d="scan'208";a="861830704"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga005.jf.intel.com with ESMTP; 07 Apr 2023 09:24:59 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 7 Apr 2023 09:24:59 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 7 Apr 2023 09:24:58 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Fri, 7 Apr 2023 09:24:58 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Fri, 7 Apr 2023 09:24:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ByKbmQVKpaW9/YrazmKVY6QC74OfZAOHD+g16D+QpRRl4VZI3DG3I+Yi4jEhHZ+Hwc72KQdDzdB8pWf0mcHiRCAQ31jQPIb9ynUmdgLfPaNqF9uHG5JJRGWpBvTfH2n6YA4T0XkstVUbksZHk8L5QnlUb04n2m6JR7ComoMZkaQcTGqNC1W/gOBdiZTdmc5isa7grRAK2crICSFRgJfgzHVKehTSY8hcIIC2R7BRG/AVEgE4mw9bBO2/dvaTPjXau98MWw2Q+GrYX1Mya1zVtBcLAj9HQ4UnjfI4UtyOhS1dvuX/0i+uHrYPJoi+M8GGSFzEYZLasedoOI3MAS5ebg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gLSS85CFdex1qHbFaj/HrVe19Uh1FWDMRCXJgvgDeaw=;
 b=RdCJAiC5SzmGwouHAp8NCPwrpvnyhsAmxh1VdQ++ax7iN5XbYASuXY+v+qu2lTJHjqzxqOfbhjvLdgU/tCFVBxVZuG9MiJ2s+/gxQ7ClSJGOK8rxO3kgJHefkhhBCjJ7CpLUOc0quI+nM9nrt1I9ixDo/oLO4nIfzCCBaqL2zKkmfDCaYt8D2DjTRWozjaZiTIlj//hVV3WowKwLI1/reFKpXuqCaPtDmWtxQdkM8EnnxOLfiQluBS1+mnPJ/M9hNMp/lUMlnkjUDTiAO/actEQIYvz8Z3HvNGYwWwQo4+0dfp0CJ1OLWbKkaWNqj3c7YW6PgzpE7xEB9OwHctXBtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB6763.namprd11.prod.outlook.com (2603:10b6:303:20b::7)
 by PH7PR11MB6649.namprd11.prod.outlook.com (2603:10b6:510:1a7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.34; Fri, 7 Apr
 2023 16:24:55 +0000
Received: from MW4PR11MB6763.namprd11.prod.outlook.com
 ([fe80::ea27:a8a0:3e6:db89]) by MW4PR11MB6763.namprd11.prod.outlook.com
 ([fe80::ea27:a8a0:3e6:db89%6]) with mapi id 15.20.6277.031; Fri, 7 Apr 2023
 16:24:55 +0000
Message-ID: <8ccfac25-678e-3e75-553f-a263bdbfaacd@intel.com>
Date:   Fri, 7 Apr 2023 09:24:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.9.0
Subject: Re: [PATCH] fpga: dfl-fme: constify pointers to hwmon_channel_info
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
        Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
        <linux-fpga@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        <linux-hwmon@vger.kernel.org>
References: <20230407150112.79854-1-krzysztof.kozlowski@linaro.org>
From:   Russ Weight <russell.h.weight@intel.com>
In-Reply-To: <20230407150112.79854-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0089.namprd03.prod.outlook.com
 (2603:10b6:303:b6::34) To MW4PR11MB6763.namprd11.prod.outlook.com
 (2603:10b6:303:20b::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB6763:EE_|PH7PR11MB6649:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ed7ecae-efa1-474d-dea8-08db37849f34
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uBHs+sA2bApXmN5cVVyCX8kZGc1NIftLzsZxxa3qq5deoHxWKleGsNNDB7auwnl6FeZDuL8am8QrmL+gLxbC9k4Uitqf7QgY1ur2Xxb8U7Ev65PgaX38/RxzlCPlTIOu+p26QjXiAVd9007jgWDUcqAyNsfGFqZKYnx9WRwndIVsA28/FQpB9213qD5/lOV/pkYWmFQNzH6KwPFz0FkMOU3ygvWe0sSCuUHZLXsppIZZOXwpafsZi5Tkoz+xpksJ6MAqIPyu0bmh06ovBkiWf9+twm/oFWHqyI1h/wWPVqKhten94tpxgtMJBLO/UPGXAUzXJrF3+q/qCwA/26xfzOYXC5qjHccYecZxkTP4WACz1mtiyarR3vTVzo0Svz4FaC6zWFRXQHTB7YyEwtfAMgHctV8MOpXOcjlY9C1VvJr5cmsxrgA4oAdRxOdEmpG/JoFSCH+KMLqG8lBhMlPMTZ+8XV4Uox4wcWXZL4ritfvPZHAZyRP6uRjkCzMp2m9TevZ7/FXtLvfky5brn2KEMRJBLsg4oVvradTgi2zVj5/+ptVMKSBTUsmztfovdKt36po5GwzqjVQV5cNC3E2myPjmKQ9JZqdgiqvNVyos8t0SrgncHR4U/sNgg6tFWi+CV4NgiqBxDOoJa8LF+l2jIA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB6763.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(39860400002)(136003)(346002)(376002)(396003)(451199021)(86362001)(31696002)(36756003)(26005)(186003)(6506007)(6512007)(53546011)(2906002)(83380400001)(2616005)(478600001)(4326008)(66946007)(66556008)(8676002)(66476007)(316002)(110136005)(54906003)(5660300002)(31686004)(6486002)(41300700001)(966005)(8936002)(38100700002)(82960400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cUE3N3E4ZWJ4d2pvazFIWkxqYkwzL202K1NIdVMyUk5oWlMrL3U1cituT2Rr?=
 =?utf-8?B?Wm1mZE1odExxenBJZ3dEblJFbEh6MHBUTE0wU0dZVjk4MjFac0RJNWhjQmVY?=
 =?utf-8?B?Sk9DbXRPZ3RaUDJTMUNjSzdlV0ZySXIyOWVoOXZxSkFXeVJROTRqK1BlaTRW?=
 =?utf-8?B?UktoaFFwT1Jxa2hwc3hxczVMb2p6dko2cEFVSkhqUHYycVN5K3lmNnZpQzJM?=
 =?utf-8?B?TER1cVQyN0ljZ2ZzMUVJSXZ0U1UwT1Q5bkEwUUlFY0VVVUtaVUhITlhGWVV2?=
 =?utf-8?B?NTJCb3BPMkl1ZTRhNWtDdVlxMkhYNzJSSXludWZVa3JISGVMTk9OcVgyMGtD?=
 =?utf-8?B?am9VVEIzclJMZ3VtaUhFWlZrYTBXSk5uYzI3M2ZGRFhqeTZIS1ZOSGFOalZE?=
 =?utf-8?B?YTVwVGdGUFM1dzNWUU1reXZrc1JBYWYyM3M0NlNHODFJMTN3N0dNV1RnS2w5?=
 =?utf-8?B?TmpPbjcwakdEYVljVUxDUk9VQ0UyMG1BaHlmUGJLOElwcXdNdWNrOXVvNFBR?=
 =?utf-8?B?MmZ6NHJScjRXNnV2UE5udWFSbDA5Y043U2F3NVpTYlBzMW9sT2EvbXd2MFM2?=
 =?utf-8?B?Y0UwK1RwaTN0VU0rM0llcEphOEZ1TDN6dEVxU2pmcHFKd1RVV0VNVktsOVJW?=
 =?utf-8?B?QUZNVjVGamJJbXlHdGQ2NnBTazg5ZkxjQUZTd25YWkxwcytyVFQ0VmxIK1dm?=
 =?utf-8?B?SFhkUnpaZVZETS96dTV1eDhnVkxvT2NZUEk3QmQ2azU3dVk1MFAzZXhqZ2VU?=
 =?utf-8?B?VDQ0SUd6MGY1WXhMendIaXNUWitJVGs4bkhzWmd1SHlqendWbjZhQS9adk51?=
 =?utf-8?B?WHNMZkRVTTRQYnllY1ZHdHhJSW9ZR3BkOEdiNEhkOHZjZ0NVMFdJTnJWUkVy?=
 =?utf-8?B?WXQ3WU5LZDdKOE1zTEQrOUhlZDYvRGJIcCt3QVNJaTRJRU1WV2pYU1NVcWdZ?=
 =?utf-8?B?UzlwMlZ4SHMvQUtuQVhDMDk3Nkh2TFpzUXRWZVMvT2VERDZML2M0TEpGTW5k?=
 =?utf-8?B?a0tJREJFRkpiNk5yNkEzZEZZYlVoUDJDOTI5R0RuOWhNM3AzcE1LK2RUNlQ2?=
 =?utf-8?B?K0lLZG8zRDl1b2tnN2MxSkRiM1RVNnhMR0M4b1hjOHpyZE5FSU5LTG16allX?=
 =?utf-8?B?N3dlNjBXWkUyWW9KVk9uelY4WUpZNmVvY2RtK1h3KzFKeEYxNVI5Q3Q3VEhi?=
 =?utf-8?B?ZlZwRnY4ZytVSHQzM2d0cGdzODhWazNodGVTdjdkeGxUdWFxd2VEWHZ4V3lp?=
 =?utf-8?B?QXBMa0RDN0FDRW15NUNxMlFRWkhFOXA1eDd6SHg3OHNVM0ZKb2FGRUNqekRD?=
 =?utf-8?B?cS81YllVSGVqcnRnU1RVdXVvWUFXRmhTSS94aWxWdHF5b1l3MHNCckRFeDVo?=
 =?utf-8?B?RjBCdEpla1Q3WTY5UnpKT2tmZlFVbkY4N2FwVC9QcWNiWjFFWlIwdW1idERl?=
 =?utf-8?B?K0JlZS9LZXZOODdZUFV5N1JUUUxLVGVKQWJNaFlHNVVvTDcyeXpOUFpjYTMv?=
 =?utf-8?B?YUMxekVOTEZDcENYNjM3UHI1ajd2RStZM1ZCSXFSYjhITGR4Unh1aTlJSktj?=
 =?utf-8?B?bmlhYjU5cXhqVXpXeGVSR3NNYk56a0pXaFlZblI5aFdDRENvT2NZNlo5TVlr?=
 =?utf-8?B?RzgzNmJqY0xneG50dlVHZUg5blNKaEJERlRjSXdhUjhIc0tlK01LUHZiNjdr?=
 =?utf-8?B?eFM5QnAxWGM2UE1lOE4wY3A4WFY3VklHcUQ4ZFlWOEEvZy9obnVHVndVMWFB?=
 =?utf-8?B?VGlHdmNpd1drT0pGL3JvbzVUQ3RJZVFaZ0FvYmV0WkxTL1dNcE1aZUNOQnNS?=
 =?utf-8?B?L1FJUTFyT2FuSFBYNGxZVmhwOWFIWXBSNmtjQlFJcUxpUm14ei9jQi9OZEhu?=
 =?utf-8?B?b2M0WXVOeUFka2lKQTcxQ2J1eTlENFJFMFRjcllsYWMxVW1yTnJxOFNMbmVl?=
 =?utf-8?B?bWZWclBSak54Z05rSnhxdnhZWGxwU3p2azBqY0VpemM0Vm02M3cyREg2SU5E?=
 =?utf-8?B?VHBTakNORGx5QlIyT3JJVnNhNU1hWEN1MEJ0THhNR2I1djFSRGFZTzF1cE9U?=
 =?utf-8?B?M3dCR29hRzBLbWUvMzZ3bmtKYmhDR1dmMHpMek9nOXBBb2R3b045NXRTbkhI?=
 =?utf-8?B?RkZPMEgwQlFWbDFwaExMQXhhUXZsYTA5TEc5SlRlVXVoWHIxQXpmVklTbkRN?=
 =?utf-8?B?alE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ed7ecae-efa1-474d-dea8-08db37849f34
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB6763.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2023 16:24:55.1376
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gv+SEZ3eDsaFy9xbov+j9/2wbl6C8P6XXVoHmzexPiz3Iz66r6GzHLnYwxcrJGC2B67rEKD/z9pgRIdVHyW8fDwJ7ZhFREmeFOB2AIoQ1IE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6649
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

 
On 4/7/23 08:01, Krzysztof Kozlowski wrote:
> Statically allocated array of pointed to hwmon_channel_info can be made
> const for safety.

Reviewed-by: Russ Weight <russell.h.weight@intel.com>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>
> ---
>
> This depends on hwmon core patch:
> https://lore.kernel.org/all/20230406203103.3011503-2-krzysztof.kozlowski@linaro.org/
>
> Therefore I propose this should also go via hwmon tree.
>
> Cc: Jean Delvare <jdelvare@suse.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: linux-hwmon@vger.kernel.org
> ---
>  drivers/fpga/dfl-fme-main.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/fpga/dfl-fme-main.c b/drivers/fpga/dfl-fme-main.c
> index 77ea04d4edbe..bcb5d34b3b82 100644
> --- a/drivers/fpga/dfl-fme-main.c
> +++ b/drivers/fpga/dfl-fme-main.c
> @@ -265,7 +265,7 @@ static const struct hwmon_ops thermal_hwmon_ops = {
>  	.read = thermal_hwmon_read,
>  };
>  
> -static const struct hwmon_channel_info *thermal_hwmon_info[] = {
> +static const struct hwmon_channel_info * const thermal_hwmon_info[] = {
>  	HWMON_CHANNEL_INFO(temp, HWMON_T_INPUT | HWMON_T_EMERGENCY |
>  				 HWMON_T_MAX   | HWMON_T_MAX_ALARM |
>  				 HWMON_T_CRIT  | HWMON_T_CRIT_ALARM),
> @@ -465,7 +465,7 @@ static const struct hwmon_ops power_hwmon_ops = {
>  	.write = power_hwmon_write,
>  };
>  
> -static const struct hwmon_channel_info *power_hwmon_info[] = {
> +static const struct hwmon_channel_info * const power_hwmon_info[] = {
>  	HWMON_CHANNEL_INFO(power, HWMON_P_INPUT |
>  				  HWMON_P_MAX   | HWMON_P_MAX_ALARM |
>  				  HWMON_P_CRIT  | HWMON_P_CRIT_ALARM),

