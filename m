Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 253D12B90C6
	for <lists+linux-fpga@lfdr.de>; Thu, 19 Nov 2020 12:18:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbgKSLRf (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 19 Nov 2020 06:17:35 -0500
Received: from mga05.intel.com ([192.55.52.43]:55836 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726555AbgKSLRf (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 19 Nov 2020 06:17:35 -0500
IronPort-SDR: xPqY03va8el7d1hvm1XG/nTaItSwQavjyRM3037dhMgiDzJesUgjrsieciQxXKs+MoQZHoK/BZ
 SSEd/m4oTNSw==
X-IronPort-AV: E=McAfee;i="6000,8403,9809"; a="255981941"
X-IronPort-AV: E=Sophos;i="5.77,490,1596524400"; 
   d="scan'208";a="255981941"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2020 03:17:35 -0800
IronPort-SDR: dGfIt0tp3dBatLtAa2eGfVhDsStgyROEji14imL8qsPX9Zq6S34yLPjwjb3TYWeZ409O14SWSx
 EIIqs6X2t3Og==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,490,1596524400"; 
   d="scan'208";a="359936887"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.141])
  by fmsmga004.fm.intel.com with ESMTP; 19 Nov 2020 03:17:33 -0800
Date:   Thu, 19 Nov 2020 19:13:21 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     David Gow <davidgow@google.com>
Cc:     Moritz Fischer <mdf@kernel.org>, Tom Rix <trix@redhat.com>,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-um@lists.infradead.org,
        Brendan Higgins <brendanhiggins@google.com>
Subject: Re: [PATCH] drivers: fpga: Specify HAS_IOMEM dependency for FPGA_DFL
Message-ID: <20201119111321.GA26472@yilunxu-OptiPlex-7050>
References: <20201119082209.3598354-1-davidgow@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201119082209.3598354-1-davidgow@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Thanks for the fix, looks good to me.

Thanks,
Yilun

On Thu, Nov 19, 2020 at 12:22:09AM -0800, David Gow wrote:
> Because dfl.c uses the 'devm_ioremap', 'devm_iounmap',
> 'devm_ioremap_resource', and 'devm_platform_ioremap_resource'
> functions, it should depend on HAS_IOMEM.
> 
> This fixes make allyesconfig under UML (ARCH=um), which doesn't provide
> HAS_IOMEM.
> 
> Signed-off-by: David Gow <davidgow@google.com>
> ---
>  drivers/fpga/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
> index 7cd5a29fc437..5645226ca3ce 100644
> --- a/drivers/fpga/Kconfig
> +++ b/drivers/fpga/Kconfig
> @@ -142,6 +142,7 @@ config FPGA_DFL
>  	tristate "FPGA Device Feature List (DFL) support"
>  	select FPGA_BRIDGE
>  	select FPGA_REGION
> +	depends on HAS_IOMEM
>  	help
>  	  Device Feature List (DFL) defines a feature list structure that
>  	  creates a linked list of feature headers within the MMIO space
> -- 
> 2.29.2.454.gaff20da3a2-goog
