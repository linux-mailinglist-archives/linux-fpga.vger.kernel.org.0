Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A79D4545D4C
	for <lists+linux-fpga@lfdr.de>; Fri, 10 Jun 2022 09:26:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346889AbiFJHYP (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 10 Jun 2022 03:24:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346795AbiFJHXw (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 10 Jun 2022 03:23:52 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83B9321C3B3;
        Fri, 10 Jun 2022 00:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654845830; x=1686381830;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=POm9JCNG8hbNwtmENSOZ9MbIkytxsFpCygdTnLttjFA=;
  b=Qp0RU2LzOuzhubuY+egvd67s4UG2dJVeEIbXUyr6WJuWfiNhlAD7+Os1
   /Wu0cPP+nNOUe1TWI6tuF1NQ/2b8PZCGlhw10i+Yzh+9QDbk1EYxUKIY5
   WvTj73lM2NH67rxuJAjrcIcFr3u6Y/ufa53GmgOe9jhOE2+75uhyAMfkE
   WOiDfSdbqVYSmyirMd6ShPK1X/iqQBwMZf8OjjQgniYUT5F7ZlACHi6fH
   AkZFH2Hc7shOUbWW654F+wBv2UUVrwNt48q9ppgmKNmylaBUQiQrG+PIN
   xGIj1O45crCZ94sGKxXxnwscTel0VOTuxpKrcCr7633dLaPVOpphQMkVb
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10373"; a="302918958"
X-IronPort-AV: E=Sophos;i="5.91,288,1647327600"; 
   d="scan'208";a="302918958"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2022 00:23:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,288,1647327600"; 
   d="scan'208";a="649685430"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmsmga004.fm.intel.com with ESMTP; 10 Jun 2022 00:23:44 -0700
Date:   Fri, 10 Jun 2022 15:15:47 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Ivan Bornyakov <i.bornyakov@metrotek.ru>
Cc:     mdf@kernel.org, hao.wu@intel.com, trix@redhat.com, corbet@lwn.net,
        Ivan Bornyakov <brnkv.i1@gmail.com>,
        Conor.Dooley@microchip.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-fpga@vger.kernel.org,
        devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, system@metrotek.ru
Subject: Re: [PATCH v17 2/4] docs: fpga: mgr: document parse_header() callback
Message-ID: <20220610071547.GA655812@yilunxu-OptiPlex-7050>
References: <20220609154752.20781-1-i.bornyakov@metrotek.ru>
 <20220609154752.20781-3-i.bornyakov@metrotek.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220609154752.20781-3-i.bornyakov@metrotek.ru>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Thu, Jun 09, 2022 at 06:47:50PM +0300, Ivan Bornyakov wrote:
> Document newly introduced fpga_manager_ops callback parse_header() along
> with header_size and data_size fields of struct fpga_image_info.
> 
> Signed-off-by: Ivan Bornyakov <i.bornyakov@metrotek.ru>
> ---
>  Documentation/driver-api/fpga/fpga-mgr.rst | 31 ++++++++++++++++------
>  1 file changed, 23 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/driver-api/fpga/fpga-mgr.rst b/Documentation/driver-api/fpga/fpga-mgr.rst
> index 42c01f396dce..db0852bd3ddc 100644
> --- a/Documentation/driver-api/fpga/fpga-mgr.rst
> +++ b/Documentation/driver-api/fpga/fpga-mgr.rst
> @@ -79,14 +79,29 @@ do the programming sequence for this particular FPGA.  These ops return 0 for
>  success or negative error codes otherwise.
>  
>  The programming sequence is::
> - 1. .write_init
> - 2. .write or .write_sg (may be called once or multiple times)
> - 3. .write_complete
> -
> -The .write_init function will prepare the FPGA to receive the image data.  The
> -buffer passed into .write_init will be at most .initial_header_size bytes long;
> -if the whole bitstream is not immediately available then the core code will
> -buffer up at least this much before starting.
> + 1. .parse_header

    1. .parse_header (optional, may be called once or multiple times)

> + 2. .write_init
> + 3. .write or .write_sg (may be called once or multiple times)
> + 4. .write_complete
> +
> +The .parse_header function will set header_size and data_size to
> +struct fpga_image_info. If header_size is set, .write function will get image
> +buffer starting at header_size offset from the beginning. If data_size is set,
> +.write function will get data_size bytes of the image buffer, otherwise .write
> +will get data up to the end of image buffer. This will not affect .write_sg,
> +.write_sg will still get whole image in sg_table form. If FPGA image is a

							  If FPGA image is already mapped as a 

Others look good to me.

Thanks,
Yilun

> +single contiguous buffer, whole buffer will be passed into .parse_header.
> +If image is in scatter-gather form, core code will buffer up at least
> +.initial_header_size before the first call of .parse_header, if it is not
> +enough, .parse_header should set desired size into info->header_size and
> +return -EAGAIN, then it will be called again with greater part of image buffer
> +on the input.
> +
> +The .write_init function will prepare the FPGA to receive the image data. The
> +buffer passed into .write_init will be at least info->header_size bytes long,
> +if it's defined, otherwise .initial_header_size; if the whole bitstream is not
> +immediately available then the core code will buffer up at least this much
> +before starting.
>  
>  The .write function writes a buffer to the FPGA. The buffer may be contain the
>  whole FPGA image or may be a smaller chunk of an FPGA image.  In the latter
> -- 
> 2.35.1
> 
