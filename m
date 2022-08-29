Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ECE65A444B
	for <lists+linux-fpga@lfdr.de>; Mon, 29 Aug 2022 09:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbiH2Hyw (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 29 Aug 2022 03:54:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiH2Hyu (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 29 Aug 2022 03:54:50 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4267027C;
        Mon, 29 Aug 2022 00:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661759685; x=1693295685;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ipfjR7Wqny5WFVCOck08ZfdhxWBbw1koNseqdUvofxY=;
  b=c7/K90RRQWPbWiWUE0rAbPBt895k7+a660OJrI3jgrpfniFxEeDmKmG2
   dpuYR5eJBcOT3Kq1dMiOIa2xxKMFiM+p+YmP8/DxccGrl0Jmcov7BO0OY
   GNA1sHKQ3zYfqkBiqNYthMfOBSawdya7Bcy4BaOI1D5RPKC26/BDRGQP0
   hP+tsS2gvXjS77iK285ZQcsyfAWkq+B2IN8i5dUCdXcOU7jclK0uunOoN
   vMxGjK2lbPrcPdd3sq4A29YR20zx0++R8swiWwXKSV8sA7YlSJj64/Zv7
   8WmzCMNMslhW99AEcreW3lFBYkDeHeg/8TNB+JZEl9ihveqeHXz5I6Muj
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10453"; a="293580376"
X-IronPort-AV: E=Sophos;i="5.93,272,1654585200"; 
   d="scan'208";a="293580376"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2022 00:54:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,272,1654585200"; 
   d="scan'208";a="939487252"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmsmga005.fm.intel.com with ESMTP; 29 Aug 2022 00:54:39 -0700
Date:   Mon, 29 Aug 2022 15:45:21 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Johannes Zink <j.zink@pengutronix.de>
Cc:     linux-fpga@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        kernel@pengutronix.de
Subject: Re: [PATCH 03/16] dt-bindings: fpga: machxo2-slave: add pin for
 program sequence init
Message-ID: <YwxukXtb5pJBKlq7@yilunxu-OptiPlex-7050>
References: <20220825141343.1375690-1-j.zink@pengutronix.de>
 <20220825141343.1375690-4-j.zink@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220825141343.1375690-4-j.zink@pengutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2022-08-25 at 16:13:30 +0200, Johannes Zink wrote:
> This commit adds a pin which initiates the FPGA programming sequence
> once pulsed low.

Why we don't have to use this pin before?

Thanks,
Yilun

> 
> Signed-off-by: Johannes Zink <j.zink@pengutronix.de>
> ---
>  .../devicetree/bindings/fpga/lattice,machxo2-slave.yaml    | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/fpga/lattice,machxo2-slave.yaml b/Documentation/devicetree/bindings/fpga/lattice,machxo2-slave.yaml
> index 78f0da8f772f..03dc134ec7b8 100644
> --- a/Documentation/devicetree/bindings/fpga/lattice,machxo2-slave.yaml
> +++ b/Documentation/devicetree/bindings/fpga/lattice,machxo2-slave.yaml
> @@ -26,6 +26,12 @@ properties:
>      enum:
>        - lattice,machxo2-slave-spi
>  
> +  program-gpios:
> +    maxItems: 1
> +    description: |
> +      GPIO Output tied to the FPGA's n_program pin to initiate a
> +      programming sequence. This pin is active low.
> +
>    lattice,erase-sram:
>      type: boolean
>      description: SRAM is to be erased during flash erase operation
> @@ -57,5 +63,6 @@ examples:
>              reg = <0>;
>              lattice,erase-sram;
>              lattice,erase-feature-row;
> +            lattice,program-gpios = <&gpio1 2 GPIO_ACTIVE_LOW>
>          };
>      };
> -- 
> 2.30.2
> 
