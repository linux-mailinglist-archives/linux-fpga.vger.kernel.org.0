Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7037559283C
	for <lists+linux-fpga@lfdr.de>; Mon, 15 Aug 2022 05:44:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232766AbiHODm7 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 14 Aug 2022 23:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232605AbiHODm7 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 14 Aug 2022 23:42:59 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E43A11451;
        Sun, 14 Aug 2022 20:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660534978; x=1692070978;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UMqmxjssfvr9MGTku5Xh+2RDGy3WR7MtBK+2rqnJ73o=;
  b=Glbz5xAh/JdvKqiotz1iYhZD9Lw75CPU+C2700g48PvVKpKWmaNlFEyq
   MF2iIBwuXU2r3tlcMrAoM6iWQY6s0zXVC5E4aNmgW+lrFizfS9b1byoC4
   Hcuw3JqQBs7/adWbpp1ILHD+BXEYjdMmOoI0VyW730b/c9W6fXlinQ3mL
   HJ6ogsitMOzab5XD5C+k5WrPlqVqDaSxMq3HSX3urxLxVWqleERFjJmK4
   Cv7+Mh8MrGqImAZyu9BOnOL8UXmWpXmgaCOWEGkMTXADASB9vLlf7Yzq+
   KxtR89+B+isgJdoTvkvXOvoNXEg6vagQtbD6Dn7KKXeWIPU4aJkUFWGVL
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10439"; a="272276443"
X-IronPort-AV: E=Sophos;i="5.93,237,1654585200"; 
   d="scan'208";a="272276443"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2022 20:42:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,237,1654585200"; 
   d="scan'208";a="709633356"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmsmga002.fm.intel.com with ESMTP; 14 Aug 2022 20:42:55 -0700
Date:   Mon, 15 Aug 2022 11:33:52 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Ivan Bornyakov <i.bornyakov@metrotek.ru>,
        Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Tom Rix <trix@redhat.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-fpga@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: fpga: microchip,mpf-spi-fpga-mgr: use
 spi-peripheral-props.yaml
Message-ID: <Yvm+oPCzNnTDcrFd@yilunxu-OptiPlex-7050>
References: <20220727164347.386398-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220727164347.386398-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2022-07-27 at 18:43:47 +0200, Krzysztof Kozlowski wrote:
> Instead of listing directly properties typical for SPI peripherals,
> reference the spi-peripheral-props.yaml schema.  This allows using all
> properties typical for SPI-connected devices, even these which device
> bindings author did not tried yet.
> 
> Remove the spi-* properties which now come via spi-peripheral-props.yaml
> schema, except for the cases when device schema adds some constraints
> like maximum frequency.
> 
> While changing additionalProperties->unevaluatedProperties, put it in
> typical place, just before example DTS.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Acked-by: Xu Yilun <yilun.xu@intel.com>

Applied to for-next.

Thanks,
Yilun

> 
> ---
> 
> Technically, this depends on [1] merged to SPI tree, if we want to
> preserve existing behavior of not allowing SPI CPHA and CPOL in each of
> schemas in this patch.
> 
> If this patch comes independently via different tree, the SPI CPHA and
> CPOL will be allowed for brief period of time, before [1] is merged.
> This will not have negative impact, just DT schema checks will be
> loosened for that period.
> 
> [1] https://lore.kernel.org/all/20220722191539.90641-2-krzysztof.kozlowski@linaro.org/
> ---
>  .../bindings/fpga/microchip,mpf-spi-fpga-mgr.yaml          | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/fpga/microchip,mpf-spi-fpga-mgr.yaml b/Documentation/devicetree/bindings/fpga/microchip,mpf-spi-fpga-mgr.yaml
> index aee45cb15592..527532f039ce 100644
> --- a/Documentation/devicetree/bindings/fpga/microchip,mpf-spi-fpga-mgr.yaml
> +++ b/Documentation/devicetree/bindings/fpga/microchip,mpf-spi-fpga-mgr.yaml
> @@ -22,13 +22,14 @@ properties:
>      description: SPI chip select
>      maxItems: 1
>  
> -  spi-max-frequency: true
> -
>  required:
>    - compatible
>    - reg
>  
> -additionalProperties: false
> +allOf:
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +unevaluatedProperties: false
>  
>  examples:
>    - |
> -- 
> 2.34.1
> 
