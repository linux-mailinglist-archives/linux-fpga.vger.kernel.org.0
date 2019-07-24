Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C54E72B5F
	for <lists+linux-fpga@lfdr.de>; Wed, 24 Jul 2019 11:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbfGXJ3M (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 24 Jul 2019 05:29:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:60722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726539AbfGXJ3M (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 24 Jul 2019 05:29:12 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4856920651;
        Wed, 24 Jul 2019 09:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563960551;
        bh=di95QMpzOVnd1w0M+lrR15A6sABXPrhp6Jm9zb+E5CE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zdSovAqyKbrcXVdq5u7+OIG8/jJqg2Ma0XQhIbhOUkogwkF/f/ZAVSvW/36muO+WT
         LTHJtvhtsrNaSHfy3V31S9yOHTZXUdvuaT40uiiG93fKica3ZQj/VtX8i6C3J9oOYH
         SRTb83L2yv+1sfkGq+OvYZNqjTpvHKFgIBU6nGvU=
Date:   Wed, 24 Jul 2019 11:29:09 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Moritz Fischer <mdf@kernel.org>
Cc:     YueHaibing <yuehaibing@huawei.com>, stillcompiling@gmail.com,
        atull@kernel.org, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org
Subject: Re: [PATCH] fpga-manager: altera-ps-spi: Fix build error
Message-ID: <20190724092909.GA15423@kroah.com>
References: <20190708071356.50928-1-yuehaibing@huawei.com>
 <20190709000527.GA1587@archbook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190709000527.GA1587@archbook>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, Jul 08, 2019 at 05:05:27PM -0700, Moritz Fischer wrote:
> On Mon, Jul 08, 2019 at 03:13:56PM +0800, YueHaibing wrote:
> > If BITREVERSE is m and FPGA_MGR_ALTERA_PS_SPI is y,
> > build fails:
> > 
> > drivers/fpga/altera-ps-spi.o: In function `altera_ps_write':
> > altera-ps-spi.c:(.text+0x4ec): undefined reference to `byte_rev_table'
> > 
> > Select BITREVERSE to fix this.
> > 
> > Reported-by: Hulk Robot <hulkci@huawei.com>
> > Fixes: fcfe18f885f6 ("fpga-manager: altera-ps-spi: use bitrev8x4")
> > Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> > ---
> >  drivers/fpga/Kconfig | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
> > index 474f304..cdd4f73 100644
> > --- a/drivers/fpga/Kconfig
> > +++ b/drivers/fpga/Kconfig
> > @@ -40,6 +40,7 @@ config ALTERA_PR_IP_CORE_PLAT
> >  config FPGA_MGR_ALTERA_PS_SPI
> >  	tristate "Altera FPGA Passive Serial over SPI"
> >  	depends on SPI
> > +	select BITREVERSE
> >  	help
> >  	  FPGA manager driver support for Altera Arria/Cyclone/Stratix
> >  	  using the passive serial interface over SPI.
> > -- 
> > 2.7.4
> > 
> > 
> Acked-by: Moritz Fischer <mdf@kernel.org>

I've queued this up directly now, thanks.

greg k-h
