Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F0926954E4
	for <lists+linux-fpga@lfdr.de>; Tue, 14 Feb 2023 00:42:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbjBMXke (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 13 Feb 2023 18:40:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbjBMXkd (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 13 Feb 2023 18:40:33 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 651FBCA3A;
        Mon, 13 Feb 2023 15:40:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676331626; x=1707867626;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=k3o8AsMAZzzeeRLJ8WMo56GkScdDiFraCfWOUWnK2bQ=;
  b=Vl32GZcFtRvtgSKUDdJ1b88uuMZhvAu3XOZV9pdvrVvzKSlyLVUyy6TN
   CDzKQx58I5Ec4JYLRiEH4Usmyuujxqa8obXN5P5k0dC3CVZgXc0vxZanD
   prkZBnHzNKMIrWQXEcrH+riWEwdUH6fKVlgeTw4Hnw2onSac9sGb10ZNi
   v/rV7utxK7DfUjDJvAIz/tmpEjO4aOcQGEK7tb7icnL8uyFOlRwOdL2eS
   SCcef4yeIWAcXgzFYuo+Scgk9yFW+3f/WM6pzILOrxpFCJTO/5rco8J9c
   SyNV4FuwIMkTKfnUdBeLxt53JB+6hG3K7p/MLrRDxQlEuycJsz6Sl36SQ
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="332341119"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="332341119"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2023 15:37:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="842955339"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="842955339"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga005.jf.intel.com with ESMTP; 13 Feb 2023 15:37:26 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 13 Feb 2023 15:37:26 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 13 Feb 2023 15:37:26 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.46) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 13 Feb 2023 15:37:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M9tucrOyclZzKWPpqDLWKf0dxuxoJCU7Qa5zTliZEIC9fQxD9/SaNRETdaG85tvu6kj5BivTQlrcM9MUNvoIudzgDE37ebV0N4e1ma116NKCzHsm1NZio+JxJj+4xMYbuKQGi6AWB2bzhy7x+W1blnja8R7uwcy1ItkmuX9XfC0xZVyQF9CURCQo9ew0UE8J6QYsdgPcOxtnoc81mMu7h/BLsLv63vQAZgz8lnllC39F5KW8tHOqe94/3EqIjCfXfwruzl3FqrAEF8azEYok6CCjOdV58rhRH7Latv/J1kZUkemdgsFaVwjstIzkRhQifahvxXGpm/EkZu9w2HwT7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0nQGvmMBC7prpkwZg6U5mZxoknmiAWEN3ZgcUo//r3E=;
 b=ZICN6GY5S0eOXrGxUdS2BUMImewJzeTZ72jND857nxrDXH9qZAGgSUYquwP6Y9jlA9hR6ksKjU4B710+Jl1XQLh+2eWAqINPdJQ+9ugrUHazcMgg1VOQv3EsxE0Fek6Xp9dqueBIg8DWuMxZuPiEfOx/dP23XWsszduCnzvx9idbfUVbjbA/ts8X1T5Qg8cVfrRtSPHVzOBs44OnB9ByDwd5B6D+xENvMOkvu/boUDHemifgJuqpUAHw7KZ+AeAq5Ro0VMUE1pTAzxgxZhwluGWKP7FmeD7D3u8/jb+I1Jacnm/taXDKEUwqYeSasUcmKvOWJgX1nz3sE0vwZGmtRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM5PR11MB1899.namprd11.prod.outlook.com (2603:10b6:3:10b::14)
 by BL3PR11MB6481.namprd11.prod.outlook.com (2603:10b6:208:3bc::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.22; Mon, 13 Feb
 2023 23:37:21 +0000
Received: from DM5PR11MB1899.namprd11.prod.outlook.com
 ([fe80::d151:74c0:20d6:d5fc]) by DM5PR11MB1899.namprd11.prod.outlook.com
 ([fe80::d151:74c0:20d6:d5fc%6]) with mapi id 15.20.6086.024; Mon, 13 Feb 2023
 23:37:20 +0000
Message-ID: <3588ad2f-f33f-8979-ba05-29c367716610@intel.com>
Date:   Mon, 13 Feb 2023 15:37:16 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [RFC PATCH 1/4] fpga: add initial KUnit test suite
Content-Language: en-US
To:     Marco Pagani <marpagan@redhat.com>,
        Moritz Fischer <mdf@kernel.org>, "Wu Hao" <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-fpga@vger.kernel.org>
References: <20230203170653.414990-1-marpagan@redhat.com>
 <20230203170653.414990-2-marpagan@redhat.com>
From:   Russ Weight <russell.h.weight@intel.com>
In-Reply-To: <20230203170653.414990-2-marpagan@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0003.namprd03.prod.outlook.com
 (2603:10b6:303:8f::8) To DM5PR11MB1899.namprd11.prod.outlook.com
 (2603:10b6:3:10b::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR11MB1899:EE_|BL3PR11MB6481:EE_
X-MS-Office365-Filtering-Correlation-Id: cfd7fafe-463a-481d-b654-08db0e1b400f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Yl8E1F9dbmyW6hnn69C9iUgyfZxuc0dV6o1ULujKt6fKyPUhQjac/eX4zmaDRrUJnjLSm4oUONjblOTilZ7C811Vy6uFSVzuKHLYJFR8SlkKzZqYs+0EBtr3dVH8810AYmy8aVfpCWZikfRurLaLn+u35zLAZcbRfyrtRGkrwDndcY75kjJ1OJKfUxVwkDxUAWC6clt6Qws0rrZbYj+3j1woNSC//DLDv4aBu5skIS7Jb0yemzq5KEBk8pM3KOy9xkjD0jjKn36p91hNCCweUtuqVsrawn90fpFru6eem7EWUaWIP4OnSIAdvi2fUKwfp1cvDgI77dbhl0Lo0U9bI9KkyWxa2+RAk8maxXEnOhHSOdlk+wnaZpbDNmyhdc97THkKG/RITv4ox0WxaUiAwVhhn3cYd06y8tfPYaF2JHQXNpYLfrxoR5fTp7jChP/1wiWbcDWelx9gI06ONHqldIpXKdM6u7kFCQNXjIy3ZUv/e18R1BcWreiWwUbihufglr7ofUqCX4bdf/I0n3N0dOVKWavK3QONQEb2lBL0AQrJHVvw4AutqTd5a5XldPllN+ncOPl/1PdHLR+PLXu198fCnMOhwYFaWi8wD3YO3nSEN+Z+uyXB3u3BIkMuOR9fUgdjrbvaa6d8gRyyaQBmdhk1VXfi1t+dNnbEPo1UXjX1BZz9mipLxqfYaZzWPyyHd+EnGrWXaMhIsBrlxqmjFR8LqnWBwLgAbC0SxMXp+pY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR11MB1899.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(396003)(39860400002)(366004)(376002)(136003)(451199018)(31686004)(110136005)(82960400001)(2616005)(6666004)(6512007)(38100700002)(6506007)(316002)(478600001)(6486002)(86362001)(31696002)(186003)(53546011)(26005)(30864003)(66476007)(36756003)(4326008)(8676002)(8936002)(2906002)(5660300002)(66556008)(83380400001)(41300700001)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?THd4Zi9naGdzQkJpY201M2FNZ29BYXo0b2lXRzY1amVma3E2Q0lVYzZnQ1c0?=
 =?utf-8?B?akJQOTRVeURMTWgrdjEvVWhsdGM4aGlTcCtLcWd4VXlSek0yTFRDSlJMbllP?=
 =?utf-8?B?L3hQbGtvUkphT1B5US9GZzN1N2ZZdHNyVXNYam42SkV4ZFdoM2xnNmFKc0l1?=
 =?utf-8?B?dEd0RTRwR1cvRUdWbGJNam5DRGxIZDgrVHF3cEg1dEtDMXdsaWprcm5qM2M3?=
 =?utf-8?B?NEcwRFVtdnhXYzFiT0NRZldzR1N5cGszS1hQMGJnb3ZKR3E3aWMvSjgzcnlF?=
 =?utf-8?B?bU5BOGtmOTZOWHZ3bHNHUEE0VTZGV0ZhWjRWRWlLQmVnUm5qb1hyUjhuWnhD?=
 =?utf-8?B?bHZzY0FXTUgyOTIzcFhVZkVlL25SU2NGcStWc0pwSHJhVHJaZTJwWEsvcE80?=
 =?utf-8?B?dG03anVKTzgwWU44RmdnRWdNbWtOSGthRVJ5dVlWRlI1MkRqdGhrZXE0ak5V?=
 =?utf-8?B?R2tDMTVOYUxQcG13Q3hBaVpBL3VxZURPRmZITFNLa2gyVTBrUEhwSUpQVXRn?=
 =?utf-8?B?azFKM1IrR1VEcE1CaWg5ZmcycmJ2WnJ0YkJjb3g5bTlHdXd3QWh5S2RhU1Ey?=
 =?utf-8?B?VkxDTDJRVXdzbWppTjNnWnNkcmYyNmdjK3lkc0FiYUFnVjliRVA0TG5FQmtm?=
 =?utf-8?B?NUVSREMrR3pOSlljUEtVOG01YmJUVUU3NGRoM3lsaTNwQUtPTG1iWUo5Z3py?=
 =?utf-8?B?VkRtVkt1RVRpYUk1cDlJUC9YTlUwV3RXbWk5bXNZWnQxdGhBSEFEaWFRNzBl?=
 =?utf-8?B?NEtZcFFNeXpwOUpTWWY3QmVxaHZXT3p1YWZOWUVOdW51bG1Za2R4b0JLcU1F?=
 =?utf-8?B?UVdVcWtteHY5b0I3b3d1UXMyRzFVaDd0SU15aklWelZ5VUUrU3ZHRDU4cmpE?=
 =?utf-8?B?aHBpaEtaVlVHbzloakZoem9BVVBqbVZ0MENsZFg5ZDdKeGtnSmx3ZGt3Z1Vk?=
 =?utf-8?B?YWliL1RUNkMvM0VpRWpOaER2NE5FOStMa1lMQ2tQZXhRd2d3aXFUaWFKTFcy?=
 =?utf-8?B?MUhYd1JsbEMyVGdna3ZRdGNWWDY3cGRKUDdTc0JjZW1GRE01c3VDSk1OSWJX?=
 =?utf-8?B?RFJsQ3AxekhyQk1US0J5OFdTdjlodGJKaWZLbHdTVkgzR25qT2xwTy85K1V2?=
 =?utf-8?B?cWV0UHRLYUlsYzVTS3F0WVhXMXpqUnFiQS90NjRaVkdjZEhTQ1hPZ1dLVzJF?=
 =?utf-8?B?YjNyNERZSDROVllJTHc2cGk5bHQ2QUJaZ3FOcmtnYXZSNmpZWEY4NHJqZk05?=
 =?utf-8?B?VEdnYU91Qmt3WnI1cGRSajM0STBNaHZPQnNKNFE4d0g4bHR6SWpjQVlrRVlD?=
 =?utf-8?B?TlNBM2JOK0w2WVE0VFZvME5mQ1ZYeFIzZm1EYnltSEhYUmE0MXErVm9nVUo0?=
 =?utf-8?B?Q25xWUt6MFVHZS9zc21mR0Q0Q3FGQ01ac01HbENzK2I0TE8zVnlFcVlndU95?=
 =?utf-8?B?NUFvQm0yV1N6TFlrU2hETXhCR2w2bDFRZjgrRlJtRXk2QjV5QjZuOWtzbkN0?=
 =?utf-8?B?RVhpL21mRG1kWWpjNFNJZ2pBMTVBcUdiajMxV2pLVGE4M3E2UHd1UXNLMFF0?=
 =?utf-8?B?L1B0WW5ueE9JODBZMkNTWGxkSVZHV01YcWxDSmN5MGV0QnMvaFZDYUNSR3VH?=
 =?utf-8?B?WFEzU0pTRFVmendDZlRqdHFwL0xkZHZKdHdyKzhiKzVHUTZaT21SUmgzcXFx?=
 =?utf-8?B?V01HRHdqMTFmMXpzQU81NnltY1dUNC9kYnZHRzVnd1BGSzZjNzk5M1luemZK?=
 =?utf-8?B?NURjemlxazVPWEFiRWRoUGx4cGdKak4zd2pzYW5WeTlKWHhuWWZ2Y1RJaVhI?=
 =?utf-8?B?UHR0bEtUUWlqbXFLM0tIeG8yWHRabXlFcWdVK1ZtQkhtVWlqTm9aZkVwQTdk?=
 =?utf-8?B?N1BqeGtIRk1UWE1EU29nRWUvZE5xRUc2YSs4VmNVbjFWN09MSXBxTzBMWTc1?=
 =?utf-8?B?dnpua0twVkJjWUIyWlBjU0dDczViczJFTEVnbTRSTWZSOHd4cFF5Y1VscEFM?=
 =?utf-8?B?UUlPZUYxNk1oaG9taVZWMnNmd05kNEttemxHUk1Fd0JCS0dsOEtKQlVqcTE0?=
 =?utf-8?B?M2tZNGdGZ1NScFBaTmVaeHFLYy9BUVBLNGdKUkhTcVlIYVh3MENzTE1HQ0dZ?=
 =?utf-8?B?Z0kreEhRTW5DV3hiVFdOYU5HRUtTV0N0SWdiSm5NNEhNTVMyaXBRUFNqTDZ1?=
 =?utf-8?B?VkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cfd7fafe-463a-481d-b654-08db0e1b400f
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1899.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2023 23:37:20.8015
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 71s+rzNpO7r8yRh12RIegsCtrDMGBwDgwcCyRqAc9KEMKKWEsUamNQDx6sOD01UUCpOQjfN01IkwG204CTGFGYnGivJS+1eizMZk8Ise4lY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6481
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On 2/3/23 09:06, Marco Pagani wrote:
> Introduce an initial KUnit suite to test the core components of the
> FPGA subsystem.
>
> The test suite consists of two test cases. The first test case checks
> the programming of a static image on a fake FPGA with a single hardware
> bridge. The FPGA is first programmed using a test image stored in a
> buffer, and then with the same image linked to a single-entry
> scatter-gather list.
>
> The second test case models dynamic partial reconfiguration. The FPGA
> is first configured with a static image that implements a
> reconfigurable design containing a sub-region controlled by two soft
> bridges. Then, the reconfigurable sub-region is reconfigured using
> a fake partial bitstream image. After the reconfiguration, the test
> checks that the soft bridges have been correctly activated.
>
> Signed-off-by: Marco Pagani <marpagan@redhat.com>
> ---
>  drivers/fpga/Kconfig            |   2 +
>  drivers/fpga/Makefile           |   3 +
>  drivers/fpga/tests/.kunitconfig |   5 +
>  drivers/fpga/tests/Kconfig      |  15 ++
>  drivers/fpga/tests/Makefile     |   6 +
>  drivers/fpga/tests/fpga-tests.c | 264 ++++++++++++++++++++++++++++++++
>  6 files changed, 295 insertions(+)
>  create mode 100644 drivers/fpga/tests/.kunitconfig
>  create mode 100644 drivers/fpga/tests/Kconfig
>  create mode 100644 drivers/fpga/tests/Makefile
>  create mode 100644 drivers/fpga/tests/fpga-tests.c
>
> diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
> index 0a00763b9f28..2f689ac4ba3a 100644
> --- a/drivers/fpga/Kconfig
> +++ b/drivers/fpga/Kconfig
> @@ -276,4 +276,6 @@ config FPGA_MGR_LATTICE_SYSCONFIG_SPI
>  	  FPGA manager driver support for Lattice FPGAs programming over slave
>  	  SPI sysCONFIG interface.
>  
> +source "drivers/fpga/tests/Kconfig"
> +
>  endif # FPGA
> diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
> index 72e554b4d2f7..352a2612623e 100644
> --- a/drivers/fpga/Makefile
> +++ b/drivers/fpga/Makefile
> @@ -55,3 +55,6 @@ obj-$(CONFIG_FPGA_DFL_NIOS_INTEL_PAC_N3000)	+= dfl-n3000-nios.o
>  
>  # Drivers for FPGAs which implement DFL
>  obj-$(CONFIG_FPGA_DFL_PCI)		+= dfl-pci.o
> +
> +# KUnit tests
> +obj-$(CONFIG_FPGA_KUNIT_TESTS)		+= tests/
> diff --git a/drivers/fpga/tests/.kunitconfig b/drivers/fpga/tests/.kunitconfig
> new file mode 100644
> index 000000000000..a1c2a2974c39
> --- /dev/null
> +++ b/drivers/fpga/tests/.kunitconfig
> @@ -0,0 +1,5 @@
> +CONFIG_KUNIT=y
> +CONFIG_FPGA=y
> +CONFIG_FPGA_REGION=y
> +CONFIG_FPGA_BRIDGE=y
> +CONFIG_FPGA_KUNIT_TESTS=y
> diff --git a/drivers/fpga/tests/Kconfig b/drivers/fpga/tests/Kconfig
> new file mode 100644
> index 000000000000..5198e605b38d
> --- /dev/null
> +++ b/drivers/fpga/tests/Kconfig
> @@ -0,0 +1,15 @@
> +config FPGA_KUNIT_TESTS
> +	tristate "FPGA KUnit tests" if !KUNIT_ALL_TESTS
> +	depends on FPGA && FPGA_REGION && FPGA_BRIDGE && KUNIT
> +	default KUNIT_ALL_TESTS
> +	help
> +	  Builds unit tests for the FPGA subsystem. This option
> +	  is not useful for distributions or general kernels,
> +	  but only for kernel developers working on the FPGA
> +	  subsystem and its associated drivers.
> +
> +	  For more information on KUnit and unit tests in general,
> +	  please refer to the KUnit documentation in
> +	  Documentation/dev-tools/kunit/.
> +
> +	  If in doubt, say "N".
> diff --git a/drivers/fpga/tests/Makefile b/drivers/fpga/tests/Makefile
> new file mode 100644
> index 000000000000..74346ae62457
> --- /dev/null
> +++ b/drivers/fpga/tests/Makefile
> @@ -0,0 +1,6 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +obj-$(CONFIG_FPGA_KUNIT_TESTS) += fake-fpga-mgr.o
> +obj-$(CONFIG_FPGA_KUNIT_TESTS) += fake-fpga-region.o
> +obj-$(CONFIG_FPGA_KUNIT_TESTS) += fake-fpga-bridge.o
> +obj-$(CONFIG_FPGA_KUNIT_TESTS) += fpga-tests.o
> diff --git a/drivers/fpga/tests/fpga-tests.c b/drivers/fpga/tests/fpga-tests.c
> new file mode 100644
> index 000000000000..33f04079b32f
> --- /dev/null
> +++ b/drivers/fpga/tests/fpga-tests.c
> @@ -0,0 +1,264 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Test suite for the FPGA subsystem
> + *
> + * Copyright (C) 2023 Red Hat, Inc. All rights reserved.
> + *
> + * Author: Marco Pagani <marpagan@redhat.com>
> + */
> +
> +#include <kunit/test.h>
> +#include <linux/platform_device.h>
> +#include <linux/scatterlist.h>
> +
> +#include <linux/fpga/fpga-mgr.h>
> +#include <linux/fpga/fpga-region.h>
> +#include <linux/fpga/fpga-bridge.h>
> +
> +#include "fake-fpga-region.h"
> +#include "fake-fpga-bridge.h"
> +#include "fake-fpga-mgr.h"
> +
> +#define FAKE_BIT_BLOCKS		16
> +#define FAKE_BIT_SIZE		(FPGA_TEST_BIT_BLOCK * FAKE_BIT_BLOCKS)
> +
> +static u8 fake_bit[FAKE_BIT_SIZE];

I take it "bit" in fake_bit and sgt_bit is short for "bitstream". Initially,
I found this confusing as I tend to think of a bit as a single bit. It might
be better to expand that something like "fake_bitstream" or "fake_image".

- Russ
> +
> +static int init_sgt_bit(struct sg_table *sgt, void *bit, size_t len)
> +{
> +	int ret;
> +
> +	ret = sg_alloc_table(sgt, 1, GFP_KERNEL);
> +	if (ret)
> +		return ret;
> +
> +	sg_init_one(sgt->sgl, bit, len);
> +
> +	return ret;
> +}
> +
> +static void free_sgt_bit(struct sg_table *sgt)
> +{
> +	if (sgt)
> +		sg_free_table(sgt);
> +}
> +
> +static void fpga_build_base_sys(struct kunit *test, struct fake_fpga_mgr *mgr_ctx,
> +				struct fake_fpga_bridge *bridge_ctx,
> +				struct fake_fpga_region *region_ctx)
> +{
> +	int ret;
> +
> +	ret = fake_fpga_mgr_register(mgr_ctx, test);
> +	KUNIT_ASSERT_EQ(test, ret, 0);
> +
> +	ret = fake_fpga_bridge_register(bridge_ctx, test);
> +	KUNIT_ASSERT_EQ(test, ret, 0);
> +
> +	ret = fake_fpga_region_register(region_ctx, mgr_ctx->mgr, test);
> +	KUNIT_ASSERT_EQ(test, ret, 0);
> +
> +	ret = fake_fpga_region_add_bridge(region_ctx, bridge_ctx->bridge);
> +	KUNIT_ASSERT_EQ(test, ret, 0);
> +}
> +
> +static void fpga_free_base_sys(struct fake_fpga_mgr *mgr_ctx,
> +			       struct fake_fpga_bridge *bridge_ctx,
> +			       struct fake_fpga_region *region_ctx)
> +{
> +	if (region_ctx)
> +		fake_fpga_region_unregister(region_ctx);
> +
> +	if (bridge_ctx)
> +		fake_fpga_bridge_unregister(bridge_ctx);
> +
> +	if (region_ctx)
> +		fake_fpga_mgr_unregister(mgr_ctx);
> +}
> +
> +static int fpga_suite_init(struct kunit_suite *suite)
> +{
> +	fake_fpga_mgr_fill_header(fake_bit);
> +
> +	return 0;
> +}
> +
> +static void fpga_base_test(struct kunit *test)
> +{
> +	int ret;
> +
> +	struct fake_fpga_mgr mgr_ctx;
> +	struct fake_fpga_bridge base_bridge_ctx;
> +	struct fake_fpga_region base_region_ctx;
> +
> +	struct fpga_image_info *test_img_info;
> +
> +	struct sg_table sgt_bit;
> +
> +	fpga_build_base_sys(test, &mgr_ctx, &base_bridge_ctx, &base_region_ctx);
> +
> +	/* Allocate a fake test image using a buffer */
> +	test_img_info = fpga_image_info_alloc(&mgr_ctx.pdev->dev);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, test_img_info);
> +
> +	test_img_info->buf = fake_bit;
> +	test_img_info->count = sizeof(fake_bit);
> +
> +	kunit_info(test, "fake bitstream size: %zu\n", test_img_info->count);
> +
> +	KUNIT_EXPECT_EQ(test, 0, fake_fpga_mgr_get_rcfg_count(&mgr_ctx));
> +
> +	KUNIT_EXPECT_EQ(test, 0, fake_fpga_bridge_get_state(&base_bridge_ctx));
> +	KUNIT_EXPECT_EQ(test, 0, fake_fpga_bridge_get_cycles_count(&base_bridge_ctx));
> +
> +	/* Program the fake FPGA using the image buffer */
> +	base_region_ctx.region->info = test_img_info;
> +	ret = fpga_region_program_fpga(base_region_ctx.region);
> +	KUNIT_ASSERT_EQ(test, ret, 0);
> +
> +	fake_fpga_mgr_check_write_buf(&mgr_ctx);
> +
> +	KUNIT_EXPECT_EQ(test, 1, fake_fpga_mgr_get_rcfg_count(&mgr_ctx));
> +
> +	KUNIT_EXPECT_EQ(test, 1, fake_fpga_bridge_get_state(&base_bridge_ctx));
> +	KUNIT_EXPECT_EQ(test, 1, fake_fpga_bridge_get_cycles_count(&base_bridge_ctx));
> +
> +	fpga_image_info_free(test_img_info);
> +
> +	/* Allocate another fake test image using a scatter list */
> +	test_img_info = fpga_image_info_alloc(&mgr_ctx.pdev->dev);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, test_img_info);
> +
> +	ret = init_sgt_bit(&sgt_bit, fake_bit, FAKE_BIT_SIZE);
> +	KUNIT_ASSERT_EQ(test, ret, 0);
> +
> +	test_img_info->sgt = &sgt_bit;
> +
> +	/* Re-program the fake FPGA using the image scatter list */
> +	base_region_ctx.region->info = test_img_info;
> +	ret = fpga_region_program_fpga(base_region_ctx.region);
> +	KUNIT_ASSERT_EQ(test, ret, 0);
> +
> +	fake_fpga_mgr_check_write_sg(&mgr_ctx);
> +
> +	KUNIT_EXPECT_EQ(test, 2, fake_fpga_mgr_get_rcfg_count(&mgr_ctx));
> +
> +	KUNIT_EXPECT_EQ(test, 1, fake_fpga_bridge_get_state(&base_bridge_ctx));
> +	KUNIT_EXPECT_EQ(test, 2, fake_fpga_bridge_get_cycles_count(&base_bridge_ctx));
> +
> +	free_sgt_bit(&sgt_bit);
> +	fpga_image_info_free(test_img_info);
> +	fpga_free_base_sys(&mgr_ctx, &base_bridge_ctx, &base_region_ctx);
> +}
> +
> +static void fpga_pr_test(struct kunit *test)
> +{
> +	int ret;
> +
> +	struct fake_fpga_mgr mgr_ctx;
> +	struct fake_fpga_bridge base_bridge_ctx;
> +	struct fake_fpga_region base_region_ctx;
> +
> +	struct fake_fpga_bridge pr_bridge_0_ctx;
> +	struct fake_fpga_bridge pr_bridge_1_ctx;
> +	struct fake_fpga_region pr_region_ctx;
> +
> +	struct fpga_image_info *test_static_img_info;
> +	struct fpga_image_info *test_pr_img_info;
> +
> +	fpga_build_base_sys(test, &mgr_ctx, &base_bridge_ctx, &base_region_ctx);
> +
> +	/* Allocate a fake test image using a buffer */
> +	test_static_img_info = fpga_image_info_alloc(&mgr_ctx.pdev->dev);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, test_static_img_info);
> +
> +	test_static_img_info->buf = fake_bit;
> +	test_static_img_info->count = sizeof(fake_bit);
> +
> +	kunit_info(test, "fake bitstream size: %zu\n", test_static_img_info->count);
> +
> +	KUNIT_EXPECT_EQ(test, 0, fake_fpga_mgr_get_rcfg_count(&mgr_ctx));
> +
> +	KUNIT_EXPECT_EQ(test, 0, fake_fpga_bridge_get_state(&base_bridge_ctx));
> +	KUNIT_EXPECT_EQ(test, 0, fake_fpga_bridge_get_cycles_count(&base_bridge_ctx));
> +
> +	/* Program the fake FPGA using the image buffer */
> +	base_region_ctx.region->info = test_static_img_info;
> +	ret = fpga_region_program_fpga(base_region_ctx.region);
> +	KUNIT_ASSERT_EQ(test, ret, 0);
> +
> +	fake_fpga_mgr_check_write_buf(&mgr_ctx);
> +
> +	KUNIT_EXPECT_EQ(test, 1, fake_fpga_mgr_get_rcfg_count(&mgr_ctx));
> +
> +	KUNIT_EXPECT_EQ(test, 1, fake_fpga_bridge_get_state(&base_bridge_ctx));
> +	KUNIT_EXPECT_EQ(test, 1, fake_fpga_bridge_get_cycles_count(&base_bridge_ctx));
> +
> +	/* The static image contains a reconfigurable sub-region with two soft bridges */
> +	ret = fake_fpga_bridge_register(&pr_bridge_0_ctx, test);
> +	KUNIT_ASSERT_EQ(test, ret, 0);
> +
> +	ret = fake_fpga_bridge_register(&pr_bridge_1_ctx, test);
> +	KUNIT_ASSERT_EQ(test, ret, 0);
> +
> +	ret = fake_fpga_region_register(&pr_region_ctx, mgr_ctx.mgr, test);
> +	KUNIT_ASSERT_EQ(test, ret, 0);
> +
> +	ret = fake_fpga_region_add_bridge(&pr_region_ctx, pr_bridge_0_ctx.bridge);
> +	KUNIT_ASSERT_EQ(test, ret, 0);
> +
> +	ret = fake_fpga_region_add_bridge(&pr_region_ctx, pr_bridge_1_ctx.bridge);
> +	KUNIT_ASSERT_EQ(test, ret, 0);
> +
> +	/* Allocate a fake partial test image using a buffer */
> +	test_pr_img_info = fpga_image_info_alloc(&mgr_ctx.pdev->dev);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, test_pr_img_info);
> +
> +	test_pr_img_info->buf = fake_bit;
> +	test_pr_img_info->count = sizeof(fake_bit) / 2;
> +	test_pr_img_info->flags = FPGA_MGR_PARTIAL_RECONFIG;
> +
> +	kunit_info(test, "fake partial bitstream size: %zu\n", test_pr_img_info->count);
> +
> +	/* Program the reconfigurable sub-region */
> +	pr_region_ctx.region->info = test_pr_img_info;
> +	ret = fpga_region_program_fpga(pr_region_ctx.region);
> +	KUNIT_ASSERT_EQ(test, ret, 0);
> +
> +	fake_fpga_mgr_check_write_buf(&mgr_ctx);
> +
> +	KUNIT_EXPECT_EQ(test, 2, fake_fpga_mgr_get_rcfg_count(&mgr_ctx));
> +
> +	KUNIT_EXPECT_EQ(test, 1, fake_fpga_bridge_get_state(&pr_bridge_0_ctx));
> +	KUNIT_EXPECT_EQ(test, 1, fake_fpga_bridge_get_cycles_count(&pr_bridge_0_ctx));
> +
> +	KUNIT_EXPECT_EQ(test, 1, fake_fpga_bridge_get_state(&pr_bridge_1_ctx));
> +	KUNIT_EXPECT_EQ(test, 1, fake_fpga_bridge_get_cycles_count(&pr_bridge_1_ctx));
> +
> +	/* Check that the base bridge has not been disabled */
> +	KUNIT_EXPECT_EQ(test, 1, fake_fpga_bridge_get_state(&base_bridge_ctx));
> +	KUNIT_EXPECT_EQ(test, 1, fake_fpga_bridge_get_cycles_count(&base_bridge_ctx));
> +
> +	fpga_image_info_free(test_pr_img_info);
> +	fpga_image_info_free(test_static_img_info);
> +
> +	fake_fpga_region_unregister(&pr_region_ctx);
> +	fake_fpga_bridge_unregister(&pr_bridge_0_ctx);
> +	fake_fpga_bridge_unregister(&pr_bridge_1_ctx);
> +
> +	fpga_free_base_sys(&mgr_ctx, &base_bridge_ctx, &base_region_ctx);
> +}
> +
> +static struct kunit_case fpga_test_cases[] = {
> +	KUNIT_CASE(fpga_base_test),
> +	KUNIT_CASE(fpga_pr_test),
> +	{},
> +};
> +
> +static struct kunit_suite fpga_test_suite = {
> +	.name = "fpga-tests",
> +	.suite_init = fpga_suite_init,
> +	.test_cases = fpga_test_cases,
> +};
> +
> +kunit_test_suite(fpga_test_suite);

