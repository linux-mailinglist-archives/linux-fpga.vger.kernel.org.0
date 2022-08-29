Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCB475A4425
	for <lists+linux-fpga@lfdr.de>; Mon, 29 Aug 2022 09:50:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbiH2Hs0 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 29 Aug 2022 03:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbiH2HsY (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 29 Aug 2022 03:48:24 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ED3A4F640;
        Mon, 29 Aug 2022 00:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661759304; x=1693295304;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ye5VeFdVXZzesAZickCQHr8ZhP+M/k9b1rVuea1ObtI=;
  b=n/Ih7uMWgUloJYYdD6rpOaWCyUvo3HjQYIkzyln0O+GgEZ/AuePDEqEo
   OTWyrDg+cHLtndCgAAH6PVzKe82dsKSBDtxdBkPsDpPYL8TbZruK5DlLN
   aSuGnn0IfE3QSR/S3fmZieNItbfuEPQygxl4J8yt42GVLGNoxCZwFl8Gy
   tPLP+3irYQvJUtWuQzkjMEfZqMSeAtVzGH50cEVlONcLkH3ldUJMaNzQu
   v1LPEvAGm618ygQsB0e3C7hAAFO5IGDpbZz+FT2EIA08mpLKyIUlqou0F
   NzG8QriDUB1vNaolELIo8mIJ2/GatlWCx83BmagU0t1FsLMfmflHn33aW
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10453"; a="275239433"
X-IronPort-AV: E=Sophos;i="5.93,272,1654585200"; 
   d="scan'208";a="275239433"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2022 00:48:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,272,1654585200"; 
   d="scan'208";a="640838427"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orsmga008.jf.intel.com with ESMTP; 29 Aug 2022 00:48:20 -0700
Date:   Mon, 29 Aug 2022 15:39:02 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Johannes Zink <j.zink@pengutronix.de>
Cc:     linux-fpga@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        kernel@pengutronix.de
Subject: Re: [PATCH 02/16] dt-bindings: fpga: machxo2-slave: add erasure
 properties
Message-ID: <YwxtFjMILAlEF/uh@yilunxu-OptiPlex-7050>
References: <20220825141343.1375690-1-j.zink@pengutronix.de>
 <20220825141343.1375690-3-j.zink@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220825141343.1375690-3-j.zink@pengutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2022-08-25 at 16:13:29 +0200, Johannes Zink wrote:
> This patch introduces additional memory areas of the machxo2-slave fpga
> to be erased.
> 
> Signed-off-by: Johannes Zink <j.zink@pengutronix.de>
> ---
>  .../bindings/fpga/lattice,machxo2-slave.yaml      | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/fpga/lattice,machxo2-slave.yaml b/Documentation/devicetree/bindings/fpga/lattice,machxo2-slave.yaml
> index d05acd6b0fc6..78f0da8f772f 100644
> --- a/Documentation/devicetree/bindings/fpga/lattice,machxo2-slave.yaml
> +++ b/Documentation/devicetree/bindings/fpga/lattice,machxo2-slave.yaml
> @@ -26,6 +26,19 @@ properties:
>      enum:
>        - lattice,machxo2-slave-spi
>  
> +  lattice,erase-sram:
> +    type: boolean
> +    description: SRAM is to be erased during flash erase operation
> +
> +  lattice,erase-feature-row:
> +    type: boolean
> +    description: Feature row is to be erased during flash erase operation
> +
> +  lattice,erase-userflash:
> +    type: boolean
> +    description: |
> +      UFM (user flash memory) is to be erased during flash erase operation

In which conditions should we decide to erase each area?

Thanks,
Yilun

> +
>  required:
>    - compatible
>    - reg
> @@ -42,5 +55,7 @@ examples:
>              compatible = "lattice,machxo2-slave-spi";
>              spi-max-frequency = <8000000>;
>              reg = <0>;
> +            lattice,erase-sram;
> +            lattice,erase-feature-row;
>          };
>      };
> -- 
> 2.30.2
> 
