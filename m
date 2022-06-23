Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1195C5576DA
	for <lists+linux-fpga@lfdr.de>; Thu, 23 Jun 2022 11:42:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbiFWJkw (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 23 Jun 2022 05:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiFWJku (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 23 Jun 2022 05:40:50 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D62CB49909;
        Thu, 23 Jun 2022 02:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655977249; x=1687513249;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aXck3R6A19uHBgiDNe8YoiehvkSU+RaF1az/CheoTnE=;
  b=ZMDhH1U7VgRc46poQhkaX+XPu/kGm2gNEoIpScUXqEVGozZ6WWd9jG1o
   oF8Ujrb0hj3WiBSCCRS5njs3GwXQYlT61r6Su5lkK5GxR7TzKtF4C/8AV
   F/rHzMg0qQ3vGmTg45YeFrcqdVTX7viqGff58zVgV9g+RZVfkBxfnKhK5
   KubK9YvQr7DUWOr72d6MIcOFdSkKf0IuGMKwSKj4Cdo7O0Fad2+RZKeFC
   kB8NHLEG+dEL57TY67oOpCealf25D96uygIebao5DroYtvXQqvRbd9I+y
   lazcTIvI5awFooEroUBqtnH6kno324aympiKDj/9ktZYJel3KDQL/3ni7
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10386"; a="344664561"
X-IronPort-AV: E=Sophos;i="5.92,215,1650956400"; 
   d="scan'208";a="344664561"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 02:40:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,215,1650956400"; 
   d="scan'208";a="690943635"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmsmga002.fm.intel.com with ESMTP; 23 Jun 2022 02:40:46 -0700
Date:   Thu, 23 Jun 2022 17:32:37 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Ivan Bornyakov <i.bornyakov@metrotek.ru>
Cc:     mdf@kernel.org, hao.wu@intel.com, trix@redhat.com, corbet@lwn.net,
        conor.dooley@microchip.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-fpga@vger.kernel.org,
        linux-doc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, system@metrotek.ru
Subject: Re: [PATCH v21 5/5] MAINTAINERS: add Microchip PolarFire FPGA
 drivers entry
Message-ID: <20220623093237.GC1752270@yilunxu-OptiPlex-7050>
References: <20220621153847.103052-1-i.bornyakov@metrotek.ru>
 <20220621153847.103052-6-i.bornyakov@metrotek.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220621153847.103052-6-i.bornyakov@metrotek.ru>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Tue, Jun 21, 2022 at 06:38:47PM +0300, Ivan Bornyakov wrote:
> Add MAINTAINERS entry for the newly added Microchip PolarFire (MPF) FPGA
> manager. Add myself as a reviewer and Conor Dooley as a maintainer.
> 
> Suggested-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Ivan Bornyakov <i.bornyakov@metrotek.ru>

Acked-by: Xu Yilun <yilun.xu@intel.com>

> ---
>  MAINTAINERS | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b774f21828f7..ed2517574804 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7884,6 +7884,14 @@ S:	Maintained
>  F:	Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-sec-update
>  F:	drivers/fpga/intel-m10-bmc-sec-update.c
>  
> +MICROCHIP POLARFIRE FPGA DRIVERS
> +M:	Conor Dooley <conor.dooley@microchip.com>
> +R:	Ivan Bornyakov <i.bornyakov@metrotek.ru>
> +L:	linux-fpga@vger.kernel.org
> +S:	Supported
> +F:	Documentation/devicetree/bindings/fpga/microchip,mpf-spi-fpga-mgr.yaml
> +F:	drivers/fpga/microchip-spi.c
> +
>  FPU EMULATOR
>  M:	Bill Metzenthen <billm@melbpc.org.au>
>  S:	Maintained
> -- 
> 2.25.1
> 
