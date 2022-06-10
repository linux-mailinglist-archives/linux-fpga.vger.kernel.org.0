Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0D38545DFE
	for <lists+linux-fpga@lfdr.de>; Fri, 10 Jun 2022 10:00:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346561AbiFJH6m (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 10 Jun 2022 03:58:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347142AbiFJH6a (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 10 Jun 2022 03:58:30 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E8C41CB735;
        Fri, 10 Jun 2022 00:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654847906; x=1686383906;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=r/paWOotQ/qnRPehSbFw0+oxQxYViWs5HZ+mD61abhY=;
  b=e1DlcRieprPibld70R3E65vSOSzNUIwZvbzBvblZjJUFZ5d1C297TMHv
   NZAVZXISGwMruieErZ/t6yFwZOuzdNrlKL9puiFtY1KOJClaBw/RZpL6I
   Z2r9pEIfmG/t0QPmKTYfhwZgAXAFoYCtXohFXdaVcSCz9I9MJ/EX5AhTY
   y6bGXFH913TtROYDs79F0ldMtClpy8Br1YcpYMhY4FwO/a5OYUi7S01fn
   c8ZhwH/YKdzf6sY90jKnRduljYBi83WMGzsmx1eBq+GVLF/lBU6KiK9yr
   lanXTe+mrASHdHfGHi1aW6+uO/gm//0TIs9zdiSNsAthyqBDqf9N7bhGP
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10373"; a="278354839"
X-IronPort-AV: E=Sophos;i="5.91,288,1647327600"; 
   d="scan'208";a="278354839"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2022 00:58:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,288,1647327600"; 
   d="scan'208";a="828111664"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmsmga006.fm.intel.com with ESMTP; 10 Jun 2022 00:58:23 -0700
Date:   Fri, 10 Jun 2022 15:50:27 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Marco Pagani <marpagan@redhat.com>
Cc:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Tom Rix <trix@redhat.com>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        Alan Tull <atull@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] fpga: altera-pr-ip: fix unsigned comparison with less
 than zero
Message-ID: <20220610075027.GA713676@yilunxu-OptiPlex-7050>
References: <20220609140520.42662-1-marpagan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220609140520.42662-1-marpagan@redhat.com>
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Thu, Jun 09, 2022 at 04:05:19PM +0200, Marco Pagani wrote:
> Fix the "comparison with less than zero" warning reported by
> cppcheck for the unsigned (size_t) parameter count of the
> alt_pr_fpga_write() function.
> 
> Fixes: d201cc17a8a3 ("fpga pr ip: Core driver support for Altera Partial Reconfiguration IP")
> Reviewed-by: Tom Rix <trix@redhat.com>
> Acked-by: Xu Yilun <yilun.xu@intel.com>
> Signed-off-by: Marco Pagani <marpagan@redhat.com>

Applied to for-next

Thanks,
Yilun

> ---
> Changes v1 -> v2:
> - Coding style fix
> Changes v2 -> v3:
> - Added Fixes tag
> ---
>  drivers/fpga/altera-pr-ip-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/fpga/altera-pr-ip-core.c b/drivers/fpga/altera-pr-ip-core.c
> index be0667968d33..df8671af4a92 100644
> --- a/drivers/fpga/altera-pr-ip-core.c
> +++ b/drivers/fpga/altera-pr-ip-core.c
> @@ -108,7 +108,7 @@ static int alt_pr_fpga_write(struct fpga_manager *mgr, const char *buf,
>  	u32 *buffer_32 = (u32 *)buf;
>  	size_t i = 0;
>  
> -	if (count <= 0)
> +	if (!count)
>  		return -EINVAL;
>  
>  	/* Write out the complete 32-bit chunks */
> -- 
> 2.35.3
