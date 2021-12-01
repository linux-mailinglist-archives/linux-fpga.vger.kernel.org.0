Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E50BB46444E
	for <lists+linux-fpga@lfdr.de>; Wed,  1 Dec 2021 01:55:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbhLAA7B (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 30 Nov 2021 19:59:01 -0500
Received: from mga05.intel.com ([192.55.52.43]:58641 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229450AbhLAA7B (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 30 Nov 2021 19:59:01 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10184"; a="322596855"
X-IronPort-AV: E=Sophos;i="5.87,277,1631602800"; 
   d="scan'208";a="322596855"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2021 16:55:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,277,1631602800"; 
   d="scan'208";a="601749336"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.68])
  by fmsmga002.fm.intel.com with ESMTP; 30 Nov 2021 16:55:38 -0800
Date:   Wed, 1 Dec 2021 08:48:24 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Russ Weight <russell.h.weight@intel.com>,
        Tom Rix <trix@redhat.com>
Subject: Re: [PATCH v2] fpga: stratix10-soc: Do not use ret uninitialized in
 s10_probe()
Message-ID: <20211201004824.GA336280@yilunxu-OptiPlex-7050>
References: <20211130221123.3800420-1-nathan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211130221123.3800420-1-nathan@kernel.org>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Tue, Nov 30, 2021 at 03:11:24PM -0700, Nathan Chancellor wrote:
> Clang warns:
> 
> drivers/fpga/stratix10-soc.c:431:9: warning: variable 'ret' is uninitialized when used here [-Wuninitialized]
>         return ret;
>                ^~~
> 
> ret is only assigned in an error path now so just return 0 directly.
> 
> Fixes: 4ba0b2c294fe ("fpga: mgr: Use standard dev_release for class driver")
> Link: https://github.com/ClangBuiltLinux/linux/issues/1517
> Reviewed-by: Russ Weight <russell.h.weight@intel.com>
> Reviewed-by: Tom Rix <trix@redhat.com>
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Acked-by: Xu Yilun <yilun.xu@intel.com>

Thanks,
Yilun

> ---
> 
> v1 -> v2: https://lore.kernel.org/r/20211129161009.3625548-1-nathan@kernel.org/
> 
> * Drop clang's suggestion text (Tom).
> 
> * Pick up Russ and Tom's review tags.
> 
>  drivers/fpga/stratix10-soc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/fpga/stratix10-soc.c b/drivers/fpga/stratix10-soc.c
> index 737d14c6e0de..357cea58ec98 100644
> --- a/drivers/fpga/stratix10-soc.c
> +++ b/drivers/fpga/stratix10-soc.c
> @@ -428,7 +428,7 @@ static int s10_probe(struct platform_device *pdev)
>  	}
>  
>  	platform_set_drvdata(pdev, mgr);
> -	return ret;
> +	return 0;
>  
>  probe_err:
>  	stratix10_svc_free_channel(priv->chan);
> 
> base-commit: 8886a579744fbfa53e69aa453ed10ae3b1f9abac
> -- 
> 2.34.1
