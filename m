Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED7306BF948
	for <lists+linux-fpga@lfdr.de>; Sat, 18 Mar 2023 11:12:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbjCRKKy (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 18 Mar 2023 06:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbjCRKKx (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sat, 18 Mar 2023 06:10:53 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10C567EF2;
        Sat, 18 Mar 2023 03:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679134244; x=1710670244;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=i/ijir56tdBUgAEBFOFtWVndt9Fv/1cvvyoH3zkEQNA=;
  b=WfUSsNV7h9ioLldJGQywXHj53wxsbaLAz0zcBNrzQuffVBmekef/ZvSi
   8AU9wGt6LiOrU5Ta6H1tMdHYHN/WZen1yNkykKMF8GOVqXJZRIMFAa0xN
   FbFMM0oIlHeJg03jxXqicY4fIklZVMogJf1BrqW+PaUra70U4/x/QpYUO
   0TYVfYJPt2tjz+jYSWBqKlbg6/JPOiW6pHq1Ll7nJeje8FOOmslKsP+dp
   ovL4k4wLdocoRFUhPAxCNYGX+iW6ekZU5/0WdsBGoJ/+N/S50Mnj+A6kz
   8vhQOaV7gch5HDJpkDKVjWLFUtxlykFyp1h6kMpADuLD74rm01mS91ikL
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10652"; a="322271179"
X-IronPort-AV: E=Sophos;i="5.98,271,1673942400"; 
   d="scan'208";a="322271179"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2023 03:10:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10652"; a="769655413"
X-IronPort-AV: E=Sophos;i="5.98,271,1673942400"; 
   d="scan'208";a="769655413"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by FMSMGA003.fm.intel.com with ESMTP; 18 Mar 2023 03:10:41 -0700
Date:   Sat, 18 Mar 2023 17:59:20 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Tom Rix <trix@redhat.com>
Cc:     mdf@kernel.org, hao.wu@intel.com, michal.simek@xilinx.com,
        nathan@kernel.org, ndesaulniers@google.com,
        linux-fpga@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] fpga: xilinx-pr-decoupler: remove unused
 xlnx_pr_decouple_read function
Message-ID: <ZBWLeC7UuDf+4dJE@yilunxu-OptiPlex-7050>
References: <20230317230617.1673923-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230317230617.1673923-1-trix@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2023-03-17 at 19:06:17 -0400, Tom Rix wrote:
> clang with W=1 reports
> drivers/fpga/xilinx-pr-decoupler.c:37:19: error: unused function 'xlnx_pr_decouple_read' [-Werror,-Wunused-function]
> static inline u32 xlnx_pr_decouple_read(const struct xlnx_pr_decoupler_data *d,
>                   ^
> This static function is not used, so remove it.

I prefer to move the description as the first section. If you agree, I
could do it before apply.

Acked-by: Xu Yilun <yilun.xu@intel.com>

> 
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  drivers/fpga/xilinx-pr-decoupler.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/drivers/fpga/xilinx-pr-decoupler.c b/drivers/fpga/xilinx-pr-decoupler.c
> index 2d9c491f7be9..b6f18c07c752 100644
> --- a/drivers/fpga/xilinx-pr-decoupler.c
> +++ b/drivers/fpga/xilinx-pr-decoupler.c
> @@ -34,12 +34,6 @@ static inline void xlnx_pr_decoupler_write(struct xlnx_pr_decoupler_data *d,
>  	writel(val, d->io_base + offset);
>  }
>  
> -static inline u32 xlnx_pr_decouple_read(const struct xlnx_pr_decoupler_data *d,
> -					u32 offset)
> -{
> -	return readl(d->io_base + offset);
> -}
> -
>  static int xlnx_pr_decoupler_enable_set(struct fpga_bridge *bridge, bool enable)
>  {
>  	int err;
> -- 
> 2.27.0
> 
