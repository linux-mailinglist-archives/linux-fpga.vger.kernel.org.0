Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0838D6D862E
	for <lists+linux-fpga@lfdr.de>; Wed,  5 Apr 2023 20:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234228AbjDESjD (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 5 Apr 2023 14:39:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234198AbjDESjC (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 5 Apr 2023 14:39:02 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D24A76A47;
        Wed,  5 Apr 2023 11:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680719941; x=1712255941;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=Pa3esqHkymP4j1o190ulOAVOxaCkdihrBWZj4GPbhso=;
  b=jmMrOXCtUF85hAvywpIlSg2CJCMjET9JOMeU+yIHlN+gH1tbhViauaVt
   iqcXh5Zvn+GYmyQD2CH8fYyhrurYsYCNzs4g3VdSurh714SG03lQyux7F
   r7nIxxWdwuPokdrAp6ymp/4epZ5qbHQ9ukMgyJT+XRp+NhUvY6Qep1S6O
   c5rprv+5jDE9+aXw41c7qSW4r5xM7EkxCBuPrWzbtlelbW0CCcoyJMueU
   N//efen7xQsIUOdWeno4Nh0fAz7YTRh6tmYV9kqlH0UTCsp/FTVtDm1EY
   8Co+zcLsAn+9/qRUSYHANGOYUmCbHeB+LQ0HwsMpRX97yw6FaFTIi4NrU
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10671"; a="370366346"
X-IronPort-AV: E=Sophos;i="5.98,321,1673942400"; 
   d="scan'208";a="370366346"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2023 11:38:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10671"; a="686844915"
X-IronPort-AV: E=Sophos;i="5.98,321,1673942400"; 
   d="scan'208";a="686844915"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga002.jf.intel.com with ESMTP; 05 Apr 2023 11:38:57 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 5 Apr 2023 11:38:56 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Wed, 5 Apr 2023 11:38:56 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.103)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Wed, 5 Apr 2023 11:38:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n2hbVuMUtEjK4d4JZ5LiMAjP4uHFA3OT5EPhoOPMYCOVp1OII6s62VgYeGzrAuTrSmewL8cdkdpxslRHmZgqXwDYHAoUJ7ANKZjVoehCUOuAOhWyaeaMjzAgpdq29sbVp2KhJhcgZ80kkOOBfPuWz0W01orLI5HYZrOH7aiBpoz5Dm4bPgOC1MSKo8TjRAtv5x9qcQ9QyjoVw+K1rYI1BNvJDV4I+zM7p/R9W7qlR0WrE1oi4mLw7y0ICExcyf/sIPjFBYAw2h4LyH63DHQAFCguAxPanoM6oBb509QZp6XbqHO3W0FoASflNbS42bPgcFmosHLTUzRnVZoSpTcflg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AioOkwQw9/wvKBAluLZx93BlVbqesHVVTFsQoq2+7Vk=;
 b=ciYKBJh7oiI5wFOXbelGV9UIh0Trm2QeDHlCx3wa6yl6SCXuySH7Obz/sENx5PfoMksIJsh5EIi/kJd25u3GtPT/DRVWuffOXZsqYpdj0uEoJm05fNbjQhi83gn9jX66AjOJP16pMZg5e7Iih7UU/IbAI1J3WyoCxpMPn+vTRyLb25n7Upx4/lW2H+y8uv62vSfx42/3dagIeZdrcSXgz+U8j/ooKpLVUogIYrzw9TbfXh5BfmZfGd/Dx9dL7HTasl3fadVeJniX/w+Q4+OhFe/EtikToRnClPPwoHUBLVwCDHeZarlwKlOb7/FGI+wRCiz5cBuUveQuLQTxWU9P8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB6763.namprd11.prod.outlook.com (2603:10b6:303:20b::7)
 by CY5PR11MB6438.namprd11.prod.outlook.com (2603:10b6:930:35::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.23; Wed, 5 Apr
 2023 18:38:54 +0000
Received: from MW4PR11MB6763.namprd11.prod.outlook.com
 ([fe80::c4e:6c7:e9f7:7222]) by MW4PR11MB6763.namprd11.prod.outlook.com
 ([fe80::c4e:6c7:e9f7:7222%6]) with mapi id 15.20.6254.030; Wed, 5 Apr 2023
 18:38:54 +0000
Message-ID: <ae23c6c8-63e5-00ea-a579-3525c35aa871@intel.com>
Date:   Wed, 5 Apr 2023 11:38:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.9.0
Subject: Re: [PATCH 1/4] mfd: intel-m10-bmc: Move core symbols to own
 namespace
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
        Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
        <linux-fpga@vger.kernel.org>, Lee Jones <lee@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230405080152.6732-1-ilpo.jarvinen@linux.intel.com>
 <20230405080152.6732-2-ilpo.jarvinen@linux.intel.com>
From:   Russ Weight <russell.h.weight@intel.com>
In-Reply-To: <20230405080152.6732-2-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0182.namprd04.prod.outlook.com
 (2603:10b6:303:86::7) To MW4PR11MB6763.namprd11.prod.outlook.com
 (2603:10b6:303:20b::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB6763:EE_|CY5PR11MB6438:EE_
X-MS-Office365-Filtering-Correlation-Id: d1503b7c-2d86-4adf-872b-08db360501b3
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB6763.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(366004)(39860400002)(136003)(376002)(451199021)(110136005)(316002)(921005)(31696002)(31686004)(82960400001)(86362001)(66556008)(66476007)(8676002)(66574015)(478600001)(66946007)(38100700002)(83380400001)(2616005)(36756003)(186003)(26005)(41300700001)(53546011)(2906002)(6506007)(6512007)(6666004)(8936002)(5660300002)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-CrossTenant-Network-Message-Id: d1503b7c-2d86-4adf-872b-08db360501b3
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB6763.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2023 18:38:53.6356
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t8gGoK9YVw5wgl8Fj8tJVfbleIbYQTBXGc7UQTkEbJpByfS9JjTkwX4tXsi9qpCSk75mjFFuwd5n/5xP0SHuspCBTYAyIg0pVayjwivOC7Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6438
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.9 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On 4/5/23 01:01, Ilpo Järvinen wrote:
> Create INTEL_M10_BMC_CORE namespace for symbols exported by
> intel-m10-bmc-core.
Reviewed-by: Russ Weight <russell.h.weight@intel.com>
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  drivers/mfd/intel-m10-bmc-core.c | 2 +-
>  drivers/mfd/intel-m10-bmc-pmci.c | 1 +
>  drivers/mfd/intel-m10-bmc-spi.c  | 1 +
>  3 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mfd/intel-m10-bmc-core.c b/drivers/mfd/intel-m10-bmc-core.c
> index dac9cf7bcb4a..b94412813887 100644
> --- a/drivers/mfd/intel-m10-bmc-core.c
> +++ b/drivers/mfd/intel-m10-bmc-core.c
> @@ -98,7 +98,7 @@ const struct attribute_group *m10bmc_dev_groups[] = {
>  	&m10bmc_group,
>  	NULL,
>  };
> -EXPORT_SYMBOL_GPL(m10bmc_dev_groups);
> +EXPORT_SYMBOL_NS_GPL(m10bmc_dev_groups, INTEL_M10_BMC_CORE);
>  
>  int m10bmc_dev_init(struct intel_m10bmc *m10bmc, const struct intel_m10bmc_platform_info *info)
>  {
> diff --git a/drivers/mfd/intel-m10-bmc-pmci.c b/drivers/mfd/intel-m10-bmc-pmci.c
> index 8821f1876dd6..0392ef8b57d8 100644
> --- a/drivers/mfd/intel-m10-bmc-pmci.c
> +++ b/drivers/mfd/intel-m10-bmc-pmci.c
> @@ -453,3 +453,4 @@ module_dfl_driver(m10bmc_pmci_driver);
>  MODULE_DESCRIPTION("MAX10 BMC PMCI-based interface");
>  MODULE_AUTHOR("Intel Corporation");
>  MODULE_LICENSE("GPL");
> +MODULE_IMPORT_NS(INTEL_M10_BMC_CORE);
> diff --git a/drivers/mfd/intel-m10-bmc-spi.c b/drivers/mfd/intel-m10-bmc-spi.c
> index 957200e17fed..edd266557ab9 100644
> --- a/drivers/mfd/intel-m10-bmc-spi.c
> +++ b/drivers/mfd/intel-m10-bmc-spi.c
> @@ -166,3 +166,4 @@ MODULE_DESCRIPTION("Intel MAX 10 BMC SPI bus interface");
>  MODULE_AUTHOR("Intel Corporation");
>  MODULE_LICENSE("GPL v2");
>  MODULE_ALIAS("spi:intel-m10-bmc");
> +MODULE_IMPORT_NS(INTEL_M10_BMC_CORE);

