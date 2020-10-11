Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6292428A7D2
	for <lists+linux-fpga@lfdr.de>; Sun, 11 Oct 2020 16:43:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388036AbgJKOnz (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 11 Oct 2020 10:43:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:35278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388019AbgJKOny (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Sun, 11 Oct 2020 10:43:54 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 974CB2078B;
        Sun, 11 Oct 2020 14:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602427434;
        bh=yv1yootdGiYZLb8MsWumj0gcQCzLP83X0Es/Fa8wdY4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CK7lhPYTSm6ThQ6Pu10SkF/TjrCuV5cl4JabhLsPamuc4QfO67gvQJwfxgBhl8xyw
         YJ8H+hbks3uKNOpME3BhqVqCAoq3RFskM+GIVuZlVUEHU94CssYt+6Jg9LZVJfnvsz
         OJIIFpZ8cVwoISK97ZqdfCuZAQKgq8pIUBUSgd4o=
Date:   Sun, 11 Oct 2020 16:43:51 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     mdf@kernel.org, krzk@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, trix@redhat.com, lgoncalv@redhat.com,
        hao.wu@intel.com,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        Russ Weight <russell.h.weight@intel.com>
Subject: Re: [PATCH v9 2/6] fpga: dfl: move dfl_device_id to mod_devicetable.h
Message-ID: <20201011144351.GA271501@kroah.com>
References: <1602313793-21421-1-git-send-email-yilun.xu@intel.com>
 <1602313793-21421-3-git-send-email-yilun.xu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1602313793-21421-3-git-send-email-yilun.xu@intel.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Sat, Oct 10, 2020 at 03:09:49PM +0800, Xu Yilun wrote:
> In order to support MODULE_DEVICE_TABLE() for dfl device driver, this
> patch moves struct dfl_device_id to mod_devicetable.h
> 
> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> Signed-off-by: Wu Hao <hao.wu@intel.com>
> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> Reviewed-by: Tom Rix <trix@redhat.com>
> Acked-by: Wu Hao <hao.wu@intel.com>
> Signed-off-by: Moritz Fischer <mdf@kernel.org>
> ---
> v2: fix the order for the header file
> v3: rebase the patch for dfl bus name change
> v9: rebase the patch for dfl bus name changes back to "dfl"
> ---
>  drivers/fpga/dfl.h              | 13 +------------
>  include/linux/mod_devicetable.h | 12 ++++++++++++
>  2 files changed, 13 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
> index ac373b1..549c790 100644
> --- a/drivers/fpga/dfl.h
> +++ b/drivers/fpga/dfl.h
> @@ -22,6 +22,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/iopoll.h>
>  #include <linux/io-64-nonatomic-lo-hi.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
>  #include <linux/uuid.h>
> @@ -526,18 +527,6 @@ enum dfl_id_type {
>  };
>  
>  /**
> - * struct dfl_device_id -  dfl device identifier
> - * @type: DFL FIU type of the device. See enum dfl_id_type.
> - * @feature_id: feature identifier local to its DFL FIU type.
> - * @driver_data: driver specific data.
> - */
> -struct dfl_device_id {
> -	u16 type;
> -	u16 feature_id;
> -	unsigned long driver_data;
> -};
> -
> -/**
>   * struct dfl_device - represent an dfl device on dfl bus
>   *
>   * @dev: generic device interface.
> diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
> index 5b08a47..66e1405 100644
> --- a/include/linux/mod_devicetable.h
> +++ b/include/linux/mod_devicetable.h
> @@ -838,4 +838,16 @@ struct mhi_device_id {
>  	kernel_ulong_t driver_data;
>  };
>  
> +/**
> + * struct dfl_device_id -  dfl device identifier

I still have no idea what "dfl" means.  Please at the very least,
explain it here.

thanks,

greg k-h
