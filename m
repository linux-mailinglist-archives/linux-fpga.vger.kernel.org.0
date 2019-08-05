Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF3BC820C7
	for <lists+linux-fpga@lfdr.de>; Mon,  5 Aug 2019 17:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727802AbfHEPwo (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 5 Aug 2019 11:52:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:48766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726559AbfHEPwo (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 5 Aug 2019 11:52:44 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B5A2F2075B;
        Mon,  5 Aug 2019 15:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565020363;
        bh=JKWWEf+UF41qzixrKS7OzYkcF1MFv9/nEQ4bTM458I0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CgTAdhMO87lZWvO/L1sIxpO14mELKHxFF7iresS4QHoRz/JWdDbNW+HFtppUGki6L
         j0BkOKXMkYGMTLYAOLgFWf4GOLcqgfC97OJBUnOgCU6UHpDjLXsbsmQ2FQRzpqh1V9
         42uDptMp7hg/207Yk3vD6to/lyrryIujx9ezfmBY=
Date:   Mon, 5 Aug 2019 17:52:40 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Wu Hao <hao.wu@intel.com>
Cc:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, atull@kernel.org,
        Xu Yilun <yilun.xu@intel.com>
Subject: Re: [PATCH v4 06/12] fpga: dfl: afu: export __port_enable/disable
 function.
Message-ID: <20190805155240.GB8107@kroah.com>
References: <1564914022-3710-1-git-send-email-hao.wu@intel.com>
 <1564914022-3710-7-git-send-email-hao.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1564914022-3710-7-git-send-email-hao.wu@intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Sun, Aug 04, 2019 at 06:20:16PM +0800, Wu Hao wrote:
> As these two functions are used by other private features. e.g.
> in error reporting private feature, it requires to check port status
> and reset port for error clearing.
> 
> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> Signed-off-by: Wu Hao <hao.wu@intel.com>
> Acked-by: Moritz Fischer <mdf@kernel.org>
> Acked-by: Alan Tull <atull@kernel.org>
> Signed-off-by: Moritz Fischer <mdf@kernel.org>
> ---
> v2: rebased
> ---
>  drivers/fpga/dfl-afu-main.c | 25 ++++++++++++++-----------
>  drivers/fpga/dfl-afu.h      |  3 +++
>  2 files changed, 17 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/fpga/dfl-afu-main.c b/drivers/fpga/dfl-afu-main.c
> index e013afb..e312179 100644
> --- a/drivers/fpga/dfl-afu-main.c
> +++ b/drivers/fpga/dfl-afu-main.c
> @@ -22,14 +22,16 @@
>  #include "dfl-afu.h"
>  
>  /**
> - * port_enable - enable a port
> + * __port_enable - enable a port
>   * @pdev: port platform device.
>   *
>   * Enable Port by clear the port soft reset bit, which is set by default.
>   * The AFU is unable to respond to any MMIO access while in reset.
> - * port_enable function should only be used after port_disable function.
> + * __port_enable function should only be used after __port_disable function.
> + *
> + * The caller needs to hold lock for protection.
>   */
> -static void port_enable(struct platform_device *pdev)
> +void __port_enable(struct platform_device *pdev)

worst global function name ever.

Don't polute the global namespace like this for a single driver.  If you
REALLY need it, then use a prefix that shows it is your individual
dfl_special_sauce_platform_device_only type thing.

thanks,

greg k-h
