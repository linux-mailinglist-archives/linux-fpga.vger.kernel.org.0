Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D8F35A34FC
	for <lists+linux-fpga@lfdr.de>; Sat, 27 Aug 2022 08:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232146AbiH0GMT (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 27 Aug 2022 02:12:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbiH0GMS (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sat, 27 Aug 2022 02:12:18 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D7D6B02A6;
        Fri, 26 Aug 2022 23:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661580737; x=1693116737;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5bYgtucMS73ltpVcIqX+yP40x5iHTdC6A1Zl4wmQkII=;
  b=RIEVdGnKlIs+y4O68joROVMADDySMufjiul8kvr16wiRJyzPe+a002Xr
   +bRFqdLwOX5NL2lPk+nm+Hs+gPPZ3glKuyQn+3312/mVxsUyKzpt7OYqF
   SuSNXj51KWRsoZGRkDUCfyWqiOhni3mZUs7xYsUQQbbfiaMlQcG20BYzD
   iNTvJeaCnwDOoxfVvUr6ShrbWbWpMQ2Vqvf/YVqwV4WJBwVjoFJ21/ebP
   b6di47tj1jrrEocZaZZ/F5WUfr1kaTEESdE2CBQwS0XkULjbKBrmaWPSz
   AMPAZ/FLBTSV2HW9Q6szHXZKdHOPKIWJTJZvt5qs73tj21ndj9V6pJqsm
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10451"; a="295911102"
X-IronPort-AV: E=Sophos;i="5.93,267,1654585200"; 
   d="scan'208";a="295911102"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2022 23:12:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,267,1654585200"; 
   d="scan'208";a="938989333"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmsmga005.fm.intel.com with ESMTP; 26 Aug 2022 23:12:12 -0700
Date:   Sat, 27 Aug 2022 14:02:56 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Nava kishore Manne <nava.kishore.manne@amd.com>
Cc:     git@amd.com, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        michal.simek@xilinx.com, mdf@kernel.org, hao.wu@intel.com,
        trix@redhat.com, p.zabel@pengutronix.de,
        gregkh@linuxfoundation.org, ronak.jain@xilinx.com,
        rajan.vaja@xilinx.com, abhyuday.godhasara@xilinx.com,
        piyush.mehta@xilinx.com, lakshmi.sai.krishna.potthuri@xilinx.com,
        harsha.harsha@xilinx.com, linus.walleij@linaro.org,
        nava.manne@xilinx.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org
Subject: Re: [PATCH 0/4]Add afi config drivers support
Message-ID: <YwmzkNVqgSEIgSKH@yilunxu-OptiPlex-7050>
References: <20220824035542.706433-1-nava.kishore.manne@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220824035542.706433-1-nava.kishore.manne@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2022-08-24 at 09:25:38 +0530, Nava kishore Manne wrote:
> Xilinx SoC platforms (Zynq and ZynqMP) connect the PS to the programmable

Could you help explain what is PS?

Thanks,
Yiljn

> logic (PL) through the AXI port.This AXI port helps to establish the data
> path between the PS and PL. In-order to establish the proper communication
> data path between PS and PL the AXI port data path should be configured
> with the proper Bus-width values and it will also handle the PS-PL reset
> signals to reset the PL domain.
> 
> This patch series adds afi config drivers support to handle the PS-PL
> resets and AXI port bus-width configurations.
> 
> Nava kishore Manne (4):
>   firmware: xilinx: Add afi ioctl support
>   bindings: fpga: Add binding doc for the zynqmp afi config driver
>   bindings: firmware: Update binding doc for the zynqmp afi config node
>   fpga: zynqmp: Add afi config driver
> 
>  .../firmware/xilinx/xlnx,zynqmp-firmware.yaml |   7 +
>  .../bindings/fpga/xlnx,zynqmp-afi-fpga.yaml   | 100 +++++++++
>  MAINTAINERS                                   |   6 +
>  drivers/firmware/xilinx/zynqmp.c              |  14 ++
>  drivers/fpga/Kconfig                          |  13 ++
>  drivers/fpga/Makefile                         |   1 +
>  drivers/fpga/zynqmp-afi.c                     | 211 ++++++++++++++++++
>  include/linux/firmware/xlnx-zynqmp.h          |  36 +++
>  8 files changed, 388 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/fpga/xlnx,zynqmp-afi-fpga.yaml
>  create mode 100644 drivers/fpga/zynqmp-afi.c
> 
> -- 
> 2.25.1
> 
