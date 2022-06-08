Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 263B0542C3F
	for <lists+linux-fpga@lfdr.de>; Wed,  8 Jun 2022 12:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235666AbiFHJ5k (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 8 Jun 2022 05:57:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235667AbiFHJ5Y (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 8 Jun 2022 05:57:24 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D974614B668;
        Wed,  8 Jun 2022 02:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654680602; x=1686216602;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uwxUPQpS1espMfB9OR5NDTwor4yh42xNFnlWv+i1FFY=;
  b=G+mB33Yct5kLRbJKol4Hd/6j9uIJly5CjcYujPGO2sonvSNmbicsNSG9
   IlYlqC+agTAF4Lk2wjyIKM+dJPW8P+lej5eJ90qXMs4nbdLlBQrHvRNIs
   DfEH/tHuJfrFEnrpaBcMvXlH11DuXqjIDTX5s5zKmEQyA8kqI1Aq36P2V
   zVJ6NDBpa+TgSTONqjp6uIunr+2X5jba7Bm9VKZbUNhhK7q1Sv6j/m952
   JeS9zz4MZdub1R1OhVDGQMXT1s20Fg/xCvAgDD6SFkRCk3dYFRpZNTHW3
   ANNyKlGCVeSFysYzB5G7hAW5Cyd1lDx26vUiVVguiZTiGiPvXLn87vZq9
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10371"; a="302189006"
X-IronPort-AV: E=Sophos;i="5.91,285,1647327600"; 
   d="scan'208";a="302189006"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2022 02:29:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,285,1647327600"; 
   d="scan'208";a="683230214"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.135])
  by fmsmga002.fm.intel.com with ESMTP; 08 Jun 2022 02:29:33 -0700
Date:   Wed, 8 Jun 2022 17:21:39 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Ivan Bornyakov <i.bornyakov@metrotek.ru>
Cc:     mdf@kernel.org, hao.wu@intel.com, trix@redhat.com,
        Conor.Dooley@microchip.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-fpga@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        system@metrotek.ru, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v16 3/3] dt-bindings: fpga: add binding doc for
 microchip-spi fpga mgr
Message-ID: <20220608092139.GC481269@yilunxu-OptiPlex-7050>
References: <20220607111030.3003-1-i.bornyakov@metrotek.ru>
 <20220607111030.3003-4-i.bornyakov@metrotek.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220607111030.3003-4-i.bornyakov@metrotek.ru>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Tue, Jun 07, 2022 at 02:10:30PM +0300, Ivan Bornyakov wrote:
> Add Device Tree Binding doc for Microchip Polarfire FPGA Manager using
> slave SPI to load .dat formatted bitstream image.
> 
> Signed-off-by: Ivan Bornyakov <i.bornyakov@metrotek.ru>
> Reviewed-by: Rob Herring <robh@kernel.org>

Signed-off-by: Xu Yilun <yilun.xu@intel.com>

> ---
>  .../fpga/microchip,mpf-spi-fpga-mgr.yaml      | 44 +++++++++++++++++++
>  1 file changed, 44 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/fpga/microchip,mpf-spi-fpga-mgr.yaml
> 
> diff --git a/Documentation/devicetree/bindings/fpga/microchip,mpf-spi-fpga-mgr.yaml b/Documentation/devicetree/bindings/fpga/microchip,mpf-spi-fpga-mgr.yaml
> new file mode 100644
> index 000000000000..aee45cb15592
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/fpga/microchip,mpf-spi-fpga-mgr.yaml
> @@ -0,0 +1,44 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/fpga/microchip,mpf-spi-fpga-mgr.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Microchip Polarfire FPGA manager.
> +
> +maintainers:
> +  - Ivan Bornyakov <i.bornyakov@metrotek.ru>
> +
> +description:
> +  Device Tree Bindings for Microchip Polarfire FPGA Manager using slave SPI to
> +  load the bitstream in .dat format.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - microchip,mpf-spi-fpga-mgr
> +
> +  reg:
> +    description: SPI chip select
> +    maxItems: 1
> +
> +  spi-max-frequency: true
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    spi {
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            fpga_mgr@0 {
> +                    compatible = "microchip,mpf-spi-fpga-mgr";
> +                    spi-max-frequency = <20000000>;
> +                    reg = <0>;
> +            };
> +    };
> -- 
> 2.35.1
> 
