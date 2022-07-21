Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA0A157C594
	for <lists+linux-fpga@lfdr.de>; Thu, 21 Jul 2022 09:54:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231187AbiGUHxO (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 21 Jul 2022 03:53:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbiGUHxN (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 21 Jul 2022 03:53:13 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F3A77CB6B;
        Thu, 21 Jul 2022 00:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658389992; x=1689925992;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=F/IFKPNNCoSx3pRfE5e/uwKggWX4TPWvNE5TXI91sQ0=;
  b=H4atNDE37CFGv1CLo43aHD9hoL86ky7eqCTN1Z5t9lOfQ8r22dOhML14
   sLbp23ve3hpXlhNtaXjMFm0jYEth1dL593I6S0woHFb1Chhwh1J5GNMX9
   hV5xhPqcZ1KUvpX8wGF7mPeQhs+NsL2uWcp9b2IZPUEAE+Zy86XxE/NVQ
   0iq6InVs5IA8wtAvGYmylOzusLJCI7HlPX6iGHBP6MbuaV2gHZm/jpe0S
   mrlln9UG9FNgal0MwW1th84S26Y/D1u1k/rSqJuYLvdqSCDuvFBv8MMvB
   i5jHbdHi5Nr7r3Ts45GMtyjaH9wyyhW9t+KxYLjCQLr3Az2e/4KMOsjut
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10414"; a="288143430"
X-IronPort-AV: E=Sophos;i="5.92,288,1650956400"; 
   d="scan'208";a="288143430"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2022 00:53:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,288,1650956400"; 
   d="scan'208";a="626009740"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orsmga008.jf.intel.com with ESMTP; 21 Jul 2022 00:53:09 -0700
Date:   Thu, 21 Jul 2022 15:44:31 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Ivan Bornyakov <i.bornyakov@metrotek.ru>
Cc:     mdf@kernel.org, hao.wu@intel.com, trix@redhat.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-fpga@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, system@metrotek.ru
Subject: Re: [PATCH v5 0/2] Lattice ECP5 FPGA manager
Message-ID: <20220721074431.GA1712998@yilunxu-OptiPlex-7050>
References: <20220719112335.9528-1-i.bornyakov@metrotek.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220719112335.9528-1-i.bornyakov@metrotek.ru>
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Tue, Jul 19, 2022 at 02:23:33PM +0300, Ivan Bornyakov wrote:
> Add support to the FPGA manager for programming Lattice ECP5 FPGA over
> slave SPI interface with .bit formatted uncompressed bitstream image.

I didn't have time to looking into the patches yet, but I have some quick
question.

Where is the bitstream data writing to? To the FPGA active region or the
backup nvmem like flash?

After reconfiguration, how to re-enumerate the hardware devices in the
newly programmed FPGA region?

Thanks,
Yilun

> 
> ChangeLog:
>   v1 -> v2:
>     * remove "spi" from compatible string
>     * reword description in dt-bindings doc
>     * add reference to spi-peripheral-props.yaml in dt-binding doc
>     * fix DTS example in dt-bindings doc: 4-spaces indentations, no
>       undersores in node names.
>   v2 -> v3:
>     * fix typo "##size-cells" -> "#size-cells" in dt-bindings example
>   v3 -> v4:
>     * dt-bindings: reword description
>     * dt-bindings: revert props order
>   v4 -> v5:
>     * dt-bindings: remove trailing dot from title
>     * dt-bindings: reword description to avoid driver reference
>     * dt-bindings: add "Reviewed-by: Krzysztof Kozlowski" tag
> 
> Ivan Bornyakov (2):
>   fpga: ecp5-spi: add Lattice ECP5 FPGA manager
>   dt-bindings: fpga: add binding doc for ecp5-spi fpga mgr
> 
>  .../bindings/fpga/lattice,ecp5-fpga-mgr.yaml  |  74 +++++
>  drivers/fpga/Kconfig                          |   7 +
>  drivers/fpga/Makefile                         |   1 +
>  drivers/fpga/ecp5-spi.c                       | 275 ++++++++++++++++++
>  4 files changed, 357 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/fpga/lattice,ecp5-fpga-mgr.yaml
>  create mode 100644 drivers/fpga/ecp5-spi.c
> 
> -- 
> 2.37.1
> 
