Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CABE559EA0
	for <lists+linux-fpga@lfdr.de>; Fri, 24 Jun 2022 18:38:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231299AbiFXQgc (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 24 Jun 2022 12:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbiFXQga (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 24 Jun 2022 12:36:30 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F5DF4E384;
        Fri, 24 Jun 2022 09:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656088589; x=1687624589;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ISZpanMTrKMtDF2ptQdE6nRc4RobHD9iXX2SAkgkzm8=;
  b=J5QyMSv0gVcMNtSsxHtX9zLYLHBe2tFpvYYxAn+R35GIlqjM0rNgchJP
   xR6QIg0NidV3a93N91zKHsmYa4XpINcmBgR48TMpSfU7Pl4UOEI2qWd0A
   kJfFm3ax8ClQxkhRlHCU19/2cy5z8fdLjW6WqdsDyh4Wg+YZjB/7jFBIc
   yYHd/jiLpFnvDGLGtmvUjr1y0DyAEiIo//+0V7D0IL4hgzJ1s0fBGcM5u
   7WBKT6qs8147m0RIgqpUfQyn5pKKpmsW4xqFL1tUFB+BONQuUzjMmAm9S
   4kj0hCWxLME6JYJDttTGVorlVmMhDSxT0yxEJw/4dD2kAhYsbHNq9Z08v
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10388"; a="342726209"
X-IronPort-AV: E=Sophos;i="5.92,218,1650956400"; 
   d="scan'208";a="342726209"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2022 09:36:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,218,1650956400"; 
   d="scan'208";a="835188932"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmsmga006.fm.intel.com with ESMTP; 24 Jun 2022 09:36:25 -0700
Date:   Sat, 25 Jun 2022 00:28:15 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Nava kishore Manne <nava.manne@xilinx.com>
Cc:     mdf@kernel.org, hao.wu@intel.com, trix@redhat.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        michal.simek@xilinx.com, linux-fpga@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, git@xilinx.com,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 2/3] fpga: region: Add fpga-region 'power-domains'
 property
Message-ID: <20220624162815.GA2142910@yilunxu-OptiPlex-7050>
References: <20220523134517.4056873-1-nava.manne@xilinx.com>
 <20220523134517.4056873-3-nava.manne@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220523134517.4056873-3-nava.manne@xilinx.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, May 23, 2022 at 07:15:16PM +0530, Nava kishore Manne wrote:
> Add fpga-region 'power-domains' property to allow to handle
> the FPGA/PL power domains.
> 
> Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
> Changes for v2:
>               - Updated power-domains description.
> 
>  .../devicetree/bindings/fpga/fpga-region.txt       | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/fpga/fpga-region.txt b/Documentation/devicetree/bindings/fpga/fpga-region.txt
> index 7d3515264838..f299c3749505 100644
> --- a/Documentation/devicetree/bindings/fpga/fpga-region.txt
> +++ b/Documentation/devicetree/bindings/fpga/fpga-region.txt
> @@ -196,6 +196,20 @@ Optional properties:
>  - config-complete-timeout-us : The maximum time in microseconds time for the
>  	FPGA to go to operating mode after the region has been programmed.
>  - child nodes : devices in the FPGA after programming.
> +- power-domains : A phandle and power domain specifier pair to the power domain
> +	which is responsible for turning on/off the power to the FPGA/PL region.

Could you help explain what is PL?

> +Example:
> +	fpga_full: fpga-full {
> +                compatible = "fpga-region";
> +                fpga-mgr = <&zynqmp_pcap>;
> +                #address-cells = <2>;
> +                #size-cells = <2>;
> +                ranges;
> +                power-domains = <&zynqmp_firmware PL_PD>;
> +        };
> +
> +	The PL_PD power domain will be turned on before loading the bitstream
> +and turned off while removing/unloading the bitstream using overlays.

I think the single power-domain may not cover some use cases that
of-fpga-region driver supports. It is possible there are already
devices in fpga-region for static OF tree, or an overlay with no
'firmware-name' but 'external-fpga-config'. In these cases power domains
may still be needed, is it?

Another case is the fpga-region may need multiple power domains?

Since the of-fpga-region driver is a generic fpga-region driver, we may
investigate more for a compatible power-domain solution.

Thanks,
Yilun

>  
>  In the example below, when an overlay is applied targeting fpga-region0,
>  fpga_mgr is used to program the FPGA.  Two bridges are controlled during
> -- 
> 2.25.1
