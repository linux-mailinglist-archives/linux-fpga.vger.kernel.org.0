Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35BE23A6D37
	for <lists+linux-fpga@lfdr.de>; Mon, 14 Jun 2021 19:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235625AbhFNRcY (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 14 Jun 2021 13:32:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:57164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235626AbhFNRcU (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 14 Jun 2021 13:32:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A747E6023E;
        Mon, 14 Jun 2021 17:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623691806;
        bh=2IE+0g7ScU1coJq0BYEHEfAczg8Lm/PIKRUKgDY37nQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mXdDuK42dye/QOry5FYvd+M4s4NWk5xaCvcsGxADOjGbLnMULwiTBabN5P8x+VnoC
         g23I9C5aiV8X9v2MVNrrfKwcUYlrEAvbzsQXFqEFj9BhSQHODhspMwsaHddLGHAIDB
         TLQgkUfw7KZflkFB4lLA5UzSaji+mVFKuHSEQfdw=
Date:   Mon, 14 Jun 2021 19:30:03 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Moritz Fischer <mdf@kernel.org>
Cc:     linux-fpga@vger.kernel.org,
        Russ Weight <russell.h.weight@intel.com>,
        Xu Yilun <yilun.xu@intel.com>
Subject: Re: [PATCH 2/8] fpga: stratix10-soc: Add missing fpga_mgr_free() call
Message-ID: <YMeSG6puw7/4OZ6b@kroah.com>
References: <20210614170909.232415-1-mdf@kernel.org>
 <20210614170909.232415-3-mdf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210614170909.232415-3-mdf@kernel.org>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, Jun 14, 2021 at 10:09:03AM -0700, Moritz Fischer wrote:
> From: Russ Weight <russell.h.weight@intel.com>
> 
> The stratix10-soc driver uses fpga_mgr_create() function and is therefore
> responsible to call fpga_mgr_free() to release the class driver resources.
> Add a missing call to fpga_mgr_free in the s10_remove() function.
> 
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> Reviewed-by: Xu Yilun <yilun.xu@intel.com>
> Signed-off-by: Moritz Fischer <mdf@kernel.org>
> ---
>  drivers/fpga/stratix10-soc.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/fpga/stratix10-soc.c b/drivers/fpga/stratix10-soc.c
> index 657a70c5fc99..9e34bbbce26e 100644
> --- a/drivers/fpga/stratix10-soc.c
> +++ b/drivers/fpga/stratix10-soc.c
> @@ -454,6 +454,7 @@ static int s10_remove(struct platform_device *pdev)
>  	struct s10_priv *priv = mgr->priv;
>  
>  	fpga_mgr_unregister(mgr);
> +	fpga_mgr_free(mgr);
>  	stratix10_svc_free_channel(priv->chan);
>  
>  	return 0;
> -- 
> 2.31.1
> 

Does this fix a specific commit?  Does it need a Fixes: and cc: stable
line too?

thanks,

greg k-h
