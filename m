Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F273373CF4D
	for <lists+linux-fpga@lfdr.de>; Sun, 25 Jun 2023 10:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231701AbjFYIYs (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 25 Jun 2023 04:24:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231734AbjFYIYq (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 25 Jun 2023 04:24:46 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E109510D7;
        Sun, 25 Jun 2023 01:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687681483; x=1719217483;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=O2m0q02Mtu457nNDRC77XsltlPuNb7XtG8yo5Z+9cUk=;
  b=BYmuUGT/e1tyKvC1OHH5+42qRQl8hnzegiA9V48E0BMjCDfmJF7QLvWY
   kBz3HIy4mIPOw3S2b03yRq7SvRp0FlZc22+4f4wLfarCagUcwGGCEcYVj
   aJBGwKPcR9l5XVz3yHtNjEEUqfbgscFG+sQATAEWvp1cfLg9J2eB/OxO9
   ulp692swVoct/zQnEGz7fcRq8vsHSIA1i2ILO9Vj8X9hLDd5KQQwBwfXm
   0+MFkXsBWS+EWD9WPIeDXSKalwqBYxG8u1IhTkhuYqp59LvNkEKemCPCh
   3RGaXLt9hNmYIb9iXL+DMMZyMHe6+FDtJiOQhfBf/OHKOvytmXKjgIBFP
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10751"; a="424716440"
X-IronPort-AV: E=Sophos;i="6.01,156,1684825200"; 
   d="scan'208";a="424716440"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2023 01:24:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10751"; a="718986577"
X-IronPort-AV: E=Sophos;i="6.01,156,1684825200"; 
   d="scan'208";a="718986577"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmsmga007.fm.intel.com with ESMTP; 25 Jun 2023 01:24:39 -0700
Date:   Sun, 25 Jun 2023 16:23:33 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Marco Pagani <marpagan@redhat.com>
Cc:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org
Subject: Re: [PATCH v7 4/4] fpga: add configuration for the FPGA KUnit test
 suites.
Message-ID: <ZJf5hUkGYCg1YCPx@yilunxu-OptiPlex-7050>
References: <20230616154405.220502-1-marpagan@redhat.com>
 <20230616154405.220502-5-marpagan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230616154405.220502-5-marpagan@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2023-06-16 at 17:44:05 +0200, Marco Pagani wrote:
> Add configuration for the KUnit test suites for the core components
> of the FPGA subsystem.
> 
> Signed-off-by: Marco Pagani <marpagan@redhat.com>
> ---
>  drivers/fpga/Kconfig            |  2 ++
>  drivers/fpga/Makefile           |  3 +++
>  drivers/fpga/tests/.kunitconfig |  5 +++++
>  drivers/fpga/tests/Kconfig      | 11 +++++++++++
>  drivers/fpga/tests/Makefile     |  5 +++++
>  5 files changed, 26 insertions(+)
>  create mode 100644 drivers/fpga/tests/.kunitconfig
>  create mode 100644 drivers/fpga/tests/Kconfig
>  create mode 100644 drivers/fpga/tests/Makefile
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
> index 000000000000..e4a64815f16d
> --- /dev/null
> +++ b/drivers/fpga/tests/Kconfig
> @@ -0,0 +1,11 @@
> +config FPGA_KUNIT_TESTS
> +	tristate "KUnit test for the FPGA subsystem" if !KUNIT_ALL_TESTS
> +	depends on FPGA && FPGA_REGION && FPGA_BRIDGE && KUNIT=y

Why KUNIT shouldn't be 'm'

> +	default KUNIT_ALL_TESTS
> +        help
> +          This builds unit tests for the FPGA subsystem
> +
> +          For more information on KUnit and unit tests in general,
> +          please refer to the KUnit documentation in Documentation/dev-tools/kunit/.
> +
> +          If unsure, say N.
> diff --git a/drivers/fpga/tests/Makefile b/drivers/fpga/tests/Makefile
> new file mode 100644
> index 000000000000..faa5fa230ab0
> --- /dev/null
> +++ b/drivers/fpga/tests/Makefile
> @@ -0,0 +1,5 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +obj-$(CONFIG_FPGA_KUNIT_TESTS) += fpga-mgr-test.o
> +obj-$(CONFIG_FPGA_KUNIT_TESTS) += fpga-bridge-test.o
> +obj-$(CONFIG_FPGA_KUNIT_TESTS) += fpga-region-test.o

Could be integrated in one line?

Thanks,
Yilun

> -- 
> 2.40.1
> 
