Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B81A06DA901
	for <lists+linux-fpga@lfdr.de>; Fri,  7 Apr 2023 08:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbjDGGid (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 7 Apr 2023 02:38:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjDGGib (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 7 Apr 2023 02:38:31 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB8435B88;
        Thu,  6 Apr 2023 23:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680849510; x=1712385510;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=vVTkW3Ec4gZLzzZYVf3Rwf4yfSnUAronz8v0/X06PYw=;
  b=oINbUe+sO0aveyOOut7kmDcW0atWqwKhK/RQkiyPvt4lnIkhBs85s5+c
   8gtVcRgphaax3NmzmtLKXmT4E+5eszyFVCZiTz//chs08h62IOCNE+fIB
   vH8Opc8fpxNYqwlEwNUQMOJhvz6ogd/21gpTc6M4Li37uVR7HznljYkxu
   Nbh77/O4FnZ6Hj1TA40H78wCP1YbKQS02CetJ6p+O9PEoM4H8rRhg1fpp
   j2u63xC/bV8Ovf/RGZpb0I9JJ0r3AJpCzi/5RDGYMxLzj4LaII5mvrj/f
   n9IvzyiXAgDfzXIGkyVuqooXntLwBinr16QYYbwxxBZBzXoHInAjgdLST
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10672"; a="370770656"
X-IronPort-AV: E=Sophos;i="5.98,326,1673942400"; 
   d="scan'208";a="370770656"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2023 23:38:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10672"; a="664790120"
X-IronPort-AV: E=Sophos;i="5.98,326,1673942400"; 
   d="scan'208";a="664790120"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orsmga006.jf.intel.com with ESMTP; 06 Apr 2023 23:38:26 -0700
Date:   Fri, 7 Apr 2023 14:26:34 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
        Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org,
        Lee Jones <lee@kernel.org>, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org,
        Russ Weight <russell.h.weight@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] mfd: intel-m10-bmc: Move core symbols to own
 namespace
Message-ID: <ZC+3msi6ovoF55tr@yilunxu-OptiPlex-7050>
References: <20230405080152.6732-1-ilpo.jarvinen@linux.intel.com>
 <20230405080152.6732-2-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230405080152.6732-2-ilpo.jarvinen@linux.intel.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2023-04-05 at 11:01:49 +0300, Ilpo Järvinen wrote:
> Create INTEL_M10_BMC_CORE namespace for symbols exported by
> intel-m10-bmc-core.

Is it necessary for handshake register, or just an independent
improvement?

> 
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

Why this function is not included in namespace?

Thanks,
Yilun

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
> -- 
> 2.30.2
> 
