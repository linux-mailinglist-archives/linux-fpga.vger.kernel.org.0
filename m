Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6D076F636F
	for <lists+linux-fpga@lfdr.de>; Thu,  4 May 2023 05:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbjEDDem (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 3 May 2023 23:34:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjEDDej (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 3 May 2023 23:34:39 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0AFC1BF6;
        Wed,  3 May 2023 20:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683171257; x=1714707257;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3KiOAT90UU7GzEuS/S0TppUB/RAnJK0O9UmCMBs0ZBM=;
  b=RX9+w68TDldESwTGAJ75inYBOaFpYuB7r/uiZknU4YRIAk9MOKNBvLdx
   NuUdkDfIkSFjv6SzibL2YGq4W2t5nVy+Mny6zy3+X4fsnaonjkKBGageN
   NyAv2/cFyXVr+JyLNTeTuj5hyGrHPJGRK9a44T6I6su7MxR0AOSXtYAMC
   vo4dmfNz48aL5anbn7ZjOSw1mdtsKv/RFAcC+LQrS4aHjsGig4KEf6M0j
   mnMA58SeC69Gbv2tnE3xXm+7ZOcSwUNRR8JZz29GODz4v760/mDE2r3xp
   1HR5bIGHuErgbcX9/knZbnUEt6miQNWAKlpKdX6dfemVePBHWT+Ly/It1
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10699"; a="348868849"
X-IronPort-AV: E=Sophos;i="5.99,249,1677571200"; 
   d="scan'208";a="348868849"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2023 20:34:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10699"; a="871198748"
X-IronPort-AV: E=Sophos;i="5.99,249,1677571200"; 
   d="scan'208";a="871198748"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orsmga005.jf.intel.com with ESMTP; 03 May 2023 20:34:14 -0700
Date:   Thu, 4 May 2023 19:34:26 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Ivan Bornyakov <i.bornyakov@metrotek.ru>
Cc:     linux-kernel@vger.kernel.org, Moritz Fischer <mdf@kernel.org>,
        Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Vladimir Georgiev <v.georgiev@metrotek.ru>, system@metrotek.ru,
        linux-fpga@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 1/2] MAINTAINERS: update Microchip MPF FPGA reviewers
Message-ID: <ZFOYQgA6TYa8hCjS@yilunxu-OptiPlex-7050>
References: <20230429104838.5064-1-i.bornyakov@metrotek.ru>
 <20230429104838.5064-2-i.bornyakov@metrotek.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230429104838.5064-2-i.bornyakov@metrotek.ru>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2023-04-29 at 13:48:37 +0300, Ivan Bornyakov wrote:
> As I'm leaving Metrotek, hand over reviewing duty of Microchip MPF FPGA
> driver to Vladimir.
> 
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Acked-by: Vladimir Georgiev <v.georgiev@metrotek.ru>
> Signed-off-by: Ivan Bornyakov <i.bornyakov@metrotek.ru>

Hi Vladimir:

I need the "Acked-by" from your mail address.

> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a81ba8328704..aab9fbb20362 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8100,7 +8100,7 @@ F:	drivers/fpga/intel-m10-bmc-sec-update.c
>  
>  MICROCHIP POLARFIRE FPGA DRIVERS
>  M:	Conor Dooley <conor.dooley@microchip.com>
> -R:	Ivan Bornyakov <i.bornyakov@metrotek.ru>
> +R:	Vladimir Georgiev <v.georgiev@metrotek.ru>
>  L:	linux-fpga@vger.kernel.org
>  S:	Supported
>  F:	Documentation/devicetree/bindings/fpga/microchip,mpf-spi-fpga-mgr.yaml
> -- 
> 2.40.0
> 
> 
