Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A20640B510
	for <lists+linux-fpga@lfdr.de>; Tue, 14 Sep 2021 18:40:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229448AbhINQlV (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 14 Sep 2021 12:41:21 -0400
Received: from mga06.intel.com ([134.134.136.31]:43039 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229379AbhINQlV (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 14 Sep 2021 12:41:21 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10107"; a="283060468"
X-IronPort-AV: E=Sophos;i="5.85,292,1624345200"; 
   d="scan'208";a="283060468"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2021 09:39:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,292,1624345200"; 
   d="scan'208";a="552589447"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga002.fm.intel.com with ESMTP; 14 Sep 2021 09:39:11 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Tue, 14 Sep 2021 09:39:11 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Tue, 14 Sep 2021 09:39:10 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Tue, 14 Sep 2021 09:39:10 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Tue, 14 Sep 2021 09:39:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c37rb+psqr0wztz5qZGVAUTS90FF1ASAJFi5CHH2eskSJQUHS3vt1seFv62WaNtpgZ2n3XOVufuOjp8k0aHr+N2RJOz3bY0ESK9fld+hOIywjTJGTI4bv9IJmy8V9W0fUDlBlowmkzqEO++iXTVnX9nmkFr6OKbr9B5d3NMK8AmeVkQRePCp3bAWpmkpjiyQOPRnTK3nDINBUGrINL6jVUslNGlrcfXcK7E4Bxyipi8kFczvc+kWbnN/QhOYdB+52nIlgoDNEW96qmY2YaUUrzBne+/IYcTKy3CP3h1XleUbt68RZWLxgdHbU9ChCix5E9wrcys50SFZeaiy+wBe2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=UCCtQKwrhBGpH7ZQUGhe/mUozmJI0sevFl8e5WySmE4=;
 b=GZDceoYNnjvffxUWNk8QTY93RUwcNp+tucfngPOj89ygV9ru/JnmEbw/HrVDWyltS7TcF7DgoIydbYQtFdTNZwji73BR+2eSK25a2Q39D1OgDLZkgN6liDqAfxdL6+OhNe4V2CgYokmi5al211MmQ1rKGcMl/KkfZPAGHXVKkMdDlux6gwq0YLifLRwfuDf3Bm+kEsRbVS86woyE2dY0qZ/t67a+5VtHmG8aWc1M5BDCsbG3XMKTOwdrScVUetJ7kbX0u875/BeKVNFH5VO8ZOBv95M3X/HZwpAyOa+z8I2YV+Ra6vZfAjQfJFVS0xzhPwb3xjZNipGYGyW4f8N57w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UCCtQKwrhBGpH7ZQUGhe/mUozmJI0sevFl8e5WySmE4=;
 b=X0iharb+u5BCBTjCpy9gYXMqeeQEh0qP5MTgoHRIgOiBIIn/1duNgcYmAdy3Rp/6Hm0jc8qrlkNvAeMwdf+cBnSbcg/mXERehkzepW69ENrWS15Ui3hYqwoEvDYlE2zZ3GhHiuwqnV42ZNqam7ZGomaCQh4lsza7MOWagvKvGMY=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
Received: from SA2PR11MB5163.namprd11.prod.outlook.com (2603:10b6:806:113::20)
 by SN6PR11MB2766.namprd11.prod.outlook.com (2603:10b6:805:53::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Tue, 14 Sep
 2021 16:39:07 +0000
Received: from SA2PR11MB5163.namprd11.prod.outlook.com
 ([fe80::90de:46c1:4d23:5c8c]) by SA2PR11MB5163.namprd11.prod.outlook.com
 ([fe80::90de:46c1:4d23:5c8c%6]) with mapi id 15.20.4500.019; Tue, 14 Sep 2021
 16:39:07 +0000
Subject: Re: [PATCH v11 1/3] fpga: mgr: Use standard dev_release for class
 driver
To:     <mdf@kernel.org>, <linux-fpga@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <trix@redhat.com>, <lgoncalv@redhat.com>, <yilun.xu@intel.com>,
        <hao.wu@intel.com>, <matthew.gerlach@intel.com>,
        <richard.gong@intel.com>
References: <20210913231232.65944-1-russell.h.weight@intel.com>
 <20210913231232.65944-2-russell.h.weight@intel.com>
From:   Russ Weight <russell.h.weight@intel.com>
Message-ID: <103f6c76-4478-84c2-481f-a3bcf152821e@intel.com>
Date:   Tue, 14 Sep 2021 09:39:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
In-Reply-To: <20210913231232.65944-2-russell.h.weight@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: MWHPR22CA0015.namprd22.prod.outlook.com
 (2603:10b6:300:ef::25) To SA2PR11MB5163.namprd11.prod.outlook.com
 (2603:10b6:806:113::20)
MIME-Version: 1.0
Received: from [10.0.2.4] (50.43.42.212) by MWHPR22CA0015.namprd22.prod.outlook.com (2603:10b6:300:ef::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend Transport; Tue, 14 Sep 2021 16:39:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4d845008-0b6e-47c6-6b43-08d9779e2b96
X-MS-TrafficTypeDiagnostic: SN6PR11MB2766:
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR11MB2766B5AC89A02F2E4AC9B864C5DA9@SN6PR11MB2766.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XKZ1Wrm8ibzYh4ZmqzMPfKlGQF2FH0X3nSeblIs0d/1Jmx8E3glSaseKx1t6Xj+O00be9h//y7kFkzVptdUX0qUGwUP4joNVqepECwsuB9enYVSJHTGmaL/U3IJhCEdv2PYrFlTnhm8nG/w0Fl6/OgvZCGq7lGdMyxQcQs+Q5th6bZ/pXDkP7GtG9r/JvGwWlhDTOa2ZusMwH9lsXbPZJTw2BN804EOFvFSAdFCYCysu4SNOVQnmhSV4byHTJZQmqutIDJAJtFJm+F45mOwmf8sdZP9NJ86UIumqeKbtI3trWKMqaUJp83q80UcY/giALVx5ncGZC2TeLB9Ccn8K14lxj58YJ523oTto5Nk47ACvp+E3vtUi8NfLd68qye5YN/M4aNbInxtQEpte6dMHAsAPVdR2VVjj0aIaO5oxQJsxmAgBdQzjdLk/ejvjmad/y4xvVVIk5AkK7iGxWjgTRteVgSx2lqcCkdaSAhWXcymj2D5iZSzIKoOGpZe3+pATwaG7xpyzwGjxEDPkOLX6vWgUayQXr6PFwXn87frf3RVzwZqGO1OJ6sLOVAyFxChOLl4wFgFso3i0rgs4K75y+naGAGucM+VuifChPy8+QQrOhJtMtMfbKXQrntaPQpQbr9gkUn0DJrKfDO0I94rduTsb5EETWllI9ZmgehCDZSBBxe4tfUIo2ZEbz3jxCFJdkD278fb1DWFKUI1Vp8XCot/x4ZoDoUw5zhPdfoS1RYo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB5163.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(31686004)(8676002)(6486002)(107886003)(956004)(26005)(36756003)(83380400001)(8936002)(2616005)(66556008)(66476007)(66946007)(16576012)(31696002)(86362001)(5660300002)(508600001)(30864003)(316002)(6666004)(53546011)(38100700002)(186003)(4326008)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U1lzbFJoYVAwbE9UcTkraEQvdlBjNUI3ZmM1LzRkcWxaVkpYZ2piYXk0N2JD?=
 =?utf-8?B?L2tUUG5UZFlSYVd3SStkU1VDdmFHWGRrYk1wNGhEWG5IdHptV29heEQ0b2ln?=
 =?utf-8?B?Tmt5bitLMW1DeEMxRkl1aGhiS1l1ZDJjdnpWN01FTklnRm81MFh3VGxrMEc0?=
 =?utf-8?B?bldSZG1mQkRFQ2FTRlE5OC96S25kZmJtWUpldG4xZGRCZXBVZXVVeG43T1VT?=
 =?utf-8?B?d2l6TGc2c2pYcXFGMUtPUk5VUyt2QXdlSm9RcVEyWGw2blFxRUdxaTZFeGk3?=
 =?utf-8?B?dmVSZWRRZXlmRDBBci8yRUFXQXlxaDVsZkNKR3ZJYmRpcnYwNUxKRHdUaStk?=
 =?utf-8?B?allSL2tKU2lDVTA3UkRhRFRMdE5xR1RxaEp6L1BKRTR4UmFndk40MThoUllX?=
 =?utf-8?B?WXFSUWVxNldFbE5OVi9Wd2V4YTN5VHBHVVI2YkJpVnY5bnN6TjJ2NkFvS1Fm?=
 =?utf-8?B?bGRzM2lOaUZvdGZTVkJ2SmxtWHIvbG9Hdld5RDgzWTBOaFowUkFCNGJjUm1m?=
 =?utf-8?B?RHZNdThVekJCNEVkRDNrdTBVYlRGcit4WHp0Kzl3aWZLd25tYUlKWEZUeDNr?=
 =?utf-8?B?T3JrWnk0WUpNdExIck4xYmtjdDVEcG94Rml0QjVpMUh1cWJHL1M5eVZqZDlZ?=
 =?utf-8?B?dlcxSS9yR0d0S3ViaFBIMUV3RlBaeW1PZDF1QUkwdnZDakZMeDd1U2xWd01y?=
 =?utf-8?B?WHZwZTZzaFdtUDJGLzROUzNlSkFsbEVSMGIyZm9VZEFTMGJCTDlIRm43QVZS?=
 =?utf-8?B?SFo1czdUUjByRHQyNU9FMlI0TmJDdWs4Mkt1a045eUpiaDlYYTFlV2dGbTZG?=
 =?utf-8?B?cGZjWnFraWVTaFdhZGx5Q2lpZUZJS05vYlllTjVaR3BDeFltYzVoUHNLcmJO?=
 =?utf-8?B?WDVHL0hxaFNJcWpJSktZY053S3RaWkN3R1pVUEZac1NiRFpSY3RGVmMvaGlv?=
 =?utf-8?B?ZWhWK2pRLy9JeVFNUEovRS9EeFNCeFRicFlydTNNa3NjMktWUkdVYjVsYngy?=
 =?utf-8?B?RHZHVThrNDREdEVpN1JZTXpPSGpYKzFMZTQrTVV3UmNWTEtJd2R5YUZtbllI?=
 =?utf-8?B?QTJPNmFsSHQ4NHppRDcvVXdvVWtHd1F1UG5US1lra0c0RzRMR25rUFo2eElU?=
 =?utf-8?B?MHJUUnpUbC9aVE9NSTJRdWFXWWh2eFZkYUxHOVVJWTdvRkxCekd2MjJiVThJ?=
 =?utf-8?B?dEMySUsyL0FtVmRpRGRoUkdzTFpLWkpCWGJvdWNVVjBvekJXZjdQNk1NZWor?=
 =?utf-8?B?by9qc2diWHorL1dEVkp6M2RkNlMvNGxzN092NllUWHJCNHl5V3RMdS9jZEZq?=
 =?utf-8?B?OFRMN3NoRFlTRldoMS92Vm1QTFJXUndkUUdmQ09PbXMwYzl4RG9ZS0ZjdkVz?=
 =?utf-8?B?a2JQaVhHR09qKzNacWoxdFdVRUVQRmtuOEFhUXl1Vnhjdk96WW9DWWVIVTlX?=
 =?utf-8?B?dEMxZGpaYlhpc2Y0TWZXaFRtMGtzdWh0RVhLRWFva2ZLUHBzTXBMN2tqYm43?=
 =?utf-8?B?MlVCUWt0dDJmTzBDUUNlQVo1YnhtYjVVdnBVRnhlbUNOTDBHTlp0WkVTbzRj?=
 =?utf-8?B?VHJWV1MrMGVVdEE0cVI1WFRZMEZXbnRmanpSQTRaZlJyWkQ0bXdqaXN3c2l1?=
 =?utf-8?B?eUt0Z2NuSHF4Q3ova242NzVGajNlM0xvV0R0SERKTU5HaTJra1FBMnA0aW1t?=
 =?utf-8?B?dTJuRkRxdU80OUVpbE9NTU9zZm1hZlRHSVZPQVJEdnVZUks5Z05VQStFV3hH?=
 =?utf-8?Q?AlyEKkjjxNYdzs/4nRRp+972IxAhNL50eBk1kk6?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d845008-0b6e-47c6-6b43-08d9779e2b96
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB5163.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2021 16:39:07.1513
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v6Z1vUpy4XrleVwoFTOs6Vjbe0wV1/6jfkDncMr3Bhn4T7SKCrjMffotYLJYQN8VHGSLdyYv6N/wUTFeXBJXJilXNEqf4GdC5fKrwIJH1R4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2766
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

I need to resubmit with support for the new Xilinx Versal Driver which
uses this class driver.

This oversight was reported bykernel test robot <lkp@intel.com>

- Russ

On 9/13/21 4:12 PM, Russ Weight wrote:
> The FPGA manager class driver data structure is being treated as a
> managed resource instead of using the standard dev_release call-back
> function to release the class data structure. This change removes
> the managed resource code for the freeing of the class data structure
> and combines the create() and register() functions into a single
> register() or register_full() function.
>
> The register_full() function accepts an info data structure to provide
> flexibility in passing optional parameters. The register() function
> supports the current parameter list for users that don't require the
> use of optional parameters.
>
> The devm_fpga_mgr_register() function is retained, and the
> devm_fpga_mgr_register_full() function is added.
>
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> Reviewed-by: Xu Yilun <yilun.xu@intel.com>
> ---
> v11:
>   - Rebased to latest linux-next
>   - Resolved a single conflict with associated with  wrapper function:
>     fpga_mgr_state(mgr)
> v10:
>   - Fixed commit message to reference register_full() instead of
>     register_simple().
>   - Updated documentation to reference the fpga_manager_info structure
> v9:
>   - Cleaned up documentation for the FPGA Manager register functions
>   - Renamed fpga_mgr_register() to fpga_mgr_register_full()
>   - Renamed fpga_mgr_register_simple() to fpga_mgr_register()
>   - Renamed devm_fpga_mgr_register() to devm_fpga_mgr_register_full()
>   - Renamed devm_fpga_mgr_register_simple() to devm_fpga_mgr_register()
> v8:
>   - Added reviewed-by tag.
>   - Updated Documentation/driver-api/fpga/fpga-mgr.rst documentation.
> v7:
>   - Update the commit message to describe the new parameters for the
>     *fpga_mgr_register() functions and to mention the
>     *fpga_mgr_register_simple() functions.
>   - Fix function prototypes in header file to rename dev to parent.
>   - Make use of the PTR_ERR_OR_ZERO() macro when possible.
>   - Some cleanup of comments.
>   - Update function definitions/prototypes to apply const to the new info
>     parameter.
> v6:
>   - Moved FPGA manager optional parameters out of the ops structure and
>     back into the FPGA manager structure.
>   - Changed fpga_mgr_register()/devm_fpga_mgr_register() parameters to
>     accept an info data structure to provide flexibility in passing optional
>     parameters.
>   - Added fpga_mgr_register_simple()/devm_fpga_mgr_register_simple()
>     functions to support current parameters for users that don't require
>     the use of optional parameters.
> v5:
>   - Rebased on top of recently accepted patches.
>   - Removed compat_id from the fpga_mgr_register() parameter list
>     and added it to the fpga_manager_ops structure. This also required
>     dynamically allocating the dfl-fme-ops structure in order to add
>     the appropriate compat_id.
> v4:
>   - Added the compat_id parameter to fpga_mgr_register() and
>     devm_fpga_mgr_register() to ensure that the compat_id is set before
>     the device_register() call.
> v3:
>   - Cleaned up comment header for fpga_mgr_register()
>   - Fix error return on ida_simple_get() failure
> v2:
>   - Restored devm_fpga_mgr_register() functionality, adapted for the combined
>     create/register functionality.
>   - All previous callers of devm_fpga_mgr_register() will continue to call
>     devm_fpga_mgr_register().
>   - replaced unnecessary ternary operators in return statements with standard
>     if conditions.
> ---
>  Documentation/driver-api/fpga/fpga-mgr.rst |  38 +++-
>  drivers/fpga/altera-cvp.c                  |  12 +-
>  drivers/fpga/altera-pr-ip-core.c           |   7 +-
>  drivers/fpga/altera-ps-spi.c               |   9 +-
>  drivers/fpga/dfl-fme-mgr.c                 |  22 +--
>  drivers/fpga/fpga-mgr.c                    | 215 +++++++++------------
>  drivers/fpga/ice40-spi.c                   |   9 +-
>  drivers/fpga/machxo2-spi.c                 |   9 +-
>  drivers/fpga/socfpga-a10.c                 |  16 +-
>  drivers/fpga/socfpga.c                     |   9 +-
>  drivers/fpga/stratix10-soc.c               |  16 +-
>  drivers/fpga/ts73xx-fpga.c                 |   9 +-
>  drivers/fpga/xilinx-spi.c                  |  11 +-
>  drivers/fpga/zynq-fpga.c                   |  16 +-
>  drivers/fpga/zynqmp-fpga.c                 |   9 +-
>  include/linux/fpga/fpga-mgr.h              |  62 ++++--
>  16 files changed, 214 insertions(+), 255 deletions(-)
>
> diff --git a/Documentation/driver-api/fpga/fpga-mgr.rst b/Documentation/driver-api/fpga/fpga-mgr.rst
> index 4d926b452cb3..42c01f396dce 100644
> --- a/Documentation/driver-api/fpga/fpga-mgr.rst
> +++ b/Documentation/driver-api/fpga/fpga-mgr.rst
> @@ -24,7 +24,7 @@ How to support a new FPGA device
>  --------------------------------
>  
>  To add another FPGA manager, write a driver that implements a set of ops.  The
> -probe function calls fpga_mgr_register(), such as::
> +probe function calls fpga_mgr_register() or fpga_mgr_register_full(), such as::
>  
>  	static const struct fpga_manager_ops socfpga_fpga_ops = {
>  		.write_init = socfpga_fpga_ops_configure_init,
> @@ -49,14 +49,14 @@ probe function calls fpga_mgr_register(), such as::
>  		 * them in priv
>  		 */
>  
> -		mgr = devm_fpga_mgr_create(dev, "Altera SOCFPGA FPGA Manager",
> -					   &socfpga_fpga_ops, priv);
> -		if (!mgr)
> -			return -ENOMEM;
> +		mgr = fpga_mgr_register(dev, "Altera SOCFPGA FPGA Manager",
> +					&socfpga_fpga_ops, priv);
> +		if (IS_ERR(mgr))
> +			return PTR_ERR(mgr);
>  
>  		platform_set_drvdata(pdev, mgr);
>  
> -		return fpga_mgr_register(mgr);
> +		return 0;
>  	}
>  
>  	static int socfpga_fpga_remove(struct platform_device *pdev)
> @@ -68,6 +68,11 @@ probe function calls fpga_mgr_register(), such as::
>  		return 0;
>  	}
>  
> +Alternatively, the probe function could call one of the resource managed
> +register functions, devm_fpga_mgr_register() or devm_fpga_mgr_register_full().
> +When these functions are used, the parameter syntax is the same, but the call
> +to fpga_mgr_unregister() should be removed. In the above example, the
> +socfpga_fpga_remove() function would not be required.
>  
>  The ops will implement whatever device specific register writes are needed to
>  do the programming sequence for this particular FPGA.  These ops return 0 for
> @@ -104,8 +109,14 @@ API for implementing a new FPGA Manager driver
>  * ``fpga_mgr_states`` -  Values for :c:expr:`fpga_manager->state`.
>  * struct fpga_manager -  the FPGA manager struct
>  * struct fpga_manager_ops -  Low level FPGA manager driver ops
> -* devm_fpga_mgr_create() -  Allocate and init a manager struct
> -* fpga_mgr_register() -  Register an FPGA manager
> +* struct fpga_manager_info -  Parameter structure for fpga_mgr_register_full()
> +* fpga_mgr_register_full() -  Create and register an FPGA manager using the
> +  fpga_mgr_info structure to provide the full flexibility of options
> +* fpga_mgr_register() -  Create and register an FPGA manager using standard
> +  arguments
> +* devm_fpga_mgr_register_full() -  Resource managed version of
> +  fpga_mgr_register_full()
> +* devm_fpga_mgr_register() -  Resource managed version of fpga_mgr_register()
>  * fpga_mgr_unregister() -  Unregister an FPGA manager
>  
>  .. kernel-doc:: include/linux/fpga/fpga-mgr.h
> @@ -117,11 +128,20 @@ API for implementing a new FPGA Manager driver
>  .. kernel-doc:: include/linux/fpga/fpga-mgr.h
>     :functions: fpga_manager_ops
>  
> +.. kernel-doc:: include/linux/fpga/fpga-mgr.h
> +   :functions: fpga_manager_info
> +
>  .. kernel-doc:: drivers/fpga/fpga-mgr.c
> -   :functions: devm_fpga_mgr_create
> +   :functions: fpga_mgr_register_full
>  
>  .. kernel-doc:: drivers/fpga/fpga-mgr.c
>     :functions: fpga_mgr_register
>  
> +.. kernel-doc:: drivers/fpga/fpga-mgr.c
> +   :functions: devm_fpga_mgr_register_full
> +
> +.. kernel-doc:: drivers/fpga/fpga-mgr.c
> +   :functions: devm_fpga_mgr_register
> +
>  .. kernel-doc:: drivers/fpga/fpga-mgr.c
>     :functions: fpga_mgr_unregister
> diff --git a/drivers/fpga/altera-cvp.c b/drivers/fpga/altera-cvp.c
> index ccf4546eff29..4ffb9da537d8 100644
> --- a/drivers/fpga/altera-cvp.c
> +++ b/drivers/fpga/altera-cvp.c
> @@ -652,19 +652,15 @@ static int altera_cvp_probe(struct pci_dev *pdev,
>  	snprintf(conf->mgr_name, sizeof(conf->mgr_name), "%s @%s",
>  		 ALTERA_CVP_MGR_NAME, pci_name(pdev));
>  
> -	mgr = devm_fpga_mgr_create(&pdev->dev, conf->mgr_name,
> -				   &altera_cvp_ops, conf);
> -	if (!mgr) {
> -		ret = -ENOMEM;
> +	mgr = fpga_mgr_register(&pdev->dev, conf->mgr_name,
> +				&altera_cvp_ops, conf);
> +	if (IS_ERR(mgr)) {
> +		ret = PTR_ERR(mgr);
>  		goto err_unmap;
>  	}
>  
>  	pci_set_drvdata(pdev, mgr);
>  
> -	ret = fpga_mgr_register(mgr);
> -	if (ret)
> -		goto err_unmap;
> -
>  	return 0;
>  
>  err_unmap:
> diff --git a/drivers/fpga/altera-pr-ip-core.c b/drivers/fpga/altera-pr-ip-core.c
> index dfdf21ed34c4..be0667968d33 100644
> --- a/drivers/fpga/altera-pr-ip-core.c
> +++ b/drivers/fpga/altera-pr-ip-core.c
> @@ -191,11 +191,8 @@ int alt_pr_register(struct device *dev, void __iomem *reg_base)
>  		(val & ALT_PR_CSR_STATUS_MSK) >> ALT_PR_CSR_STATUS_SFT,
>  		(int)(val & ALT_PR_CSR_PR_START));
>  
> -	mgr = devm_fpga_mgr_create(dev, dev_name(dev), &alt_pr_ops, priv);
> -	if (!mgr)
> -		return -ENOMEM;
> -
> -	return devm_fpga_mgr_register(dev, mgr);
> +	mgr = devm_fpga_mgr_register(dev, dev_name(dev), &alt_pr_ops, priv);
> +	return PTR_ERR_OR_ZERO(mgr);
>  }
>  EXPORT_SYMBOL_GPL(alt_pr_register);
>  
> diff --git a/drivers/fpga/altera-ps-spi.c b/drivers/fpga/altera-ps-spi.c
> index 23bfd4d1ad0f..5e1e009dba89 100644
> --- a/drivers/fpga/altera-ps-spi.c
> +++ b/drivers/fpga/altera-ps-spi.c
> @@ -302,12 +302,9 @@ static int altera_ps_probe(struct spi_device *spi)
>  	snprintf(conf->mgr_name, sizeof(conf->mgr_name), "%s %s",
>  		 dev_driver_string(&spi->dev), dev_name(&spi->dev));
>  
> -	mgr = devm_fpga_mgr_create(&spi->dev, conf->mgr_name,
> -				   &altera_ps_ops, conf);
> -	if (!mgr)
> -		return -ENOMEM;
> -
> -	return devm_fpga_mgr_register(&spi->dev, mgr);
> +	mgr = devm_fpga_mgr_register(&spi->dev, conf->mgr_name,
> +				     &altera_ps_ops, conf);
> +	return PTR_ERR_OR_ZERO(mgr);
>  }
>  
>  static const struct spi_device_id altera_ps_spi_ids[] = {
> diff --git a/drivers/fpga/dfl-fme-mgr.c b/drivers/fpga/dfl-fme-mgr.c
> index 313420405d5e..af0785783b52 100644
> --- a/drivers/fpga/dfl-fme-mgr.c
> +++ b/drivers/fpga/dfl-fme-mgr.c
> @@ -276,7 +276,7 @@ static void fme_mgr_get_compat_id(void __iomem *fme_pr,
>  static int fme_mgr_probe(struct platform_device *pdev)
>  {
>  	struct dfl_fme_mgr_pdata *pdata = dev_get_platdata(&pdev->dev);
> -	struct fpga_compat_id *compat_id;
> +	struct fpga_manager_info info = { 0 };
>  	struct device *dev = &pdev->dev;
>  	struct fme_mgr_priv *priv;
>  	struct fpga_manager *mgr;
> @@ -296,20 +296,16 @@ static int fme_mgr_probe(struct platform_device *pdev)
>  			return PTR_ERR(priv->ioaddr);
>  	}
>  
> -	compat_id = devm_kzalloc(dev, sizeof(*compat_id), GFP_KERNEL);
> -	if (!compat_id)
> +	info.name = "DFL FME FPGA Manager";
> +	info.mops = &fme_mgr_ops;
> +	info.priv = priv;
> +	info.compat_id = devm_kzalloc(dev, sizeof(*info.compat_id), GFP_KERNEL);
> +	if (!info.compat_id)
>  		return -ENOMEM;
>  
> -	fme_mgr_get_compat_id(priv->ioaddr, compat_id);
> -
> -	mgr = devm_fpga_mgr_create(dev, "DFL FME FPGA Manager",
> -				   &fme_mgr_ops, priv);
> -	if (!mgr)
> -		return -ENOMEM;
> -
> -	mgr->compat_id = compat_id;
> -
> -	return devm_fpga_mgr_register(dev, mgr);
> +	fme_mgr_get_compat_id(priv->ioaddr, info.compat_id);
> +	mgr = devm_fpga_mgr_register_full(dev, &info);
> +	return PTR_ERR_OR_ZERO(mgr);
>  }
>  
>  static struct platform_driver fme_mgr_driver = {
> diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
> index aa30889e2320..d49a9ce34568 100644
> --- a/drivers/fpga/fpga-mgr.c
> +++ b/drivers/fpga/fpga-mgr.c
> @@ -592,49 +592,49 @@ void fpga_mgr_unlock(struct fpga_manager *mgr)
>  EXPORT_SYMBOL_GPL(fpga_mgr_unlock);
>  
>  /**
> - * fpga_mgr_create - create and initialize an FPGA manager struct
> + * fpga_mgr_register_full - create and register an FPGA Manager device
>   * @parent:	fpga manager device from pdev
> - * @name:	fpga manager name
> - * @mops:	pointer to structure of fpga manager ops
> - * @priv:	fpga manager private data
> + * @info:	parameters for fpga manager
>   *
> - * The caller of this function is responsible for freeing the struct with
> - * fpga_mgr_free().  Using devm_fpga_mgr_create() instead is recommended.
> + * The caller of this function is responsible for calling fpga_mgr_unregister().
> + * Using devm_fpga_mgr_register_full() instead is recommended.
>   *
> - * Return: pointer to struct fpga_manager or NULL
> + * Return: pointer to struct fpga_manager pointer or ERR_PTR()
>   */
> -struct fpga_manager *fpga_mgr_create(struct device *parent, const char *name,
> -				     const struct fpga_manager_ops *mops,
> -				     void *priv)
> +struct fpga_manager *
> +fpga_mgr_register_full(struct device *parent, const struct fpga_manager_info *info)
>  {
> +	const struct fpga_manager_ops *mops = info->mops;
>  	struct fpga_manager *mgr;
>  	int id, ret;
>  
>  	if (!mops) {
>  		dev_err(parent, "Attempt to register without fpga_manager_ops\n");
> -		return NULL;
> +		return ERR_PTR(-EINVAL);
>  	}
>  
> -	if (!name || !strlen(name)) {
> +	if (!info->name || !strlen(info->name)) {
>  		dev_err(parent, "Attempt to register with no name!\n");
> -		return NULL;
> +		return ERR_PTR(-EINVAL);
>  	}
>  
>  	mgr = kzalloc(sizeof(*mgr), GFP_KERNEL);
>  	if (!mgr)
> -		return NULL;
> +		return ERR_PTR(-ENOMEM);
>  
>  	id = ida_simple_get(&fpga_mgr_ida, 0, 0, GFP_KERNEL);
> -	if (id < 0)
> +	if (id < 0) {
> +		ret = id;
>  		goto error_kfree;
> +	}
>  
>  	mutex_init(&mgr->ref_mutex);
>  
> -	mgr->name = name;
> -	mgr->mops = mops;
> -	mgr->priv = priv;
> +	mgr->name = info->name;
> +	mgr->mops = info->mops;
> +	mgr->priv = info->priv;
> +	mgr->compat_id = info->compat_id;
>  
> -	device_initialize(&mgr->dev);
>  	mgr->dev.class = fpga_mgr_class;
>  	mgr->dev.groups = mops->groups;
>  	mgr->dev.parent = parent;
> @@ -645,6 +645,19 @@ struct fpga_manager *fpga_mgr_create(struct device *parent, const char *name,
>  	if (ret)
>  		goto error_device;
>  
> +	/*
> +	 * Initialize framework state by requesting low level driver read state
> +	 * from device.  FPGA may be in reset mode or may have been programmed
> +	 * by bootloader or EEPROM.
> +	 */
> +	mgr->state = fpga_mgr_state(mgr);
> +
> +	ret = device_register(&mgr->dev);
> +	if (ret) {
> +		put_device(&mgr->dev);
> +		return ERR_PTR(ret);
> +	}
> +
>  	return mgr;
>  
>  error_device:
> @@ -652,96 +665,36 @@ struct fpga_manager *fpga_mgr_create(struct device *parent, const char *name,
>  error_kfree:
>  	kfree(mgr);
>  
> -	return NULL;
> +	return ERR_PTR(ret);
>  }
> -EXPORT_SYMBOL_GPL(fpga_mgr_create);
> +EXPORT_SYMBOL_GPL(fpga_mgr_register_full);
>  
>  /**
> - * fpga_mgr_free - free an FPGA manager created with fpga_mgr_create()
> - * @mgr:	fpga manager struct
> - */
> -void fpga_mgr_free(struct fpga_manager *mgr)
> -{
> -	ida_simple_remove(&fpga_mgr_ida, mgr->dev.id);
> -	kfree(mgr);
> -}
> -EXPORT_SYMBOL_GPL(fpga_mgr_free);
> -
> -static void devm_fpga_mgr_release(struct device *dev, void *res)
> -{
> -	struct fpga_mgr_devres *dr = res;
> -
> -	fpga_mgr_free(dr->mgr);
> -}
> -
> -/**
> - * devm_fpga_mgr_create - create and initialize a managed FPGA manager struct
> + * fpga_mgr_register - create and register an FPGA Manager device
>   * @parent:	fpga manager device from pdev
>   * @name:	fpga manager name
>   * @mops:	pointer to structure of fpga manager ops
>   * @priv:	fpga manager private data
>   *
> - * This function is intended for use in an FPGA manager driver's probe function.
> - * After the manager driver creates the manager struct with
> - * devm_fpga_mgr_create(), it should register it with fpga_mgr_register().  The
> - * manager driver's remove function should call fpga_mgr_unregister().  The
> - * manager struct allocated with this function will be freed automatically on
> - * driver detach.  This includes the case of a probe function returning error
> - * before calling fpga_mgr_register(), the struct will still get cleaned up.
> + * The caller of this function is responsible for calling fpga_mgr_unregister().
> + * Using devm_fpga_mgr_register() instead is recommended. This simple
> + * version of the register function should be sufficient for most users. The
> + * fpga_mgr_register_full() function is available for users that need to pass
> + * additional, optional parameters.
>   *
> - * Return: pointer to struct fpga_manager or NULL
> + * Return: pointer to struct fpga_manager pointer or ERR_PTR()
>   */
> -struct fpga_manager *devm_fpga_mgr_create(struct device *parent, const char *name,
> -					  const struct fpga_manager_ops *mops,
> -					  void *priv)
> +struct fpga_manager *
> +fpga_mgr_register(struct device *parent, const char *name,
> +		  const struct fpga_manager_ops *mops, void *priv)
>  {
> -	struct fpga_mgr_devres *dr;
> +	struct fpga_manager_info info = { 0 };
>  
> -	dr = devres_alloc(devm_fpga_mgr_release, sizeof(*dr), GFP_KERNEL);
> -	if (!dr)
> -		return NULL;
> +	info.name = name;
> +	info.mops = mops;
> +	info.priv = priv;
>  
> -	dr->mgr = fpga_mgr_create(parent, name, mops, priv);
> -	if (!dr->mgr) {
> -		devres_free(dr);
> -		return NULL;
> -	}
> -
> -	devres_add(parent, dr);
> -
> -	return dr->mgr;
> -}
> -EXPORT_SYMBOL_GPL(devm_fpga_mgr_create);
> -
> -/**
> - * fpga_mgr_register - register an FPGA manager
> - * @mgr: fpga manager struct
> - *
> - * Return: 0 on success, negative error code otherwise.
> - */
> -int fpga_mgr_register(struct fpga_manager *mgr)
> -{
> -	int ret;
> -
> -	/*
> -	 * Initialize framework state by requesting low level driver read state
> -	 * from device.  FPGA may be in reset mode or may have been programmed
> -	 * by bootloader or EEPROM.
> -	 */
> -	mgr->state = fpga_mgr_state(mgr);
> -
> -	ret = device_add(&mgr->dev);
> -	if (ret)
> -		goto error_device;
> -
> -	dev_info(&mgr->dev, "%s registered\n", mgr->name);
> -
> -	return 0;
> -
> -error_device:
> -	ida_simple_remove(&fpga_mgr_ida, mgr->dev.id);
> -
> -	return ret;
> +	return fpga_mgr_register_full(parent, &info);
>  }
>  EXPORT_SYMBOL_GPL(fpga_mgr_register);
>  
> @@ -765,14 +718,6 @@ void fpga_mgr_unregister(struct fpga_manager *mgr)
>  }
>  EXPORT_SYMBOL_GPL(fpga_mgr_unregister);
>  
> -static int fpga_mgr_devres_match(struct device *dev, void *res,
> -				 void *match_data)
> -{
> -	struct fpga_mgr_devres *dr = res;
> -
> -	return match_data == dr->mgr;
> -}
> -
>  static void devm_fpga_mgr_unregister(struct device *dev, void *res)
>  {
>  	struct fpga_mgr_devres *dr = res;
> @@ -781,45 +726,67 @@ static void devm_fpga_mgr_unregister(struct device *dev, void *res)
>  }
>  
>  /**
> - * devm_fpga_mgr_register - resource managed variant of fpga_mgr_register()
> - * @dev: managing device for this FPGA manager
> - * @mgr: fpga manager struct
> + * devm_fpga_mgr_register_full - resource managed variant of fpga_mgr_register()
> + * @parent:	fpga manager device from pdev
> + * @info:	parameters for fpga manager
>   *
> - * This is the devres variant of fpga_mgr_register() for which the unregister
> + * This is the devres variant of fpga_mgr_register_full() for which the unregister
>   * function will be called automatically when the managing device is detached.
>   */
> -int devm_fpga_mgr_register(struct device *dev, struct fpga_manager *mgr)
> +struct fpga_manager *
> +devm_fpga_mgr_register_full(struct device *parent, const struct fpga_manager_info *info)
>  {
>  	struct fpga_mgr_devres *dr;
> -	int ret;
> -
> -	/*
> -	 * Make sure that the struct fpga_manager * that is passed in is
> -	 * managed itself.
> -	 */
> -	if (WARN_ON(!devres_find(dev, devm_fpga_mgr_release,
> -				 fpga_mgr_devres_match, mgr)))
> -		return -EINVAL;
> +	struct fpga_manager *mgr;
>  
>  	dr = devres_alloc(devm_fpga_mgr_unregister, sizeof(*dr), GFP_KERNEL);
>  	if (!dr)
> -		return -ENOMEM;
> +		return ERR_PTR(-ENOMEM);
>  
> -	ret = fpga_mgr_register(mgr);
> -	if (ret) {
> +	mgr = fpga_mgr_register_full(parent, info);
> +	if (IS_ERR(mgr)) {
>  		devres_free(dr);
> -		return ret;
> +		return mgr;
>  	}
>  
>  	dr->mgr = mgr;
> -	devres_add(dev, dr);
> +	devres_add(parent, dr);
>  
> -	return 0;
> +	return mgr;
> +}
> +EXPORT_SYMBOL_GPL(devm_fpga_mgr_register_full);
> +
> +/**
> + * devm_fpga_mgr_register - resource managed variant of fpga_mgr_register()
> + * @parent:	fpga manager device from pdev
> + * @name:	fpga manager name
> + * @mops:	pointer to structure of fpga manager ops
> + * @priv:	fpga manager private data
> + *
> + * This is the devres variant of fpga_mgr_register() for which the
> + * unregister function will be called automatically when the managing
> + * device is detached.
> + */
> +struct fpga_manager *
> +devm_fpga_mgr_register(struct device *parent, const char *name,
> +		       const struct fpga_manager_ops *mops, void *priv)
> +{
> +	struct fpga_manager_info info = { 0 };
> +
> +	info.name = name;
> +	info.mops = mops;
> +	info.priv = priv;
> +
> +	return devm_fpga_mgr_register_full(parent, &info);
>  }
>  EXPORT_SYMBOL_GPL(devm_fpga_mgr_register);
>  
>  static void fpga_mgr_dev_release(struct device *dev)
>  {
> +	struct fpga_manager *mgr = to_fpga_manager(dev);
> +
> +	ida_simple_remove(&fpga_mgr_ida, mgr->dev.id);
> +	kfree(mgr);
>  }
>  
>  static int __init fpga_mgr_class_init(void)
> diff --git a/drivers/fpga/ice40-spi.c b/drivers/fpga/ice40-spi.c
> index 69dec5af23c3..b7591912248f 100644
> --- a/drivers/fpga/ice40-spi.c
> +++ b/drivers/fpga/ice40-spi.c
> @@ -178,12 +178,9 @@ static int ice40_fpga_probe(struct spi_device *spi)
>  		return ret;
>  	}
>  
> -	mgr = devm_fpga_mgr_create(dev, "Lattice iCE40 FPGA Manager",
> -				   &ice40_fpga_ops, priv);
> -	if (!mgr)
> -		return -ENOMEM;
> -
> -	return devm_fpga_mgr_register(dev, mgr);
> +	mgr = devm_fpga_mgr_register(dev, "Lattice iCE40 FPGA Manager",
> +				     &ice40_fpga_ops, priv);
> +	return PTR_ERR_OR_ZERO(mgr);
>  }
>  
>  static const struct of_device_id ice40_fpga_of_match[] = {
> diff --git a/drivers/fpga/machxo2-spi.c b/drivers/fpga/machxo2-spi.c
> index ea2ec3c6815c..905607992a12 100644
> --- a/drivers/fpga/machxo2-spi.c
> +++ b/drivers/fpga/machxo2-spi.c
> @@ -370,12 +370,9 @@ static int machxo2_spi_probe(struct spi_device *spi)
>  		return -EINVAL;
>  	}
>  
> -	mgr = devm_fpga_mgr_create(dev, "Lattice MachXO2 SPI FPGA Manager",
> -				   &machxo2_ops, spi);
> -	if (!mgr)
> -		return -ENOMEM;
> -
> -	return devm_fpga_mgr_register(dev, mgr);
> +	mgr = devm_fpga_mgr_register(dev, "Lattice MachXO2 SPI FPGA Manager",
> +				     &machxo2_ops, spi);
> +	return PTR_ERR_OR_ZERO(mgr);
>  }
>  
>  #ifdef CONFIG_OF
> diff --git a/drivers/fpga/socfpga-a10.c b/drivers/fpga/socfpga-a10.c
> index 573d88bdf730..ac8e89b8a5cc 100644
> --- a/drivers/fpga/socfpga-a10.c
> +++ b/drivers/fpga/socfpga-a10.c
> @@ -508,19 +508,15 @@ static int socfpga_a10_fpga_probe(struct platform_device *pdev)
>  		return -EBUSY;
>  	}
>  
> -	mgr = devm_fpga_mgr_create(dev, "SoCFPGA Arria10 FPGA Manager",
> -				   &socfpga_a10_fpga_mgr_ops, priv);
> -	if (!mgr)
> -		return -ENOMEM;
> -
> -	platform_set_drvdata(pdev, mgr);
> -
> -	ret = fpga_mgr_register(mgr);
> -	if (ret) {
> +	mgr = fpga_mgr_register(dev, "SoCFPGA Arria10 FPGA Manager",
> +				&socfpga_a10_fpga_mgr_ops, priv);
> +	if (IS_ERR(mgr)) {
>  		clk_disable_unprepare(priv->clk);
> -		return ret;
> +		return PTR_ERR(mgr);
>  	}
>  
> +	platform_set_drvdata(pdev, mgr);
> +
>  	return 0;
>  }
>  
> diff --git a/drivers/fpga/socfpga.c b/drivers/fpga/socfpga.c
> index 1f467173fc1f..7e0741f99696 100644
> --- a/drivers/fpga/socfpga.c
> +++ b/drivers/fpga/socfpga.c
> @@ -571,12 +571,9 @@ static int socfpga_fpga_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>  
> -	mgr = devm_fpga_mgr_create(dev, "Altera SOCFPGA FPGA Manager",
> -				   &socfpga_fpga_ops, priv);
> -	if (!mgr)
> -		return -ENOMEM;
> -
> -	return devm_fpga_mgr_register(dev, mgr);
> +	mgr = devm_fpga_mgr_register(dev, "Altera SOCFPGA FPGA Manager",
> +				     &socfpga_fpga_ops, priv);
> +	return PTR_ERR_OR_ZERO(mgr);
>  }
>  
>  #ifdef CONFIG_OF
> diff --git a/drivers/fpga/stratix10-soc.c b/drivers/fpga/stratix10-soc.c
> index 047fd7f23706..737d14c6e0de 100644
> --- a/drivers/fpga/stratix10-soc.c
> +++ b/drivers/fpga/stratix10-soc.c
> @@ -419,18 +419,11 @@ static int s10_probe(struct platform_device *pdev)
>  
>  	init_completion(&priv->status_return_completion);
>  
> -	mgr = fpga_mgr_create(dev, "Stratix10 SOC FPGA Manager",
> -			      &s10_ops, priv);
> -	if (!mgr) {
> -		dev_err(dev, "unable to create FPGA manager\n");
> -		ret = -ENOMEM;
> -		goto probe_err;
> -	}
> -
> -	ret = fpga_mgr_register(mgr);
> -	if (ret) {
> +	mgr = fpga_mgr_register(dev, "Stratix10 SOC FPGA Manager",
> +				&s10_ops, priv);
> +	if (IS_ERR(mgr)) {
>  		dev_err(dev, "unable to register FPGA manager\n");
> -		fpga_mgr_free(mgr);
> +		ret = PTR_ERR(mgr);
>  		goto probe_err;
>  	}
>  
> @@ -448,7 +441,6 @@ static int s10_remove(struct platform_device *pdev)
>  	struct s10_priv *priv = mgr->priv;
>  
>  	fpga_mgr_unregister(mgr);
> -	fpga_mgr_free(mgr);
>  	stratix10_svc_free_channel(priv->chan);
>  
>  	return 0;
> diff --git a/drivers/fpga/ts73xx-fpga.c b/drivers/fpga/ts73xx-fpga.c
> index 167abb0b08d4..8e6e9c840d9d 100644
> --- a/drivers/fpga/ts73xx-fpga.c
> +++ b/drivers/fpga/ts73xx-fpga.c
> @@ -116,12 +116,9 @@ static int ts73xx_fpga_probe(struct platform_device *pdev)
>  	if (IS_ERR(priv->io_base))
>  		return PTR_ERR(priv->io_base);
>  
> -	mgr = devm_fpga_mgr_create(kdev, "TS-73xx FPGA Manager",
> -				   &ts73xx_fpga_ops, priv);
> -	if (!mgr)
> -		return -ENOMEM;
> -
> -	return devm_fpga_mgr_register(kdev, mgr);
> +	mgr = devm_fpga_mgr_register(kdev, "TS-73xx FPGA Manager",
> +				     &ts73xx_fpga_ops, priv);
> +	return PTR_ERR_OR_ZERO(mgr);
>  }
>  
>  static struct platform_driver ts73xx_fpga_driver = {
> diff --git a/drivers/fpga/xilinx-spi.c b/drivers/fpga/xilinx-spi.c
> index b6bcf1d9233d..e1a227e7ff2a 100644
> --- a/drivers/fpga/xilinx-spi.c
> +++ b/drivers/fpga/xilinx-spi.c
> @@ -247,13 +247,10 @@ static int xilinx_spi_probe(struct spi_device *spi)
>  		return dev_err_probe(&spi->dev, PTR_ERR(conf->done),
>  				     "Failed to get DONE gpio\n");
>  
> -	mgr = devm_fpga_mgr_create(&spi->dev,
> -				   "Xilinx Slave Serial FPGA Manager",
> -				   &xilinx_spi_ops, conf);
> -	if (!mgr)
> -		return -ENOMEM;
> -
> -	return devm_fpga_mgr_register(&spi->dev, mgr);
> +	mgr = devm_fpga_mgr_register(&spi->dev,
> +				     "Xilinx Slave Serial FPGA Manager",
> +				     &xilinx_spi_ops, conf);
> +	return PTR_ERR_OR_ZERO(mgr);
>  }
>  
>  #ifdef CONFIG_OF
> diff --git a/drivers/fpga/zynq-fpga.c b/drivers/fpga/zynq-fpga.c
> index 9b75bd4f93d8..426aa34c6a0d 100644
> --- a/drivers/fpga/zynq-fpga.c
> +++ b/drivers/fpga/zynq-fpga.c
> @@ -609,20 +609,16 @@ static int zynq_fpga_probe(struct platform_device *pdev)
>  
>  	clk_disable(priv->clk);
>  
> -	mgr = devm_fpga_mgr_create(dev, "Xilinx Zynq FPGA Manager",
> -				   &zynq_fpga_ops, priv);
> -	if (!mgr)
> -		return -ENOMEM;
> -
> -	platform_set_drvdata(pdev, mgr);
> -
> -	err = fpga_mgr_register(mgr);
> -	if (err) {
> +	mgr = fpga_mgr_register(dev, "Xilinx Zynq FPGA Manager",
> +				&zynq_fpga_ops, priv);
> +	if (IS_ERR(mgr)) {
>  		dev_err(dev, "unable to register FPGA manager\n");
>  		clk_unprepare(priv->clk);
> -		return err;
> +		return PTR_ERR(mgr);
>  	}
>  
> +	platform_set_drvdata(pdev, mgr);
> +
>  	return 0;
>  }
>  
> diff --git a/drivers/fpga/zynqmp-fpga.c b/drivers/fpga/zynqmp-fpga.c
> index 7d3d5650c322..c60f20949c47 100644
> --- a/drivers/fpga/zynqmp-fpga.c
> +++ b/drivers/fpga/zynqmp-fpga.c
> @@ -95,12 +95,9 @@ static int zynqmp_fpga_probe(struct platform_device *pdev)
>  
>  	priv->dev = dev;
>  
> -	mgr = devm_fpga_mgr_create(dev, "Xilinx ZynqMP FPGA Manager",
> -				   &zynqmp_fpga_ops, priv);
> -	if (!mgr)
> -		return -ENOMEM;
> -
> -	return devm_fpga_mgr_register(dev, mgr);
> +	mgr = devm_fpga_mgr_register(dev, "Xilinx ZynqMP FPGA Manager",
> +				     &zynqmp_fpga_ops, priv);
> +	return PTR_ERR_OR_ZERO(mgr);
>  }
>  
>  #ifdef CONFIG_OF
> diff --git a/include/linux/fpga/fpga-mgr.h b/include/linux/fpga/fpga-mgr.h
> index 474c1f506307..0f9468771bb9 100644
> --- a/include/linux/fpga/fpga-mgr.h
> +++ b/include/linux/fpga/fpga-mgr.h
> @@ -105,6 +105,36 @@ struct fpga_image_info {
>  #endif
>  };
>  
> +/**
> + * struct fpga_compat_id - id for compatibility check
> + *
> + * @id_h: high 64bit of the compat_id
> + * @id_l: low 64bit of the compat_id
> + */
> +struct fpga_compat_id {
> +	u64 id_h;
> +	u64 id_l;
> +};
> +
> +/**
> + * struct fpga_manager_info - collection of parameters for an FPGA Manager
> + * @name: fpga manager name
> + * @compat_id: FPGA manager id for compatibility check.
> + * @mops: pointer to structure of fpga manager ops
> + * @priv: fpga manager private data
> + *
> + * fpga_manager_info contains parameters for the register_full function.
> + * These are separated into an info structure because they some are optional
> + * others could be added to in the future. The info structure facilitates
> + * maintaining a stable API.
> + */
> +struct fpga_manager_info {
> +	const char *name;
> +	struct fpga_compat_id *compat_id;
> +	const struct fpga_manager_ops *mops;
> +	void *priv;
> +};
> +
>  /**
>   * struct fpga_manager_ops - ops for low level fpga manager drivers
>   * @initial_header_size: Maximum number of bytes that should be passed into write_init
> @@ -143,17 +173,6 @@ struct fpga_manager_ops {
>  #define FPGA_MGR_STATUS_IP_PROTOCOL_ERR		BIT(3)
>  #define FPGA_MGR_STATUS_FIFO_OVERFLOW_ERR	BIT(4)
>  
> -/**
> - * struct fpga_compat_id - id for compatibility check
> - *
> - * @id_h: high 64bit of the compat_id
> - * @id_l: low 64bit of the compat_id
> - */
> -struct fpga_compat_id {
> -	u64 id_h;
> -	u64 id_l;
> -};
> -
>  /**
>   * struct fpga_manager - fpga manager structure
>   * @name: name of low level fpga manager
> @@ -191,17 +210,18 @@ struct fpga_manager *fpga_mgr_get(struct device *dev);
>  
>  void fpga_mgr_put(struct fpga_manager *mgr);
>  
> -struct fpga_manager *fpga_mgr_create(struct device *dev, const char *name,
> -				     const struct fpga_manager_ops *mops,
> -				     void *priv);
> -void fpga_mgr_free(struct fpga_manager *mgr);
> -int fpga_mgr_register(struct fpga_manager *mgr);
> -void fpga_mgr_unregister(struct fpga_manager *mgr);
> +struct fpga_manager *
> +fpga_mgr_register_full(struct device *parent, const struct fpga_manager_info *info);
>  
> -int devm_fpga_mgr_register(struct device *dev, struct fpga_manager *mgr);
> +struct fpga_manager *
> +fpga_mgr_register(struct device *parent, const char *name,
> +		  const struct fpga_manager_ops *mops, void *priv);
> +void fpga_mgr_unregister(struct fpga_manager *mgr);
>  
> -struct fpga_manager *devm_fpga_mgr_create(struct device *dev, const char *name,
> -					  const struct fpga_manager_ops *mops,
> -					  void *priv);
> +struct fpga_manager *
> +devm_fpga_mgr_register_full(struct device *parent, const struct fpga_manager_info *info);
> +struct fpga_manager *
> +devm_fpga_mgr_register(struct device *parent, const char *name,
> +		       const struct fpga_manager_ops *mops, void *priv);
>  
>  #endif /*_LINUX_FPGA_MGR_H */

