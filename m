Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C88255301D
	for <lists+linux-fpga@lfdr.de>; Tue, 21 Jun 2022 12:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbiFUKpS (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 21 Jun 2022 06:45:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiFUKpR (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 21 Jun 2022 06:45:17 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 773C4286D4;
        Tue, 21 Jun 2022 03:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655808316; x=1687344316;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=92qWkWzDZRR+3vN9HA1g36iku2zgJgrFBeBrin/KXIc=;
  b=IErzzsYxL0TpuYIdNFbt8LJ0Vq7bwJBPft31fbYi1e92KCMgOaLS5QLE
   8SqY9MBWLfJ7mXEmih9/dFCjLiKqqNSkZfpwE53FhoK7IcOGFXkFBQayc
   +5IN1tgyD7HcsaEFlW2v21B+y4UcxPjtohx74ddqAfHHA0WeNYLTndyKR
   B9n+YaZMsfkjCqm13e418wVrwcjWx/VP2m3NoT1oPCKZl+jPnXk1tTb0P
   /uneplq4xWlTntpReehUL1oQ5/hanVANRkPSe2bsp+zYMUrrae2WOmGq8
   dEYG651qxNxAjUvLj5exm8N7NWS9FpqDKwo/N+0OQAjhutmkmM/x1X6Vn
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10384"; a="280136737"
X-IronPort-AV: E=Sophos;i="5.92,209,1650956400"; 
   d="scan'208";a="280136737"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2022 03:45:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,209,1650956400"; 
   d="scan'208";a="833523803"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmsmga006.fm.intel.com with ESMTP; 21 Jun 2022 03:45:04 -0700
Date:   Tue, 21 Jun 2022 18:36:57 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Ivan Bornyakov <i.bornyakov@metrotek.ru>
Cc:     mdf@kernel.org, hao.wu@intel.com, trix@redhat.com, corbet@lwn.net,
        Conor.Dooley@microchip.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-fpga@vger.kernel.org,
        devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, system@metrotek.ru
Subject: Re: [PATCH v20 2/4] docs: fpga: mgr: document parse_header() callback
Message-ID: <20220621103657.GB1530041@yilunxu-OptiPlex-7050>
References: <20220617134846.19859-1-i.bornyakov@metrotek.ru>
 <20220617134846.19859-3-i.bornyakov@metrotek.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220617134846.19859-3-i.bornyakov@metrotek.ru>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Fri, Jun 17, 2022 at 04:48:44PM +0300, Ivan Bornyakov wrote:
> Document newly introduced fpga_manager_ops callback parse_header() and
> flag skip_header along with header_size and data_size fields of struct
> fpga_image_info.
> 
> Signed-off-by: Ivan Bornyakov <i.bornyakov@metrotek.ru>

Acked-by: Xu Yilun <yilun.xu@intel.com>

> ---
>  Documentation/driver-api/fpga/fpga-mgr.rst | 27 +++++++++++++++++-----
>  1 file changed, 21 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/driver-api/fpga/fpga-mgr.rst b/Documentation/driver-api/fpga/fpga-mgr.rst
> index 42c01f396dce..49c0a9512653 100644
> --- a/Documentation/driver-api/fpga/fpga-mgr.rst
> +++ b/Documentation/driver-api/fpga/fpga-mgr.rst
> @@ -79,12 +79,27 @@ do the programming sequence for this particular FPGA.  These ops return 0 for
>  success or negative error codes otherwise.
>  
>  The programming sequence is::
> - 1. .write_init
> - 2. .write or .write_sg (may be called once or multiple times)
> - 3. .write_complete
> -
> -The .write_init function will prepare the FPGA to receive the image data.  The
> -buffer passed into .write_init will be at most .initial_header_size bytes long;
> + 1. .parse_header (optional, may be called once or multiple times)
> + 2. .write_init
> + 3. .write or .write_sg (may be called once or multiple times)
> + 4. .write_complete
> +
> +The .parse_header function will set header_size and data_size to
> +struct fpga_image_info. Before parse_header call, header_size is initialized
> +with initial_header_size. If flag skip_header of fpga_manager_ops is true,
> +.write function will get image buffer starting at header_size offset from the
> +beginning. If data_size is set, .write function will get data_size bytes of
> +the image buffer, otherwise .write will get data up to the end of image buffer.
> +This will not affect .write_sg, .write_sg will still get whole image in
> +sg_table form. If FPGA image is already mapped as a single contiguous buffer,
> +whole buffer will be passed into .parse_header. If image is in scatter-gather
> +form, core code will buffer up at least .initial_header_size before the first
> +call of .parse_header, if it is not enough, .parse_header should set desired
> +size into info->header_size and return -EAGAIN, then it will be called again
> +with greater part of image buffer on the input.
> +
> +The .write_init function will prepare the FPGA to receive the image data. The
> +buffer passed into .write_init will be at least info->header_size bytes long;
>  if the whole bitstream is not immediately available then the core code will
>  buffer up at least this much before starting.
>  
> -- 
> 2.25.1
> 
