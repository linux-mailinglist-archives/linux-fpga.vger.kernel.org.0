Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C73E3A10C7
	for <lists+linux-fpga@lfdr.de>; Wed,  9 Jun 2021 12:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238537AbhFIKCO (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 9 Jun 2021 06:02:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:45058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236044AbhFIKCO (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 9 Jun 2021 06:02:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 76D826128A;
        Wed,  9 Jun 2021 10:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623232820;
        bh=OTqK2VZjMh+zxGq9ifnmlASDu1uIzhORxy6quLAa9yM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HesuOHbli8UoInq3D0nCId5gt4aP1H0N/ubdWRSH+5m+VfD/sjN+StVLvL4YGF7cL
         EEnT6INWVotMExg+gF0IMQ1d6SkTwuQ/zbP3Wj+fkN9qnikHMTkA4Cpsab3fO9vBSB
         Cbqt2bdPCoAZbVhIfzz9gcY1UqfT6F5guu/4vfr0=
Date:   Wed, 9 Jun 2021 12:00:17 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     trix@redhat.com
Cc:     mdf@kernel.org, fpacheco@redhat.com, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/7] fpga: altera: remove altera- prefix on files
Message-ID: <YMCRMeckadaRw3gI@kroah.com>
References: <20210608162623.3010726-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210608162623.3010726-1-trix@redhat.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Tue, Jun 08, 2021 at 09:26:23AM -0700, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> It is not necessary to have an altera- prefix on a file
> when the file is in an altera/ subdir.
> 
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  drivers/fpga/altera/Makefile                         | 12 ++++++------
>  drivers/fpga/altera/{altera-cvp.c => cvp.c}          |  0
>  .../altera/{altera-fpga2sdram.c => fpga2sdram.c}     |  0
>  .../{altera-freeze-bridge.c => freeze-bridge.c}      |  0
>  .../fpga/altera/{altera-hps2fpga.c => hps2fpga.c}    |  0
>  .../{altera-pr-ip-core-plat.c => pr-ip-core-plat.c}  |  0
>  .../altera/{altera-pr-ip-core.c => pr-ip-core.c}     |  0
>  drivers/fpga/altera/{altera-ps-spi.c => ps-spi.c}    |  0
>  8 files changed, 6 insertions(+), 6 deletions(-)
>  rename drivers/fpga/altera/{altera-cvp.c => cvp.c} (100%)
>  rename drivers/fpga/altera/{altera-fpga2sdram.c => fpga2sdram.c} (100%)
>  rename drivers/fpga/altera/{altera-freeze-bridge.c => freeze-bridge.c} (100%)
>  rename drivers/fpga/altera/{altera-hps2fpga.c => hps2fpga.c} (100%)
>  rename drivers/fpga/altera/{altera-pr-ip-core-plat.c => pr-ip-core-plat.c} (100%)
>  rename drivers/fpga/altera/{altera-pr-ip-core.c => pr-ip-core.c} (100%)
>  rename drivers/fpga/altera/{altera-ps-spi.c => ps-spi.c} (100%)
> 
> diff --git a/drivers/fpga/altera/Makefile b/drivers/fpga/altera/Makefile
> index 4d725c72fcbef..c2d626cd1f540 100644
> --- a/drivers/fpga/altera/Makefile
> +++ b/drivers/fpga/altera/Makefile
> @@ -1,12 +1,12 @@
>  # SPDX-License-Identifier: GPL-2.0
>  
> -obj-$(CONFIG_ALTERA_FREEZE_BRIDGE) += altera-freeze-bridge.o
> -obj-$(CONFIG_ALTERA_PR_IP_CORE) += altera-pr-ip-core.o
> -obj-$(CONFIG_ALTERA_PR_IP_CORE_PLAT) += altera-pr-ip-core-plat.o
> -obj-$(CONFIG_FPGA_MGR_ALTERA_CVP) += altera-cvp.o
> -obj-$(CONFIG_FPGA_MGR_ALTERA_PS_SPI) += altera-ps-spi.o
> +obj-$(CONFIG_ALTERA_FREEZE_BRIDGE) += freeze-bridge.o
> +obj-$(CONFIG_ALTERA_PR_IP_CORE) += pr-ip-core.o
> +obj-$(CONFIG_ALTERA_PR_IP_CORE_PLAT) += pr-ip-core-plat.o
> +obj-$(CONFIG_FPGA_MGR_ALTERA_CVP) += cvp.o
> +obj-$(CONFIG_FPGA_MGR_ALTERA_PS_SPI) += ps-spi.o
>  obj-$(CONFIG_FPGA_MGR_SOCFPGA) += socfpga.o
>  obj-$(CONFIG_FPGA_MGR_SOCFPGA_A10) += socfpga-a10.o
>  obj-$(CONFIG_FPGA_MGR_STRATIX10_SOC) += stratix10-soc.o
>  obj-$(CONFIG_FPGA_MGR_TS73XX) += ts73xx-fpga.o
> -obj-$(CONFIG_SOCFPGA_FPGA_BRIDGE) += altera-hps2fpga.o altera-fpga2sdram.o
> +obj-$(CONFIG_SOCFPGA_FPGA_BRIDGE) += hps2fpga.o fpga2sdram.o

Same issue here, you are renaming the resulting module for no good
reason.  Please never do that unless you mean to, AND, you document why
you are doing so in the changelog text.

thanks,

greg k-h
