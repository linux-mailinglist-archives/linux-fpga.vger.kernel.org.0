Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2A8068CBB5
	for <lists+linux-fpga@lfdr.de>; Tue,  7 Feb 2023 02:07:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbjBGBFu (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 6 Feb 2023 20:05:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjBGBFu (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 6 Feb 2023 20:05:50 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 528063A88;
        Mon,  6 Feb 2023 17:05:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675731948; x=1707267948;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4o14gOXXs7BHIUVPnpetWq4XMB8BYF5O95xEKSoP0vM=;
  b=LgxBw6urYtFHYhgCwdVVqPWpEwHXr16WuPxxexCtvmEBms4zFZiW4ZUJ
   lvXwO2b02HSOkNd5FXSMNSDd3fH7MZONVBV2wK5KHjSkpNO1Ov4WJXF8q
   7XJPGloMfO0CpKP1HntS66+au+K9ztAwwml+r0fWNSyhF7AmvNiB30XQ/
   /stQJL3vj3x4zAnGw9hzcnaVqfecS705D/cMmEcqP+5colFFWF73lRRJM
   uiBPoFd/FQK6X85eDtrMqeqrdT8uELcRxqZbycGlK4A8DlHJ8+8Vb40YC
   RgocjEcfk+GQnhNxBUVKt2xUWK8XPHuPz2JDWEvH8mmB/h+ufKwZtClCw
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="330656085"
X-IronPort-AV: E=Sophos;i="5.97,278,1669104000"; 
   d="scan'208";a="330656085"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 17:05:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="616619904"
X-IronPort-AV: E=Sophos;i="5.97,278,1669104000"; 
   d="scan'208";a="616619904"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga003.jf.intel.com with ESMTP; 06 Feb 2023 17:05:47 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 6 Feb 2023 17:05:47 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 6 Feb 2023 17:05:47 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.176)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 6 Feb 2023 17:05:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cgnqu5eFcybah/nem9EKhTbEOptoEKvESGJ6JilebO6Xrrdtv9Bt3o/TFDXubkQaK25VOWE/YGiNgJjg8iWwLj/r7cYXNh6VRLMTaozr4NKV7o2X0vzawFWqjozTY6MEJ3y3uQQTCzbtxmK0x3nK1EII8biEcgivOmg0De5LVf/x9/2gDIUbPOuHKVhuXCXr+4ZBEU2YhjDj9G0gSFNk9iWKQ1ZvFuAniMh8kY9r7YPPtOtuliZFh5R60uwNLMDAY4j6I55900ZzIvXamnJkoLaStfKB57lkZTYrYxBTKFSgdft/ttiw8Q9aZoMA6jTyAJDK/JylxJQEhXWMggqJZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6MO1H+xo3UnIdtbJj4oDYWbWguuvxlLrrsiVE/ktZNs=;
 b=T0iezFdMqGcqGaHQDrIIlN4CJFzSUputnidkhWEr1tPbtzCGqyPQK/ToX/SNad+42BCDn1WlY+unjgndNpd+LL9QNDBD2ZPXy+PkPcJshwecpoC6r964CJgbK4lNZbTlADVtk/1t8XC6dvuktfFzBtchC1hO+yX295qxxfMQE2TPM8H493Jklt4EukzaemCH+ZrmakKeRm6xfe9Y9QFNjjEGrVIRomM24J/OJ5GltYO109CdZBLCmRRjgIRfvGdQ3fYW8BO+TWEqc+42oJTQoGvYJoRemy77Q43y40lvXr6iVVYI0YKWYd69/CcLB4MdviqBpbBkyxYcXrYUQYhDSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM5PR11MB1899.namprd11.prod.outlook.com (2603:10b6:3:10b::14)
 by DM4PR11MB7757.namprd11.prod.outlook.com (2603:10b6:8:103::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.32; Tue, 7 Feb
 2023 01:05:44 +0000
Received: from DM5PR11MB1899.namprd11.prod.outlook.com
 ([fe80::d151:74c0:20d6:d5fc]) by DM5PR11MB1899.namprd11.prod.outlook.com
 ([fe80::d151:74c0:20d6:d5fc%6]) with mapi id 15.20.6064.034; Tue, 7 Feb 2023
 01:05:44 +0000
Message-ID: <0491c635-1c0f-01a9-6449-0970f7c0c52f@intel.com>
Date:   Mon, 6 Feb 2023 17:05:32 -0800
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
X-ClientProxiedBy: MW2PR2101CA0020.namprd21.prod.outlook.com
 (2603:10b6:302:1::33) To DM5PR11MB1899.namprd11.prod.outlook.com
 (2603:10b6:3:10b::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR11MB1899:EE_|DM4PR11MB7757:EE_
X-MS-Office365-Filtering-Correlation-Id: b2a9888d-60b8-42af-0553-08db08a77029
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wi47D1QRBv3eg48Wl+TpNDrkYLY/t7VtHa09FIG6O+yZM+e4jMoE0plYu1s/GNqwlep6ZNmSPl0bPbHfU9WgkRani5H11VD8TI0F+HsYPihA8/PXDftp5yO8q9cAdUwrPg+A4PSfSxlqyFWA7xgAd6qZrOyr12MXfLvJxYF/RSuCuNFIsDkkzcevl+18VN5nfwOr4TWN2bG8TzHPCcFXptHb8f4M5CB8MYx9eWVKJv7KzdnFOSLcBvhSpOWjD1ayWX0fm9XBC6/XqXD1viwzlgzPqEuByORbdsYRa/oVDxza5xG87SuIXB/QzJDKswlNPHiSpi2YjePBMlgpU2DXDv/iIMLliT6DvK6zawcbfGRXKQ0/n/m3lWldeCs57adWLiQatmtLfCk82jHomoPf25SyRvGEnSTlO226AytHyKq8GVOJjNNPsfbcFaZeD5C3w605cfX1/KY4ifq4wVhPRCRxF0QgFZDlXXKR/CrGdfWEZ9WjlNzHOEk52y0U8nKwBfoml1EoyDZtdxHmCwaJ0R/ui/C32P5prp+9usM6D206Rt++kgkaitPiTcNiLC/8fGM9eHDrEptBU9EiVBkWNePhE1tyhvqsCO+5p+Gop1iCN20L2WJY8coL1Vo/DKjB1Ee1NEV1ILj2yx7QaOUnR6o0aYLd5OfbW0FmmmKL48++l232rwIH1ZeeVpJbo9/je6AWr0dwF7DrSbj6DLXk6CS+ThZEJxSdhHeId0AmuTY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR11MB1899.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(376002)(39860400002)(136003)(396003)(346002)(451199018)(6506007)(53546011)(478600001)(6486002)(110136005)(6512007)(186003)(26005)(66946007)(66476007)(4326008)(66556008)(31696002)(8676002)(316002)(31686004)(6666004)(2616005)(41300700001)(86362001)(5660300002)(8936002)(83380400001)(30864003)(2906002)(36756003)(82960400001)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dzJvSXRFUUUwT3hvRUJacy9zZ1JlT096OGFoYVZrWDBZejQzT3JTSFdyS1Rk?=
 =?utf-8?B?TEhUZWlLR3lTMEE5QWdtZ3huNVhoV0VrZE1FNi9vNnlZQ2hESlMzcngyMnJi?=
 =?utf-8?B?ZjNnc0VkYUp0ankzTnJhb0k2emJMV1A1blB1d2lnZFRCcjVrbEhwZXhyUGx0?=
 =?utf-8?B?TVVaUE45eDduZklFWUZCYVd6eVBJc1RCaE9TZ3dxZlV6TE1ialBuNVkwOTFC?=
 =?utf-8?B?SGdJNk5GWkRGcG5YaFJhazYzOXkvM1UvQjUxY1JqS29HUGxvZnZ2SnhiSk5s?=
 =?utf-8?B?eTF3czc5R215WmxsaGM3UHVKTktHUi9yZnRVZEtUZ0hGZnhWN3djSzE0ZHNY?=
 =?utf-8?B?cGNzeWF5cUw3VmFEaThxdzdqR3ZQdlpTUGRvS01TVGtPTDZOSjFMaXpyU2lv?=
 =?utf-8?B?NzhPZWZBNTNPdXRabnlsNnhDeitzU2VyUW5MdFFuTUJPUHd4VkdUYnFlZzcy?=
 =?utf-8?B?aVpsM3I4RzBmOTBoNGV6R2d5YnFBR01FbVB1a2lGTzYvUll5MFN3cUpLZjBu?=
 =?utf-8?B?NzlVWktSNzZKa2FNTncvejMvODNYcVRaNXpIdGx6YmxPSlFOc0VseUhHaWM4?=
 =?utf-8?B?NlJnaWZteUdITFBaaXUvemQydzNiL2Voazg3VlpoZlV0cmFSU1FhWGhPUUEr?=
 =?utf-8?B?M3RPRHBDcTVLUVNTOGRKdVEzUXhua2ZGc1Uxb1VYT2VWekU0aFEwMi9LWVBt?=
 =?utf-8?B?SWVnYTdKK0s4L3Z4UzJQSGlDak0vVkxaeUZMQVRIQVloVnZ0TjluNEpYZjcv?=
 =?utf-8?B?MjhwWDNLTUMyNDA1dDBHUG5DWmlkdml4bk1xT1NvbVcvaGRPZUd6TFBLQUts?=
 =?utf-8?B?RHBBck01cFpNd0xja1dWSlE0cGxtcTJmL1Zod284MVhnNGlmQkVVQ0VLZXo2?=
 =?utf-8?B?YzdvbDk2aW5QdVZNZjI1cWtVRWllK3FrRklRd2FhaUdIRkVxb09pMDI5ckVP?=
 =?utf-8?B?emxiVVpZVFlxcmJWS2xwd2puOFlFZ1E2dzNBaUEvQjlYdG5PclhPOG93aVVa?=
 =?utf-8?B?bXRhUndkM3RaNENSajRVQ1prdEFpb1NUQWQ2YXZ6NmtnbTg1RTdXS2k2MmNP?=
 =?utf-8?B?L2llZGQ2RGthT3dlZDliazVNSzVXTnhPOWwzbnJKV1ozcXFmdE1ZL3FGSncy?=
 =?utf-8?B?SXNkY3FSOTczcElUNUlrdGxDNUFBTHVRN25DaFptWFJUSkRPZVdUSUlHUVlH?=
 =?utf-8?B?V2xlQzladTZSU1FycDZjVldBSWQrRnlEcFJ4UkRIRndBV2V2bEsrVTIyYU9E?=
 =?utf-8?B?c3ZvN29TcTdoZE14TkZOOWtkdjNHbzJQMUhOVTJQUnFzWTd5cjRMU1p4VkpN?=
 =?utf-8?B?MlZvWHNkN1pZZ2xCZHhZTjM5TitkL2IwWlNRRFhpREJrZGZRN0lYR1R3SVFK?=
 =?utf-8?B?TjBreFNnSTR6c0E0RThJNmZNbjh3dU90MGcrWUxmYURVTUd3NFVyQ3lBUDIr?=
 =?utf-8?B?VVY1S0VxeVFIeXkxcE9uUTJHQUpjWDVZT2k5S1dKYzJZT3VXNXVFS0FJK3dZ?=
 =?utf-8?B?TmVSZlRyUm5oTVJUWGVpNEVOYllabmlRR3dEZjdZT2ZFdDdOU0s3aHpxejRL?=
 =?utf-8?B?akpKTU9WQmp1aU85OFBVamhianQzMUpCWjV4YVFNMXgxRFdFanhYY3ZNWmNo?=
 =?utf-8?B?UWdyVFgvYUh2TTVXTjRNd3lZRFBnNituSnRhbVREc1VCKzdhTVFYazBHWFBs?=
 =?utf-8?B?L2NuT1BaTWo0OSs3WWxJTTRYaFJMR2p0UVFLZFdRK2RBaUVtOUhyWlMvTW0y?=
 =?utf-8?B?bVNNVjJLanZ0cmRkakx1NnN6K0c1cm9EczUzbFNMUGZOZmdYbXdZbDdxUzBH?=
 =?utf-8?B?d3BtQlZ4VnB4TnJXUlFEVmRQRXZkVHJ5bXdGWjZnUnlmYTE4NVdMNnBpMGRJ?=
 =?utf-8?B?TTMyMUN2TDcwQndpK1BDUGd5ZmVCbDN6U1RwQVhmUFltblArL0Y1eGNkLzV0?=
 =?utf-8?B?MjM1WXU0L2w1R0VRT2h4TGwvNjRkWmlZZ0dZcWlVczBFdUR6L1Q5dGk2MWxU?=
 =?utf-8?B?L0xBZmV2ckZpWmYyTjVHUWtSWjk4VFMzQStKZmxBYUxRU1M1bUNHWjVGd3Zy?=
 =?utf-8?B?UWJPeEhFeUswVExKc2NQcDJZeC9YQkJCazNqMlFSekNKY2k4Q0ZaSFJxaUlz?=
 =?utf-8?B?RjhYOWxpU200U3BMelNnV29vdzM1cVVxYmE2OUdKNUVGdFJrSzNqaExOc2Fr?=
 =?utf-8?B?THc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b2a9888d-60b8-42af-0553-08db08a77029
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1899.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2023 01:05:44.0010
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OXRAXCqgD3Ima9xIbAIuFS2WvrvPsv15TkxDD4EfXJtE66qKiFbUrVv+SvYlFR/x5rZUS8QVFcxtyIpfEuiD47oMgzJlLrRcxDcipl15n/E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7757
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Marco,

I've just started looking at this, but I have a couple of early comments below

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
These lines seem shorter than necessary. You can use up to 75
characters per line.

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

When I try to build with these patches, I get this error:
>
> ERROR: modpost: missing MODULE_LICENSE() in drivers/fpga/tests/fpga-tests.o

I was able to fix it by adding this line at the bottom of the file:

> MODULE_LICENSE("GPL");

- Russ
