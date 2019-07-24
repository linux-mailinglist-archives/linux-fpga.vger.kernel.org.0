Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9DE272C29
	for <lists+linux-fpga@lfdr.de>; Wed, 24 Jul 2019 12:11:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbfGXKLO (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 24 Jul 2019 06:11:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:54466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725776AbfGXKLO (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 24 Jul 2019 06:11:14 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B986218B8;
        Wed, 24 Jul 2019 10:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563963073;
        bh=ZReY6BfZr785T/XUU+EfBwuJQvluwwTrNg76KPixSQE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QzGjz/xIlcZOYSnxx51ICns8OYaUNPys5YNOgjZpt4dlwJQDqTO1MxwN4fHeioSA2
         VG5s8L34uh6X7ITH2KhN5PEz83NkW+3tdwJ03HvGeWCY1liS/Id0b/UcKtNUPBFuFI
         EyzV1j7S5xUedjFHZ0U7agCWeaQKDSLtiuTcK/Ko=
Date:   Wed, 24 Jul 2019 12:11:09 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Wu Hao <hao.wu@intel.com>
Cc:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, atull@kernel.org,
        Xu Yilun <yilun.xu@intel.com>
Subject: Re: [PATCH v3 09/12] fpga: dfl: afu: add STP (SignalTap) support
Message-ID: <20190724101109.GE29532@kroah.com>
References: <1563857495-26692-1-git-send-email-hao.wu@intel.com>
 <1563857495-26692-10-git-send-email-hao.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1563857495-26692-10-git-send-email-hao.wu@intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Tue, Jul 23, 2019 at 12:51:32PM +0800, Wu Hao wrote:
> STP (SignalTap) is one of the private features under the port for
> debugging. This patch adds private feature driver support for it
> to allow userspace applications to mmap related mmio region and
> provide STP service.
> 
> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> Signed-off-by: Wu Hao <hao.wu@intel.com>
> Acked-by: Moritz Fischer <mdf@kernel.org>
> Acked-by: Alan Tull <atull@kernel.org>
> Signed-off-by: Moritz Fischer <mdf@kernel.org>
> ---
>  drivers/fpga/dfl-afu-main.c | 34 ++++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
> 
> diff --git a/drivers/fpga/dfl-afu-main.c b/drivers/fpga/dfl-afu-main.c
> index 15dd4cb..395f96e 100644
> --- a/drivers/fpga/dfl-afu-main.c
> +++ b/drivers/fpga/dfl-afu-main.c
> @@ -514,6 +514,36 @@ static void port_afu_uinit(struct platform_device *pdev,
>  	.uinit = port_afu_uinit,
>  };
>  
> +static int port_stp_init(struct platform_device *pdev,
> +			 struct dfl_feature *feature)
> +{
> +	struct resource *res = &pdev->resource[feature->resource_index];
> +
> +	dev_dbg(&pdev->dev, "PORT STP Init.\n");

ftrace is your friend, no need to do a lot of "look I am here!"
messages.

> +
> +	return afu_mmio_region_add(dev_get_platdata(&pdev->dev),
> +				   DFL_PORT_REGION_INDEX_STP,
> +				   resource_size(res), res->start,
> +				   DFL_PORT_REGION_MMAP | DFL_PORT_REGION_READ |
> +				   DFL_PORT_REGION_WRITE);
> +}
> +
> +static void port_stp_uinit(struct platform_device *pdev,
> +			   struct dfl_feature *feature)
> +{
> +	dev_dbg(&pdev->dev, "PORT STP UInit.\n");

Same here.

Why have this function at all if it does not do anything?


thanks,

greg k-h
