Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6229755F952
	for <lists+linux-fpga@lfdr.de>; Wed, 29 Jun 2022 09:42:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbiF2Hjn (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 29 Jun 2022 03:39:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231143AbiF2Hjm (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 29 Jun 2022 03:39:42 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51E69248EB;
        Wed, 29 Jun 2022 00:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656488382; x=1688024382;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xGQsMjXyyiPl0THGayv1e3wyuAKEHlcjzN/mbTlnUmo=;
  b=cggK1qxgaB9A+tpirpZpB/3OjYjzUhoeiZzkKBKDqBmX5xtXmLxK4mQZ
   biCUH5aGirxQYMzeHgAQldmPSnq3cNKPEtSVluEjTEN9bjezI9QA/1NFS
   KrAE516rX2zsFS1sBcL/dwBQS9CE4zNRIt6qdcElRisxlsmf+V6p8ycBq
   QoepG+sMVIHcQypTXX/lbpiGgxnIUaq53Lj5CQ0RzbcSkvaNsL5bwYRcD
   D9NvBtU8xzqJp1eKoLe1iN3keLPuQ1k/haYK2GlItVIci3beNIO/Bl7Hq
   fkr2dVBfXSJj235nlc0lJjgv4yewQUDPC9LPLfAYDHMd8Elz5Mgz8YP7g
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10392"; a="368266535"
X-IronPort-AV: E=Sophos;i="5.92,230,1650956400"; 
   d="scan'208";a="368266535"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2022 00:39:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,230,1650956400"; 
   d="scan'208";a="680395139"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by FMSMGA003.fm.intel.com with ESMTP; 29 Jun 2022 00:39:40 -0700
Date:   Wed, 29 Jun 2022 15:31:24 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Tom Rix <trix@redhat.com>, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH][next] fpga: fpga-mgr: Fix spelling mistake "bitsream" ->
 "bitstream"
Message-ID: <20220629073124.GA2628780@yilunxu-OptiPlex-7050>
References: <20220624081409.14760-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220624081409.14760-1-colin.i.king@gmail.com>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Fri, Jun 24, 2022 at 09:14:09AM +0100, Colin Ian King wrote:
> There is an spelling mistake in a dev_err message. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  drivers/fpga/fpga-mgr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
> index a0fa0a2cb8af..8efa67620e21 100644
> --- a/drivers/fpga/fpga-mgr.c
> +++ b/drivers/fpga/fpga-mgr.c
> @@ -158,7 +158,7 @@ static int fpga_mgr_parse_header_mapped(struct fpga_manager *mgr,
>  	ret = fpga_mgr_parse_header(mgr, info, buf, count);
>  
>  	if (info->header_size + info->data_size > count) {
> -		dev_err(&mgr->dev, "Bitsream data outruns FPGA image\n");
> +		dev_err(&mgr->dev, "Bitstream data outruns FPGA image\n");
>  		ret = -EINVAL;
>  	}

Adds the Fixes tag

  Fixes: 3cc624beba63 ("fpga: fpga-mgr: support bitstream offset in image buffer")

and applied to for-next

Thanks,
Yilun

>  
> -- 
> 2.35.3
